# Changelog

## v1.1.1 - First-day checklist patch

- Added `FirstDayChecklist` output in ignored `generated/first-day-checklist.md`.
- Updated `OnboardingReport` to generate the first-day checklist automatically.
- Tightened `ReleaseAudit` so releases fail when reusable files have uncommitted changes.

## v1.1.0 - Release readiness and scalable onboarding

- Added client capability metadata for Codex, Claude Code, and Gemini CLI.
- Added `ReleaseAudit`, `CatalogReview`, `TestFixtures`, and `ItRequest` actions.
- Added profile fixture checks for expected MCP server names.
- Added generated `onboarding-state.json` alongside the human onboarding report.
- Added optional `KEY_FILE` secret loading so local env files can point to ignored secret files.
- Expanded validation to parse all PowerShell modules and check the new support files.
- Expanded GitHub Actions validation with fixture, catalog, and release-audit checks.

## v1.0.0 - First stable release

- Added self-validation for reusable kit files, catalog metadata, profile references, and secret hygiene.
- Added `Doctor` diagnostics for first-day machine readiness and selected tool state.
- Added `OnboardingReport` generation in ignored `generated/onboarding-report.md`.
- Added reusable tool profiles: `minimal`, `google-workspace`, `analytics-core`, `browser-testing`, and `full-web-analyst`.
- Added catalog decision metadata for maintainability: officialness, auth friction, runtime, data exposure, write capability, risk level, and verification date.
- Added JSON schemas for catalog, tool selection, and profiles.
- Added IT request templates and data/credential safety guidance.
- Added GitHub Actions validation workflow.

## v0.1.0 - Initial release

- Added AGENTS workflow, README quick start, MCP catalog, tool-selection example, secret template, and Windows setup helper.
