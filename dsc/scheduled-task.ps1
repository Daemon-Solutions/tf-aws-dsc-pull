$dscbucketname=get-content c:\dsc\dsc_bucket.txt
$dsc_files=(get-s3object -BucketName $dscbucketname | ? {$_.key -like "dsc*"}).Key
foreach ($dsc_file in $dsc_files){
Copy-S3Object -BucketName $dscbucketname -Key $dsc_file -LocalFile "c:\dsc\configs\$dsc_file" 
}

$configs=(gci -Path C:\dsc\configs | ? {$_.Name -like "dsc*.ps1"}).Name
foreach ($config in $configs){
Invoke-Expression "c:\dsc\configs\$config"}
