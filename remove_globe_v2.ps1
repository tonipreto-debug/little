$targetBlock = @"
                <!-- ✦ 3D GLOBE (WebGL) ✦ -->
                <div class="footer-globe-outer">
                    <canvas class="globe-canvas" width="200" height="200" data-asset-base="./assets/"></canvas>
                    <div class="globe-ground-glow"></div>
                </div>
"@

$replacement = @"
                <img src="./assets/logo.png" alt="Little Juego Libre" class="footer-logo-img">
"@

$targetBlock2 = @"
                <div class="footer-globe-outer">
                    <canvas class="globe-canvas" width="200" height="200" data-asset-base="./assets/"></canvas>
                    <div class="globe-ground-glow"></div>
                </div>
"@

$files = Get-ChildItem -Filter *.html
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName)
    
    $content = $content.Replace($targetBlock, $replacement)
    $content = $content.Replace($targetBlock.Replace("`r`n", "`n"), $replacement.Replace("`r`n", "`n"))
    
    $content = $content.Replace($targetBlock2, $replacement)
    $content = $content.Replace($targetBlock2.Replace("`r`n", "`n"), $replacement.Replace("`r`n", "`n"))
    
    $scriptTag1 = "    <script defer src=`"./js/globe.js`"></script>`r`n"
    $content = $content.Replace($scriptTag1, "")
    $scriptTag2 = "    <script defer src=`"./js/globe.js`"></script>`n"
    $content = $content.Replace($scriptTag2, "")
    
    $scriptTag3 = "    <script src=`"./js/globe.js`"></script>`r`n"
    $content = $content.Replace($scriptTag3, "")
    $scriptTag4 = "    <script src=`"./js/globe.js`"></script>`n"
    $content = $content.Replace($scriptTag4, "")
    
    [System.IO.File]::WriteAllText($f.FullName, $content)
}

Write-Host "Done replacing text strings."
