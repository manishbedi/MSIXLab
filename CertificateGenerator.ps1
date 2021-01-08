$Publisher_CN = “CN=Natwest” #enter cert name
$Publisher_DisplayName=”Natwest” #enter organization name
$password=”Sisl123$” #enter password
$FolderToExportCert=”C:\Temp” #Note: Folder must exist
$CertName=”MSIX” #filename for the cert file

#——————————— Modify lines above only ———————————–

$pwd=ConvertTo-SecureString -String $password -Force -AsPlainText
$PfxName = “$($FolderToExportCert)\$($CertName).pfx”
$cert = New-SelfSignedCertificate -Subject $Publisher_CN -FriendlyName $Publisher_DisplayName -KeyAlgorithm RSA -KeyLength 2048 -Provider “Microsoft Enhanced RSA and AES Cryptographic Provider” -KeyExportPolicy Exportable -KeyUsage DigitalSignature -Type CodeSigningCert -CertStoreLocation “Cert:\LocalMachine\my” -NotAfter (Get-Date).AddMonths(120)
$cert | Export-PfxCertificate -FilePath $PfxName -Password $pwd -Force
Remove-item $cert.PsPath