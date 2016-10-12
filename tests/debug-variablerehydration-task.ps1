#Save-Module -Name VstsTaskSdk -Path ..\processtemplate-task\ps_modules\


#Import-Module ..\variablerehydration-task\ps_modules\VstsTaskSdk




Invoke-VstsTaskScript -ScriptBlock ([scriptblock]::Create('. ..\variablerehydration-task\rehydrate-veriables.ps1')) -Verbose