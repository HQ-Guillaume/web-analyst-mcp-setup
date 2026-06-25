# Contributing

Thanks for improving Web Analyst MCP Setup.

This repository is meant to stay practical, safe, and useful for first-day web
analyst onboarding with AI agents. Good contributions usually improve setup
clarity, credential safety, validation scripts, documentation, or compatibility
with analytics tooling.

## Guidelines

- Keep reusable instructions free of client data, credentials, private URLs, and
  company-specific secrets.
- Prefer read-only smoke tests and explicit user approval before any destructive
  or publishing action.
- Keep Windows support strong; note any PowerShell 7 or cross-platform behavior
  clearly.
- Update `README.md`, `AGENTS.md`, or docs when changing the user-facing setup
  flow.
- Add or update validation checks when changing scripts or generated config.

## Pull Requests

Before opening a pull request:

- Run the available validation workflow or local test scripts when relevant.
- Explain the setup scenario the change improves.
- Call out any new dependency, permission, credential, or vendor-console
  requirement.
