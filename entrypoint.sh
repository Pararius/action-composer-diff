#!/bin/bash -l

DIFF="$(composer-lock-diff --from=HEAD --to="${GITHUB_SHA}" --md)"

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

curl -LSs \
  -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY}/issues/${PULL_REQUEST}/comments" \
  -d "{\"body\":${BODY}}"
