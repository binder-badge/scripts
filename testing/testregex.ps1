$testString = "Lars;  Qureshi; Hillard"
# $regexPattern = '\s*[^\p{L}\p{Nd}]\s*'
$regexPattern = '\s*(?=\S)\W(?!\S)\s*'
$newString = $testString -replace $regexPattern, ", "
$artistList = $newString.split(", ")
echo $testString
echo $newString
echo $artistList