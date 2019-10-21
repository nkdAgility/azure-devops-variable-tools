[CmdletBinding()]
param(
    [string] $jsonfiles
)
$jsonfiles = Get-VstsInput -Name jsonfiles -Require

Write-VstsTaskVerbose "jsonfiles: $jsonfiles" 

$files = Get-ChildItem -Path $jsonfiles -Recurse

Write-Output "Found $($files.count) files in $jsonfiles" 

if ($files.count -eq 0)
{
   Write-VstsTaskError "There were no files found. You must specify at least one file to rehydrate. "
   Write-VstsSetResult -Result Failed -DoNotThrow
   exit 999
}

foreach ($file in $files)
{
    Write-Output "Importing $file" 
    Try
    {
        $results = Get-Content -Raw -Path $file | ConvertFrom-Json
        if ($results.Length -ne 0)
        {
            Write-Output $results
            foreach ($result in $results)
            {
                Write-Output "##vso[task.setvariable variable=$($result.Name);]$($result.Value)"
            }
        }
        else
        {
            Write-Output "No variables were found in $file"
        }
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName
        Write-VstsTaskError "Did not get a result retunred from the upload, twas not even JSON!"
        Write-VstsTaskError $ErrorMessage
        Write-VstsTaskError $result
        Write-VstsSetResult -Result Failed -DoNotThrow
        exit 666
    }
}
