#!/usr/bin/env bash
set -u

timestamp="$(date +%Y%m%d-%H%M%S)"
log_file="/var/log/cyberpanel-wp-restore-rollback-${timestamp}.log"

log() {
  echo "[$(date '+%F %T')] $*" | tee -a "$log_file"
}

log "Starting wp-config.php rollback"

for f in /home/*/public_html/wp-config.php; do
  [ -f "$f" ] || continue

  latest_backup="$(ls -1t "${f}.bak.cyberfix-"* 2>/dev/null | head -n 1 || true)"

  if [ -z "$latest_backup" ]; then
    log "No cyberfix backup found for $f"
    continue
  fi

  current_backup="${f}.pre-rollback-${timestamp}"
  cp -a "$f" "$current_backup"
  cp -a "$latest_backup" "$f"

  log "Restored $f from $latest_backup"
  log "Current file backup stored at $current_backup"
done

log "Restarting OpenLiteSpeed"
systemctl restart lsws

log "Rollback completed"
