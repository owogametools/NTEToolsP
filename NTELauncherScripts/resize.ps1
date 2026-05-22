$root = Join-Path $PSScriptRoot "NTEGlobal\ResFilesM"

  if (!(Test-Path $root)) {
      Write-Host "找不到資料夾: $root"
      exit 1
  }

  Get-ChildItem -Path $root -Recurse -Filter "yh.dat" -File | ForEach-Object {
      $file = $_.FullName
      $bak = "$file.bak"

      if ($_.Length -gt 10MB) {
          Write-Host "處理: $file"

          Move-Item $file $bak -Force
          ffmpeg -f mjpeg -i $bak -frames:v 1 -c:v copy -f mjpeg $file

          if ($LASTEXITCODE -ne 0) {
              Write-Host "ffmpeg 失敗，還原: $file"
              Move-Item $bak $file -Force
          }
      }
  }