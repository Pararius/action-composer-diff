GitHub action to post a diff of updated composer dependencies

## Usage

```yaml
post-composer-diff:
  runs-on: ubuntu-latest
  steps:
  - uses: actions/checkout@v2.3.4
  - uses: Pararius/action-composer-diff@v0.2.0
```

If `composer.lock` is not in the root, but under `foo/bar`:

```yaml
post-composer-diff:
  runs-on: ubuntu-latest
  steps:
  - uses: actions/checkout@v2.3.4
  - uses: Pararius/action-composer-diff@v0.2.0
    with:
      base_path: foo/bar
```
