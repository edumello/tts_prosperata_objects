param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing

$width = 1792
$height = 1024

$sourcePath = Join-Path $Root "image_menu\source\edward_medieval_frame.png"
$exports = Join-Path $Root "image_menu\exports"
$assetPath = Join-Path $Root "assets\edward_attack_panel.png"
$exportPath = Join-Path $exports "edward_attack_panel_v1.png"

if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
    throw "Fonte medieval do painel nao encontrada: $sourcePath"
}

New-Item -ItemType Directory -Path $exports -Force | Out-Null
New-Item -ItemType Directory -Path (Split-Path $assetPath) -Force | Out-Null

$source = [System.Drawing.Image]::FromFile($sourcePath)
$bitmap = New-Object System.Drawing.Bitmap($width, $height)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

try {
    $graphics.CompositingMode =
        [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
    $graphics.CompositingQuality =
        [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $graphics.InterpolationMode =
        [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.SmoothingMode =
        [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $graphics.PixelOffsetMode =
        [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    # A arte-fonte ja usa 7:4. O resize deterministico preserva a moldura e
    # produz exatamente o canvas esperado pelo Custom Tile e pela Object UI.
    $graphics.DrawImage(
        $source,
        [System.Drawing.Rectangle]::new(0, 0, $width, $height),
        0,
        0,
        $source.Width,
        $source.Height,
        [System.Drawing.GraphicsUnit]::Pixel
    )

    $bitmap.Save($exportPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bitmap.Save($assetPath, [System.Drawing.Imaging.ImageFormat]::Png)
}
finally {
    $graphics.Dispose()
    $bitmap.Dispose()
    $source.Dispose()
}

Write-Output "Generated $exportPath"
Write-Output "Updated $assetPath"
