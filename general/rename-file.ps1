$inputFolder = ""
$files = Get-ChildItem $inputFolder -File -Filter "*.mp3"
foreach ($file in $files) {
    $filePath = $file.FullName
    $changedFilePath = $filePath.replace(".temp","")
    Rename-Item -Path "${filepath}" -NewName $changedfilePath
}
