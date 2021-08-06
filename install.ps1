$dotfilesDir = $(Split-Path "$($MyInvocation.MyCommand.Path)" -Parent)

if (Select-String -Pattern ". `"$HOME\dotfiles\profile.ps1`"" -Path $PROFILE -CaseSensitive -SimpleMatch)
{
    Write-Output "Skipping installing profile.ps1 because it has already been installed"
}
else
{
    Write-Output "Installing profile.ps1"
    Add-Content -Path "$PROFILE" -Value ""
    Add-Content -Path "$PROFILE" -Value ". `"$dotfilesDir\profile.ps1`""
}

if (Test-Path "$HOME\_vimrc" -PathType Leaf)
{
    Write-Output "Skipping installing _vimrc because it already exists"
}
else
{
    Write-Output "Installing _vimrc"
    New-Item -Path "$HOME\_vimrc" -ItemType SymbolicLink -Value "$dotfilesDir\vimrc"
}

Write-Output "Done."
