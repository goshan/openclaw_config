#!/bin/bash

echo "Backup..."

HOME_DIR=$(cd "$(dirname "$0")/.." &> /dev/null && pwd)
OPENCLAW_DIR="$HOME/.openclaw"
OPENCLAW_CRON="$OPENCLAW_DIR/cron/jobs.json"
OPENCLAW_SKILL="$OPENCLAW_DIR/workspace/skills"
BACKUP_DIR="$HOME_DIR/backup"
TIME=$(date "+%Y%m%d%H%M%S")

mkdir -p $BACKUP_DIR

skill_backup="$BACKUP_DIR/skills_$TIME.bak"
cp -r "$OPENCLAW_SKILL/" "$skill_backup"
# only keep the latest 3 backups
printf '%s\n' "$BACKUP_DIR"/skills_*.bak | sort -r | tail -n +4 | xargs -I {} rm -rf -- "{}"
echo "  - skills -> $skill_backup"

crontab_backup="$BACKUP_DIR/crontab_$TIME.bak"
crontab -l > $crontab_backup
# only keep the latest 3 backups
printf '%s\n' "$BACKUP_DIR"/crontab_*.bak | sort -r | tail -n +4 | xargs -I {} rm -- "{}"
echo "  - crontab -> $crontab_backup"

openclaw_cron_backup="$BACKUP_DIR/openclaw_jobs_$TIME.bak.json"
cp $OPENCLAW_CRON $openclaw_cron_backup
# only keep the latest 3 backups
printf '%s\n' "$BACKUP_DIR"/openclaw_jobs_*.bak.json | sort -r | tail -n +4 | xargs -I {} rm -- "{}"
echo "  - openclaw jobs -> $openclaw_cron_backup"

db_backup="$BACKUP_DIR/data_$TIME.bak"
cp -r "$HOME_DIR/data/" "$db_backup"
# only keep the latest 3 backups
printf '%s\n' "$BACKUP_DIR"/data_*.bak | sort -r | tail -n +4 | xargs -I {} rm -rf -- "{}"
echo "  - database -> $db_backup"

echo "Backup finished"
echo ""
