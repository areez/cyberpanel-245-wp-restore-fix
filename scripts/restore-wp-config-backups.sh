#!/usr/bin/env bash
set -u

timestamp=$(date +%Y%m%d-%H%M%S)

for f in /home/*/public_html/wp-config.php; do
  [ -f "$f" ] || continue

  latest_backup=$(ls -1t "$f.bak.cyberfix-"* 2>/dev/null | head -n 1)

  [ -z "$latest_backup" ] && continue

  cp -a "$f" "$f.pre-rollback-$timestamp"
  cp -a "$latest_backup" "$f"

  echo "Restored $f from $latest_backup"
done

systemctl restart lsws

echo "Rollback completed."
