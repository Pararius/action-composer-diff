#!/bin/sh -l

diff="$(composer-lock-diff --from=HEAD --md)"
diff="${diff//'%'/'%25'}"
diff="${diff//$'\n'/'%0A'}"
diff="${diff//$'\r'/'%0D'}"

echo "::set-output name=diff::$diff"
