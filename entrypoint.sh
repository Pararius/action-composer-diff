#!/bin/bash -l

REPO="$1"
PR="$2"
FROM="$3"
TO="$4"
TOKEN="$5"

DIFF="$(composer-lock-diff --from="$FROM" --to="$TO" --md)"

outputDiff="${DIFF}"
outputDiff="${outputDiff//'%'/'%25'}"
outputDiff="${outputDiff//$'\n'/'%0A'}"
outputDiff="${outputDiff//$'\r'/'%0D'}"

echo "::set-output name=diff::$outputDiff"

if test -z "${DIFF}"; then
  echo "No changed dependencies"
  exit 0
fi

BODY="$(printf 'The following Composer dependencies have been changed:\n\n%s' "${DIFF}" | jq -aRs '.')"

curl -q \
  -X POST \
  -H "Authorization: token ${TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/${REPO}/issues/${PR}/comments" \
  -d "{\"body\":${BODY}}"
