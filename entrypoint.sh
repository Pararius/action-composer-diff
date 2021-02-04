#!/bin/bash -l

git fetch --no-tags --prune --depth=1 origin "${GITHUB_BASE_REF}"

DIFF="$(composer-lock-diff --path="${BASE_PATH}" --from="origin/${GITHUB_BASE_REF}" --to="${GITHUB_SHA}" --md)"

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
