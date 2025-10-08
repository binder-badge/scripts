$inputFolder = "D:\test"
$files = Get-ChildItem $inputFolder -File -Filter "*.flac"
foreach ($file in $files) {
    $filePath = $file.FullName
    $changedFilePath = $filePath.replace(".flac","")
    & ffmpeg -i $filePath -f ffmetadata -i "${changedFilePath}.txt" -map_metadata 1 "${changedFilePath}.temp.flac"
    Remove-Item -Path $filePath
    Rename-Item -Path "${changedFilePath}.temp.flac" -NewName $filePath
}