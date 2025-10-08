$inputFolder = ""
$trackNum = 1
$totaltracks = 20
$extension = "flac"
# Rest of the script for metadata manipulation
$files = Get-ChildItem $inputFolder -File -Filter "*.${extension}"
foreach ($file in $files) {
    $filePath = $file.FullName
    $changedFilePath = $filePath.replace(".${extension}","")
    $stringTrack = "$trackNum/$totaltracks"
    #& ffmpeg -i $filePath -c:a copy -metadata track="$stringTrack" "${changedFilePath}.temp.mp3"
    & ffmpeg -i $filePath -c:a copy -metadata COMPILATION=1 "${changedFilePath}.temp.${extension}"
    Remove-Item -Path $filePath
    Rename-Item -Path "${changedFilePath}.temp.${extension}" -NewName $filePath
    $trackNum = $trackNum + 1
}
