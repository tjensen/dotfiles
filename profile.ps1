Set-PSReadlineKeyHandler -Key Tab -Function Complete

function Prompt
{
    $host.ui.RawUI.WindowTitle = [io.path]::GetFileName($pwd)

    $ESC = [char]27

    "$ESC[0mPS [$ESC[36m$(Get-Date -format HH:mm)$ESC[0m] $ESC[1m${pwd}$ESC[0m> "
}

function pvm
{
<#
.SYNOPSIS
    Loads a version of Python

.PARAMETER Id
    The ID of the Python version to load

.EXAMPLE
    pvm 3.8
#>
    param (
        [Parameter(Mandatory)]
        [string]$Id
    )

    if ($pvmPaths.ContainsKey($Id))
    {
        $base = $pvmPaths[$Id]

        Set-Item -Path Env:Path -Value "$base;$base\Scripts;$Env:Path"
    }
    else
    {
        throw "ID $Id not in ($($pvmPaths.PSbase.Keys -Join ", "))"
    }
}

function workon
{
<#
.SYNOPSIS
    Loads a Python virtual environment

.PARAMETER Name
    The Name of the Python virtual environment to load

.EXAMPLE
    workon ProjectName
#>
    param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    $virtualenv = "$Home\.virtualenvs\$Name"

    if (Test-Path -Path "$virtualenv")
    {
        & "$virtualenv\Scripts\Activate.ps1"
    }
    else
    {
        throw "Virtualenv $Name does not exist"
    }
}

function wo
{
<#
.SYNOPSIS
    Loads the Python virtual environment for the current directory

.EXAMPLE
    wo
#>
    $virtualenv = [System.IO.Path]::GetFileName($Pwd)

    workon "$virtualenv"
}

function mkvirtualenv
{
<#
.SYNOPSIS
    Creates a new Python virtual environment

.PARAMETER Name
    The Name of the Python virtual environment to create

.EXAMPLE
    mkvirtualenv ProjectName
#>
    param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    python.exe -m venv "$Home\.virtualenvs\$Name"
}

function mkv
{
<#
.SYNOPSIS
    Creates a new Python virtual environment for the current directory

.EXAMPLE
    mkv
#>
    $virtualenv = [System.IO.Path]::GetFileName($Pwd)

    mkvirtualenv "$virtualenv"
}

function rmvirtualenv
{
<#
.SYNOPSIS
    Removes a Python virtual environment

.PARAMETER Name
    The Name of the Python virtual environment to remove

.EXAMPLE
    rmvirtualenv ProjectName
#>
    param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    Remove-Item -Recurse "$Home\.virtualenvs\$Name"
}
