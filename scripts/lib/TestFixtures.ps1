function Get-ProfileMcpServerNamesForFixture {
    param($ProfileObject, $Catalog)
    $names = @()
    foreach ($tool in $ProfileObject.tools.PSObject.Properties) {
        if (-not $tool.Value.enabled) { continue }
        $item = Resolve-CatalogItem -CatalogItem $Catalog.($tool.Name) -Provider ([string]$tool.Value.provider)
        if (-not $item -or $item.kind -ne "mcp") { continue }
        if (-not [string]::IsNullOrWhiteSpace([string]$item.serverName)) {
            $names += [string]$item.serverName
        }
    }
    return @($names | Sort-Object)
}

function Invoke-TestFixtures {
    New-Item -ItemType Directory -Force $GeneratedDir | Out-Null
    $reportPath = Join-Path $GeneratedDir "fixture-test-report.md"
    $fixturePath = Join-Path $Root "tests\fixtures\profile-server-names.json"
    $errors = @()
    $lines = @()

    try {
        Invoke-ValidateKit -Quiet
    } catch {
        $errors += "Validation failed before fixture tests: $($_.Exception.Message)"
    }

    $catalog = Read-JsonFile -Path $CatalogPath
    $profiles = Read-JsonFile -Path $ProfilesPath
    $selectionExample = Read-JsonFile -Path $SelectionExamplePath
    $fixture = Read-JsonFile -Path $fixturePath

    foreach ($catalogTool in $catalog.PSObject.Properties) {
        if (-not (Test-ObjectProperty -Object $selectionExample.tools -Name $catalogTool.Name)) {
            $errors += "tool-selection.example.json is missing catalog tool '$($catalogTool.Name)'."
        }
    }

    foreach ($profile in $profiles.profiles.PSObject.Properties) {
        if (-not (Test-ObjectProperty -Object $fixture.profiles -Name $profile.Name)) {
            $errors += "Fixture is missing expected server names for profile '$($profile.Name)'."
            continue
        }

        $actual = @(Get-ProfileMcpServerNamesForFixture -ProfileObject $profile.Value -Catalog $catalog)
        $expected = @($fixture.profiles.($profile.Name).mcpServerNames | Sort-Object)
        $diff = @(Compare-Object -ReferenceObject $expected -DifferenceObject $actual)
        if ($diff.Count -gt 0) {
            $errors += "Profile '$($profile.Name)' MCP servers changed. Expected [$($expected -join ', ')], actual [$($actual -join ', ')]."
        }
    }

    foreach ($fixtureProfile in $fixture.profiles.PSObject.Properties) {
        if (-not (Test-ObjectProperty -Object $profiles.profiles -Name $fixtureProfile.Name)) {
            $errors += "Fixture references unknown profile '$($fixtureProfile.Name)'."
        }
    }

    $lines += "# Fixture Test Report"
    $lines += ""
    $lines += "Generated: $((Get-Date).ToString("yyyy-MM-dd HH:mm:ss zzz"))"
    $lines += ""
    $lines += "| Profile | Expected MCP Servers |"
    $lines += "| --- | --- |"
    foreach ($profile in $profiles.profiles.PSObject.Properties) {
        $actual = @(Get-ProfileMcpServerNamesForFixture -ProfileObject $profile.Value -Catalog $catalog)
        $lines += "| $($profile.Name) | $($actual -join ', ') |"
    }

    if ($errors.Count -gt 0) {
        $lines += ""
        $lines += "## Errors"
        $lines += ""
        foreach ($errorItem in $errors) { $lines += "- $errorItem" }
        Set-Content -LiteralPath $reportPath -Value $lines -Encoding UTF8
        Write-Host "Wrote fixture test report: $reportPath"
        throw "Fixture tests failed with $($errors.Count) error(s)."
    }

    $lines += ""
    $lines += "Result: OK"
    Set-Content -LiteralPath $reportPath -Value $lines -Encoding UTF8
    Write-Host "Fixture tests passed."
    Write-Host "Wrote fixture test report: $reportPath"
}
