# Electronification demo

A throwaway Shiny app that exercises the
[`coatless-actions/shiny-to-electron`](https://github.com/coatless-actions/shiny-to-electron)
GitHub Action end to end. Each push runs the action across a small matrix of
runners and runtime strategies. Pushing a `v*` tag publishes the resulting
installers as a GitHub Release.

## What the action does here

The workflow at `.github/workflows/build.yml`:

- checks the repo out,
- runs `coatless-actions/shiny-to-electron` against `app/`,
- the action sets up R and Node.js, installs `shinyelectron` from GitHub,
  and calls `shinyelectron::export()` for the runner's OS / arch,
- ships the resulting `.dmg`, `.exe`, or `.AppImage` as a workflow artifact.

## The Shiny app

`app/app.R` is a histogram-of-rnorm slider toy. Two inputs (sample size,
standard deviation), one plot, one numerical summary. Enough to stress the
build pipeline; small enough to fit in a comment.

## Cutting a release

```bash
git tag v0.1.0
git push origin v0.1.0
```

Each runner produces a platform-specific installer; the release job
downloads everything and attaches it to a fresh GitHub Release.

## See also

- [`shinyelectron`](https://github.com/coatless-rpkg/shinyelectron) — the R
  package that does the heavy lifting.
- [`shiny-to-electron`](https://github.com/coatless-actions/shiny-to-electron)
  — the composite action this repo consumes.
