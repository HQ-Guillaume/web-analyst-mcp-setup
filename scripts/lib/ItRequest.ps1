function Invoke-ItRequest {
    Ensure-LocalFiles | Out-Null
    New-Item -ItemType Directory -Force $GeneratedDir | Out-Null
    $requestPath = Join-Path $GeneratedDir "it-request.md"
    $selection = Read-JsonFile -Path $SelectionPath
    $catalog = Read-JsonFile -Path $CatalogPath
    $toolRows = @(Get-ToolStatusRows | Where-Object { $_.Enabled })

    $selectedItems = @()
    foreach ($tool in $selection.tools.PSObject.Properties) {
        if (-not $tool.Value.enabled) { continue }
        $item = Resolve-CatalogItem -CatalogItem $catalog.($tool.Name) -Provider ([string]$tool.Value.provider)
        if (-not $item) { continue }
        $selectedItems += [PSCustomObject]@{
            ToolName = $tool.Name
            Provider = if ($item.selectedProvider) { [string]$item.selectedProvider } else { [string]$tool.Value.provider }
            Item = $item
        }
    }

    $googleServices = @()
    $googleScopes = @()
    $credentialKeys = @()
    foreach ($selected in $selectedItems) {
        $googleServices += @($selected.Item.requiredGoogleServices | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })
        $googleScopes += @($selected.Item.requiredScopes | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })
        $credentialKeys += @($selected.Item.credentialKeys | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })
        $credentialKeys += @($selected.Item.optionalCredentialKeys | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })
    }
    $googleServices = @($googleServices | Select-Object -Unique | Sort-Object)
    $googleScopes = @($googleScopes | Select-Object -Unique | Sort-Object)
    $credentialKeys = @($credentialKeys | Select-Object -Unique | Sort-Object)

    $lines = @()
    $lines += "# Web Analyst Access Request"
    $lines += ""
    $lines += "Generated: $((Get-Date).ToString("yyyy-MM-dd HH:mm:ss zzz"))"
    $lines += ""
    $lines += "Use this as a draft for IT, data, analytics engineering, or vendor admins. It intentionally lists credential names only, never values."
    $lines += ""

    if ($selectedItems.Count -eq 0) {
        $lines += "No tools are enabled yet. Run `Prepare`, choose tools, then rerun `ItRequest`."
        Set-Content -LiteralPath $requestPath -Value $lines -Encoding UTF8
        Write-Host "Wrote IT request draft: $requestPath"
        return
    }

    $lines += "## Selected Tools"
    $lines += ""
    $lines += "| Tool | Provider | Runtime | Auth | Access Risk | Credential State |"
    $lines += "| --- | --- | --- | --- | --- | --- |"
    foreach ($row in $toolRows) {
        $item = @($selectedItems | Where-Object { $_.ToolName -eq $row.Tool } | Select-Object -First 1).Item
        $lines += "| $($row.DisplayName) | $($row.Provider) | $($row.Runtime) | $($row.Auth) | $($item.riskLevel) | $($row.CredentialState) |"
    }

    $lines += ""
    $lines += "## Request Summary"
    $lines += ""
    $lines += "Hello,"
    $lines += ""
    $lines += "I need approved access for a web analyst MCP setup on my company PC. The setup will use my own company/vendor user account where OAuth is available, keep generated credentials local, start with read-only smoke tests, and avoid write actions, email sending, tag publishing, broad SQL, or sensitive browser inspection unless explicitly approved."
    $lines += ""

    if ($googleServices.Count -gt 0 -or $googleScopes.Count -gt 0) {
        $lines += "## Google / Cloud Items"
        $lines += ""
        if ($googleServices.Count -gt 0) {
            $lines += "Requested APIs or services:"
            foreach ($service in $googleServices) { $lines += "- $service" }
            $lines += ""
        }
        if ($googleScopes.Count -gt 0) {
            $lines += "Requested OAuth scopes:"
            foreach ($scope in $googleScopes) { $lines += "- $scope" }
            $lines += ""
        }
        $lines += "Requested credential route:"
        $lines += "- Company-provided OAuth client ID/secret or approved browser OAuth path."
        $lines += "- For GA4, Application Default Credentials through browser login with the official Google Analytics MCP."
        $lines += "- For BigQuery, least-privilege IAM and approved project/dataset IDs before query work."
        $lines += ""
    }

    $vendorItems = @($selectedItems | Where-Object { $_.Item.source -notmatch "google|gstatic|cloud\.google|developers\.google" })
    if ($vendorItems.Count -gt 0) {
        $lines += "## Vendor Items"
        $lines += ""
        foreach ($selected in $vendorItems) {
            $lines += "- $($selected.Item.displayName): $($selected.Item.notes)"
        }
        $lines += ""
    }

    if ($credentialKeys.Count -gt 0) {
        $lines += "## Credential Names Needed"
        $lines += ""
        foreach ($key in $credentialKeys) { $lines += "- $key" }
        $lines += ""
    }

    $lines += "## Controls"
    $lines += ""
    $lines += "- Store credentials only in ignored local files or company-approved secret storage."
    $lines += "- Run harmless read-only smoke tests first."
    $lines += "- Confirm before write-capable actions, GTM publish, Gmail send/delete, browser inspection of sensitive pages, or costly BigQuery SQL."
    $lines += "- Revoke OAuth or remove local ignored tokens when leaving the company/client."

    Set-Content -LiteralPath $requestPath -Value $lines -Encoding UTF8
    Write-Host "Wrote IT request draft: $requestPath"
}
