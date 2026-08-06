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
$uiAssets = Join-Path $Root "assets\ui"

if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
    throw "Fonte medieval do painel nao encontrada: $sourcePath"
}

New-Item -ItemType Directory -Path $exports -Force | Out-Null
New-Item -ItemType Directory -Path (Split-Path $assetPath) -Force | Out-Null
New-Item -ItemType Directory -Path $uiAssets -Force | Out-Null

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

function New-RoundedPath(
    [float]$x,
    [float]$y,
    [float]$w,
    [float]$h,
    [float]$radius
) {
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $diameter = $radius * 2
    $path.AddArc($x, $y, $diameter, $diameter, 180, 90)
    $path.AddArc($x + $w - $diameter, $y, $diameter, $diameter, 270, 90)
    $path.AddArc($x + $w - $diameter, $y + $h - $diameter, $diameter, $diameter, 0, 90)
    $path.AddArc($x, $y + $h - $diameter, $diameter, $diameter, 90, 90)
    $path.CloseFigure()
    return $path
}

function Write-ControlSprite(
    [string]$Path,
    [int]$Width,
    [int]$Height,
    [int]$Radius,
    [string]$TopColor,
    [string]$BottomColor,
    [string]$BorderColor
) {
    $sprite = New-Object System.Drawing.Bitmap(
        $Width,
        $Height,
        [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
    )
    $spriteGraphics = [System.Drawing.Graphics]::FromImage($sprite)

    try {
        $spriteGraphics.Clear([System.Drawing.Color]::Transparent)
        $spriteGraphics.SmoothingMode =
            [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        $spriteGraphics.PixelOffsetMode =
            [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

        $shadowPath = New-RoundedPath 9 13 ($Width - 18) ($Height - 22) $Radius
        $shadowBrush = New-Object System.Drawing.SolidBrush(
            [System.Drawing.Color]::FromArgb(145, 0, 0, 0)
        )
        $spriteGraphics.FillPath($shadowBrush, $shadowPath)

        $buttonPath = New-RoundedPath 7 7 ($Width - 14) ($Height - 20) $Radius
        $buttonBounds = [System.Drawing.Rectangle]::new(7, 7, $Width - 14, $Height - 20)
        $gradient = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
            $buttonBounds,
            [System.Drawing.ColorTranslator]::FromHtml($TopColor),
            [System.Drawing.ColorTranslator]::FromHtml($BottomColor),
            90
        )
        $borderPen = New-Object System.Drawing.Pen(
            [System.Drawing.ColorTranslator]::FromHtml($BorderColor),
            4
        )
        $highlightPen = New-Object System.Drawing.Pen(
            [System.Drawing.Color]::FromArgb(75, 255, 255, 255),
            2
        )

        $spriteGraphics.FillPath($gradient, $buttonPath)
        $spriteGraphics.DrawPath($borderPen, $buttonPath)

        $innerPath = New-RoundedPath 13 13 ($Width - 26) ($Height - 32) ([math]::Max(4, $Radius - 7))
        $spriteGraphics.DrawPath($highlightPen, $innerPath)

        $sprite.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        if ($innerPath) { $innerPath.Dispose() }
        if ($highlightPen) { $highlightPen.Dispose() }
        if ($borderPen) { $borderPen.Dispose() }
        if ($gradient) { $gradient.Dispose() }
        if ($buttonPath) { $buttonPath.Dispose() }
        if ($shadowBrush) { $shadowBrush.Dispose() }
        if ($shadowPath) { $shadowPath.Dispose() }
        $spriteGraphics.Dispose()
        $sprite.Dispose()
    }
}

# Sprites transparentes permitem cantos arredondados reais nos Buttons XML.
# O estado hover/pressed continua sendo fornecido pelo ColorTint do TTS.
Write-ControlSprite (Join-Path $uiAssets "edward_control_row.png") 980 112 18 "#4A4337" "#292620" "#A08348"
Write-ControlSprite (Join-Path $uiAssets "edward_action_attack.png") 780 264 30 "#2C6A96" "#123B5B" "#C7A758"
Write-ControlSprite (Join-Path $uiAssets "edward_action_critical.png") 780 264 30 "#8A5517" "#4A2607" "#D2AD50"
Write-ControlSprite (Join-Path $uiAssets "edward_action_damage.png") 780 264 30 "#8A3732" "#4A1716" "#C77A61"
Write-ControlSprite (Join-Path $uiAssets "edward_action_clear.png") 780 264 30 "#454252" "#242330" "#8C829E"

Write-Output "Updated rounded control sprites in $uiAssets"
