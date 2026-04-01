# OpenClaw Config

This repository contains the configuration, skills, and tools for an **OpenClaw** deployment. OpenClaw is an automation and monitoring system that orchestrates "skills" to perform tasks like tracking expenses and monitoring emails.

## Project Structure

- `bins/`: High-level management scripts (setup, deploy, backup, init_db).
- `skills/`: Modular functional units.
    - `expenses-track/`: Tracks credit card and cash expenses using email parsing and image recognition.
    - `school-mail-monitor/`: Monitors and summarizes school-related emails.
- `tools/`: Reusable utility scripts.
    - `database/`: SQL execution wrappers.
    - `mail/`: Gmail fetching and parsing utilities.
- `data/`: Local SQLite databases (e.g., `expense.db`).
- `deploy_config.json`: Master configuration for enabled skills and cron schedules.

## Tech Stack

- **Automation**: OpenClaw
- **Database**: SQLite3
- **Email**: Gmail (via `gog` CLI and custom scripts)
- **Messaging**: Slack (for reports and user interaction)
- **Scripting**: Bash / Shell

## Key Workflows

### 1. Expense Tracking
- **Automated**: Cron jobs fetch emails from specific senders (`info@tscubic.com`, `statement@vpass.ne.jp`), parse transactions, and log them to `data/expense.db`.
- **Manual**: Users can upload receipts or screenshots; the skill processes them and asks for confirmation.
- **Reporting**: Generates daily and monthly reports via cron.

### 2. School Mail Monitoring
- Fetches emails from Veracross and ISSH.
- Summarizes content in **Chinese**.
- Extracts action items and deadlines.
- Posts reports to Slack.

## Developer & AI Instructions

### Environment Variables
- `$MY_OPENCLAW_ROOT`: The root of this repository.
- `$OPENCLAW_ROOT`: Absolute path to the root of OpenClaw in server
- `$GOG_KEYRING_PASSWORD`: gog script env for auth
- `$GOG_ACCOUNT`: The Gmail account used for fetching emails.
- `$SLACK_WEBHOOK_URL`: Slack incoming webhook URL for reports

### Adding a New Skill
1. Create a directory in `skills/`.
2. Add a `SKILL.md` following the existing format (metadata, description, workflows).
3. (Optional) Add supporting scripts in a `scripts/` subdirectory within the skill.
4. Enable the skill in `deploy_config.json`.

### Database Operations
Use the tools in `tools/database/` or the scripts in `bins/` to interact with the databases. Avoid direct `sqlite3` calls if a tool is available.

### Git Conventions
- Do not commit files in `data/` or `tmp/`.
- Ensure scripts in `bins/` and `tools/` have execution permissions.
