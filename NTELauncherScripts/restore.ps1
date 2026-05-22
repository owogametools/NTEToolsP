$root = Join-Path $PSScriptRoot "NTEGlobal\ResFilesM"

  if (!(Test-Path $root)) {
      Write-Host "找不到資料夾: $root"
      exit 1
  }

  Get-ChildItem -Path $root -Recurse -Filter "yh.dat.bak" -File | ForEach-Object {
      $bak = $_.FullName
      $file = $bak -replace '\.bak$', ''

      Write-Host "還原: $file"
      Move-Item $bak $file -Force
  }