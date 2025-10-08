$inputFolder = ""
$files = Get-ChildItem $inputFolder -File -Filter "*.wav"
foreach ($file in $files) {
    $filePath = $file.FullName
    $changedFilePath = $filePath.replace(".wav","")
    & ffmpeg -i $filePath "${changedFilePath}.flac"
}