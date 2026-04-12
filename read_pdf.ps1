$word = New-Object -ComObject Word.Application
$word.Visible = $false
$pdfPath = "c:\Users\tonip\Desktop\LITTLE\PORTAFOLIO EVENTOS.pdf"
$doc = $word.Documents.Open($pdfPath, $false, $true)
$text = $doc.Content.Text
$text | Out-File -FilePath "c:\Users\tonip\Desktop\LITTLE\pdf_text.txt" -Encoding UTF8
$doc.Close($false)
$word.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
