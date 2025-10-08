$sourceFolder = "D:\test"
$destinationFolder = "D:\test2"
$extension = "flac"
$files = Get-ChildItem -LiteralPath $sourceFolder -File -Filter "*.$extension"
foreach ($file in $files) {
    $filePath = $file.FullName
    Copy-Item -LiteralPath "$filepath" -Destination $destinationFolder
    echo "replaced " $file.BaseName
}
