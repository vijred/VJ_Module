# Contributing
Contributions to this project are subject to code reviews and pull requests. As a good-contributor, users should adhere to development\programming best-practices.

# Development Guidelines

- When creating or adding new functions, the function itself must be defined as a ps1 script in the "functions" folder using a filename the same name as the defined function name.  Once the function has been defined, the function must be added to the following areas of the module in order for it to be available within the module.

    - SqlServerBuild.psd1
        - Add the defined function name, without .ps1 extension (e.g. Get-HostType), to the section "FunctionsToExport", ALPHABETICALLY.

- When creating or adding new functions, the naming convention must adhere to PowerShell verb-noun standards.  Please refer to the following documentation:

    https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7

- When creating or adding new functions, please leverage the "new-function-template.md" file found in the module's "functions" folder as a new functiom template.