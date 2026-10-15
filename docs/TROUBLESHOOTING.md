# Troubleshooting

- **Rscript ENOENT:** Find Rscript from `R.home("bin")` and configure the full path in `jslResearchRail.rscriptPath`.
- **Annotation rail command missing:** Install Research Rail v0.1.3, reload Positron, open the command explicitly and move the Activity Bar view into the Secondary Sidebar.
- **Composite formatter not idempotent:** Read Output → JSL Research Rail. Use Air-only formatting temporarily instead of disabling safety guards.
- **Different configuration in a project:** Inspect local `.vscode/settings.json` or `air.toml`.
- **Different profile:** Check the editor's **Apply Setting to All Profiles** and **Apply Extension to All Profiles** features.
- **Old R comments still visible:** Sidecar annotations are deliberately separate and do not remove source comments.

For reproduction, include versions, diagnostics and minimal synthetic R code, not private source datasets or secrets.
