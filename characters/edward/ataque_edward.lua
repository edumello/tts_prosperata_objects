-- =========================================================
-- CONFIGURAÇÃO DO PERSONAGEM
-- Edward / Humano Guerreiro 5 / Espada de execução
-- =========================================================

local CONFIG = {
    nomeArma = "Espada de execução",

    -- Bônus com a espada preparada:
    -- Luta +10, Foco em Arma +2, Armas da Ambição +1
    bonusAtaqueBase = 13,

    -- Dano normal:
    -- 2d6 da espada + Força 6 + Estilo de Duas Mãos +5
    quantidadeDadosDano = 2,
    ladosDadoDano = 6,
    bonusDanoBase = 11,

    -- Crítico da espada com Armas da Ambição
    margemCritico = 17,
    multiplicadorCritico = 4,

    -- Guerreiro nível 1 a 4: máximo 1 PM
    -- Guerreiro nível 5 a 8: máximo 2 PM
    -- Guerreiro nível 9 a 12: máximo 3 PM
    -- Guerreiro nível 13 a 16: máximo 4 PM
    -- Guerreiro nível 17+: máximo 5 PM
    ataqueEspecialMaxPM = 2,

    -- Golpe Pessoal: Passo do Carrasco
    golpePessoalNome = "Passo do Carrasco",
    golpePessoalCustoPM = 1,
    golpePessoalDadoExtra = 1,
    golpePessoalEfeitos =
        "Avanço + Brutal + Preciso + Truque Secreto",
    golpePessoalAvisoAvanco =
        "AVANÇO: você pode percorrer até seu deslocamento em linha reta antes de desferir o golpe.",
    golpePessoalAvisoTruque =
        "TRUQUE SECRETO: este Golpe Pessoal só pode ser usado uma vez contra cada alvo por cena.",

    -- Limites do modificador manual de ataque
    modExtraMin = -20,
    modExtraMax = 20,

    -- Mantem poderes e selecoes ativos entre todos os tipos de ataque.
    resetarAposAtaque = false,

    -- Mantem modificadores extras entre ataques para efeitos de varios turnos.
    resetarModExtraAposAtaque = false,

    -- Depois de rolar o dano, consome o último ataque armazenado
    consumirAtaqueAposDano = true,

    -- D20 fisico usado por ROLAR ATAQUE
    dadoAtaqueTipo = "Die_20",
    dadoAtaqueOffsetLocal = {0, 2.0, -1.35},
    dadoAtaqueEspacamento = 0.55,
    dadoAtaqueEscala = {1.25, 1.25, 1.25},
    dadoAtaqueForcaMinima = {-3, 14, -3},
    dadoAtaqueForcaMaxima = {3, 18, 3},
    dadoAtaqueTorqueMinimo = {-35, -35, -35},
    dadoAtaqueTorqueMaximo = {35, 35, 35},
    dadoAtaqueEsperaMaxima = 8,
    dadoAtaqueIntervaloLeitura = 0.25,

    -- D6 fisicos usados por ROLAR DANO e ROLAR ATAQUE CRITICO
    dadoDanoTipo = "Die_6",
    dadoDanoOffsetLocal = {0, 2.0, 1.35},
    dadoDanoEspacamento = 0.48,
    dadoDanoEscala = {1.05, 1.05, 1.05},
    dadoDanoForcaMinima = {-3, 12, -3},
    dadoDanoForcaMaxima = {3, 16, 3},
    dadoDanoTorqueMinimo = {-30, -30, -30},
    dadoDanoTorqueMaximo = {30, 30, 30},
    dadoDanoEsperaMaxima = 8,
    dadoDanoIntervaloLeitura = 0.25,

    -- Verde original dos resultados de ataque e dano no chat.
    corChat = {
        r = 0.35,
        g = 1.00,
        b = 0.35
    },

    corErro = {
        r = 1.00,
        g = 0.35,
        b = 0.35
    },

    -- Atualizacao automatica via GitHub.
    -- Estes arquivos precisam estar publicados no branch main.
    githubScriptUrl =
        "https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/ataque_edward.lua",
    githubImagemUrl =
        "https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/assets/edward_attack_panel.png"
}

local QUANTIDADE_MOD_EXTRAS = 4

-- O XML abaixo e sincronizado a partir de ui.xml por build.ps1. Manter os
-- marcadores intactos para que o runtime publicado continue autocontido.
-- BEGIN EMBEDDED OBJECT UI
local OBJECT_UI_XML = [==[
<!-- Object UI do painel Edward. Este arquivo e a fonte canonica do XML
     incorporado em ataque_edward.lua pelo script de build. -->
<Defaults>
    <Text color="#EEE6D4" fontSize="23" fontStyle="Bold"
          alignment="MiddleCenter" resizeTextForBestFit="true"
          resizeTextMinSize="13" resizeTextMaxSize="26"
          horizontalOverflow="Wrap" verticalOverflow="Truncate" />

    <Panel class="card" color="#11120FF2" outline="#8D762D" outlineSize="2 2" />
    <Panel class="readout" color="#0E1D18F4" outline="#3AAE67" outlineSize="2 2" />

    <Button class="baseButton" fontSize="22" fontStyle="Bold" textColor="#FFF5D7"
            textAlignment="MiddleCenter" resizeTextForBestFit="true"
            resizeTextMinSize="15" resizeTextMaxSize="24"
            colors="#34312A|#504936|#25231E|#22201BCC"
            outline="#A98D49" outlineSize="2 2" padding="9 9 5 5" />
    <Button class="toggleButton" fontSize="22" fontStyle="Bold" textColor="#FFFDF5"
            textAlignment="MiddleLeft" resizeTextForBestFit="true"
            resizeTextMinSize="15" resizeTextMaxSize="24"
            colors="#3A3D40|#50555A|#272A2D|#202326CC"
            outline="#A99B78" outlineSize="2 2" padding="22 18 5 5" />
    <Button class="miniButton" fontSize="25" fontStyle="Bold" textColor="#FFF3C7"
            textAlignment="MiddleCenter" resizeTextForBestFit="true"
            resizeTextMinSize="18" resizeTextMaxSize="26"
            colors="#3A3528|#574A2A|#272319|#211E17CC"
            outline="#B99A45" outlineSize="2 2" padding="2 2 2 2" />
    <Button class="blueAction" fontSize="25" fontStyle="Bold" textColor="#F3F8FF"
            textAlignment="MiddleCenter" resizeTextForBestFit="true"
            resizeTextMinSize="15" resizeTextMaxSize="26"
            colors="#24527F|#3674A8|#183751|#0B1B2888"
            outline="#E0BC5B" outlineSize="4 4" padding="10 10 6 6" />
    <Button class="orangeAction" fontSize="25" fontStyle="Bold" textColor="#FFF1DA"
            textAlignment="MiddleCenter" resizeTextForBestFit="true"
            resizeTextMinSize="15" resizeTextMaxSize="26"
            colors="#713512|#A4511D|#48210B|#25100688"
            outline="#E0BC5B" outlineSize="4 4" padding="10 10 6 6" />
    <Button class="redAction" fontSize="25" fontStyle="Bold" textColor="#FFE7E1"
            textAlignment="MiddleCenter" resizeTextForBestFit="true"
            resizeTextMinSize="15" resizeTextMaxSize="26"
            colors="#681B17|#943027|#42110E|#21090888"
            outline="#E0BC5B" outlineSize="4 4" padding="10 10 6 6" />
    <Button class="clearAction" fontSize="25" fontStyle="Bold" textColor="#EFE9DE"
            textAlignment="MiddleCenter" resizeTextForBestFit="true"
            resizeTextMinSize="15" resizeTextMaxSize="26"
            colors="#292C2E|#444A4D|#17191A|#0C0D0E88"
            outline="#9A8A63" outlineSize="4 4" padding="10 10 6 6" />

    <InputField class="nameInput" fontSize="20" fontStyle="Bold"
                textColor="#E5F2E7" color="#090C0B"
                colors="#20231F|#30382F|#161815|#151714CC"
                alignment="MiddleCenter" lineType="SingleLine"
                characterValidation="None" characterLimit="18"
                caretColor="#E0BC5B" selectionColor="#826A35AA"
                outline="#716441" outlineSize="2 2" />
</Defaults>

<!-- A UI acompanha a face superior do Custom_Tile. A rotacao compensa o
     rotY=180 usado pelo Saved Object oficial. -->
<Panel id="edwardConsole" width="2048" height="640" rectAlignment="MiddleCenter"
       position="0 0 -50" rotation="0 0 180" scale="0.25 0.25 1"
       color="#00000000" raycastTarget="false">

    <Button id="update" class="baseButton" text="ATUALIZAR"
            onClick="uiDispatch" width="220" height="50"
            rectAlignment="UpperLeft" offsetXY="1690 -82" />

    <!-- Ataques: o card inteiro e o botao. -->
    <Button id="toggle_preparada" class="toggleButton" text="PREPARADA  —  INATIVO"
            onClick="uiDispatch" width="526" height="44"
            rectAlignment="UpperLeft" offsetXY="150 -204" />
    <Button id="toggle_poderoso" class="toggleButton" text="PODEROSO  —  INATIVO"
            onClick="uiDispatch" width="526" height="44"
            rectAlignment="UpperLeft" offsetXY="150 -254" />
    <Button id="toggle_pesado" class="toggleButton" text="PESADO  —  INATIVO"
            onClick="uiDispatch" width="526" height="44"
            rectAlignment="UpperLeft" offsetXY="150 -304" />
    <Button id="toggle_golpe_pessoal" class="toggleButton" text="GOLPE PESSOAL  —  INATIVO"
            onClick="uiDispatch" width="526" height="44"
            rectAlignment="UpperLeft" offsetXY="150 -354" />

    <Button id="especial_mode" class="toggleButton" text="ESPECIAL  —  INATIVO"
            onClick="uiDispatch" width="318" height="44"
            rectAlignment="UpperLeft" offsetXY="150 -404" />
    <Button id="especial_pm_minus" class="miniButton" text="−"
            onClick="uiDispatch" width="44" height="44"
            rectAlignment="UpperLeft" offsetXY="478 -404" />
    <Text id="especial_pm_value" text="1 PM" width="82" height="44"
          rectAlignment="UpperLeft" offsetXY="528 -404"
          color="#F5DE96" outline="#090909" outlineSize="1 1" />
    <Button id="especial_pm_plus" class="miniButton" text="+"
            onClick="uiDispatch" width="44" height="44"
            rectAlignment="UpperLeft" offsetXY="618 -404" />

    <!-- Modificadores extras: input e controles explicitos. -->
    <InputField id="mod_name_1" class="nameInput" text="EXTRA 1" onEndEdit="uiEditModName"
                width="318" height="44" rectAlignment="UpperLeft" offsetXY="782 -204" />
    <Button id="mod_1_minus" class="miniButton" text="−" onClick="uiDispatch"
            width="44" height="44" rectAlignment="UpperLeft" offsetXY="1110 -204" />
    <Text id="mod_1_value" text="+0" width="66" height="44"
          rectAlignment="UpperLeft" offsetXY="1160 -204" color="#F5DE96" />
    <Button id="mod_1_plus" class="miniButton" text="+" onClick="uiDispatch"
            width="44" height="44" rectAlignment="UpperLeft" offsetXY="1232 -204" />

    <InputField id="mod_name_2" class="nameInput" text="EXTRA 2" onEndEdit="uiEditModName"
                width="318" height="44" rectAlignment="UpperLeft" offsetXY="782 -264" />
    <Button id="mod_2_minus" class="miniButton" text="−" onClick="uiDispatch"
            width="44" height="44" rectAlignment="UpperLeft" offsetXY="1110 -264" />
    <Text id="mod_2_value" text="+0" width="66" height="44"
          rectAlignment="UpperLeft" offsetXY="1160 -264" color="#F5DE96" />
    <Button id="mod_2_plus" class="miniButton" text="+" onClick="uiDispatch"
            width="44" height="44" rectAlignment="UpperLeft" offsetXY="1232 -264" />

    <InputField id="mod_name_3" class="nameInput" text="EXTRA 3" onEndEdit="uiEditModName"
                width="318" height="44" rectAlignment="UpperLeft" offsetXY="782 -324" />
    <Button id="mod_3_minus" class="miniButton" text="−" onClick="uiDispatch"
            width="44" height="44" rectAlignment="UpperLeft" offsetXY="1110 -324" />
    <Text id="mod_3_value" text="+0" width="66" height="44"
          rectAlignment="UpperLeft" offsetXY="1160 -324" color="#F5DE96" />
    <Button id="mod_3_plus" class="miniButton" text="+" onClick="uiDispatch"
            width="44" height="44" rectAlignment="UpperLeft" offsetXY="1232 -324" />

    <InputField id="mod_name_4" class="nameInput" text="EXTRA 4" onEndEdit="uiEditModName"
                width="318" height="44" rectAlignment="UpperLeft" offsetXY="782 -384" />
    <Button id="mod_4_minus" class="miniButton" text="−" onClick="uiDispatch"
            width="44" height="44" rectAlignment="UpperLeft" offsetXY="1110 -384" />
    <Text id="mod_4_value" text="+0" width="66" height="44"
          rectAlignment="UpperLeft" offsetXY="1160 -384" color="#F5DE96" />
    <Button id="mod_4_plus" class="miniButton" text="+" onClick="uiDispatch"
            width="44" height="44" rectAlignment="UpperLeft" offsetXY="1232 -384" />

    <!-- Previa: somente leitura. -->
    <Panel class="readout" width="490" height="62" rectAlignment="UpperLeft" offsetXY="1404 -202">
        <Text text="PM GASTO" width="170" height="54" rectAlignment="MiddleLeft"
              offsetXY="18 0" alignment="MiddleLeft" color="#CFFFE0" fontSize="21" />
        <Text id="preview_pm" text="0 PM" width="236" height="54" rectAlignment="MiddleRight"
              offsetXY="-18 0" alignment="MiddleRight" color="#FFFFFF" fontSize="21" />
    </Panel>
    <Panel class="readout" width="490" height="62" rectAlignment="UpperLeft" offsetXY="1404 -284">
        <Text text="ATAQUE" width="170" height="54" rectAlignment="MiddleLeft"
              offsetXY="18 0" alignment="MiddleLeft" color="#CFFFE0" fontSize="21" />
        <Text id="preview_attack" text="0 / 0 / 0" width="266" height="54" rectAlignment="MiddleRight"
              offsetXY="-18 0" alignment="MiddleRight" color="#FFFFFF" fontSize="21" />
    </Panel>
    <Panel class="readout" width="490" height="62" rectAlignment="UpperLeft" offsetXY="1404 -366">
        <Text text="DANO" width="170" height="54" rectAlignment="MiddleLeft"
              offsetXY="18 0" alignment="MiddleLeft" color="#CFFFE0" fontSize="21" />
        <Text id="preview_damage" text="0 / 0 / 0" width="266" height="54" rectAlignment="MiddleRight"
              offsetXY="-18 0" alignment="MiddleRight" color="#FFFFFF" fontSize="21" />
    </Panel>

    <!-- Acoes: quatro hitboxes completas e independentes. -->
    <Button id="roll_attack" class="blueAction" text="ROLAR ATAQUE&#10;d20 + modificadores"
            onClick="uiDispatch" width="360" height="70"
            rectAlignment="UpperLeft" offsetXY="210 -516" />
    <Button id="roll_critical" class="orangeAction" text="CRÍTICO&#10;dano x4 salvo"
            onClick="uiDispatch" width="360" height="70"
            rectAlignment="UpperLeft" offsetXY="626 -516" />
    <Button id="roll_damage" class="redAction" text="ROLAR DANO&#10;aguardando ataque"
            onClick="uiDispatch" width="360" height="70"
            rectAlignment="UpperLeft" offsetXY="1042 -516" />
    <Button id="clear_dice" class="clearAction" text="LIMPAR DADOS&#10;somente deste painel"
            onClick="uiDispatch" width="360" height="70"
            rectAlignment="UpperLeft" offsetXY="1458 -516" />
</Panel>
]==]
-- END EMBEDDED OBJECT UI

local DICE_OWNER_SCHEMA = 1
local DICE_OWNER_PRODUCER =
    "edumello/tts_prosperata_objects:edward"

local ESPECIAL_NOMES = {
    [0] = "OFF",
    [1] = "ATAQUE",
    [2] = "DANO",
    [3] = "DIVIDIDO"
}

-- =========================================================
-- ESTADO
-- =========================================================

local function criarUltimoAtaqueVazio()
    return {
        disponivel = false,
        jogador = "",
        d20 = 0,
        d20Lista = {},
        totalAtaque = 0,
        modificadorAtaque = 0,
        modificadorDano = CONFIG.bonusDanoBase,
        quantidadeDadosDano = CONFIG.quantidadeDadosDano,
        golpePessoal = false,
        custoPM = 0,
        ameacaCritico = false,
        listaEfeitos = "Nenhum",
        resumoEfeitosChat = "Sem modificadores"
    }
end

local function limitarModExtraInicial(valor)
    valor = math.floor(tonumber(valor) or 0)

    return math.max(
        CONFIG.modExtraMin,
        math.min(CONFIG.modExtraMax, valor)
    )
end

local function criarModExtraPadrao(indice, valor)
    return {
        nome = "EXTRA " .. tostring(indice),
        valor = limitarModExtraInicial(valor)
    }
end

local function criarModExtrasPadrao()
    local modificadores = {}

    for indice = 1, QUANTIDADE_MOD_EXTRAS do
        modificadores[indice] =
            criarModExtraPadrao(indice, 0)
    end

    return modificadores
end

local function criarEstadoPadrao()
    return {
        preparada = false,
        poderoso = false,
        especialModo = 0,
        especialPM = 1,
        pesado = false,
        golpePessoal = false,
        modExtras = criarModExtrasPadrao(),

        ultimoAtaque = criarUltimoAtaqueVazio(),
        dadoAtaqueGuid = "",
        dadoAtaqueGuids = {},
        dadoDanoGuids = {}
    }
end

local state = criarEstadoPadrao()

local dadoAtaqueObjeto = nil
local dadosAtaqueObjetos = {}
local dadoAtaqueWaitId = nil
local dadoAtaqueRolagemId = 0
local dadosDanoObjetos = {}
local dadoDanoWaitId = nil
local dadoDanoRolagemId = 0
local updateGithubEmAndamento = false

local calcularModificadoresSelecionados = nil
local calcularPreviewSelecionado = nil

-- =========================================================
-- FUNÇÕES AUXILIARES
-- =========================================================

local function limitar(valor, minimo, maximo)
    valor = tonumber(valor) or minimo

    return math.max(
        minimo,
        math.min(maximo, valor)
    )
end

local function limitarInteiro(valor, minimo, maximo)
    return math.floor(
        limitar(valor, minimo, maximo)
    )
end

local function ultimoAtaqueValido(ultimo)
    if type(ultimo) ~= "table" then
        return false
    end

    local d20 = tonumber(ultimo.d20)

    return ultimo.disponivel == true
        and d20 ~= nil
        and d20 >= 1
        and d20 <= 20
end

local function descartarUltimoAtaque()
    state.ultimoAtaque = criarUltimoAtaqueVazio()
end

local function sinal(numero)
    numero = tonumber(numero) or 0

    if numero >= 0 then
        return "+" .. tostring(numero)
    end

    return tostring(numero)
end

local function limitarTexto(texto, maximo)
    texto = tostring(texto or "")
    texto = texto:gsub("[\r\n\t]", " ")
    texto = texto:gsub("^%s+", ""):gsub("%s+$", "")

    if texto == "" then
        return nil
    end

    if string.len(texto) > maximo then
        texto = string.sub(texto, 1, maximo)
    end

    return texto
end

local function nomeJogador(jogador)
    local cor =
        tostring(jogador or "")

    if cor ~= ""
        and Player ~= nil
        and Player[cor] ~= nil then
        local sucesso, nome =
            pcall(function()
                return Player[cor].steam_name
            end)

        nome =
            limitarTexto(nome, 40)

        if sucesso and nome ~= nil then
            return nome
        end
    end

    if cor ~= "" then
        return cor
    end

    return "Jogador"
end

local function garantirModExtras()
    if type(state.modExtras) ~= "table" then
        state.modExtras = criarModExtrasPadrao()
    end

    for indice = 1, QUANTIDADE_MOD_EXTRAS do
        if type(state.modExtras[indice]) ~= "table" then
            state.modExtras[indice] =
                criarModExtraPadrao(indice, 0)
        end

        state.modExtras[indice].nome =
            limitarTexto(
                state.modExtras[indice].nome,
                18
            ) or "EXTRA " .. tostring(indice)

        state.modExtras[indice].valor =
            limitarInteiro(
                state.modExtras[indice].valor or 0,
                CONFIG.modExtraMin,
                CONFIG.modExtraMax
            )
    end
end

local function somarModExtras()
    garantirModExtras()

    local total = 0

    for indice = 1, QUANTIDADE_MOD_EXTRAS do
        total =
            total +
            state.modExtras[indice].valor
    end

    return total
end

local function nomeModExtra(indice)
    garantirModExtras()

    return state.modExtras[indice].nome
        or "EXTRA " .. tostring(indice)
end

local function textoToggle(ativo)
    if ativo then
        return "ATIVO"
    end

    return "INATIVO"
end

local function formatarMedia(valor)
    if math.floor(valor) == valor then
        return tostring(valor)
    end

    return string.format("%.1f", valor)
end

local function objetoValido(objeto)
    if objeto == nil then
        return false
    end

    local sucesso, destruido =
        pcall(function()
            return objeto.isDestroyed()
        end)

    return sucesso and not destruido
end

local function guidDoPainel()
    local sucesso, guid = pcall(function()
        return self.getGUID()
    end)

    if sucesso then
        return tostring(guid or "")
    end

    return ""
end

local function metadadosDado(tipo)
    return {
        schema = DICE_OWNER_SCHEMA,
        producer = DICE_OWNER_PRODUCER,
        ownerGuid = guidDoPainel(),
        kind = tostring(tipo or "")
    }
end

local function marcarDadoComoProprio(dado, tipo)
    if not objetoValido(dado) then
        return false
    end

    local sucesso = pcall(function()
        dado.setGMNotes(
            JSON.encode(metadadosDado(tipo))
        )
    end)

    return sucesso
end

local function dadoPertenceAoPainel(dado, tipoEsperado)
    if not objetoValido(dado) then
        return false
    end

    local sucessoNotas, notas = pcall(function()
        return dado.getGMNotes()
    end)

    if not sucessoNotas
        or notas == nil
        or notas == "" then
        return false
    end

    local sucessoJson, dados =
        pcall(JSON.decode, tostring(notas))

    if not sucessoJson
        or type(dados) ~= "table" then
        return false
    end

    return tonumber(dados.schema) == DICE_OWNER_SCHEMA
        and dados.producer == DICE_OWNER_PRODUCER
        and tostring(dados.ownerGuid or "") == guidDoPainel()
        and (tipoEsperado == nil
            or tostring(dados.kind or "") == tipoEsperado)
end

local function obterDadosAtaqueAtuais()
    local dados = {}

    for _, dado in ipairs(dadosAtaqueObjetos) do
        if dadoPertenceAoPainel(dado, "attack") then
            table.insert(dados, dado)
        end
    end

    if #dados == 0
        and dadoPertenceAoPainel(dadoAtaqueObjeto, "attack") then
        table.insert(dados, dadoAtaqueObjeto)
    end

    if #dados == 0
        and type(state.dadoAtaqueGuids) == "table" then
        for _, guid in ipairs(state.dadoAtaqueGuids) do
            local dado =
                getObjectFromGUID(tostring(guid))

            if dadoPertenceAoPainel(dado, "attack") then
                table.insert(dados, dado)
            end
        end
    end

    if #dados == 0
        and state.dadoAtaqueGuid ~= nil
        and state.dadoAtaqueGuid ~= "" then
        local dado =
            getObjectFromGUID(state.dadoAtaqueGuid)

        if dadoPertenceAoPainel(dado, "attack") then
            table.insert(dados, dado)
        end
    end

    dadosAtaqueObjetos = dados
    dadoAtaqueObjeto = dados[1]

    if #dados == 0 then
        state.dadoAtaqueGuid = ""
        state.dadoAtaqueGuids = {}
    end

    return dados
end

local function pararEsperaDadoAtaque()
    if dadoAtaqueWaitId ~= nil then
        pcall(function()
            Wait.stop(dadoAtaqueWaitId)
        end)

        dadoAtaqueWaitId = nil
    end
end

local function destruirDadoAtaqueAtual()
    pararEsperaDadoAtaque()

    for _, dado in ipairs(obterDadosAtaqueAtuais()) do
        pcall(function()
            dado.destruct()
        end)
    end

    dadoAtaqueObjeto = nil
    dadosAtaqueObjetos = {}
    state.dadoAtaqueGuid = ""
    state.dadoAtaqueGuids = {}
end

local function posicaoSpawnDadoAtaque(indice, quantidade)
    local x =
        CONFIG.dadoAtaqueOffsetLocal[1]

    if quantidade > 1 then
        x =
            x +
            (indice - ((quantidade + 1) / 2)) *
            CONFIG.dadoAtaqueEspacamento
    end

    local offset = {
        x,
        CONFIG.dadoAtaqueOffsetLocal[2],
        CONFIG.dadoAtaqueOffsetLocal[3]
    }

    local sucesso, posicao =
        pcall(function()
            return self.positionToWorld(offset)
        end)

    if sucesso then
        return posicao
    end

    local posicaoPainel =
        self.getPosition()

    return {
        posicaoPainel.x + x,
        posicaoPainel.y + CONFIG.dadoAtaqueOffsetLocal[2],
        posicaoPainel.z + CONFIG.dadoAtaqueOffsetLocal[3]
    }
end

local function vetorAleatorio(minimos, maximos)
    return {
        math.random(minimos[1], maximos[1]),
        math.random(minimos[2], maximos[2]),
        math.random(minimos[3], maximos[3])
    }
end

local function impulsionarDadoAtaque(dado, jogador)
    Wait.frames(function()
        if not objetoValido(dado) then
            return
        end

        pcall(function()
            dado.randomize(jogador)
            dado.addForce(
                vetorAleatorio(
                    CONFIG.dadoAtaqueForcaMinima,
                    CONFIG.dadoAtaqueForcaMaxima
                ),
                3
            )
            dado.addTorque(
                vetorAleatorio(
                    CONFIG.dadoAtaqueTorqueMinimo,
                    CONFIG.dadoAtaqueTorqueMaximo
                ),
                3
            )
        end)
    end, 1)
end

local function obterDadosDanoAtuais()
    local dados = {}

    for _, dado in ipairs(dadosDanoObjetos) do
        if dadoPertenceAoPainel(dado, "damage") then
            table.insert(dados, dado)
        end
    end

    if #dados == 0 and type(state.dadoDanoGuids) == "table" then
        for _, guid in ipairs(state.dadoDanoGuids) do
            local dado =
                getObjectFromGUID(tostring(guid))

            if dadoPertenceAoPainel(dado, "damage") then
                table.insert(dados, dado)
            end
        end
    end

    dadosDanoObjetos = dados

    return dados
end

local function pararEsperaDadoDano()
    if dadoDanoWaitId ~= nil then
        pcall(function()
            Wait.stop(dadoDanoWaitId)
        end)

        dadoDanoWaitId = nil
    end
end

local function destruirDadosDanoAtuais()
    pararEsperaDadoDano()

    for _, dado in ipairs(obterDadosDanoAtuais()) do
        pcall(function()
            dado.destruct()
        end)
    end

    dadosDanoObjetos = {}
    state.dadoDanoGuids = {}
end

local function posicaoSpawnDadoDano(indice, quantidade)
    local colunas =
        math.min(quantidade, 4)

    local coluna =
        (indice - 1) % 4

    local linha =
        math.floor((indice - 1) / 4)

    local x =
        CONFIG.dadoDanoOffsetLocal[1] +
        (coluna - ((colunas - 1) / 2)) *
        CONFIG.dadoDanoEspacamento

    local z =
        CONFIG.dadoDanoOffsetLocal[3] +
        linha *
        CONFIG.dadoDanoEspacamento

    local offset = {
        x,
        CONFIG.dadoDanoOffsetLocal[2],
        z
    }

    local sucesso, posicao =
        pcall(function()
            return self.positionToWorld(offset)
        end)

    if sucesso then
        return posicao
    end

    local posicaoPainel =
        self.getPosition()

    return {
        posicaoPainel.x + x,
        posicaoPainel.y + CONFIG.dadoDanoOffsetLocal[2],
        posicaoPainel.z + z
    }
end

local function impulsionarDadoDano(dado, jogador)
    Wait.frames(function()
        if not objetoValido(dado) then
            return
        end

        pcall(function()
            dado.randomize(jogador)
            dado.addForce(
                vetorAleatorio(
                    CONFIG.dadoDanoForcaMinima,
                    CONFIG.dadoDanoForcaMaxima
                ),
                3
            )
            dado.addTorque(
                vetorAleatorio(
                    CONFIG.dadoDanoTorqueMinimo,
                    CONFIG.dadoDanoTorqueMaximo
                ),
                3
            )
        end)
    end, 1)
end

local function erroRolagemDado(jogador, mensagem)
    printToColor(
        mensagem,
        jogador,
        CONFIG.corErro
    )
end

-- =========================================================
-- OBJECT UI
-- =========================================================

local function uiSet(id, atributo, valor)
    pcall(function()
        self.UI.setAttribute(
            tostring(id),
            tostring(atributo),
            tostring(valor)
        )
    end)
end

local function coresToggle(ativo)
    if ativo then
        return "#296B39|#3D8B50|#1C4D28|#173A20CC"
    end

    return "#3A3D40|#50555A|#272A2D|#202326CC"
end

local function aplicarEstiloToggle(id, ativo)
    uiSet(id, "colors", coresToggle(ativo))
    uiSet(id, "textColor", "#FFFDF5")
    uiSet(
        id,
        "outline",
        ativo and "#70C77F" or "#A99B78"
    )
end

local function atualizarBotoes()
    garantirModExtras()

    -- O TTS pode reaplicar a cor padrao escura do tema ao reconstruir a UI.
    -- Fixar a cor em runtime mantem todos os rotulos legiveis em qualquer
    -- tema, inclusive botoes ainda indisponiveis.
    local botoesComTextoClaro = {
        "update",
        "especial_pm_minus",
        "especial_pm_plus",
        "mod_1_minus",
        "mod_1_plus",
        "mod_2_minus",
        "mod_2_plus",
        "mod_3_minus",
        "mod_3_plus",
        "mod_4_minus",
        "mod_4_plus",
        "roll_attack",
        "roll_critical",
        "roll_damage",
        "clear_dice"
    }

    for _, id in ipairs(botoesComTextoClaro) do
        uiSet(id, "textColor", "#FFFDF5")
    end

    uiSet(
        "toggle_preparada",
        "text",
        "PREPARADA  —  " .. textoToggle(state.preparada)
    )
    aplicarEstiloToggle("toggle_preparada", state.preparada)

    uiSet(
        "toggle_poderoso",
        "text",
        "PODEROSO  —  " .. textoToggle(state.poderoso)
    )
    aplicarEstiloToggle("toggle_poderoso", state.poderoso)

    uiSet(
        "toggle_pesado",
        "text",
        "PESADO  —  " .. textoToggle(state.pesado)
    )
    aplicarEstiloToggle("toggle_pesado", state.pesado)

    uiSet(
        "toggle_golpe_pessoal",
        "text",
        "GOLPE PESSOAL  —  " .. textoToggle(state.golpePessoal)
    )
    aplicarEstiloToggle("toggle_golpe_pessoal", state.golpePessoal)

    local modoEspecial =
        state.especialModo == 0 and
            "INATIVO" or
            (ESPECIAL_NOMES[state.especialModo] or "INATIVO")

    uiSet(
        "especial_mode",
        "text",
        "ESPECIAL  —  " .. modoEspecial
    )
    aplicarEstiloToggle("especial_mode", state.especialModo ~= 0)
    uiSet(
        "especial_pm_value",
        "text",
        tostring(state.especialPM) .. " PM"
    )

    for indice = 1, QUANTIDADE_MOD_EXTRAS do
        uiSet(
            "mod_name_" .. tostring(indice),
            "text",
            nomeModExtra(indice)
        )
        uiSet(
            "mod_" .. tostring(indice) .. "_value",
            "text",
            sinal(state.modExtras[indice].valor)
        )
    end

    local statusDano = "aguardando ataque"

    if ultimoAtaqueValido(state.ultimoAtaque) then
        statusDano = "ataque salvo"
    end

    uiSet(
        "roll_damage",
        "text",
        "ROLAR DANO\n" .. statusDano
    )
    uiSet(
        "update",
        "text",
        updateGithubEmAndamento and "ATUALIZANDO..." or "ATUALIZAR"
    )
    uiSet(
        "update",
        "interactable",
        updateGithubEmAndamento and "false" or "true"
    )

    if calcularPreviewSelecionado ~= nil then
        local preview = calcularPreviewSelecionado()

        uiSet(
            "preview_pm",
            "text",
            tostring(preview.custoPM) .. " PM"
        )
        uiSet(
            "preview_attack",
            "text",
            tostring(preview.ataqueMin) ..
                " / " ..
                formatarMedia(preview.ataqueMedio) ..
                " / " ..
                tostring(preview.ataqueMax)
        )
        uiSet(
            "preview_damage",
            "text",
            tostring(preview.danoMin) ..
                " / " ..
                formatarMedia(preview.danoMedio) ..
                " / " ..
                tostring(preview.danoMax)
        )
    end
end

local function instalarObjectUI()
    -- Remove os controles Classic UI de objetos atualizados a partir da
    -- versao anterior. A transformacao fisica do painel nao e alterada.
    pcall(function()
        self.clearButtons()
    end)
    pcall(function()
        self.clearInputs()
    end)

    local sucesso, erro = pcall(function()
        self.UI.setXml(OBJECT_UI_XML)
    end)

    if not sucesso then
        print(
            "Edward: falha ao instalar Object UI: " ..
            tostring(erro)
        )
        return
    end

    local function finalizarCarregamento()
        atualizarBotoes()
    end

    local function terminouCarregamento()
        local ok, carregando = pcall(function()
            return self.UI.loading
        end)

        return ok and carregando == false
    end

    pcall(function()
        Wait.frames(function()
            Wait.condition(
                finalizarCarregamento,
                terminouCarregamento,
                5,
                function()
                    print("Edward: a Object UI nao terminou de carregar.")
                end
            )
        end, 2)
    end)
end

local function corDoJogadorUI(player)
    if player == nil then
        return ""
    end

    local sucesso, cor = pcall(function()
        return player.color
    end)

    if sucesso and cor ~= nil then
        return tostring(cor)
    end

    return tostring(player or "")
end

function uiDispatch(player, valor, id)
    local jogador = corDoJogadorUI(player)

    if id == "toggle_preparada" then
        alternarPreparada(self, jogador, false)
    elseif id == "toggle_poderoso" then
        alternarPoderoso(self, jogador, false)
    elseif id == "toggle_pesado" then
        alternarPesado(self, jogador, false)
    elseif id == "toggle_golpe_pessoal" then
        alternarGolpePessoal(self, jogador, false)
    elseif id == "especial_mode" then
        alternarEspecial(self, jogador, false)
    elseif id == "especial_pm_minus" then
        alterarEspecialPM(self, jogador, true)
    elseif id == "especial_pm_plus" then
        alterarEspecialPM(self, jogador, false)
    elseif id == "roll_attack" then
        rolarAtaque(self, jogador, false)
    elseif id == "roll_critical" then
        rolarAtaqueCritico(self, jogador, false)
    elseif id == "roll_damage" then
        rolarDano(self, jogador, false)
    elseif id == "clear_dice" then
        limparDados(self, jogador, false)
    elseif id == "update" then
        atualizarViaGithub(self, jogador, false)
    else
        local indice, direcao =
            tostring(id or ""):match("^mod_(%d+)_(%a+)$")

        if indice ~= nil
            and (direcao == "minus" or direcao == "plus") then
            alterarModExtraPorIndice(
                tonumber(indice),
                direcao == "minus"
            )
        end
    end
end

function uiEditModName(player, valor, id)
    local indice =
        tonumber(tostring(id or ""):match("^mod_name_(%d+)$"))

    if indice == nil
        or indice < 1
        or indice > QUANTIDADE_MOD_EXTRAS then
        return
    end

    nomearModExtraPorIndice(indice, valor)
    atualizarBotoes()
end

-- =========================================================
-- CHAT
-- =========================================================

local function mensagemSeguraParaChat(mensagem)
    -- O chat do TTS interpreta colchetes ASCII como BBCode. Resultados como
    -- d20 [18] podem ocultar a mensagem atual e corromper as seguintes.
    -- Mantemos o texto legivel usando os equivalentes Unicode apenas no chat.
    local segura = tostring(mensagem)
    segura = string.gsub(segura, "%[", "［")
    segura = string.gsub(segura, "%]", "］")

    return segura
end

local function enviarResumoParaChat(mensagem)
    local sucesso, erro = pcall(function()
        printToAll(
            mensagemSeguraParaChat(mensagem),
            CONFIG.corChat
        )
    end)

    if not sucesso then
        print(
            "Erro ao enviar resumo para o chat: " ..
            tostring(erro)
        )
    end
end

local function ocultarResultadoGlobalLegado()
    -- Objetos atualizados podem ter deixado o antigo popup no Global UI.
    pcall(function()
        UI.hide("resultadoAtaque")
    end)
end

-- =========================================================
-- ATUALIZACAO VIA GITHUB
-- =========================================================

local function notificarGithub(jogador, mensagem, erro)
    if jogador ~= nil and jogador ~= "" then
        if erro then
            printToColor(
                mensagem,
                jogador,
                CONFIG.corErro
            )
        else
            printToColor(
                mensagem,
                jogador
            )
        end

        return
    end

    if erro then
        printToAll(
            mensagem,
            CONFIG.corErro
        )
    else
        printToAll(
            mensagem
        )
    end
end

local function urlComCacheBuster(url)
    local separador = "?"

    if string.find(url, "?", 1, true) ~= nil then
        separador = "&"
    end

    local marcador =
        tostring(math.random(100000, 999999))

    pcall(function()
        if os ~= nil
            and os.time ~= nil then
            marcador =
                tostring(os.time()) ..
                "_" ..
                marcador
        end
    end)

    return
        tostring(url) ..
        separador ..
        "tts_update=" ..
        marcador
end

local function aplicarImagemGithub(urlImagem)
    local sucessoObjeto, custom =
        pcall(function()
            return self.getCustomObject()
        end)

    if not sucessoObjeto
        or type(custom) ~= "table" then
        return false, "nao foi possivel ler o Custom Object"
    end

    custom.image = urlImagem

    local sucessoImagem, erroImagem =
        pcall(function()
            self.setCustomObject(custom)
        end)

    if not sucessoImagem then
        return false, tostring(erroImagem)
    end

    return true, nil
end

local function aplicarScriptGithub(script, jogador)
    if string.find(
        script,
        "Edward / Humano Guerreiro",
        1,
        true
    ) == nil then
        updateGithubEmAndamento = false
        atualizarBotoes()

        notificarGithub(
            jogador,
            "Update cancelado: o arquivo baixado nao parece ser o script do Edward.",
            true
        )

        return
    end

    local urlImagem =
        urlComCacheBuster(CONFIG.githubImagemUrl)

    local imagemOk, erroImagem =
        aplicarImagemGithub(urlImagem)

    if not imagemOk then
        notificarGithub(
            jogador,
            "Script baixado, mas a imagem nao foi aplicada: " ..
            tostring(erroImagem),
            true
        )
    end

    local sucessoScript, erroScript =
        pcall(function()
            self.setLuaScript(script)
        end)

    if not sucessoScript then
        updateGithubEmAndamento = false
        atualizarBotoes()

        notificarGithub(
            jogador,
            "Update falhou ao aplicar o script: " ..
            tostring(erroScript),
            true
        )

        return
    end

    notificarGithub(
        jogador,
        "Update aplicado. Recarregando o painel do Edward..."
    )

    Wait.frames(function()
        pcall(function()
            self.reload()
        end)
    end, 1)
end

function atualizarViaGithub(
    objeto,
    jogador,
    cliqueAlternativo
)
    if updateGithubEmAndamento then
        notificarGithub(
            jogador,
            "Update ja esta em andamento."
        )

        return
    end

    if WebRequest == nil
        or WebRequest.get == nil then
        notificarGithub(
            jogador,
            "Update indisponivel: WebRequest nao esta acessivel nesta mesa.",
            true
        )

        return
    end

    updateGithubEmAndamento = true
    atualizarBotoes()

    notificarGithub(
        jogador,
        "Buscando a versao mais nova do Edward no GitHub..."
    )

    WebRequest.get(
        urlComCacheBuster(CONFIG.githubScriptUrl),
        function(resposta)
            if resposta == nil
                or resposta.is_error then
                updateGithubEmAndamento = false
                atualizarBotoes()

                local erroResposta = "sem resposta"

                if resposta ~= nil
                    and resposta.error ~= nil then
                    erroResposta =
                        tostring(resposta.error)
                end

                notificarGithub(
                    jogador,
                    "Update falhou ao baixar o script: " ..
                    erroResposta,
                    true
                )

                return
            end

            local script =
                tostring(resposta.text or "")

            if script == "" then
                updateGithubEmAndamento = false
                atualizarBotoes()

                notificarGithub(
                    jogador,
                    "Update falhou: o script baixado veio vazio.",
                    true
                )

                return
            end

            aplicarScriptGithub(
                script,
                jogador
            )
        end
    )
end

-- =========================================================
-- CÁLCULO DOS MODIFICADORES SELECIONADOS
-- =========================================================

calcularModificadoresSelecionados = function()
    local modificadorAtaque =
        CONFIG.bonusAtaqueBase

    local modificadorDano =
        CONFIG.bonusDanoBase

    local custoPM = 0

    local efeitos = {}
    local efeitosChat = {}

    -- -----------------------------------------------------
    -- Espada preparada
    -- -----------------------------------------------------

    if state.preparada then
        table.insert(
            efeitos,
            "Espada preparada"
        )

        table.insert(
            efeitosChat,
            "Preparada"
        )
    else
        modificadorAtaque =
            modificadorAtaque - 5

        table.insert(
            efeitos,
            "Espada sem preparar (-5 no ataque)"
        )

        table.insert(
            efeitosChat,
            "Sem preparar -5"
        )
    end

    -- -----------------------------------------------------
    -- Ataque Poderoso
    -- -----------------------------------------------------

    if state.poderoso then
        modificadorAtaque =
            modificadorAtaque - 2

        modificadorDano =
            modificadorDano + 5

        table.insert(
            efeitos,
            "Ataque Poderoso (-2 no ataque, +5 no dano)"
        )

        table.insert(
            efeitosChat,
            "Poderoso -2/+5"
        )
    end

    -- -----------------------------------------------------
    -- Ataque Especial
    -- -----------------------------------------------------

    if state.especialModo ~= 0 then
        local bonusEspecial =
            state.especialPM * 4

        custoPM =
            custoPM + state.especialPM

        if state.especialModo == 1 then
            modificadorAtaque =
                modificadorAtaque + bonusEspecial

        elseif state.especialModo == 2 then
            modificadorDano =
                modificadorDano + bonusEspecial

        elseif state.especialModo == 3 then
            local metade =
                bonusEspecial / 2

            modificadorAtaque =
                modificadorAtaque + metade

            modificadorDano =
                modificadorDano + metade
        end

        table.insert(
            efeitos,
            "Ataque Especial " ..
            tostring(state.especialPM) ..
            " PM em " ..
            ESPECIAL_NOMES[state.especialModo]
        )

        table.insert(
            efeitosChat,
            "Especial " ..
            tostring(state.especialPM) ..
            "PM " ..
            ESPECIAL_NOMES[state.especialModo]
        )
    end

    -- -----------------------------------------------------
    -- Modificador extra
    -- -----------------------------------------------------

    local totalModExtras =
        somarModExtras()

    if totalModExtras ~= 0 then
        modificadorAtaque =
            modificadorAtaque +
            totalModExtras

        for indice = 1, QUANTIDADE_MOD_EXTRAS do
            local extra =
                state.modExtras[indice]

            if extra.valor ~= 0 then
                table.insert(
                    efeitos,
                    tostring(extra.nome) ..
                    " " ..
                    sinal(extra.valor)
                )

                table.insert(
                    efeitosChat,
                    tostring(extra.nome) ..
                    " " ..
                    sinal(extra.valor)
                )
            end
        end
    end

    -- -----------------------------------------------------
    -- Ataque Pesado
    -- -----------------------------------------------------

    if state.pesado then
        custoPM = custoPM + 1

        table.insert(
            efeitos,
            "Ataque Pesado"
        )

        table.insert(
            efeitosChat,
            "Pesado 1PM"
        )
    end

    -- -----------------------------------------------------
    -- Golpe Pessoal: Passo do Carrasco
    -- -----------------------------------------------------

    local quantidadeDadosDano =
        CONFIG.quantidadeDadosDano

    if state.golpePessoal then
        custoPM =
            custoPM +
            CONFIG.golpePessoalCustoPM

        quantidadeDadosDano =
            quantidadeDadosDano +
            CONFIG.golpePessoalDadoExtra

        table.insert(
            efeitos,
            "Golpe Pessoal: " ..
            CONFIG.golpePessoalNome ..
            " (" ..
            CONFIG.golpePessoalEfeitos ..
            ", 1 PM)"
        )

        table.insert(
            efeitosChat,
            "Golpe Pessoal 1PM"
        )
    end

    local listaEfeitos = "Nenhum"
    local resumoEfeitosChat = "Sem modificadores"

    if #efeitos > 0 then
        listaEfeitos =
            table.concat(efeitos, ", ")
    end

    if #efeitosChat > 0 then
        resumoEfeitosChat =
            table.concat(efeitosChat, ", ")
    end

    return {
        modificadorAtaque = modificadorAtaque,
        modificadorDano = modificadorDano,
        custoPM = custoPM,
        quantidadeDadosDano = quantidadeDadosDano,
        golpePessoal = state.golpePessoal == true,
        listaEfeitos = listaEfeitos,
        resumoEfeitosChat = resumoEfeitosChat
    }
end

calcularPreviewSelecionado = function()
    local calculo =
        calcularModificadoresSelecionados()

    local ataqueMin =
        1 + calculo.modificadorAtaque

    local d20Medio =
        10.5

    if calculo.golpePessoal then
        d20Medio = 13.825
    end

    local ataqueMedio =
        d20Medio + calculo.modificadorAtaque

    local ataqueMax =
        20 + calculo.modificadorAtaque

    local danoMin =
        calculo.quantidadeDadosDano +
        calculo.modificadorDano

    local danoMedio =
        calculo.quantidadeDadosDano *
        ((CONFIG.ladosDadoDano + 1) / 2) +
        calculo.modificadorDano

    local danoMax =
        calculo.quantidadeDadosDano *
        CONFIG.ladosDadoDano +
        calculo.modificadorDano

    return {
        custoPM = calculo.custoPM,
        ataqueMin = ataqueMin,
        ataqueMedio = ataqueMedio,
        ataqueMax = ataqueMax,
        danoMin = danoMin,
        danoMedio = danoMedio,
        danoMax = danoMax
    }
end

-- =========================================================
-- RESET DAS SELEÇÕES
-- =========================================================

local function resetarSelecoesAposAtaque()
    if CONFIG.resetarAposAtaque then
        state.preparada = false
        state.poderoso = false
        state.especialModo = 0
        state.pesado = false
        state.golpePessoal = false
    end

    if CONFIG.resetarModExtraAposAtaque then
        garantirModExtras()

        for indice = 1, QUANTIDADE_MOD_EXTRAS do
            state.modExtras[indice].valor = 0
        end

    end
end

-- =========================================================
-- CARREGAMENTO DO ÚLTIMO ATAQUE
-- =========================================================

local function carregarModExtras(dados)
    local modificadores =
        criarModExtrasPadrao()

    if type(dados) == "table" then
        for indice = 1, QUANTIDADE_MOD_EXTRAS do
            local extraSalvo =
                dados[indice]

            if type(extraSalvo) == "table" then
                modificadores[indice].nome =
                    limitarTexto(
                        extraSalvo.nome,
                        18
                    ) or "EXTRA " .. tostring(indice)

                modificadores[indice].valor =
                    limitarInteiro(
                        extraSalvo.valor or 0,
                        CONFIG.modExtraMin,
                        CONFIG.modExtraMax
                    )
            end
        end
    end

    return modificadores
end

local function carregarUltimoAtaque(dados)
    local ultimo = criarUltimoAtaqueVazio()

    if type(dados) ~= "table" then
        return ultimo
    end

    ultimo.disponivel =
        dados.disponivel == true

    ultimo.jogador =
        tostring(dados.jogador or "")

    ultimo.d20 =
        tonumber(dados.d20) or 0

    if type(dados.d20Lista) == "table" then
        ultimo.d20Lista = {}

        for _, valor in ipairs(dados.d20Lista) do
            local d20 =
                tonumber(valor)

            if d20 ~= nil
                and d20 >= 1
                and d20 <= 20 then
                table.insert(
                    ultimo.d20Lista,
                    math.floor(d20)
                )
            end
        end
    end

    if #ultimo.d20Lista == 0
        and ultimo.d20 >= 1
        and ultimo.d20 <= 20 then
        ultimo.d20Lista = {ultimo.d20}
    end

    ultimo.totalAtaque =
        tonumber(dados.totalAtaque) or 0

    ultimo.modificadorAtaque =
        tonumber(dados.modificadorAtaque) or 0

    ultimo.modificadorDano =
        tonumber(dados.modificadorDano)
        or CONFIG.bonusDanoBase

    ultimo.quantidadeDadosDano =
        tonumber(dados.quantidadeDadosDano)
        or CONFIG.quantidadeDadosDano

    if ultimo.quantidadeDadosDano < CONFIG.quantidadeDadosDano then
        ultimo.quantidadeDadosDano =
            CONFIG.quantidadeDadosDano
    end

    ultimo.golpePessoal =
        dados.golpePessoal == true

    ultimo.custoPM =
        tonumber(dados.custoPM) or 0

    ultimo.ameacaCritico =
        dados.ameacaCritico == true

    ultimo.listaEfeitos =
        tostring(dados.listaEfeitos or "Nenhum")

    ultimo.resumoEfeitosChat =
        tostring(
            dados.resumoEfeitosChat
            or "Sem modificadores"
        )

    if not ultimoAtaqueValido(ultimo) then
        return criarUltimoAtaqueVazio()
    end

    return ultimo
end

local function carregarListaGuids(dados)
    local guids = {}

    if type(dados) ~= "table" then
        return guids
    end

    for _, guid in ipairs(dados) do
        local texto =
            tostring(guid or "")

        if texto ~= "" then
            table.insert(guids, texto)
        end
    end

    return guids
end

-- =========================================================
-- CARREGAR E SALVAR
-- =========================================================

function onLoad(savedData)
    state = criarEstadoPadrao()

    if savedData ~= nil and savedData ~= "" then
        local sucesso, dadosSalvos =
            pcall(JSON.decode, savedData)

        if sucesso and type(dadosSalvos) == "table" then
            state.preparada =
                dadosSalvos.preparada == true

            state.poderoso =
                dadosSalvos.poderoso == true

            state.pesado =
                dadosSalvos.pesado == true

            state.golpePessoal =
                dadosSalvos.golpePessoal == true

            state.especialModo =
                limitarInteiro(
                    dadosSalvos.especialModo or 0,
                    0,
                    3
                )

            state.especialPM =
                limitarInteiro(
                    dadosSalvos.especialPM or 1,
                    1,
                    CONFIG.ataqueEspecialMaxPM
                )

            state.modExtras =
                carregarModExtras(
                    dadosSalvos.modExtras
                )

            state.ultimoAtaque =
                carregarUltimoAtaque(
                    dadosSalvos.ultimoAtaque
                )

            state.dadoAtaqueGuid =
                tostring(dadosSalvos.dadoAtaqueGuid or "")

            state.dadoAtaqueGuids =
                carregarListaGuids(
                    dadosSalvos.dadoAtaqueGuids
                )

            state.dadoDanoGuids =
                carregarListaGuids(
                    dadosSalvos.dadoDanoGuids
                )
        end
    end

    if not ultimoAtaqueValido(state.ultimoAtaque) then
        descartarUltimoAtaque()
    end

    -- Descarta GUIDs herdados de uma copia ou de dados antigos sem a marca de
    -- propriedade. Nenhum objeto e destruido durante esta reconciliacao.
    obterDadosAtaqueAtuais()
    obterDadosDanoAtuais()

    ocultarResultadoGlobalLegado()
    instalarObjectUI()
end

function onSave()
    return JSON.encode(state)
end

-- =========================================================
-- BOTÕES DE SELEÇÃO
-- =========================================================

function alternarPreparada(
    objeto,
    jogador,
    cliqueAlternativo
)
    state.preparada = not state.preparada
    atualizarBotoes()
end

function alternarPoderoso(
    objeto,
    jogador,
    cliqueAlternativo
)
    state.poderoso = not state.poderoso
    atualizarBotoes()
end

function alternarPesado(
    objeto,
    jogador,
    cliqueAlternativo
)
    state.pesado = not state.pesado
    atualizarBotoes()
end

function alternarGolpePessoal(
    objeto,
    jogador,
    cliqueAlternativo
)
    state.golpePessoal = not state.golpePessoal
    atualizarBotoes()
end

function alternarEspecial(
    objeto,
    jogador,
    cliqueAlternativo
)
    if cliqueAlternativo then
        state.especialModo =
            state.especialModo - 1

        if state.especialModo < 0 then
            state.especialModo = 3
        end
    else
        state.especialModo =
            state.especialModo + 1

        if state.especialModo > 3 then
            state.especialModo = 0
        end
    end

    atualizarBotoes()
end

function alterarEspecialPM(
    objeto,
    jogador,
    cliqueAlternativo
)
    if cliqueAlternativo then
        state.especialPM =
            state.especialPM - 1

        if state.especialPM < 1 then
            state.especialPM =
                CONFIG.ataqueEspecialMaxPM
        end
    else
        state.especialPM =
            state.especialPM + 1

        if state.especialPM >
            CONFIG.ataqueEspecialMaxPM then
            state.especialPM = 1
        end
    end

    atualizarBotoes()
end

function alterarModExtra(
    objeto,
    jogador,
    cliqueAlternativo
)
    alterarModExtraPorIndice(1, cliqueAlternativo)
end

function alterarModExtra2(
    objeto,
    jogador,
    cliqueAlternativo
)
    alterarModExtraPorIndice(2, cliqueAlternativo)
end

function alterarModExtra3(
    objeto,
    jogador,
    cliqueAlternativo
)
    alterarModExtraPorIndice(3, cliqueAlternativo)
end

function alterarModExtra4(
    objeto,
    jogador,
    cliqueAlternativo
)
    alterarModExtraPorIndice(4, cliqueAlternativo)
end

function alterarModExtraPorIndice(
    indice,
    cliqueAlternativo
)
    local alteracao =
        cliqueAlternativo and -1 or 1

    garantirModExtras()

    state.modExtras[indice].valor =
        limitarInteiro(
            state.modExtras[indice].valor + alteracao,
            CONFIG.modExtraMin,
            CONFIG.modExtraMax
        )

    somarModExtras()
    atualizarBotoes()
end

function nomearModExtra1(
    objeto,
    jogador,
    valor,
    selecionado
)
    nomearModExtraPorIndice(1, valor)
end

function nomearModExtra2(
    objeto,
    jogador,
    valor,
    selecionado
)
    nomearModExtraPorIndice(2, valor)
end

function nomearModExtra3(
    objeto,
    jogador,
    valor,
    selecionado
)
    nomearModExtraPorIndice(3, valor)
end

function nomearModExtra4(
    objeto,
    jogador,
    valor,
    selecionado
)
    nomearModExtraPorIndice(4, valor)
end

function nomearModExtraPorIndice(
    indice,
    valor
)
    garantirModExtras()

    state.modExtras[indice].nome =
        limitarTexto(valor, 18)
        or "EXTRA " .. tostring(indice)
end

function limparDados(
    objeto,
    jogador,
    cliqueAlternativo
)
    -- Invalida callbacks antes de parar waits. Qualquer dado que termine de
    -- spawnar depois deste ponto sera destruido pelo proprio callback antigo.
    dadoAtaqueRolagemId = dadoAtaqueRolagemId + 1
    dadoDanoRolagemId = dadoDanoRolagemId + 1

    destruirDadoAtaqueAtual()
    destruirDadosDanoAtuais()
    atualizarBotoes()

    if jogador ~= nil and jogador ~= "" then
        pcall(function()
            printToColor(
                "Edward: dados deste painel removidos.",
                jogador,
                CONFIG.corChat
            )
        end)
    end
end

-- =========================================================
-- ROLAR ATAQUE
-- =========================================================

local function textoD20Ataque(d20, d20Lista)
    if type(d20Lista) == "table"
        and #d20Lista > 1 then
        return
            "2d20 [" ..
            table.concat(d20Lista, ", ") ..
            "] maior " ..
            tostring(d20)
    end

    return "d20 [" .. tostring(d20) .. "]"
end

local function finalizarAtaqueRolado(jogador, calculo, d20, d20Lista)
    local nomeDoJogador =
        nomeJogador(jogador)

    local totalAtaque =
        d20 + calculo.modificadorAtaque

    local ameacaCritico =
        d20 >= CONFIG.margemCritico
        and d20 ~= 1

    local resultadoAutomatico = nil

    if d20 == 1 then
        resultadoAutomatico =
            "FALHA AUTOMÁTICA"
    elseif d20 == 20 then
        resultadoAutomatico =
            "SUCESSO AUTOMÁTICO"
    end

    -- Salva uma fotografia dos modificadores deste ataque
    state.ultimoAtaque = {
        disponivel = true,
        jogador = nomeDoJogador,
        d20 = d20,
        d20Lista = d20Lista or {d20},
        totalAtaque = totalAtaque,

        modificadorAtaque =
            calculo.modificadorAtaque,

        modificadorDano =
            calculo.modificadorDano,

        quantidadeDadosDano =
            calculo.quantidadeDadosDano,

        golpePessoal =
            calculo.golpePessoal,

        custoPM =
            calculo.custoPM,

        ameacaCritico =
            ameacaCritico,

        listaEfeitos =
            calculo.listaEfeitos,

        resumoEfeitosChat =
            calculo.resumoEfeitosChat
    }

    -- -----------------------------------------------------
    -- Resumo do chat e do popup global
    -- -----------------------------------------------------

    local resumoChat = string.format(
        "%s | %s | ATAQUE %s (%s %s) | PM %s | %s",

        tostring(nomeDoJogador),
        tostring(CONFIG.nomeArma),
        tostring(totalAtaque),
        textoD20Ataque(d20, d20Lista),
        sinal(calculo.modificadorAtaque),
        tostring(calculo.custoPM),
        tostring(calculo.resumoEfeitosChat)
    )

    if resultadoAutomatico ~= nil then
        resumoChat =
            resumoChat ..
            " | " ..
            resultadoAutomatico
    end

    if ameacaCritico then
        resumoChat =
            resumoChat ..
            " | AMEAÇA DE CRÍTICO"
    end

    enviarResumoParaChat(resumoChat)

    resetarSelecoesAposAtaque()
    atualizarBotoes()
end

local function lerResultadoD20(dado)
    local sucesso, valor =
        pcall(function()
            return dado.getRotationValue()
        end)

    if not sucesso then
        return nil
    end

    valor = tonumber(valor)

    if valor == nil
        or valor < 1
        or valor > 20 then
        return nil
    end

    return math.floor(valor)
end

local function todosDadosAtaqueEmRepouso(dados)
    for _, dado in ipairs(dados) do
        if not objetoValido(dado) then
            return false
        end

        local sucesso, emRepouso =
            pcall(function()
                return dado.resting == true
            end)

        if not sucesso
            or not emRepouso then
            return false
        end
    end

    return true
end

local function lerResultadosD20(dados)
    local resultados = {}
    local maior = nil

    for _, dado in ipairs(dados) do
        local valor =
            lerResultadoD20(dado)

        if valor == nil then
            return nil, nil
        end

        if maior == nil or valor > maior then
            maior = valor
        end

        table.insert(resultados, valor)
    end

    return maior, resultados
end

local function aguardarDadosAtaque(
    rolagemId,
    dados,
    jogador,
    calculo,
    tempoDecorrido
)
    if rolagemId ~= dadoAtaqueRolagemId then
        return
    end

    for _, dado in ipairs(dados) do
        if not objetoValido(dado) then
            dadoAtaqueWaitId = nil

            erroRolagemDado(
                jogador,
                "Um D20 do ataque foi removido antes de parar."
            )

            atualizarBotoes()
            return
        end
    end

    if todosDadosAtaqueEmRepouso(dados) then
        local d20, d20Lista =
            lerResultadosD20(dados)

        dadoAtaqueWaitId = nil

        if d20 == nil then
            erroRolagemDado(
                jogador,
                "Nao foi possivel ler todos os D20 fisicos."
            )

            atualizarBotoes()
            return
        end

        finalizarAtaqueRolado(
            jogador,
            calculo,
            d20,
            d20Lista
        )

        return
    end

    if tempoDecorrido >= CONFIG.dadoAtaqueEsperaMaxima then
        dadoAtaqueWaitId = nil

        erroRolagemDado(
            jogador,
            "O D20 do ataque nao parou a tempo. Role o ataque novamente."
        )

        atualizarBotoes()
        return
    end

    dadoAtaqueWaitId =
        Wait.time(function()
            aguardarDadosAtaque(
                rolagemId,
                dados,
                jogador,
                calculo,
                tempoDecorrido +
                    CONFIG.dadoAtaqueIntervaloLeitura
            )
        end, CONFIG.dadoAtaqueIntervaloLeitura)
end

function rolarAtaque(
    objeto,
    jogador,
    cliqueAlternativo
)
    local calculo =
        calcularModificadoresSelecionados()

    dadoAtaqueRolagemId =
        dadoAtaqueRolagemId + 1

    local rolagemId =
        dadoAtaqueRolagemId

    destruirDadoAtaqueAtual()
    descartarUltimoAtaque()
    atualizarBotoes()

    local quantidadeD20 = 1

    if calculo.golpePessoal then
        quantidadeD20 = 2
    end

    local dados = {}
    local guids = {}
    local dadosSpawnados = 0
    dadosAtaqueObjetos = {}
    dadoAtaqueObjeto = nil
    state.dadoAtaqueGuid = ""
    state.dadoAtaqueGuids = {}

    for indice = 1, quantidadeD20 do
        local indiceDado =
            indice

        spawnObject({
            type = CONFIG.dadoAtaqueTipo,
            position =
                posicaoSpawnDadoAtaque(
                    indiceDado,
                    quantidadeD20
                ),
            rotation = {
                math.random(0, 359),
                math.random(0, 359),
                math.random(0, 359)
            },
            scale = CONFIG.dadoAtaqueEscala,
            snap_to_grid = false,
            callback_function = function(dado)
                if rolagemId ~= dadoAtaqueRolagemId then
                    pcall(function()
                        dado.destruct()
                    end)

                    return
                end

                if not marcarDadoComoProprio(dado, "attack")
                    or not dadoPertenceAoPainel(dado, "attack") then
                    dadoAtaqueRolagemId = dadoAtaqueRolagemId + 1
                    pcall(function()
                        dado.destruct()
                    end)
                    destruirDadoAtaqueAtual()
                    erroRolagemDado(
                        jogador,
                        "Nao foi possivel identificar com seguranca o dado de ataque."
                    )
                    return
                end

                dados[indiceDado] = dado
                dadosSpawnados =
                    dadosSpawnados + 1

                table.insert(
                    guids,
                    dado.getGUID()
                )

                table.insert(dadosAtaqueObjetos, dado)
                dadoAtaqueObjeto = dadosAtaqueObjetos[1]
                state.dadoAtaqueGuid = guids[1] or ""
                state.dadoAtaqueGuids = guids

                pcall(function()
                    dado.setName("D20 Ataque Edward")
                    dado.setColorTint({0.65, 0.08, 0.08})
                    dado.measure_movement = false
                end)

                impulsionarDadoAtaque(dado, jogador)

                if dadosSpawnados == quantidadeD20 then
                    dadosAtaqueObjetos = dados
                    dadoAtaqueObjeto = dados[1]
                    state.dadoAtaqueGuid = guids[1] or ""
                    state.dadoAtaqueGuids = guids

                    dadoAtaqueWaitId =
                        Wait.time(function()
                            aguardarDadosAtaque(
                                rolagemId,
                                dados,
                                jogador,
                                calculo,
                                0
                            )
                        end, CONFIG.dadoAtaqueIntervaloLeitura)
                end
            end
        })
    end
end

-- =========================================================
-- ROLAR DANO
-- =========================================================

function rolarAtaqueCritico(
    objeto,
    jogador,
    cliqueAlternativo
)
    rolarDano(
        objeto,
        jogador,
        "FORCAR_CRITICO"
    )
end

local function finalizarDanoRolado(
    jogador,
    ultimo,
    quantidadeDados,
    usarCritico,
    totalDados,
    listaDados
)
    local totalDano =
        totalDados +
        ultimo.modificadorDano

    local tipoDano = "DANO NORMAL"

    if usarCritico then
        tipoDano = "DANO CRÍTICO"
    end

    -- -----------------------------------------------------
    -- Resumo do chat e do popup global
    -- -----------------------------------------------------

    local resumoChat = string.format(
        "%s | %s | %s %s (%sd%s [%s] %s) | Ataque %s | %s",

        tostring(ultimo.jogador),
        tostring(CONFIG.nomeArma),
        tostring(tipoDano),
        tostring(totalDano),
        tostring(quantidadeDados),
        tostring(CONFIG.ladosDadoDano),
        tostring(listaDados),
        sinal(ultimo.modificadorDano),
        tostring(ultimo.totalAtaque),
        tostring(ultimo.resumoEfeitosChat)
    )

    if usarCritico
        and not ultimo.ameacaCritico then
        resumoChat =
            resumoChat ..
            " | CRITICO MANUAL"
    end

    enviarResumoParaChat(resumoChat)

    -- -----------------------------------------------------
    -- Limpeza do último ataque
    -- -----------------------------------------------------

    if CONFIG.consumirAtaqueAposDano then
        descartarUltimoAtaque()
    end

    atualizarBotoes()
end

local function lerResultadoDado(dado, lados)
    local sucesso, valor =
        pcall(function()
            return dado.getRotationValue()
        end)

    if not sucesso then
        return nil
    end

    valor = tonumber(valor)

    if valor == nil
        or valor < 1
        or valor > lados then
        return nil
    end

    return math.floor(valor)
end

local function todosDadosEmRepouso(dados)
    for _, dado in ipairs(dados) do
        if not objetoValido(dado) then
            return false
        end

        local sucesso, emRepouso =
            pcall(function()
                return dado.resting == true
            end)

        if not sucesso
            or not emRepouso then
            return false
        end
    end

    return true
end

local function lerResultadosDados(dados, lados)
    local resultados = {}
    local total = 0

    for _, dado in ipairs(dados) do
        local valor =
            lerResultadoDado(
                dado,
                lados
            )

        if valor == nil then
            return nil, nil
        end

        total = total + valor
        table.insert(
            resultados,
            valor
        )
    end

    return total, table.concat(resultados, ", ")
end

local function aguardarDadosDano(
    rolagemId,
    dados,
    jogador,
    ultimo,
    quantidadeDados,
    usarCritico,
    tempoDecorrido
)
    if rolagemId ~= dadoDanoRolagemId then
        return
    end

    for _, dado in ipairs(dados) do
        if not objetoValido(dado) then
            dadoDanoWaitId = nil

            erroRolagemDado(
                jogador,
                "Um dado de dano foi removido antes de parar."
            )

            atualizarBotoes()
            return
        end
    end

    if todosDadosEmRepouso(dados) then
        local totalDados, listaDados =
            lerResultadosDados(
                dados,
                CONFIG.ladosDadoDano
            )

        dadoDanoWaitId = nil

        if totalDados == nil then
            erroRolagemDado(
                jogador,
                "Nao foi possivel ler todos os dados de dano."
            )

            atualizarBotoes()
            return
        end

        finalizarDanoRolado(
            jogador,
            ultimo,
            quantidadeDados,
            usarCritico,
            totalDados,
            listaDados
        )

        return
    end

    if tempoDecorrido >= CONFIG.dadoDanoEsperaMaxima then
        dadoDanoWaitId = nil

        erroRolagemDado(
            jogador,
            "Os dados de dano nao pararam a tempo. Role o dano novamente."
        )

        atualizarBotoes()
        return
    end

    dadoDanoWaitId =
        Wait.time(function()
            aguardarDadosDano(
                rolagemId,
                dados,
                jogador,
                ultimo,
                quantidadeDados,
                usarCritico,
                tempoDecorrido +
                    CONFIG.dadoDanoIntervaloLeitura
            )
        end, CONFIG.dadoDanoIntervaloLeitura)
end

local function iniciarRolagemDanoFisico(
    jogador,
    ultimo,
    quantidadeDados,
    usarCritico
)
    dadoDanoRolagemId =
        dadoDanoRolagemId + 1

    local rolagemId =
        dadoDanoRolagemId

    destruirDadosDanoAtuais()

    local dados = {}
    local guids = {}
    local dadosSpawnados = 0
    dadosDanoObjetos = {}
    state.dadoDanoGuids = {}

    for indice = 1, quantidadeDados do
        local indiceDado =
            indice

        spawnObject({
            type = CONFIG.dadoDanoTipo,
            position =
                posicaoSpawnDadoDano(
                    indiceDado,
                    quantidadeDados
                ),
            rotation = {
                math.random(0, 359),
                math.random(0, 359),
                math.random(0, 359)
            },
            scale = CONFIG.dadoDanoEscala,
            snap_to_grid = false,
            callback_function = function(dado)
                if rolagemId ~= dadoDanoRolagemId then
                    pcall(function()
                        dado.destruct()
                    end)

                    return
                end

                if not marcarDadoComoProprio(dado, "damage")
                    or not dadoPertenceAoPainel(dado, "damage") then
                    dadoDanoRolagemId = dadoDanoRolagemId + 1
                    pcall(function()
                        dado.destruct()
                    end)
                    destruirDadosDanoAtuais()
                    erroRolagemDado(
                        jogador,
                        "Nao foi possivel identificar com seguranca um dado de dano."
                    )
                    return
                end

                dados[indiceDado] = dado
                dadosSpawnados =
                    dadosSpawnados + 1

                table.insert(
                    guids,
                    dado.getGUID()
                )

                table.insert(dadosDanoObjetos, dado)
                state.dadoDanoGuids = guids

                pcall(function()
                    dado.setName("D6 Dano Edward")
                    dado.setColorTint({0.12, 0.28, 0.55})
                    dado.measure_movement = false
                end)

                impulsionarDadoDano(
                    dado,
                    jogador
                )

                if dadosSpawnados == quantidadeDados then
                    dadosDanoObjetos = dados
                    state.dadoDanoGuids = guids

                    dadoDanoWaitId =
                        Wait.time(function()
                            aguardarDadosDano(
                                rolagemId,
                                dados,
                                jogador,
                                ultimo,
                                quantidadeDados,
                                usarCritico,
                                0
                            )
                        end, CONFIG.dadoDanoIntervaloLeitura)
                end
            end
        })
    end
end

function rolarDano(
    objeto,
    jogador,
    cliqueAlternativo
)
    if not ultimoAtaqueValido(state.ultimoAtaque) then
        descartarUltimoAtaque()
        atualizarBotoes()

        printToColor(
            "Não existe um ataque armazenado. Role o ataque primeiro.",
            jogador,
            CONFIG.corErro
        )

        return
    end

    local usarCritico =
        cliqueAlternativo == "FORCAR_CRITICO"

    local ultimo =
        state.ultimoAtaque

    local quantidadeDados =
        tonumber(ultimo.quantidadeDadosDano)
        or CONFIG.quantidadeDadosDano

    if quantidadeDados < CONFIG.quantidadeDadosDano then
        quantidadeDados =
            CONFIG.quantidadeDadosDano
    end

    if usarCritico then
        quantidadeDados =
            quantidadeDados *
            CONFIG.multiplicadorCritico
    end

    iniciarRolagemDanoFisico(
        jogador,
        ultimo,
        quantidadeDados,
        usarCritico
    )
end
