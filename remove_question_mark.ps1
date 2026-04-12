$p = (Get-Location).Path + '\js\translations.js'
$content = [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8)
$firstChar = [int]$content[0]
Write-Host "First char code: $firstChar"

if ($firstChar -eq 63) {
    # 63 = '?' - remove it
    $fixed = $content.Substring(1)
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($p, $fixed, $utf8)
    Write-Host "Removed leading '?' character. File now starts with: $($fixed.Substring(0, 20))"
} else {
    Write-Host "First char is not '?', it is: $firstChar"
}
