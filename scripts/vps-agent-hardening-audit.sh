#!/usr/bin/env bash
set -euo pipefail
OUT=${1:-"vps-agent-hardening-audit-$(date -u +%Y%m%d-%H%M%S).log"}
{
  echo "### HOST"; hostname; date -Is; uname -a; cat /etc/os-release 2>/dev/null || true
  echo "### ID"; id
  echo "### IPS"; ip -brief addr || true
  echo "### LISTEN"; ss -ltnup 2>/dev/null || ss -ltnp 2>/dev/null || true
  echo "### FIREWALL_UFW"; sudo ufw status verbose 2>/dev/null || true
  echo "### FIREWALL_NFT"; sudo nft list ruleset 2>/dev/null | sed -n '1,260p' || true
  echo "### FIREWALL_IPTABLES"; sudo iptables -S 2>/dev/null | sed -n '1,260p' || true
  echo "### SSHD"; sudo sshd -T 2>/dev/null | egrep '^(port|listenaddress|permitrootlogin|passwordauthentication|pubkeyauthentication|kbdinteractiveauthentication|challengeresponseauthentication|allowusers|authenticationmethods|maxauthtries|x11forwarding|allowtcpforwarding)' || true
  echo "### SERVICES"; systemctl list-units --type=service --state=running --no-pager || true
  echo "### TIMERS"; systemctl list-timers --all --no-pager || true
  echo "### CRON"; crontab -l 2>/dev/null || true; sudo ls -la /etc/cron.d /etc/cron.daily 2>/dev/null || true
  echo "### UPDATES"; apt list --upgradable 2>/dev/null || true
  echo "### UNATTENDED"; systemctl status unattended-upgrades --no-pager 2>/dev/null | sed -n '1,80p' || true
  echo "### FAIL2BAN"; systemctl status fail2ban --no-pager 2>/dev/null | sed -n '1,80p' || true
  echo "### SECRET_FILE_METADATA_ONLY"
  find "$HOME" /etc -maxdepth 4 -type f \( -iname '*token*' -o -iname '*secret*' -o -iname '*.env' -o -iname '*credential*' -o -iname '*key*.json' \) -printf '%M %u:%g %p\n' 2>/dev/null | sort || true
} | tee "$OUT"
echo "Audit written to $OUT"
