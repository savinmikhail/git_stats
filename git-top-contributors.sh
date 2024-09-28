#!/bin/bash

# Time range (e.g., last 1 month) - corrected
TIME_RANGE="--since=1.month.ago"

# Get all contributors and calculate lines of code added, removed, and total
git log --all $TIME_RANGE --pretty='%aN' | sort -u | while read -r author; do
  git log --all --author="$author" $TIME_RANGE --pretty=tformat: --numstat |
  awk -v author="$author" '{
    added += $1;
    removed += $2;
    total += $1 - $2;
  } END {
    if (added + removed > 0) {
      printf "%-25s | Added: %6d | Removed: %6d | Total: %6d\n", author, added, removed, total;
    }
  }'
done | sort -t: -k4 -n -r
