$rootcert = New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -DnsName "RootCA" -TextExtension @("2.5.29.19={text}CA=true") -KeyUsage CertSign,CrlSign,DigitalSignature
[System.Security.SecureString]$rootcertPassword = ConvertTo-SecureString -String "password" -Force -AsPlainText
[String]$rootCertPath = Join-Path -Path 'cert:\CurrentUser\My\' -ChildPath "$($rootcert.Thumbprint)"
Export-PfxCertificate -Cert $rootCertPath -FilePath 'RootCA.pfx' -Password $rootcertPassword
Export-Certificate -Cert $rootCertPath -FilePath 'RootCA.crt'

echo "Install This cert using your admin Account"
openssl pkcs12 -in .\RootCA.pfx -nocerts -out RootCA.key
openssl rsa -in .\RootCA.key -out .\RootCADec.key

kubectl create secret -n cert-manager --from-file=tls.crt=ca/ca.crt  --from-file=tls.key=RootCADec.key generic ca-key-pair