$files = Get-ChildItem -Filter *.html
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    $combinedPattern = '(?s)\s*(<!-- ✦ 3D GLOBE \(WebGL\) ✦ -->)?\s*<div class="footer-globe-outer">.*?</div>\s*</div>'
    $replacement = "`r`n                <img src=`"./assets/logo.png`" alt=`"Little Juego Libre`" class=`"footer-logo-img`">"
    
    $content = $content -replace $combinedPattern, $replacement
    
    $content = $content -replace '(?s)\s*<script defer src="\./js/globe\.js"></script>', ""
    $content = $content -replace '(?s)\s*<script src="\./js/globe\.js"></script>', ""
    
    [System.IO.File]::WriteAllText($file.FullName, $content)
}

Write-Host "Regex string replacement completed."
