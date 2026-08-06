$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$candidateDlls = @()
if (${env:ProgramFiles(x86)}) {
    $candidateDlls += Join-Path ${env:ProgramFiles(x86)} "Steam\steamapps\common\Tabletop Simulator\Tabletop Simulator_Data\Managed\MoonSharp.Interpreter.dll"
}
if ($env:ProgramFiles) {
    $candidateDlls += Join-Path $env:ProgramFiles "Steam\steamapps\common\Tabletop Simulator\Tabletop Simulator_Data\Managed\MoonSharp.Interpreter.dll"
}

$moonSharpDll = $candidateDlls | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
if (-not $moonSharpDll) {
    throw "MoonSharp.Interpreter.dll nao encontrado na instalacao do Tabletop Simulator."
}

Add-Type -Path $moonSharpDll
$runtime = Get-Content -Raw -LiteralPath (Join-Path $projectRoot "ataque_edward.lua")

$harnessPrefix = @'
local attributes = {}
local publicChat = {}
local privateChat = {}
local objects = {}
local dieSequence = 0
local uiXml = ''
local deferSpawns = false
local deferredCallbacks = {}
local deferredDice = {}
local lastSpawnedDie = nil

local function encodeOwnership(value)
    return table.concat({
        tostring(value.schema),
        tostring(value.producer),
        tostring(value.ownerGuid),
        tostring(value.kind)
    }, '|')
end

JSON = {
    encode = function(value)
        if type(value) == 'table' and value.producer ~= nil then
            return encodeOwnership(value)
        end
        return '{}'
    end,
    decode = function(value)
        if value == 'COPY' then
            return {
                dadoAtaqueGuid = 'foreign',
                dadoAtaqueGuids = {'foreign'},
                dadoDanoGuids = {'manual'}
            }
        end
        local schema, producer, owner, kind =
            tostring(value):match('^([^|]+)|([^|]+)|([^|]+)|([^|]+)$')
        if schema ~= nil then
            return {
                schema = tonumber(schema),
                producer = producer,
                ownerGuid = owner,
                kind = kind
            }
        end
        return {}
    end
}

print = function(_) end
printToAll = function(message, color)
    table.insert(publicChat, {message = message, color = color})
end
printToColor = function(message, color, tint)
    table.insert(privateChat, {message = message, color = color, tint = tint})
end

local whitePlayer = {color = 'White', steam_name = 'Edward Tester'}
Player = {White = whitePlayer}
UI = {hide = function(_) end}

Wait = {
    frames = function(callback, _) callback() end,
    time = function(callback, _) callback(); return 1 end,
    stop = function(_) end,
    condition = function(callback, condition, _, timeout)
        if condition() then callback() elseif timeout then timeout() end
    end
}

self = {
    getGUID = function() return 'panelA' end,
    getPosition = function() return {x = 10, y = 1, z = 20} end,
    positionToWorld = function(offset)
        return {x = 10 + offset[1], y = 1 + offset[2], z = 20 + offset[3]}
    end,
    clearButtons = function() end,
    clearInputs = function() end,
    UI = {
        loading = false,
        setXml = function(xml) uiXml = xml end,
        setAttribute = function(id, attribute, value)
            attributes[id .. ':' .. attribute] = value
        end
    }
}

local function makeDie(guid, value, initialNotes)
    local destroyed = false
    local notes = initialNotes or ''
    local die = {
        resting = true,
        isDestroyed = function() return destroyed end,
        destruct = function() destroyed = true; objects[guid] = nil end,
        getGUID = function() return guid end,
        getGMNotes = function() return notes end,
        setGMNotes = function(nextNotes) notes = nextNotes end,
        setName = function(_) end,
        setColorTint = function(_) end,
        randomize = function(_) end,
        addForce = function(_, _) end,
        addTorque = function(_, _) end,
        getRotationValue = function() return value end,
        wasDestroyed = function() return destroyed end
    }
    objects[guid] = die
    return die
end

getObjectFromGUID = function(guid) return objects[guid] end
spawnObject = function(params)
    dieSequence = dieSequence + 1
    local value = params.type == 'Die_20' and 17 or ((dieSequence % 6) + 1)
    local die = makeDie('owned' .. tostring(dieSequence), value, '')
    lastSpawnedDie = die
    if deferSpawns then
        table.insert(deferredDice, die)
        table.insert(deferredCallbacks, function() params.callback_function(die) end)
    else
        params.callback_function(die)
    end
    return die
end
'@

$harnessSuffix = @'

onLoad('')
assert(string.find(uiXml, 'id="clear_dice"', 1, true) ~= nil)
assert(attributes['toggle_preparada:text'] == 'PREPARADA     OFF')

uiDispatch(whitePlayer, '-1', 'toggle_poderoso')
uiDispatch(whitePlayer, '-1', 'mod_1_plus')
uiDispatch(whitePlayer, '-1', 'roll_attack')
assert(#publicChat == 1)
assert(string.find(publicChat[1].message, 'ATAQUE', 1, true) ~= nil)
assert(publicChat[1].color.r == 0.35 and publicChat[1].color.g == 1.0)

local attackDie = objects.owned1
assert(attackDie ~= nil)
uiDispatch(whitePlayer, '-1', 'clear_dice')
assert(attackDie.wasDestroyed())

-- Limpar dados preserva o ultimo ataque, logo dano continua disponivel.
uiDispatch(whitePlayer, '-1', 'roll_damage')
assert(#publicChat == 2)
assert(string.find(publicChat[2].message, 'DANO NORMAL', 1, true) ~= nil)
assert(attributes['toggle_poderoso:text'] == 'PODEROSO     ON')
assert(attributes['mod_1_value:text'] == '+1')

-- As tres opcoes de rolagem continuam funcionando com modificadores ativos.
uiDispatch(whitePlayer, '-1', 'roll_attack')
uiDispatch(whitePlayer, '-1', 'roll_critical')
assert(#publicChat == 4)
assert(string.find(publicChat[4].message, 'DANO CRÍTICO', 1, true) ~= nil)
assert(attributes['toggle_poderoso:text'] == 'PODEROSO     ON')
assert(attributes['mod_1_value:text'] == '+1')

-- Limpar durante um spawn pendente invalida o callback; quando ele chega,
-- o dado criado por esta rolagem e destruido sem publicar resultado falso.
deferSpawns = true
uiDispatch(whitePlayer, '-1', 'toggle_golpe_pessoal')
uiDispatch(whitePlayer, '-1', 'roll_attack')
assert(#deferredCallbacks == 2)
deferredCallbacks[1]()
local firstPendingDie = deferredDice[1]
local secondPendingDie = deferredDice[2]
uiDispatch(whitePlayer, '-1', 'clear_dice')
assert(firstPendingDie.wasDestroyed())
assert(not secondPendingDie.wasDestroyed())
deferredCallbacks[2]()
assert(secondPendingDie.wasDestroyed())
assert(#publicChat == 4)
deferSpawns = false

-- Uma copia do painel pode herdar GUIDs, mas nao pode apagar dados de outra
-- instancia nem um dado manual sem metadados.
local foreign = makeDie(
    'foreign',
    10,
    encodeOwnership({
        schema = 1,
        producer = 'edumello/tts_prosperata_objects:edward',
        ownerGuid = 'panelB',
        kind = 'attack'
    })
)
local manual = makeDie('manual', 6, '')
onLoad('COPY')
uiDispatch(whitePlayer, '-1', 'clear_dice')
assert(not foreign.wasDestroyed())
assert(not manual.wasDestroyed())

return #publicChat, #privateChat, attributes['mod_1_value:text']
'@

$script = [MoonSharp.Interpreter.Script]::new([MoonSharp.Interpreter.CoreModules]::Preset_Complete)
$result = $script.DoString($harnessPrefix + "`n" + $runtime + "`n" + $harnessSuffix).ToString()
if ($result -ne '4, 3, "+0"') {
    throw "Smoke MoonSharp retornou '$result'; esperado '4, 3, `"+0`"'."
}

Write-Output "Edward MoonSharp smoke OK: $result"
