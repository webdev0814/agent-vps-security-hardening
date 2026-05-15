# Harness-Agnostic VPS Agent Security Hardening Procedure

Use this procedure for any VPS running AI agents or automation harnesses. It is designed to be safe, staged, and approval-first.

## 0. Rules of engagement

Before changing anything:

- Do not modify SSH/firewall rules until you know how the operator connects.
- Do not close a port unless you know what owns it and whether it is required.
- Keep a rollback command/file for each state-changing step.
- Never print secrets, tokens, private keys, OAuth refresh tokens, or webhook signing secrets.
- Prefer private-network exposure for agent control surfaces.
- Keep outbound internet available unless the owner explicitly wants egress filtering.

## 1. Inventory

Collect read-only facts:

```bash
hostnamectl || true
uname -a
cat /etc/os-release
id
ip addr
ss -ltnup || ss -ltnp
systemctl list-units --type=service --state=running
systemctl list-timers --all
crontab -l || true
sudo ls -la /etc/cron.d /etc/cron.daily 2>/dev/null || true
```

Firewall and access:

```bash
sudo ufw status verbose 2>/dev/null || true
sudo nft list ruleset 2>/dev/null || true
sudo iptables -S 2>/dev/null || true
sudo sshd -T 2>/dev/null | egrep '^(port|listenaddress|permitrootlogin|passwordauthentication|pubkeyauthentication|kbdinteractiveauthentication|challengeresponseauthentication|allowusers|authenticationmethods|maxauthtries|x11forwarding|allowtcpforwarding)' || true
```

Updates and protection:

```bash
apt list --upgradable 2>/dev/null || true
systemctl status unattended-upgrades 2>/dev/null || true
systemctl status fail2ban 2>/dev/null || true
```

Secrets metadata only:

```bash
find "$HOME" /etc -maxdepth 4 -type f \
  \( -iname '*token*' -o -iname '*secret*' -o -iname '*.env' -o -iname '*credential*' -o -iname '*key*.json' \) \
  -printf '%M %u:%g %p\n' 2>/dev/null | sort
```

## 2. Classify services

For every listening port, assign one category:

- **Public required:** e.g. HTTPS public site, public webhook endpoint.
- **Private required:** e.g. admin dashboard, agent control plane, database, metrics, browser worker, VNC/noVNC.
- **Local only:** databases, queues, devtools, Ollama, browser debug ports, internal APIs.
- **Unexpected:** anything with no clear owner or purpose.

Common risky ports:

- SSH: `22`
- VNC/noVNC: `5900`, `5901`, `6080`, `6081`
- Browser devtools: `9222`, custom high ports
- Agent dashboards/control UIs: framework-specific ports
- Databases: `5432`, `3306`, `6379`, `27017`
- Ollama/local model APIs: `11434`
- CUPS/rpcbind: `631`, `111`

## 3. Recommended target controls

### Network

- Host firewall deny-by-default inbound.
- Allow public `80/443` only when needed.
- Allow SSH only from VPN/tailnet or known admin IPs when possible.
- Bind private services to `127.0.0.1` or VPN/tailnet IP.
- Add cloud firewall/security group rules matching the host policy.

### SSH

- `PasswordAuthentication no`
- `KbdInteractiveAuthentication no`
- `PermitRootLogin no`
- `PubkeyAuthentication yes`
- Consider `AllowUsers <admin-user>`.
- Keep a second session open while testing.

### Agent control surfaces

- Never expose unauthenticated control UIs publicly.
- Disable debug/break-glass auth bypasses.
- Prefer localhost or VPN/tailnet binding.
- Require device auth, token auth, SSO, or signed requests depending on the harness.

### Webhooks

- Require HMAC or equivalent signature validation.
- Include replay protection when possible.
- Keep secrets root/service-user readable only.
- Log event metadata, not payload secrets.

### Secrets

- `.env`, OAuth tokens, bot tokens, private keys: `0600`.
- Directories containing secrets: `0700`.
- Prefer service-specific users over shared privileged users.
- Never store secrets in repos, shell history, world-readable logs, or issue trackers.

### Services

- Run under systemd with explicit user, environment file, restart policy, and logs.
- Avoid running agent harnesses as root.
- Restrict writable paths where practical.
- Keep browser automation profiles separate from general user profiles.

### Updates and backups

- Enable unattended security updates.
- Patch app runtimes deliberately after checking release notes.
- Keep rollback backups before config changes.
- Test restore for agent configs, secrets, and state.

## 4. Approval-first remediation template

For each fix, present:

- Risk being fixed.
- Exact command(s).
- Expected impact.
- Rollback command(s).
- Verification command(s).

Example:

```text
Risk: Agent control UI is public.
Fix: Allow only VPN/tailnet interface and deny public interface.
Impact: Remote public dashboard stops working; agents keep outbound internet.
Rollback: Remove deny rule or restore firewall backup.
Verify: public probe closed, VPN probe open, service health OK.
```

## 5. Safe default firewall pattern

Ubuntu UFW example, adapt before use:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 80/tcp comment 'public HTTP'
sudo ufw allow 443/tcp comment 'public HTTPS'
sudo ufw allow in on tailscale0 to any port 22 proto tcp comment 'SSH via tailnet'
sudo ufw enable
sudo ufw status verbose
```

If SSH must remain public, keep key-only auth and consider rate limiting:

```bash
sudo ufw limit 22/tcp comment 'rate-limited SSH'
```

## 6. Verification

After each change:

```bash
ss -ltnup || ss -ltnp
sudo ufw status verbose 2>/dev/null || true
sudo nft list ruleset 2>/dev/null || true
sudo sshd -T 2>/dev/null | egrep '^(permitrootlogin|passwordauthentication|pubkeyauthentication|kbdinteractiveauthentication)'
systemctl --failed
```

From another network or VM, test public exposure:

```bash
for p in 22 80 443 5900 6080 9222 11434; do
  timeout 3 bash -c "</dev/tcp/<public-ip>/$p" >/dev/null 2>&1 && echo "open:$p" || echo "closed:$p"
done
```

## 7. Agent functionality impact

These hardening steps normally do not affect:

- outbound scraping and browsing
- API calls
- model calls
- GitHub/Gmail/Telegram integrations
- package downloads

They mainly restrict inbound public access. Be cautious with sandboxing, egress filtering, proxy changes, or disabling browser services; those can affect agent duties.
