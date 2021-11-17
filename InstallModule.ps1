$fullPath = Join-Path $fullPath -ChildPath 'PowerShellJsonObject'

Push-location $PSScriptRoot
Robocopy . $fullPath /mir /XD .vscode .git CI __tests__ data mdHelp /XF appveyor.yml azure-pipelines.yml .gitattributes .gitignore filelist.txt install.ps1 InstallModule.ps1
Pop-Location