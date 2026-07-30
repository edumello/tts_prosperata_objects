param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing

$width = 2048
$height = 640

$exports = Join-Path $Root "image_menu\exports"
$assetPath = Join-Path $Root "assets\edward_attack_panel.png"
$exportPath = Join-Path $exports "edward_attack_panel_v1.png"

New-Item -ItemType Directory -Path $exports -Force | Out-Null
New-Item -ItemType Directory -Path (Split-Path $assetPath) -Force | Out-Null

$bmp = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

function Brush($hex) {
    return New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($hex))
}

function Pen($hex, $size = 1) {
    return New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml($hex), $size)
}

function RectPath($x, $y, $w, $h, $r) {
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $d = $r * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
    return $path
}

function FillRound($x, $y, $w, $h, $r, $fill, $stroke, $strokeWidth = 2) {
    $path = RectPath $x $y $w $h $r
    $g.FillPath((Brush $fill), $path)
    if ($stroke -ne $null) {
        $g.DrawPath((Pen $stroke $strokeWidth), $path)
    }
    $path.Dispose()
}

function DrawText(
    [string]$text,
    [System.Drawing.Font]$font,
    [string]$brushHex,
    [float]$x,
    [float]$y,
    [float]$w,
    [float]$h,
    [string]$align = "Near",
    [bool]$shadow = $true
) {
    $format = New-Object System.Drawing.StringFormat
    $format.Alignment = [System.Drawing.StringAlignment]::$align
    $format.LineAlignment = [System.Drawing.StringAlignment]::Center
    $format.FormatFlags = [System.Drawing.StringFormatFlags]::NoWrap
    $format.Trimming = [System.Drawing.StringTrimming]::EllipsisCharacter
    $rect = New-Object System.Drawing.RectangleF -ArgumentList $x, $y, $w, $h
    if ($shadow) {
        $shadowRect = New-Object System.Drawing.RectangleF -ArgumentList ($x + 3), ($y + 3), $w, $h
        $g.DrawString($text, $font, (Brush "#000000"), $shadowRect, $format)
    }
    $g.DrawString($text, $font, (Brush $brushHex), $rect, $format)
}

function DrawIconCircle($cx, $cy, $kind) {
    FillRound ($cx - 34) ($cy - 34) 68 68 34 "#0D0D0B" "#D8B857" 4
    $penGold = Pen "#EACB6D" 5
    $penDark = Pen "#44320E" 2

    if ($kind -eq "swords") {
        $g.DrawLine($penGold, $cx - 18, $cy - 20, $cx + 20, $cy + 18)
        $g.DrawLine($penGold, $cx + 18, $cy - 20, $cx - 20, $cy + 18)
        $g.DrawLine($penDark, $cx - 24, $cy - 26, $cx - 12, $cy - 14)
        $g.DrawLine($penDark, $cx + 24, $cy - 26, $cx + 12, $cy - 14)
    } elseif ($kind -eq "power") {
        $g.FillPie((Brush "#EACB6D"), $cx - 21, $cy - 8, 42, 32, 195, 150)
        $g.FillRectangle((Brush "#EACB6D"), $cx - 3, $cy - 17, 13, 27)
        $g.DrawArc($penDark, $cx - 25, $cy - 17, 44, 35, 20, 150)
    } elseif ($kind -eq "weight") {
        FillRound ($cx - 20) ($cy - 2) 40 24 5 "#EACB6D" $null 0
        $g.DrawArc($penGold, $cx - 14, $cy - 24, 28, 28, 180, 180)
    } elseif ($kind -eq "star") {
        $g.DrawLine($penGold, $cx, $cy - 25, $cx, $cy + 25)
        $g.DrawLine($penGold, $cx - 25, $cy, $cx + 25, $cy)
        $g.DrawLine($penGold, $cx - 18, $cy - 18, $cx + 18, $cy + 18)
        $g.DrawLine($penGold, $cx + 18, $cy - 18, $cx - 18, $cy + 18)
    } elseif ($kind -eq "plus") {
        $g.DrawLine($penGold, $cx - 22, $cy, $cx + 22, $cy)
        $g.DrawLine($penGold, $cx, $cy - 22, $cx, $cy + 22)
    } elseif ($kind -eq "crit") {
        $g.DrawEllipse($penGold, $cx - 22, $cy - 22, 44, 44)
        $g.DrawLine($penGold, $cx - 26, $cy, $cx + 26, $cy)
        $g.DrawLine($penGold, $cx, $cy - 26, $cx, $cy + 26)
    } elseif ($kind -eq "d20") {
        $points = @(
            [System.Drawing.Point]::new($cx, $cy - 28),
            [System.Drawing.Point]::new($cx + 28, $cy - 8),
            [System.Drawing.Point]::new($cx + 18, $cy + 24),
            [System.Drawing.Point]::new($cx - 18, $cy + 24),
            [System.Drawing.Point]::new($cx - 28, $cy - 8)
        )
        $g.DrawPolygon($penGold, $points)
        $g.DrawLine($penGold, $cx, $cy - 28, $cx - 18, $cy + 24)
        $g.DrawLine($penGold, $cx, $cy - 28, $cx + 18, $cy + 24)
    }

    $penGold.Dispose()
    $penDark.Dispose()
}

function DrawSmallPlusCircle($cx, $cy) {
    FillRound ($cx - 26) ($cy - 26) 52 52 26 "#0D0D0B" "#D8B857" 4

    $penGold = Pen "#EACB6D" 5
    $g.DrawLine($penGold, $cx - 16, $cy, $cx + 16, $cy)
    $g.DrawLine($penGold, $cx, $cy - 16, $cx, $cy + 16)
    $penGold.Dispose()
}

function DrawSlot($x, $y, $w, $h, $icon, $title, $controlText, $extraControlText = $null) {
    FillRound $x $y $w $h 8 "#171510" $null 0
    DrawIconCircle ($x + 48) ($y + ($h / 2)) $icon
    $titleFont = $fontTitle
    if ($title.Length -gt 11) {
        $titleFont = $fontSmall
    }
    DrawText $title $titleFont "#FFF5D7" ($x + 98) $y 300 $h "Near" $true

    $controlY = $y + (($h - 46) / 2)
    if ($extraControlText -eq $null) {
        FillRound ($x + $w - 158) $controlY 132 46 10 "#0A0D0D" "#9AA19A" 2
    } else {
        FillRound ($x + $w - 240) $controlY 140 46 10 "#0A0D0D" "#9AA19A" 2
        FillRound ($x + $w - 88) $controlY 72 46 10 "#0A0D0D" "#9AA19A" 2
    }
}

function DrawExtraSlot($x, $y, $w, $h) {
    FillRound $x $y $w $h 8 "#171510" $null 0
    DrawSmallPlusCircle ($x + 48) ($y + ($h / 2))

    $controlY = $y + (($h - 42) / 2)
    FillRound ($x + 98) $controlY 294 42 10 "#0A0D0D" "#9AA19A" 2
    FillRound ($x + $w - 158) $controlY 132 42 10 "#0A0D0D" "#9AA19A" 2
}

function DrawReadout($x, $y, $w, $h, $title, $value, $subtitle) {
    FillRound $x $y $w $h 14 "#0E1D18" "#3AAE67" 2
    DrawText $title $fontReadoutTitle "#CFFFE0" ($x + 24) ($y + 5) 190 34 "Near" $false
}

# Plain dark background for the official panel export.
$g.Clear([System.Drawing.ColorTranslator]::FromHtml("#13120F"))

$fontHero = New-Object System.Drawing.Font("Georgia", 48, [System.Drawing.FontStyle]::Bold)
$fontHeader = New-Object System.Drawing.Font("Georgia", 28, [System.Drawing.FontStyle]::Bold)
$fontTitle = New-Object System.Drawing.Font("Georgia", 28, [System.Drawing.FontStyle]::Bold)
$fontAction = New-Object System.Drawing.Font("Georgia", 24, [System.Drawing.FontStyle]::Bold)
$fontValue = New-Object System.Drawing.Font("Bahnschrift", 25, [System.Drawing.FontStyle]::Bold)
$fontSmall = New-Object System.Drawing.Font("Bahnschrift", 22, [System.Drawing.FontStyle]::Bold)
$fontSection = New-Object System.Drawing.Font("Bahnschrift", 22, [System.Drawing.FontStyle]::Bold)
$fontReadoutTitle = New-Object System.Drawing.Font("Bahnschrift", 24, [System.Drawing.FontStyle]::Bold)
$fontReadoutValue = New-Object System.Drawing.Font("Bahnschrift", 25, [System.Drawing.FontStyle]::Bold)
$fontSubtle = New-Object System.Drawing.Font("Bahnschrift", 15, [System.Drawing.FontStyle]::Regular)

# Main panel expanded close to the image edge. This keeps the same 2048x640
# canvas for TTS alignment, but removes the empty outer margin from the asset.
FillRound 8 8 2032 624 28 "#13120F" "#4B4A43" 6
FillRound 28 28 1992 584 8 "#17150F" "#D8B857" 3
$g.DrawLine((Pen "#C39B3B" 3), 56, 150, 1992, 150)

DrawText "EDWARD" $fontHero "#F3D987" 118 82 420 62 "Near" $true
DrawText "ESPADA DE EXECUCAO" $fontHeader "#FFF2D4" 600 88 560 54 "Center" $true
FillRound 1710 86 220 48 10 "#101211" "#8F8A78" 2
DrawText "UPDATE" $fontSmall "#D8D2C0" 1710 86 220 48 "Center" $false

# Column background areas. Left and center have one section border each; the
# internal rows stay borderless to preserve spacing around the attack names.
FillRound 108 165 610 300 16 "#11100D" "#8D762D" 2
FillRound 744 165 610 300 16 "#11100D" "#8D762D" 2
FillRound 1380 165 555 300 16 "#10130F" $null 0

DrawText "ATAQUES" $fontSection "#BDB7A8" 130 160 300 34 "Near" $false
DrawText "MOD. EXTRAS" $fontSection "#BDB7A8" 766 160 300 34 "Near" $false
DrawText "PREVIA" $fontSection "#BDB7A8" 1402 160 300 34 "Near" $false

DrawSlot 128 184 570 52 "swords" "PREPARADA" "OFF"
DrawSlot 128 240 570 52 "power" "PODEROSO" "OFF"
DrawSlot 128 296 570 52 "weight" "PESADO" "OFF"
DrawSlot 128 352 570 52 "d20" "GOLPE PESSOAL" "OFF"
DrawSlot 128 408 570 52 "star" "ESPECIAL" "MODO" "1 PM"

DrawExtraSlot 764 204 570 52
DrawExtraSlot 764 268 570 52
DrawExtraSlot 764 332 570 52
DrawExtraSlot 764 396 570 52

DrawReadout 1400 198 510 70 "PM GASTO" "0 PM" "custo das opcoes"
DrawReadout 1400 294 510 70 "ATAQUE" "min / med / max" "d20 + modificador atual"
DrawReadout 1400 390 510 70 "DANO" "min / med / max" "dano normal selecionado"

# Action buttons
FillRound 430 500 360 76 14 "#2D5FA8" "#F0C865" 5
DrawIconCircle 486 538 "d20"

FillRound 844 500 360 76 14 "#8A4318" "#F0C865" 5
DrawIconCircle 900 538 "crit"

FillRound 1258 500 360 76 14 "#7D1E18" "#F0C865" 5
DrawIconCircle 1314 538 "swords"

$bmp.Save($exportPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Save($assetPath, [System.Drawing.Imaging.ImageFormat]::Png)

$g.Dispose()
$bmp.Dispose()

Write-Output "Generated $exportPath"
Write-Output "Updated $assetPath"
