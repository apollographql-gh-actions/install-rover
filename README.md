# Install Rover CLI GitHub Action

This is a GitHub Action to install the [Apollo Rover CLI](https://rover.apollo.dev/) on GitHub Actions runners. Once installed, `rover` is added to `PATH`, so it can be used in subsequent steps.

### Inputs

| Name | Description | Default |
| ---- | ----------- | ------- |
| `version` | The version of [`rover`](https://rover.apollo.dev/) to install | `latest` |

### Usage

Installing a specific version of `rover`:

```yaml
- uses: apollographql-gh-actions/install-rover@v1
  with:
    version: 0.28.1
```

Install the latest version:

```yaml
- uses: apollographql-gh-actions/install-rover@v1
```

Run a manual rover command after install:

```yaml
- uses: apollographql-gh-actions/install-rover@v1
- name: Run manual schema check (instead of included commands)
  env:
    APOLLO_KEY: ${{ secrets.APOLLO_KEY }}
  run: rover subgraph check ${{ vars.APOLLO_GRAPH_REF }} --name subgraph-name --schema ./path/to/schema.graphql
```
