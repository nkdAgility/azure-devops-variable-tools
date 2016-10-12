[CmdletBinding()]
param(
    [string] $jsonfiles
)
$jsonfiles = Get-VstsInput -Name jsonfiles -Require

Write-VstsTaskVerbose "jsonfiles: $jsonfiles" 

$files = Get-ChildItem -Path $jsonfiles

Write-Output "Found $($file.count) files in $jsonfiles" 

if ($files.count -eq 0)
{
   Write-VstsTaskError "There were no files found"
   exit 999
}

foreach ($file in $files)
{
    Write-Output "Importing $file" 
    Try
    {
        $results = Get-Content -Raw -Path $file | ConvertFrom-Json
        foreach ($result in $results)
        {
            Write-Output "##vso[task.setvariable variable=$($result.Name);]$($result.Value)"
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
