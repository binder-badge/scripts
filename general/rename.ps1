$inputFolder = ""
$chineseRegex = '[Hw]eip\d{1,6}'
# Rest of the script for metadata manipulation
$files = Get-ChildItem $inputFolder -Filter "*.flac"
foreach ($file in $files) {
    $filePath = $file.FullName
    $meta = & ffmpeg -i $filePath -hide_banner 2>&1
    $title = $null
    $meta -split "`r`n" | ForEach-Object {
        if ($_ -match "TITLE\s*:\s*(.+)") {
            $title = $matches[1]
        }
    }
}
if ($title -ne $null) {
        Write-Host "Extracted Title: $title"
        
        # Remove non-ASCII characters from the title
        $newTitle = ""
        $title.ToCharArray() | ForEach-Object {
            $charCode = [int][char]$_
            if ($charCode -ge 0 -and $charCode -le 127) {
                $newTitle += $_
            }
        }
        
        Write-Host "Modified Title: $newTitle"
        if ($title -ne $newTitle) {
            & ffmpeg -i $filePath -c:a copy -metadata title="$newTitle" "${filePath}.temp.flac"
            Remove-Item -Path $filePath
            Rename-Item -Path "${filePath}.temp.flac" -NewName $filePath
        }
} else {
    Write-Host "Title not found in metadata."
}
# $chineseRegex = '[Hw]eip\d{1,6}' # Regular expression to match Chinese characters
# $replacement = '' # Empty string as replacement value (to remove the matched character)

# if ($inputString -match $chineseRegex) {
#     $inputString = $inputString.Replace($chineseRegex, $replacement)
# }

# Write-Host "$inputString"
