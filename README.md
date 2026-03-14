
# CyberPanel WordPress Restore Fix

Author: **Areez Afsar Khan**

This project provides shell scripts to repair common **WordPress permission and filesystem issues after restoring sites on CyberPanel + OpenLiteSpeed**.

---

## Background

This script was created to address the issue reported in the CyberPanel GitHub repository:

https://github.com/usmannasir/cyberpanel/issues/1735

In that issue, WordPress sites restored from backups sometimes end up with incorrect ownership inside:

/home/<domain>/public_html

When this happens WordPress cannot write to the filesystem and starts asking for **FTP credentials** when:

- installing plugins
- updating plugins
- updating themes
- uploading media
- enabling LiteSpeed cache features

The scripts in this repository automate the repair process across all domains.

---

## What the fix script does

`scripts/fix-cyberpanel-wp-restore.sh` will:

1. Fix file ownership for all CyberPanel domains under `/home/*/public_html`
2. Reset safe default permissions
3. Create timestamped backups of every `wp-config.php`
4. Add the following WordPress filesystem constants **only if they do not already exist**

```php
define('FS_METHOD', 'direct');
define('FS_CHMOD_DIR', 0755);
define('FS_CHMOD_FILE', 0644);
```

5. Clear common LiteSpeed cache artifacts
6. Restart OpenLiteSpeed

---

## Rollback script

`scripts/restore-wp-config-backups.sh`

If anything goes wrong, this script restores the most recent `wp-config.php` backup created by the fix script.

---

## Requirements

- CyberPanel server
- OpenLiteSpeed
- WordPress sites located in `/home/<domain>/public_html`
- Root or sudo access

---

## Usage

Make scripts executable:

```bash
chmod +x scripts/*.sh
```

Run the repair script:

```bash
sudo ./scripts/fix-cyberpanel-wp-restore.sh
```

Rollback wp-config changes if needed:

```bash
sudo ./scripts/restore-wp-config-backups.sh
```

---

## License

MIT License

This script is **free to use, modify, and distribute**.

You are welcome to adapt or improve it for your own infrastructure or hosting environment.

---

## Contribution

If you improve the script or adapt it for other hosting environments, feel free to fork and contribute improvements.
