$inputFolder = ""
# first grab metadata files
$files = Get-ChildItem $inputFolder -File -Filter "*.mp3"
foreach ($file in $files) {
    $filePath = $file.FullName
    $metadataFilePath = $filePath.replace(".mp3","")
    & ffmpeg -i $filePath -f ffmetadata "${metadataFilePath}.txt" 
}