# Web Analyst MCP Setup

Version: 1.1.1

Windows-first setup kit for daily web analyst work with AI agents such as Codex, Claude Code, and Gemini CLI.

Open this folder in your agent and say:

```text
Read AGENTS.md and guide me through the web analyst setup.
```

The agent should ask a few questions, optionally apply a profile, configure the local files itself, run the setup script, and pause only for browser approval, vendor-console access, or credentials it cannot create for you.

The kit is optimized for first-day setup on a new company PC: use approved company credentials when available, get connected successfully, and keep official/future MCP paths documented without letting them block onboarding.

For Google tools, the order of preference is: company-provided OAuth credentials, vendor/browser OAuth, a company-approved managed-auth broker, then a new Google Cloud project only as a last resort.

Detailed Google Console steps are handled during the setup conversation when needed, using the selected tools and current Google screens. The reusable kit keeps only the stable checklist.

The kit is for onboarding and connection. One-off mailbox, Drive, or client-data cleanup tasks should stay outside the reusable setup instructions.

## First-Day Flow

The agent should run the setup as a guided onboarding flow:

1. Identify the AI client, selected tools, company context, and credential policy.
2. Apply a profile when useful: `minimal`, `google-workspace`, `analytics-core`, `browser-testing`, or `full-web-analyst`.
3. Inspect the PC before installing anything.
4. Choose the approved credential route for each selected tool.
5. Install only the prerequisites required by those choices.
6. Write MCP configuration, authenticate, reload the AI client if needed, and run harmless read-only smoke tests.
7. End with an onboarding report and structured onboarding state: ready tools, blocked tools, missing approvals, and whether reset is needed later for testing/reuse.

Current default paths:

- Google Drive and Gmail: well-known local Node MCP defaults for practical first-day browser login; official Google Workspace remote MCPs remain available when the company requires first-party remote MCPs and the selected client supports custom Google OAuth credentials.
- GA4: official Google Analytics MCP through `analytics-mcp` and Google ADC/browser login.
- Google Tag Manager: Stape remote OAuth MCP.
- BigQuery: official Google Cloud remote BigQuery MCP, with Google MCP Toolbox for Databases as the controlled fallback when local/allowlisted query tooling is required.
- Browser QA: official Playwright MCP for journey testing, consent checks, ecommerce paths, forms, screenshots, and repeatable browser interaction. The helper detects installed/default browsers and can use Microsoft Edge instead of requiring Google Chrome.
- Browser Debug: official Chrome DevTools MCP for optional advanced console, network, screenshot, and performance debugging. The helper can launch a compatible Chromium browser such as Microsoft Edge via executable path when Chrome is not installed.
- ClickUp: official remote MCP.
- Trello: current third-party candidate MCP.
- Piano Analytics: official private-beta MCP, plus a Piano API connector fallback.
- Contentsquare: official MCP.
- Tag Commander / Commanders Act: API connector.

Generated files and credentials stay local and are ignored by git. Do not reuse credentials from a previous employer or agency for a new company.

Browser Debug can inspect browser content. Use it deliberately on logged-in, internal, or sensitive pages.

See `docs/data-and-credential-safety.md` for the security model and `docs/it-request-templates.md` for copy-pasteable approval requests.

## Files

Core reusable files:

- `AGENTS.md`: the conversation workflow and analyst operating rules.
- `scripts/WebAnalystSetup.ps1`: the PowerShell helper for prerequisites, MCP config, status, connection commands, Google OAuth helpers, and resets.
- `config/mcp-catalog.json`: MCP/API catalog used by the helper.
- `config/tool-selection.example.json`: default tool choices copied to local ignored `tool-selection.json`.
- `config/tool-profiles.json`: reusable onboarding profiles for common first-day setups.
- `config/client-capabilities.json`: client-specific config targets and reload/login guidance.
- `secrets/.env.template`: copied to local ignored `secrets/.env.local`.
- `schemas/*.schema.json`: schema documentation and validation targets for catalog/selection/profile files.
- `tests/fixtures/profile-server-names.json`: expected MCP server names for reusable profiles.
- `scripts/lib/*.ps1`: focused helper modules for release audit, catalog review, IT requests, and fixture tests.
- `docs/`: security guidance and IT request templates.
- `.github/workflows/validate.yml`: GitHub Actions validation for releases and pull requests.
- `.gitignore`: keeps credentials and generated machine-specific files out of the reusable kit.

Local runtime files are disposable and ignored by git:

- `config/tool-selection.json`
- `secrets/.env.local`
- `generated/*`
- `.mcp.json`, `.codex/config.toml`, `.gemini/settings.json`

## Manual Commands

These commands are not required in normal use. The agent should run them for you during the conversation. They are kept here as a fallback when you want to debug, rerun a step, or understand what the agent is doing.

- `Prepare`: creates local ignored files from templates.
- `UseProfile`: applies a reusable tool profile to local ignored `config/tool-selection.json`.
- `Validate`: validates reusable kit files, JSON, PowerShell syntax, catalog metadata, profiles, and secret hygiene.
- `Doctor`: prints a first-day readiness report for the machine, local state, prerequisites, browser, and selected tools.
- `ItRequest`: writes an ignored access-request draft to `generated/it-request.md`.
- `Prereqs`: checks and installs needed prerequisites such as Node.js, Git, Python/pipx, or Google Cloud CLI depending on selected providers.
- `CheckMcpUpdates`: checks selected MCP packages before install/config generation; npm-based MCPs should use `@latest`.
- `Apply`: writes MCP configuration for the selected AI client.
- `Dashboard`: prints enabled tools, missing credentials, and reconnect/auth commands in the terminal.
- `Status`: checks selected tool status, visible MCP client state, and lightweight Google token scope/API reachability where possible.
- `FirstDayChecklist`: writes an ignored action checklist to `generated/first-day-checklist.md`.
- `OnboardingReport`: writes an ignored handover report to `generated/onboarding-report.md`, machine-readable state to `generated/onboarding-state.json`, and the first-day checklist.
- `CatalogReview`: writes an ignored catalog maintainability report to `generated/catalog-review.md`.
- `TestFixtures`: checks reusable profile expectations against `tests/fixtures/profile-server-names.json`.
- `ReleaseAudit`: validates the kit, checks tracked files for local state or credential patterns, and builds an audit archive from git.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action Prepare
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action UseProfile -Profile analytics-core
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action Validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action Doctor
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action ItRequest
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action Prereqs
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action CheckMcpUpdates
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action Apply -Client Codex
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action Dashboard
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action Status
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action FirstDayChecklist
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action OnboardingReport
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action CatalogReview
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action TestFixtures
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action ReleaseAudit
```

Google helper commands:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action GoogleOAuthFile
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action GoogleAdcLogin
```

To reset Codex MCP configuration before testing the kit again:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action ResetCodexMcp
```

To reset the kit itself after a test, before sharing/compressing the reusable folder, or when leaving a company/client:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action ResetKit
```

Do not run `ResetKit` immediately after a successful real onboarding unless you intentionally want to remove the local credentials and tokens that keep the tools working. `ResetKit` removes ignored local state and known kit-owned Google OAuth/token JSON files under `%USERPROFILE%\.web-analyst-agent`, so the folder can be compressed or reused without carrying the current PC/company connection forward.

## Release Safety

Before publishing or sharing the kit, the agent should run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action Validate
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action TestFixtures
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action CatalogReview
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\WebAnalystSetup.ps1 -Action ReleaseAudit
```

`ReleaseAudit` checks only tracked files and a git archive, so ignored local credentials and generated reports are not included in the release artifact.
