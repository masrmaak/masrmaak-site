#!/usr/bin/env bash
set -euo pipefail

files=(index.html login.html register.html app.html)
for file in "${files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing interface file: $file" >&2
    exit 1
  fi
done

if grep -En 'font-size:[[:space:]]*([0-9]|1[0-5])px|font:[^;{}]*[[:space:]]([0-9]|1[0-5])px' "${files[@]}"; then
  echo "Typography check failed: visible interface text must not be smaller than 16px." >&2
  exit 1
fi

if ! grep -q 'ENFORCED TYPOGRAPHY CONTRACT' app.html; then
  echo "Typography check failed: the enforced application contract is missing." >&2
  exit 1
fi

echo "Typography check passed: all explicit interface sizes are at least 16px."
