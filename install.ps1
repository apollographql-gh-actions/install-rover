$VersionArg = $Args[0]
$Version = If ("$VersionArg" -eq "" -Or "$VersionArg" -eq "latest") { "latest" } Else { "v$VersionArg" }

Write-Output "Fetching $Version of Rover CLI..."

$Installer = ".\installer.ps1"
$ExitCode = 0

try {
  $Response = Invoke-WebRequest https://rover.apollo.dev/win/$Version
  $Response.Content | Out-File $Installer UTF8
  Invoke-Expression "$Installer --force"

  Write-Output "$HOME\.rover\bin" | Out-File $Env:GITHUB_PATH UTF8 -Append
}
catch [System.Net.Http.HttpRequestException],[Microsoft.PowerShell.Commands.HttpResponseException] {
  Write-Error "There was a problem fetching $Version of Rover CLI: $_"
  $ExitCode = 1
}
catch {
  Write-Error "Failed to install Rover CLI: $_"
  $ExitCode = 1
}

If (Test-Path $Installer -PathType Leaf) {
  Remove-Item $Installer
}

Exit $ExitCode
