$files = Get-ChildItem -Filter *.html
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName)
    
    # Define regex pattern for the globe wrapper
    $pattern = '(?s)\s*<!-- ✦ 3D GLOBE \(WebGL\) ✦ -->\s*<div class="footer-globe-outer">\s*<canvas.*?</canvas>\s*<div class="globe-ground-glow"></div>\s*</div>'
    $replacement = "`n                <img src=`"./assets/logo.png`" alt=`"Little Juego Libre`" class=`"footer-logo-img`">"
    
    $content = [regex]::Replace($content, $pattern, $replacement)
    
    # Define regex pattern for the script
    $scriptPattern = '(?s)\s*<script defer src="\./js/globe\.js"></script>'
    $content = [regex]::Replace($content, $scriptPattern, "")
    
    [System.IO.File]::WriteAllText($f.FullName, $content)
}
Write-Host "Done replacing."
