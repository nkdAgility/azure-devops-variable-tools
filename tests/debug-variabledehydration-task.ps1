#Save-Module -Name VstsTaskSdk -Path ..\processtemplate-task\ps_modules\


#Import-Module ..\variabledehydration-task\ps_modules\VstsTaskSdk


Invoke-VstsTaskScript -ScriptBlock ([scriptblock]::Create('. ..\variabledehydration-task\dehydrate-veriables.ps1')) -Verbose