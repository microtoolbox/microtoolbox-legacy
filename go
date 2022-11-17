# Enable TLSv1.2 for compatibility with older clients
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://microtoolbox.github.io/main.bat'

$FilePath = "$env:TEMP\microtoolbox.bat"

try {
    Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing -OutFile $FilePath -Headers @{"Cache-Control"="no-cache"}
} catch {
    Write-Error $_
	Return
}

if (Test-Path $FilePath) {
    powershell -w h -c exit
    Start-Process $FilePath -Wait
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
}
