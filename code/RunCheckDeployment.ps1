# Import functions
. .\CheckDeploymentStatus.ps1
. .\GetRecentDeploymentIds.ps1

# Define SDI info
$sdiBaseUrl = "https://your-sdi-url.com"
$httpContentType = "application/json"
$headers = @{
    Authorization = "Bearer <your-token>"
    "Content-Type" = $httpContentType
}

# Fetch recent deployments
$recentDeployments = Get-RecentDeploymentIds -sdiBaseUrl $sdiBaseUrl -headers $headers -count 5

# Loop through and check status
foreach ($deployment in $recentDeployments) {
    $deploymentId = $deployment.id

    try {
        $result = CheckDeploymentIfFailed -deploymentId $deploymentId -sdiBaseUrl $sdiBaseUrl -httpContentType $httpContentType -headers $headers
        Write-Host "`n--- Deployment ID: $($result.deploymentId) ---"
        Write-Host "Status: $($result.status)"
        Write-Host "Last Request Status: $($result.lastRequestStatus)"
        Write-Host "Is Failed: $($result.isFailed)"
    }
    catch {
        Write-Warning "Could not check deployment ID $deploymentId: $_"
    }
}
