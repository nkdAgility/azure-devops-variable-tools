[CmdletBinding()]
param(
    [string] $prefixes,
    [string] $outpath
)
$prefixes = Get-VstsInput -Name prefixes -Require 
$outpath = Get-VstsInput -Name outpath -Require

Write-VstsTaskVerbose "prefixes: $prefixes" 
Write-VstsTaskVerbose "outpath: $outpath" 

$prefixesList = $prefixes -split ","


foreach ($prefix in $prefixesList)
{
    Write-Output "Saving meta data for $prefix"
    $path = join-path -path $outpath "meta-$($prefix.ToLower()).json"
    Write-VstsTaskVerbose "Save Path: $path"
    $PrefixSearch = "Env:$prefix*"
    Write-VstsTaskVerbose "Search Prefix: $PrefixSearch"
    $variables = Get-Childitem -Path $PrefixSearch | select Name,Value

    Try
    {
        if ($variables.Length -ne 0)
        {
            Write-Output $variables
            New-Item -ItemType Directory -Force -Path $outpath
            $result = $variables | ConvertTo-Json | Out-File $path
            Write-Output "created $result"
        }
        else
        {
            Write-Output "No variable names matched the prefix $prefix"
        }
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName
        Write-VstsTaskError "Did not get a result retunred from the upload, twas not even JSON!"
        Write-VstsTaskError $ErrorMessage
        Write-VstsTaskError $result
        exit 666
    }

}
