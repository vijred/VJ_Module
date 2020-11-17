<##################################################
Export Functions
##################################################>

$FunctionsPath = "functions"

$FunctionsFiles = Get-ChildItem -Path (Join-Path -Path $($PSScriptRoot) -ChildPath $FunctionsPath) -Filter "*.ps1"

# Import All .ps1 Functions in "functions" Folder
foreach ($File in $FunctionsFiles) {
    . $File.FullName
}
