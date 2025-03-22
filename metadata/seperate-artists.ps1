$inputFolder = "D:\test"
$seperator = ", "
$files = Get-ChildItem $inputFolder -Recurse -File -Include '*.mp3', '*.flac', '*.m4a', '*.ogg', '*.wav'
$regexPattern = '\s*(?=\S)\W(?!\S)\s*'
#$regexPattern = '\s*[;,\/\\]\s*'
# force utf8 encoding due to fucky cjk chars
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

foreach ($file in $files) {
    # get file path + ffmpeg output
    $filePath = $file.FullName
    Write-Host "current file: $filePath"
    # start trimming and sanitizing artist string
    $artistTag = kid3-cli -c "get artist" $filePath
    #$artistTag = $artistTag -replace '\s*artist\s*:\s*', ""
    # "， "
    # ", "
    # deal with weird unicode for cjk commas
    #artistTagFixed = $artistTag -replace $regexPattern '[\u65292]\s*', ", "
    $artistTagFixed = $artistTag -replace $regexPattern , ", "

    Write-Host "original tag: $($artistTag)"
    Write-Host "fixed tag: $($artistTagFixed)"

    $artistList = $artistTagFixed.split($seperator)
    
    Write-Host "total artists: $($artistList.count)"
    foreach ($artist in $artistList){
        Write-Host $artist
    }
    echo ""

    # construct args for kid3
    $counter = 0
    $metadataArgs = @()
    if ($artistList.count -gt 1){
        echo "applying the artists`n"
        foreach ($artist in $artistList){
            $metadataArgs += '-c'
            $metadataArgs += "set artists[$counter] `"$artist`""
            $counter++
        }
        & kid3-cli @metadataArgs "$filePath"
    }

    # run kid3 command and change encoding back afterwards
    # Write-Host "& kid3-cli $(@metadataArgs) $filePath"
}
Write-Host "`nSplitting done!"