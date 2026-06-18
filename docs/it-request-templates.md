# IT Request Templates

Use these templates during setup when the user needs approval, credentials, or access from IT, data engineering, analytics engineering, or a vendor admin.

## Google OAuth Client

Subject: Google OAuth client for web analyst AI tool setup

Hello,

I need an approved Google OAuth client for my web analyst MCP setup on my company PC.

Tools requested:

- Google Drive and/or Gmail for workspace access.
- Google Analytics 4 for read-only reporting through Application Default Credentials.
- Optional BigQuery access if approved separately.

Requested configuration:

- OAuth client type: Desktop app / installed app for local browser login.
- Audience: internal or approved test users according to company policy.
- Scopes: only the scopes required by the selected tools.
- Credential delivery: approved vault or secure channel.

The OAuth client ID and secret will be stored only in a local ignored file and used to generate user-owned OAuth tokens. The user signs in with their own company Google account, so access remains governed by their existing permissions.

## Google Workspace Access

Subject: Google Workspace access for web analyst MCP setup

Hello,

Please confirm whether I can connect Google Drive/Gmail through a local MCP using company-approved OAuth credentials.

The setup will:

- Use browser OAuth with my own company Google account.
- Keep tokens local on my PC.
- Start with read-only smoke tests.
- Avoid sending, deleting, moving, or modifying content unless I explicitly confirm a task.

Please confirm approved scopes and whether first-party Google remote MCPs are required instead of local community MCPs.

## GA4 Access

Subject: GA4 read-only access for AI-assisted analysis

Hello,

Please grant or confirm GA4 access for the properties I need to analyze.

Requested access:

- GA4 account/property IDs.
- Read-only access sufficient for Analytics Admin/Data API reporting.
- Approved Google OAuth/ADC route for local browser login.

The setup will use the official Google Analytics MCP and run only read-only smoke tests until a specific analysis request is approved.

## BigQuery Access

Subject: BigQuery read-only access for web analytics analysis

Hello,

Please confirm the approved BigQuery project and datasets for web analytics work.

Requested information:

- Google Cloud project ID.
- Dataset IDs and region.
- Billing/cost policy for analyst queries.
- Whether the official BigQuery MCP is approved or whether an allowlisted local MCP Toolbox setup is required.

Suggested least-privilege roles:

- BigQuery Job User on the project.
- BigQuery Data Viewer on the approved datasets.
- MCP Tool User or equivalent if required by the official remote MCP.

I will start with metadata listing or limited read-only queries and confirm before running broad or costly SQL.

## GTM Access

Subject: GTM access for tag audit and implementation support

Hello,

Please confirm access to the required Google Tag Manager account/container/workspace.

Requested access:

- Account/container names and numeric IDs.
- Workspace access.
- Permission level required for the task.
- Confirmation whether publish rights are allowed or whether changes must stop at preview/export/review.

The setup will use OAuth with my own account and will not publish changes without explicit confirmation.

## Vendor API Token

Subject: Vendor API token for web analyst MCP/API connector

Hello,

Please provide an approved API token or MCP URL for the selected vendor tool.

Vendor:

- Piano Analytics / Contentsquare / Tag Commander / ClickUp / Trello / other.

Requested details:

- API base URL or MCP URL.
- Site/project/account ID.
- Token/key name and expiration policy.
- Read-only versus write permissions.
- Any IP, device, or vault restrictions.

The token will be stored in a local ignored environment file and not committed to Git.
