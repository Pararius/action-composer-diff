GitHub action to post a diff of updated composer dependencies

## Usage

```yaml
post-composer-diff:
  runs-on: ubuntu-latest
  steps:
  - uses: actions/checkout@v2.3.4
  - uses: Pararius/action-composer-diff@v0.1.0
```
