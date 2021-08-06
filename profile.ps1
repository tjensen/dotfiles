Set-PSReadlineKeyHandler -Key Tab -Function Complete

function Prompt
{
    $host.ui.RawUI.WindowTitle = [io.path]::GetFileName($pwd)

    $ESC = [char]27

    "$ESC[0mPS [$ESC[36m$(Get-Date -format HH:mm)$ESC[0m] $ESC[1m${pwd}$ESC[0m> "
}
