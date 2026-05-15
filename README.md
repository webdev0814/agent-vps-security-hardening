# VPS Agent Harness Security Hardening

A harness-agnostic security hardening procedure for running AI agents, automation harnesses, chatbots, browser workers, and orchestration services on public VPS hosts.

It is intentionally not tied to OpenClaw, Hermes, LangChain, AutoGen, CrewAI, custom Python bots, Node services, or any specific agent framework. The procedure focuses on the host and deployment boundary: network exposure, SSH, firewall, secrets, service isolation, logs, updates, backups, and rollback.

## What this procedure does

- Builds an inventory of public and private listening services.
- Classifies ports into public, private/Tailscale/VPN-only, localhost-only, and unexpected.
- Protects human and agent access paths before applying changes.
- Recommends a deny-by-default inbound firewall posture.
- Keeps outbound internet access available for scraping, browsing, API calls, model calls, package downloads, Gmail, GitHub, Telegram, and other normal agent duties.
- Hardens SSH without locking out the operator.
- Identifies risky agent control surfaces and browser/VNC/noVNC/admin dashboards.
- Reviews secrets and credential file permissions without printing secrets.
- Checks automatic updates, backups, cron/systemd timers, and exposed web proxies.
- Produces an approval-first remediation plan before any state-changing action.

## What it does not do automatically

- It does not blindly close ports.
- It does not disable outbound internet.
- It does not rotate or print secrets.
- It does not change SSH/firewall rules without an access-preservation plan.
- It does not assume a particular cloud provider firewall; it checks host firewalls and reminds you to verify the cloud security list/security group separately.

## Target environment

- Public VPS or cloud VM.
- Linux systemd host, typically Ubuntu/Debian, though the checklist is portable.
- One or more long-running agent harnesses or automation services.
- Optional VPN/tailnet such as Tailscale, WireGuard, ZeroTier, or a private VPC network.

## Recommended posture

For most agent VPS setups:

- Public inbound: only `80/tcp` and `443/tcp` if serving public webhooks or dashboards intentionally.
- SSH: key-only; root login disabled; ideally restricted to VPN/tailnet or known admin IPs.
- Agent control UIs: localhost or VPN/tailnet only; strong auth enabled.
- Browser/VNC/noVNC/devtools/debug ports: localhost or VPN/tailnet only.
- Webhooks: public only if required; otherwise private network only; always signed.
- Secrets: `0600`, owned by the service user or root, never logged.
- Services: least-privilege systemd units; explicit environment files; predictable restart behavior.
- Updates: unattended security updates enabled; planned app/runtime updates.
- Backups: tested restore path for configs, secrets, and agent state.

## Quick start

Run the read-only audit first:

```bash
bash scripts/vps-agent-hardening-audit.sh
```

Then read `docs/PROCEDURE.md` and decide which remediation steps to approve.

## Approval-first workflow

1. Inventory the host.
2. Identify required public services.
3. Confirm the operator's access path.
4. Produce a rollback plan.
5. Apply one small change at a time.
6. Verify access and service health after each change.
7. Re-run the audit.

## License

MIT — see [LICENSE](LICENSE).
