# CyberPanel WordPress Restore Fix

![License](https://img.shields.io/github/license/areez/cyberpanel-245-wp-restore-fix)
![Stars](https://img.shields.io/github/stars/areez/cyberpanel-245-wp-restore-fix)
![Issues](https://img.shields.io/github/issues/areez/cyberpanel-245-wp-restore-fix)
![Bash](https://img.shields.io/badge/bash-compatible-green)
![CyberPanel](https://img.shields.io/badge/CyberPanel-2.4.x-blue)
![OpenLiteSpeed](https://img.shields.io/badge/OpenLiteSpeed-supported-orange)
![WordPress](https://img.shields.io/badge/WordPress-supported-blue)

A utility script to fix **WordPress restore permission issues on
CyberPanel servers** running OpenLiteSpeed.

> Fixes the issue discussed here:\
> https://github.com/usmannasir/cyberpanel/issues/1735

------------------------------------------------------------------------

# Overview

When WordPress sites are restored from backups on CyberPanel servers,
file ownership and permissions may become inconsistent. This can lead
to:

-   WordPress asking for **FTP credentials**
-   Plugins/themes failing to install
-   Media uploads failing
-   LiteSpeed Cache initialization errors
-   Object cache issues

This script automates the process of fixing those problems safely.

------------------------------------------------------------------------

# Workflow

![Workflow](docs/workflow.png)

Process:

1.  Scan `/home/*` for CyberPanel domains
2.  List sites in numbered format
3.  User selects target sites
4.  Fix ownership
5.  Fix permissions
6.  Backup `wp-config.php`
7.  Clear LiteSpeed cache artifacts
8.  Restart OpenLiteSpeed
9.  Print summary report

------------------------------------------------------------------------

# Features

-   Safe **ownership repair**
-   Automatic **permission correction**
-   **wp-config backup** before modification
-   **Dry run mode**
-   **Interactive site selection**
-   **Multi-site support**
-   **Rollback script included**
-   Works with **100+ domains**
-   **Verbose logging**
-   **Summary report at completion**

------------------------------------------------------------------------

# Screenshots

## Site discovery

![Discovery](docs/scan.png)

## Processing site

![Processing](docs/processing.png)

## Cache cleanup

![Cache](docs/cache-clean.png)

## Restarting OpenLiteSpeed

![Restart](docs/restart.png)

## Final summary

![Summary](docs/summary.png)

------------------------------------------------------------------------

# Installation

Clone the repository:

    git clone https://github.com/areez/cyberpanel-245-wp-restore-fix.git
    cd cyberpanel-245-wp-restore-fix
    chmod +x scripts/*.sh

------------------------------------------------------------------------

# Usage

Run the script:

    sudo ./scripts/fix-cyberpanel-wp-restore.sh

The script will:

1.  Detect all CyberPanel domains
2.  Show a numbered list
3.  Allow you to choose which sites to process

------------------------------------------------------------------------

# Dry Run Mode

Preview actions without applying changes:

    DRY_RUN=1 sudo ./scripts/fix-cyberpanel-wp-restore.sh

------------------------------------------------------------------------

# Run for One Domain

    DOMAIN=example.com sudo ./scripts/fix-cyberpanel-wp-restore.sh

------------------------------------------------------------------------

# Rollback

If you need to revert `wp-config.php` changes:

    sudo ./scripts/restore-wp-config-backups.sh

------------------------------------------------------------------------

# Logs

Execution logs are stored in:

    /var/log/cyberpanel-wp-restore-fix-*.log

------------------------------------------------------------------------

# Warning

-   Run this script **as root**
-   Always test on **one domain first** if running on production servers
-   The rollback script restores **only wp-config.php**

------------------------------------------------------------------------

# One Command Run (Optional)

For quick execution:

    curl -sSL https://raw.githubusercontent.com/areez/cyberpanel-245-wp-restore-fix/main/scripts/fix-cyberpanel-wp-restore.sh | sudo bash

------------------------------------------------------------------------

# Author

**Areez Afsar Khan**

Entrepreneur, DevOps practitioner, and founder of Valiant Technologies.

------------------------------------------------------------------------

# License

MIT License

This project is **free to use, modify, and distribute**.
