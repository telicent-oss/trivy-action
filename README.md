# Trivy Action

This repository provides a GitHub Action that wraps our standard patterns of usage of the [Aqua Security Trivy
Action][1], [Aqua Security Setup Trivy Action][2] and [Trivy Cache Action][3] into a composite action so we can simplify
our workflows and standardise improvements to how we surface Trivy scan information in our builds.

# Usage

At its most basic the action is used as follows:

```yaml
name: Trivy Scan Example
on: 
  push:
  workflow_dispatch:

jobs:
  example:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      # Normal Job setup steps happen...
     
      # Run a Trivy Filesystem Scan
      - name: Trivy Filesystem Scan
        uses: telicent-oss/trivy-action@v1
        with:
          scan-type: fs
          scan-ref: .
          scan-name: maven-poms
          uses-java: true

      # Some more build steps that generate a Docker image...

      # Run a Trivy Image Scan
      - name: Trivy Image Scan
        uses: telicent-oss/trivy-action@v1
        with:
          scan-type: image
          scan-ref: telicent/some-image@1.2.3
          scan-name: some-image
          uses-java: true
```

In the above example we invoke the action twice, once to do a `fs` scan and another to do an `image` scan.

# Inputs

| Input | Required? | Default | Purpose |
|-------|-----------|---------|---------|
| `scan-type` | Yes | N/A | Specifies the kind of Trivy scan to run, one of `fs`, `image`, `config` or `sbom` |
| `scan-ref` | Yes | N/A | Specifies what to scan, for `scan-type` of `fs`/`sbom` this is a file system path, for `image` this is a reference to a container image, for `config` this is a reference to a Dockerfile |
| `scan-name` | Yes | N/A | A unique name (within the calling workflow) for this scan used to disambiguate the scan artifacts when they are attached as artifacts to the build. |
| `uses-java` | No | `false` | If your scans involve Java code, whether for `fs` or `image` scans, then set this to `true` to ensure the Trivy Java DB is additionally downloaded and cached |
| `allow-unfixed` | No | `false` | Sets the `ignore-unfixed` input passed on to the [`aquasecurity/trivy-action`][1] that controls whether unfixed HIGH/CRITICAL severity vulnerabilities fail the build. |
| `gh-token` | No | `github.token` | Sets the GitHub token used to authenticate to GitHub to fetch Trivy release metadata to determine whether the cache needs updating. |

# Outputs

| Output | Description |
|--------|-------------|
| `scan-results` | Name of a GitHub Actions artifact that has been uploaded and contains the full Trivy JSON results. |
| `scan-results-file` | Name of the Trivy JSON file within the uploaded GitHub Actions artifact. |
| `scan-results-url` | Full URL to the uploaded artifact. |

[1]: https://github.com/aquasecurity/trivy-action
[2]: https://github.com/aquasecurity/setup-trivy
[3]: https://github.com/yogeshlonkar/trivy-cache-action
