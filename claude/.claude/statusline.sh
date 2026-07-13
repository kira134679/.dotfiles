#!/bin/bash
# Read JSON data that Claude Code sends to stdin
input=$(cat)

# Extract fields using jq
MODEL=$(echo "$input" | jq -r '.model.display_name')
EFFORT=$(echo "$input" | jq -r '.effort.level')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
# The "// 0" provides a fallback if the field is null
CTX_USAGE=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

FIVE_HOUR_USED=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
WEEK_USED=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
FIVE_HOUR_RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
WEEK_RESET=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

LIMITS=""
[ -n "$FIVE_HOUR_USED" ] && LIMITS="5h: $(printf '%.0f' "$FIVE_HOUR_USED")%"
[ -n "$WEEK_USED" ] && LIMITS="${LIMITS:+$LIMITS }7d: $(printf '%.0f' "$WEEK_USED")%"

COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
COST_FMT=$(printf '$%.0f' "$COST")

# Output the status line - ${DIR##*/} extracts just the folder name
echo "$MODEL • $EFFORT 󱉭  ${DIR##*/} 󱘲   ${CTX_USAGE}%  USD$COST_FMT"
echo "$LIMITS"
