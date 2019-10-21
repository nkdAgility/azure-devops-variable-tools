# Azure DevOps Variable Tools

Azure DevOps Variable Tools is an extension for Azure Pipleines Build and Azure Pipleines Release that help you make use of your Build variables in your Release workflows.

Get the [Azure DevOps Variable Tools](https://marketplace.visualstudio.com/items?itemName=nkdagility.variablehydration) extensions for Azure DevOps Services from the Marketplace.

Learn more about this extension on the wiki!

##Tasks included

- **Variable Save Task** - During your build you can save the variables to a json file stored with your other build assets
- **Variable Load Task** - During your Release you can load the saved variables and gain access to them.

##Steps

After installing the extension, you can add one (or more) of the tasks to a new or existing build definition or release definition

Full documentation is available on [https://dev.azure.com/nkdagility/Azure-DevOps-Variable-Tools/_wiki/wikis/variable-tools](https://dev.azure.com/nkdagility/Azure-DevOps-Variable-Tools/_wiki/wikis/variable-tools)

**NOTE: This Task used PowerShell which currently only supports Windows untill [PowerShell Handler to run PS based task on Linux/MacOS agent](https://github.com/Microsoft/vsts-task-lib/issues/314) is resolved to support cross-platform.**
