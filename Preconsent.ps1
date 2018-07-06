# Check version
# Get-Module -Name AzureAD
# Install-Module AzureAD -Force
Connect-AzureAD 

$AppId = 'INSERT-APPLICATION-ID-HERE'
$DisplayName = 'INSERT-APPLICATION-DISPLAY-NAME-HERE'

$g = Get-AzureADGroup | ? {$_.DisplayName -eq 'AdminAgents'}
Get-AzureADGroupMember -ObjectId $g.ObjectId
$s = Get-AzureADServicePrincipal -All $true  | ? {$_.AppId -eq $AppId}

if ($s -eq $null) { $s = New-AzureADServicePrincipal -AppId $AppId -DisplayName $DisplayName }
Add-AzureADGroupMember -ObjectId $g.ObjectId -RefObjectId $s.ObjectId

# The service principal for application can be removed if required with
#Remove-AzureADGroupMember -ObjectId $g.ObjectId -MemberId $s.ObjectId
