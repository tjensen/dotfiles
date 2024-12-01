Set-PSReadlineOption -EditMode vi

Set-PSReadLineKeyHandler -Key Tab -Function TabCompleteNext

function Prompt
{
    $host.ui.RawUI.WindowTitle = [io.path]::GetFileName($pwd)

    $ESC = [char]27

    $prompt = "$ESC[0mPS [$ESC[36m$(Get-Date -format HH:mm)$ESC[0m]"
    if (Get-Command Write-VcsStatus -ErrorAction SilentlyContinue)
    {
        $prompt += (Write-VcsStatus)
    }
    $prompt += " $ESC[1m${pwd}$ESC[0m> "
    $prompt
}

$Script:currentPythonPath = $null

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
        $parts = $Env:Path -Split ";"

        if ($Script:currentPythonPath -ne $null)
        {
            $parts = $parts.Where({ $_ -ne $Script:currentPythonPath -and $_ -ne "$Script:currentPythonPath\Scripts" })
        }

        $Script:currentPythonPath = $pvmPaths[$Id]

        $parts = @("$Script:currentPythonPath", "$Script:currentPythonPath\Scripts") + $parts

        $Env:Path = $parts -Join ";"
    }
    else
    {
        throw "ID $Id not in ($($pvmPaths.PSbase.Keys -Join ", "))"
    }
}

if ("$defaultPython" -ne "")
{
    pvm "$defaultPython"
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

    workon "$Name"
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
