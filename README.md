# Configuration — JSL Positron and R workstation

Reproducible Windows setup for **Positron**, **R**, **Air**, and **JSL Research Rail v0.1.3**, using the JSL Academic Instrument dark palette.

> **Complete source bundle:** [Download Configuration-complete.zip from the associated ChatGPT conversation]. The repository is currently being bootstrapped; the ZIP includes the extension source, 38 automated tests, installable VSIX, full README, global settings and Windows installer. The binary and remaining files have **not** yet been uploaded to this GitHub repository.

## New Windows computer

1. Install [R](https://cran.r-project.org/bin/windows/base/), [Positron](https://positron.posit.co/), and optionally [IBM Plex Mono](https://fonts.google.com/specimen/IBM+Plex+Mono).
2. In Positron, start an R console, then check:
   ```r
   normalizePath(file.path(R.home("bin"), "Rscript.exe"), winslash="/", mustWork=TRUE)
   ```
3. Download the **complete source bundle** and extract the `Configuration` folder.
4. Run `powershell -ExecutionPolicy Bypass -File .\scripts\install-windows.ps1` from that folder. The script backs up existing settings and merges JSL defaults. For JSONC settings containing comments, perform a manual merge as described in the bundle's README.
5. In Positron → Extensions → `...` → **Install from VSIX…**, select `extensions/jsl-research-rail-0.1.3.vsix`. Reload.
6. Run **JSL Research Rail: Open Annotation Rail**, then move its view from the Activity Bar to the **Secondary Side Bar**.
7. In Settings (JSON), verify `[r].editor.defaultFormatter` is `jsl-local.jsl-research-rail` and `jslResearchRail.rscriptPath` is `auto`.
8. Use **Apply Extension to All Profiles** and confirm that editor settings and the R formatter persist across custom profiles. Project-level configurations may override global defaults.

## Result

- R code: IBM Plex Mono, dark plum background, parchment foreground, subdued crimson accents.
- Air: 88-character line width, two-space indentation and persistent line breaks.
- Research Rail: separate `.comment` annotations; assignment breaks after `<-` except `function(...)` declarations; expanded `c()`, `tibble()`, and `data.frame()` calls; aligned named arguments.
- Formatting safeguards: parse-tree checks, comment integrity, repeated-formatting stability and safe fallback.

## Verification and troubleshooting

Open a scratch R file, format twice, and confirm the second pass is a no-op. Add a Research Rail annotation, close/reopen, and confirm its sidecar persists. If a formatter warning appears, inspect **Output → JSL Research Rail**; temporarily switch the R default formatter to `Posit.air-vscode`.

The 38 local extension tests pass; Windows Positron/R/Air live integration has not been independently run in this environment.

**Security:** This repository should contain no credentials, machine-specific R paths or proprietary font binaries.
