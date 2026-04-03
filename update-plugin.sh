#!/usr/bin/env bash
set -euo pipefail

# update-plugin.sh — Update the installed bildhauer plugin after pushing changes.
# Usage: ./update-plugin.sh
# After running, use /reload-plugins in Claude Code to pick up changes.

echo "Updating bildhauer marketplace..."
claude plugin marketplace update bildhauer-marketplace

echo "Reinstalling plugin..."
claude plugin uninstall bildhauer@bildhauer-marketplace
claude plugin install bildhauer@bildhauer-marketplace

echo ""
echo "Done. Run /reload-plugins in Claude Code to activate."
