function Get-RecentDeploymentIds {
    param (
        [string]$sdiBaseUrl,
        [hashtable]$headers,
        [int]$count = 5  # Change to how many deployments you want to fetch
    )

    $url = "$sdiBaseUrl/deployment/api/deployments?expand=lastRequest&limit=$count"
    try {
        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
        return $response
    } catch {
        Write-Error "Failed to fetch deployments: $_"
        return @()
    }
}
