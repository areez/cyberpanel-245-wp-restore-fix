#!/usr/bin/env bash
set -u

timestamp=$(date +%Y%m%d-%H%M%S)

backup_wp_config() {
  cp -a "$1" "$1.bak.cyberfix-$timestamp"
}

insert_if_missing() {
  grep -Fq "$2" "$1" || sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i $3" "$1"
}

for d in /home/*; do
  [ -d "$d/public_html" ] || continue

  u=$(stat -c '%U' "$d")

  chown -R "$u:$u" "$d/public_html"
  find "$d/public_html" -type d -exec chmod 755 {} \;
  find "$d/public_html" -type f -exec chmod 644 {} \;
done

for f in /home/*/public_html/wp-config.php; do
  [ -f "$f" ] || continue

  backup_wp_config "$f"

  insert_if_missing "$f" "define('FS_METHOD', 'direct');" "define('FS_METHOD', 'direct');"
  insert_if_missing "$f" "define('FS_CHMOD_DIR', 0755);" "define('FS_CHMOD_DIR', 0755);"
  insert_if_missing "$f" "define('FS_CHMOD_FILE', 0644);" "define('FS_CHMOD_FILE', 0644);"
done

for d in /home/*/public_html/wp-content; do
  [ -d "$d" ] || continue

  rm -f "$d/object-cache.php" "$d/advanced-cache.php" "$d/.litespeed_conf.dat"
  rm -rf "$d/cache/"* "$d/litespeed/"* 2>/dev/null
done

systemctl restart lsws

echo "CyberPanel WordPress restore fix completed."
