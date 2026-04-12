$file = "c:\Users\tonip\Desktop\LITTLE\index.html"
$content = Get-Content $file -Raw -Encoding UTF8

$content = $content.Replace("mÃ¡s", "más")
$content = $content.Replace("pequeÃ±os", "pequeños")
$content = $content.Replace("diseÃ±amos", "diseñamos")
$content = $content.Replace("temÃ¡tica", "temática")
$content = $content.Replace("cÃ³modos", "cómodos")
$content = $content.Replace("imaginaciÃ³n", "imaginación")
$content = $content.Replace("DiseÃ±amos", "Diseñamos")

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Repaired encoding"
