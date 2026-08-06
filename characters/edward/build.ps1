param(
    [string]$AssetUrl = "https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/assets/edward_attack_panel.png",
    [string]$OutputPath = (Join-Path $PSScriptRoot "dist\Edward_Attack_Panel_UI_Test.json")
)

$ErrorActionPreference = "Stop"

$luaPath = Join-Path $PSScriptRoot "ataque_edward.lua"
$uiPath = Join-Path $PSScriptRoot "ui.xml"
$imageBuilder = Join-Path $PSScriptRoot "image_menu\build_panel.ps1"

& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $imageBuilder
if ($LASTEXITCODE -ne 0) {
    throw "Falha ao gerar a imagem do painel Edward."
}

$lua = [System.IO.File]::ReadAllText($luaPath)
$ui = [System.IO.File]::ReadAllText($uiPath)
$lua = $lua -replace "`r`n?", "`n"
$newline = "`n"
$ui = ($ui -replace "`r`n?", "`n").TrimEnd()
$ui = $ui -replace "`n", $newline

$blockStart = "-- BEGIN EMBEDDED OBJECT UI${newline}local OBJECT_UI_XML = [==[${newline}"
$blockEnd = "${newline}]==]${newline}-- END EMBEDDED OBJECT UI"
$start = $lua.IndexOf($blockStart, [System.StringComparison]::Ordinal)
if ($start -lt 0) {
    throw "Marcador inicial do XML incorporado nao encontrado."
}

$contentStart = $start + $blockStart.Length
$end = $lua.IndexOf($blockEnd, $contentStart, [System.StringComparison]::Ordinal)
if ($end -lt 0) {
    throw "Marcador final do XML incorporado nao encontrado."
}

$bundledLua =
    $lua.Substring(0, $contentStart) +
    $ui +
    $lua.Substring($end)

$utf8 = [System.Text.UTF8Encoding]::new($false)
[System.IO.File]::WriteAllText($luaPath, $bundledLua, $utf8)

$notes = [ordered]@{
    project = "edumello/tts_prosperata_objects"
    branch = "agent/edward-panel-ui"
    aspectRatio = "3.2:1"
    ui = "object-xml"
}

$savedObject = [ordered]@{
    SaveName = "Edward Attack Panel - XML UI Test"
    GameMode = ""
    Date = ""
    Gravity = 0.5
    PlayArea = 0.5
    GameType = ""
    GameComplexity = ""
    Tags = @()
    Table = ""
    Sky = ""
    Note = ""
    Rules = ""
    PlayerTurn = ""
    ObjectStates = @(
        [ordered]@{
            Name = "Custom_Tile"
            Transform = [ordered]@{
                posX = 0
                posY = 1.1
                posZ = 0
                rotX = 0
                rotY = 180
                rotZ = 0
                scaleX = 1
                scaleY = 1
                scaleZ = 1
            }
            Nickname = "Edward Attack Panel"
            Description = "Painel Edward com Object UI e limpeza segura de dados"
            GMNotes = ($notes | ConvertTo-Json -Depth 5)
            ColorDiffuse = [ordered]@{ r = 1; g = 1; b = 1 }
            Locked = $false
            Grid = $true
            Snap = $true
            IgnoreFoW = $false
            MeasureMovement = $false
            DragSelectable = $true
            Autoraise = $true
            Sticky = $true
            Tooltip = $true
            GridProjection = $false
            HideWhenFaceDown = $false
            Hands = $false
            CustomImage = [ordered]@{
                ImageURL = $AssetUrl
                ImageSecondaryURL = ""
                ImageScalar = 1
                WidthScale = 0
                CustomTile = [ordered]@{
                    Type = 0
                    Thickness = 0.1
                    Stackable = $false
                    Stretch = $true
                }
            }
            LuaScript = $bundledLua
            LuaScriptState = ""
            XmlUI = ""
            GUID = "e4d001"
        }
    )
    TabStates = [ordered]@{}
    VersionNumber = ""
}

$outputDirectory = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
$json = $savedObject | ConvertTo-Json -Depth 20
[System.IO.File]::WriteAllText($OutputPath, $json + "`n", $utf8)

Write-Output "Embedded $uiPath into $luaPath"
Write-Output "Generated $OutputPath"
