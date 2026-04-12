$htmlFiles = Get-ChildItem -Path . -Filter *.html

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $newContent = $content -replace 'src="\./assets/logo\.png" alt="Little Juego Libre" class="footer-logo-img"', 'src="./assets/logo-coral.jpg" alt="Little Juego Libre" class="footer-logo-img"'
    
    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "Updated footer logo in $($file.Name)"
    }
}

$transPath = "js/translations.js"
$tContent = Get-Content -Path $transPath -Raw
$tContent = $tContent -replace '"ticker_2":\s*".*?"', '"ticker_2": "CADA MES CAMBIAMOS DE TEMÁTICA"'
$tContent = $tContent -replace '"ext_stats_3_num":\s*"6"', '"ext_stats_3_num": "4"'

Set-Content -Path $transPath -Value $tContent -Encoding UTF8
Write-Host "Updated translations.js"
