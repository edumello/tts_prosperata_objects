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

    -- Reseta os poderes depois de rolar o ataque
    resetarAposAtaque = true,

    -- Reseta o modificador manual depois do ataque
    resetarModExtraAposAtaque = true,

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

    -- Cor usada apenas para mensagens de erro.
    -- Mensagens normais ficam na cor padrao do TTS para evitar bug visual no chat.
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

    -- Tempo de exibição no painel XML
    tempoResultadoUI = 8,

    -- Popup Global UI do resultado.
    -- Ajuste estes valores para calibrar o tamanho na tela.
    resultadoUILargura = 460,
    resultadoUIAltura = 190,
    resultadoUIPosicao = "0 70",
    resultadoUICor = "rgba(0,0,0,0.86)",
    resultadoUITextoLargura = 420,
    resultadoUITextoAltura = 150,
    resultadoUIFonteMinima = 9,
    resultadoUIFonteMaxima = 14,

    -- Atualizacao automatica via GitHub.
    -- Estes arquivos precisam estar publicados no branch main.
    githubScriptUrl =
        "https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/ataque_edward.lua",
    githubImagemUrl =
        "https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/assets/edward_attack_panel.png"
}

-- =========================================================
-- LAYOUT DOS BOTÕES
--
-- Estas posições foram pensadas para um tile horizontal.
-- Ajuste principalmente x e z para encaixar no seu painel.
-- =========================================================

local ALTURA_BOTAO = 0.10
local QUANTIDADE_MOD_EXTRAS = 4

local LAYOUT = {
    altura = ALTURA_BOTAO,
    escala = {0.20, 0.20, 0.20},

    -- Thickness recomendado no Custom Tile: 0.10.
    preparada = {-1.30, ALTURA_BOTAO, -0.33},
    poderoso = {-1.30, ALTURA_BOTAO, -0.15},
    pesado = {-1.30, ALTURA_BOTAO, 0.03},
    golpePessoal = {-1.30, ALTURA_BOTAO, 0.21},

    especial = {-1.55, ALTURA_BOTAO, 0.39},
    especialPM = {-1.18, ALTURA_BOTAO, 0.39},
    modExtraNome1 = {-0.10, ALTURA_BOTAO, -0.27},
    modExtraNome2 = {-0.10, ALTURA_BOTAO, -0.07},
    modExtraNome3 = {-0.10, ALTURA_BOTAO, 0.13},
    modExtraNome4 = {-0.10, ALTURA_BOTAO, 0.33},
    modExtra = {0.70, ALTURA_BOTAO, -0.28},
    modExtra2 = {0.70, ALTURA_BOTAO, -0.08},
    modExtra3 = {0.70, ALTURA_BOTAO, 0.12},
    modExtra4 = {0.70, ALTURA_BOTAO, 0.32},
    critico = {0.12, ALTURA_BOTAO, 0.68},

    previewPM = {2.25, ALTURA_BOTAO, -0.27},
    previewAtaque = {2.25, ALTURA_BOTAO, 0.03},
    previewDano = {2.25, ALTURA_BOTAO, 0.33},

    rolarAtaque = {-1.18, ALTURA_BOTAO, 0.68},
    rolarDano = {1.40, ALTURA_BOTAO, 0.68},
    updateGithub = {2.18, ALTURA_BOTAO, -0.66}
}

-- =========================================================
-- ÍNDICES DOS BOTÕES
--
-- Os índices começam em zero e seguem a ordem de criação.
-- =========================================================

local BUTTON = {
    preparada = 0,
    poderoso = 1,
    especial = 2,
    especialPM = 3,
    modExtra = 4,
    pesado = 5,
    golpePessoal = 6,
    rolarAtaque = 7,
    critico = 8,
    rolarDano = 9,
    previewPM = 10,
    previewAtaque = 11,
    previewDano = 12,
    modExtra2 = 13,
    modExtra3 = 14,
    modExtra4 = 15,
    updateGithub = 16
}

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

local esconderResultadoWaitId = nil
local dadoAtaqueObjeto = nil
local dadosAtaqueObjetos = {}
local dadoAtaqueWaitId = nil
local dadoAtaqueRolagemId = 0
local dadosDanoObjetos = {}
local dadoDanoWaitId = nil
local dadoDanoRolagemId = 0
local updateGithubEmAndamento = false

local BUTTON_ORDER = {
    "preparada",
    "poderoso",
    "especial",
    "especialPM",
    "modExtra",
    "pesado",
    "golpePessoal",
    "rolarAtaque",
    "critico",
    "rolarDano",
    "previewPM",
    "previewAtaque",
    "previewDano",
    "modExtra2",
    "modExtra3",
    "modExtra4",
    "updateGithub"
}

local CONTROLES = {
    {
        id = "preparada",
        click = "alternarPreparada",
        labelInicial = "OFF",
        layout = "preparada",
        largura = 640,
        tooltip = "Espada de execucao: sem preparar, sofre -5 no ataque."
    },
    {
        id = "poderoso",
        click = "alternarPoderoso",
        labelInicial = "OFF",
        layout = "poderoso",
        largura = 640,
        tooltip = "Ataque Poderoso: -2 no ataque e +5 no dano."
    },
    {
        id = "especial",
        click = "alternarEspecial",
        labelInicial = "OFF",
        layout = "especial",
        largura = 650,
        tooltip = "Clique esquerdo: OFF, ATAQUE, DANO e DIVIDIDO. Clique alternativo volta."
    },
    {
        id = "especialPM",
        click = "alterarEspecialPM",
        labelInicial = "1 PM",
        layout = "especialPM",
        largura = 360,
        tooltip = "Clique esquerdo aumenta PM. Clique alternativo diminui."
    },
    {
        id = "modExtra",
        click = "alterarModExtra",
        labelInicial = "+0",
        layout = "modExtra",
        largura = 360,
        tooltip = "Modificador extra 1 no ataque. Clique esquerdo +1. Clique alternativo -1."
    },
    {
        id = "pesado",
        click = "alternarPesado",
        labelInicial = "OFF",
        layout = "pesado",
        largura = 640,
        tooltip = "Ataque Pesado: custa 1 PM. Se acertar, derruba ou empurra."
    },
    {
        id = "golpePessoal",
        click = "alternarGolpePessoal",
        labelInicial = "OFF",
        layout = "golpePessoal",
        largura = 640,
        tooltip = "Passo do Carrasco: Avanço + Brutal + Preciso + Truque Secreto. Custa 1 PM. Uma vez por alvo por cena."
    },
    {
        id = "rolarAtaque",
        click = "rolarAtaque",
        labelInicial = "ROLAR\nATAQUE",
        layout = "rolarAtaque",
        largura = 1500,
        tooltip = "Rola somente o ataque e salva os modificadores para o dano."
    },
    {
        id = "critico",
        click = "rolarAtaqueCritico",
        labelInicial = "ROLAR ATAQUE\nCRITICO",
        layout = "critico",
        largura = 1500,
        tooltip = "Rola o dano critico usando os modificadores salvos no ultimo ataque."
    },
    {
        id = "rolarDano",
        click = "rolarDano",
        labelInicial = "ROLAR DANO\nSEM ATAQUE",
        layout = "rolarDano",
        largura = 1500,
        tooltip = "Rola o dano usando os modificadores salvos no ultimo ataque."
    },
    {
        id = "previewPM",
        click = "semAcao",
        labelInicial = "0 PM",
        layout = "previewPM",
        largura = 1350,
        tooltip = "Preview do custo de PM das opcoes selecionadas."
    },
    {
        id = "previewAtaque",
        click = "semAcao",
        labelInicial = "0 / 0 / 0",
        layout = "previewAtaque",
        largura = 1350,
        tooltip = "Preview minimo, medio e maximo do teste de ataque."
    },
    {
        id = "previewDano",
        click = "semAcao",
        labelInicial = "0 / 0 / 0",
        layout = "previewDano",
        largura = 1350,
        tooltip = "Preview minimo, medio e maximo do dano normal com as opcoes selecionadas."
    },
    {
        id = "modExtra2",
        click = "alterarModExtra2",
        labelInicial = "+0",
        layout = "modExtra2",
        largura = 360,
        tooltip = "Modificador extra 2 no ataque. Clique esquerdo +1. Clique alternativo -1."
    },
    {
        id = "modExtra3",
        click = "alterarModExtra3",
        labelInicial = "+0",
        layout = "modExtra3",
        largura = 360,
        tooltip = "Modificador extra 3 no ataque. Clique esquerdo +1. Clique alternativo -1."
    },
    {
        id = "modExtra4",
        click = "alterarModExtra4",
        labelInicial = "+0",
        layout = "modExtra4",
        largura = 360,
        tooltip = "Modificador extra 4 no ataque. Clique esquerdo +1. Clique alternativo -1."
    },
    {
        id = "updateGithub",
        click = "atualizarViaGithub",
        labelInicial = "UPDATE",
        layout = "updateGithub",
        largura = 820,
        tooltip = "Baixa do GitHub a versao mais nova do script e da imagem deste painel."
    }
}

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

local function corBotao(ativo)
    if ativo then
        return {0.20, 0.55, 0.25}
    end

    return {0.25, 0.25, 0.25}
end

local function corBotaoDano()
    if ultimoAtaqueValido(state.ultimoAtaque) then
        return {0.20, 0.45, 0.65}
    end

    return {0.25, 0.25, 0.25}
end

local function corToggle(ativo)
    if ativo then
        return {0.22, 0.46, 0.26}
    end

    return {0.12, 0.13, 0.13}
end

local function textoToggle(ativo)
    if ativo then
        return "ON"
    end

    return "OFF"
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

local function obterDadosAtaqueAtuais()
    local dados = {}

    for _, dado in ipairs(dadosAtaqueObjetos) do
        if objetoValido(dado) then
            table.insert(dados, dado)
        end
    end

    if #dados == 0 and objetoValido(dadoAtaqueObjeto) then
        table.insert(dados, dadoAtaqueObjeto)
    end

    if #dados == 0
        and type(state.dadoAtaqueGuids) == "table" then
        for _, guid in ipairs(state.dadoAtaqueGuids) do
            local dado =
                getObjectFromGUID(tostring(guid))

            if objetoValido(dado) then
                table.insert(dados, dado)
            end
        end
    end

    if #dados == 0
        and state.dadoAtaqueGuid ~= nil
        and state.dadoAtaqueGuid ~= "" then
        local dado =
            getObjectFromGUID(state.dadoAtaqueGuid)

        if objetoValido(dado) then
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
        if objetoValido(dado) then
            table.insert(dados, dado)
        end
    end

    if #dados == 0 and type(state.dadoDanoGuids) == "table" then
        for _, guid in ipairs(state.dadoDanoGuids) do
            local dado =
                getObjectFromGUID(tostring(guid))

            if objetoValido(dado) then
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

local function criarBotao(
    funcao,
    texto,
    posicao,
    largura,
    tooltip
)
    self.createButton({
        click_function = funcao,
        function_owner = self,
        label = texto,

        position = posicao,
        rotation = {0, 0, 0},
        scale = LAYOUT.escala,

        width = largura,
        height = 360,
        font_size = 145,

        color = {0.25, 0.25, 0.25},
        font_color = {1, 1, 1},
        hover_color = {0.40, 0.40, 0.40},
        press_color = {0.15, 0.15, 0.15},

        tooltip = tooltip
    })
end

local function criarInput(
    funcao,
    valor,
    posicao,
    largura,
    tooltip
)
    self.createInput({
        input_function = funcao,
        function_owner = self,
        label = "",
        value = valor,

        position = posicao,
        rotation = {0, 0, 0},
        scale = LAYOUT.escala,

        width = largura,
        height = 320,
        font_size = 180,

        alignment = 3,
        validation = 1,

        color = {0.04, 0.05, 0.05},
        font_color = {0.88, 1.00, 0.88},

        tooltip = tooltip
    })
end

function semAcao(
    objeto,
    jogador,
    cliqueAlternativo
)
end

local function validarOrdemBotoes()
    local botoes = self.getButtons() or {}

    if #botoes ~= #BUTTON_ORDER then
        print(
            "Aviso: quantidade inesperada de botoes. Esperado " ..
            tostring(#BUTTON_ORDER) ..
            ", encontrado " ..
            tostring(#botoes) ..
            ". Verifique BUTTON e a ordem de criacao."
        )
    end

    for indiceEsperado, nome in ipairs(BUTTON_ORDER) do
        local indiceZeroBased = indiceEsperado - 1

        if BUTTON[nome] ~= indiceZeroBased then
            print(
                "Aviso: indice inconsistente para o botao " ..
                tostring(nome) ..
                ". Esperado " ..
                tostring(indiceZeroBased) ..
                ", configurado " ..
                tostring(BUTTON[nome]) ..
                "."
            )
        end

        if CONTROLES[indiceEsperado] == nil
            or CONTROLES[indiceEsperado].id ~= nome then
            print(
                "Aviso: ordem inconsistente em CONTROLES para o indice " ..
                tostring(indiceZeroBased) ..
                ". Esperado " ..
                tostring(nome) ..
                "."
            )
        end
    end
end

-- =========================================================
-- ATUALIZAÇÃO DOS BOTÕES
-- =========================================================

local function atualizarBotoes()
    garantirModExtras()

    local preview = nil

    if calcularPreviewSelecionado ~= nil then
        preview = calcularPreviewSelecionado()
    end

    self.editButton({
        index = BUTTON.preparada,
        label = textoToggle(state.preparada),
        color = corToggle(state.preparada)
    })

    self.editButton({
        index = BUTTON.poderoso,
        label = textoToggle(state.poderoso),
        color = corToggle(state.poderoso)
    })

    self.editButton({
        index = BUTTON.especial,
        label = ESPECIAL_NOMES[state.especialModo] or "OFF",
        color = corBotao(state.especialModo ~= 0)
    })

    self.editButton({
        index = BUTTON.especialPM,
        label =
            tostring(state.especialPM) ..
            " PM"
    })

    self.editButton({
        index = BUTTON.modExtra,
        label = sinal(state.modExtras[1].valor),
        color = corBotao(state.modExtras[1].valor ~= 0)
    })

    self.editButton({
        index = BUTTON.modExtra2,
        label = sinal(state.modExtras[2].valor),
        color = corBotao(state.modExtras[2].valor ~= 0)
    })

    self.editButton({
        index = BUTTON.modExtra3,
        label = sinal(state.modExtras[3].valor),
        color = corBotao(state.modExtras[3].valor ~= 0)
    })

    self.editButton({
        index = BUTTON.modExtra4,
        label = sinal(state.modExtras[4].valor),
        color = corBotao(state.modExtras[4].valor ~= 0)
    })

    self.editButton({
        index = BUTTON.pesado,
        label = textoToggle(state.pesado),
        color = corToggle(state.pesado)
    })

    self.editButton({
        index = BUTTON.golpePessoal,
        label = textoToggle(state.golpePessoal),
        color = corToggle(state.golpePessoal)
    })

    self.editButton({
        index = BUTTON.rolarAtaque,
        label = "ROLAR\nATAQUE",
        color = {0.45, 0.08, 0.06}
    })

    self.editButton({
        index = BUTTON.critico,
        label = "ROLAR ATAQUE\nCRITICO",
        color = {0.55, 0.22, 0.08}
    })

    local statusDano = "SEM ATAQUE"

    if ultimoAtaqueValido(state.ultimoAtaque) then
        statusDano = "PRONTO"
    end

    self.editButton({
        index = BUTTON.rolarDano,
        label =
            "ROLAR DANO\n" ..
            statusDano,
        color = corBotaoDano()
    })

    self.editButton({
        index = BUTTON.updateGithub,
        label = updateGithubEmAndamento and "..." or "UPDATE",
        color = updateGithubEmAndamento
            and {0.35, 0.35, 0.12}
            or {0.16, 0.16, 0.16}
    })

    if preview ~= nil then
        self.editButton({
            index = BUTTON.previewPM,
            label =
                tostring(preview.custoPM) ..
                " PM",
            color = {0.10, 0.11, 0.12}
        })

        self.editButton({
            index = BUTTON.previewAtaque,
            label =
                tostring(preview.ataqueMin) ..
                " / " ..
                formatarMedia(preview.ataqueMedio) ..
                " / " ..
                tostring(preview.ataqueMax),
            color = {0.10, 0.11, 0.12}
        })

        self.editButton({
            index = BUTTON.previewDano,
            label =
                tostring(preview.danoMin) ..
                " / " ..
                formatarMedia(preview.danoMedio) ..
                " / " ..
                tostring(preview.danoMax),
            color = {0.10, 0.11, 0.12}
        })
    end
end

-- =========================================================
-- CRIAÇÃO DOS BOTÕES
-- =========================================================

local function construirBotoes()
    self.clearButtons()
    self.clearInputs()

    for _, controle in ipairs(CONTROLES) do
        criarBotao(
            controle.click,
            controle.labelInicial,
            LAYOUT[controle.layout],
            controle.largura,
            controle.tooltip
        )
    end

    for indice = 1, QUANTIDADE_MOD_EXTRAS do
        criarInput(
            "nomearModExtra" .. tostring(indice),
            nomeModExtra(indice),
            LAYOUT["modExtraNome" .. tostring(indice)],
            760,
            "Nome do modificador extra " .. tostring(indice) .. "."
        )
    end

    atualizarBotoes()
    validarOrdemBotoes()
end

-- =========================================================
-- PAINEL XML
-- =========================================================

local function criarResultadoXml()
    return
        '<Panel ' ..
        'id="resultadoAtaque" ' ..
        'active="false" ' ..
        'width="' .. tostring(CONFIG.resultadoUILargura) .. '" ' ..
        'height="' .. tostring(CONFIG.resultadoUIAltura) .. '" ' ..
        'position="' .. tostring(CONFIG.resultadoUIPosicao) .. '" ' ..
        'color="' .. tostring(CONFIG.resultadoUICor) .. '">' ..
        '<Text ' ..
        'id="textoAtaque" ' ..
        'width="' .. tostring(CONFIG.resultadoUITextoLargura) .. '" ' ..
        'height="' .. tostring(CONFIG.resultadoUITextoAltura) .. '" ' ..
        'position="0 0" ' ..
        'resizeTextForBestFit="true" ' ..
        'resizeTextMinSize="' .. tostring(CONFIG.resultadoUIFonteMinima) .. '" ' ..
        'resizeTextMaxSize="' .. tostring(CONFIG.resultadoUIFonteMaxima) .. '" ' ..
        'horizontalOverflow="Wrap" ' ..
        'verticalOverflow="Truncate" ' ..
        'color="#FFFFFF" ' ..
        'fontStyle="Bold" ' ..
        'alignment="MiddleCenter">' ..
        'Resultado do ataque' ..
        '</Text>' ..
        '</Panel>'
end

local function atualizarAtributosResultadoGlobalUI()
    pcall(function()
        UI.setAttributes(
            "resultadoAtaque",
            {
                width = CONFIG.resultadoUILargura,
                height = CONFIG.resultadoUIAltura,
                position = CONFIG.resultadoUIPosicao,
                color = CONFIG.resultadoUICor
            }
        )
    end)

    pcall(function()
        UI.setAttributes(
            "textoAtaque",
            {
                width = CONFIG.resultadoUITextoLargura,
                height = CONFIG.resultadoUITextoAltura,
                resizeTextMinSize = CONFIG.resultadoUIFonteMinima,
                resizeTextMaxSize = CONFIG.resultadoUIFonteMaxima
            }
        )
    end)
end

local function garantirResultadoGlobalUI()
    local sucessoXmlAtual, xmlAtual =
        pcall(function()
            return UI.getXml()
        end)

    if sucessoXmlAtual
        and type(xmlAtual) == "string"
        and string.find(
            xmlAtual,
            'id="resultadoAtaque"',
            1,
            true
        ) ~= nil then
        atualizarAtributosResultadoGlobalUI()
        return true
    end

    local resultadoXml =
        criarResultadoXml()

    local novoXml = resultadoXml

    if sucessoXmlAtual
        and type(xmlAtual) == "string"
        and xmlAtual ~= "" then
        novoXml =
            xmlAtual ..
            "\n" ..
            resultadoXml
    end

    local sucessoSetXml, erroSetXml =
        pcall(function()
            UI.setXml(novoXml)
        end)

    if not sucessoSetXml then
        print(
            "Erro ao preparar Global UI de resultado: " ..
            tostring(erroSetXml)
        )
    end

    if sucessoSetXml then
        atualizarAtributosResultadoGlobalUI()
    end

    return sucessoSetXml
end

local function mostrarResultadoFallback(mensagem, jogador)
    if jogador ~= nil and jogador ~= "" then
        printToColor(
            mensagem,
            jogador
        )

        return
    end

    printToAll(
        mensagem
    )
end

local function mostrarResultado(mensagem, jogador)
    garantirResultadoGlobalUI()

    local sucesso, erro = pcall(function()
        UI.setValue("textoAtaque", mensagem)
        UI.show("resultadoAtaque")
    end)

    if not sucesso then
        print(
            "Erro ao mostrar resultado na UI: " ..
            tostring(erro)
        )

        mostrarResultadoFallback(mensagem, jogador)

        return
    end

    if esconderResultadoWaitId ~= nil then
        Wait.stop(esconderResultadoWaitId)
    end

    esconderResultadoWaitId = Wait.time(function()
        local sucessoEsconder, erroEsconder = pcall(function()
            UI.hide("resultadoAtaque")
        end)

        if not sucessoEsconder then
            print(
                "Erro ao esconder resultado na UI: " ..
                tostring(erroEsconder)
            )
        end

        esconderResultadoWaitId = nil
    end, CONFIG.tempoResultadoUI)
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

    garantirResultadoGlobalUI()
    construirBotoes()
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

    printToAll(
        resumoChat
    )

    mostrarResultado(
        resumoChat,
        jogador
    )

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

                dados[indiceDado] = dado
                dadosSpawnados =
                    dadosSpawnados + 1

                table.insert(
                    guids,
                    dado.getGUID()
                )

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

    printToAll(
        resumoChat
    )

    mostrarResultado(
        resumoChat,
        jogador
    )

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

                dados[indiceDado] = dado
                dadosSpawnados =
                    dadosSpawnados + 1

                table.insert(
                    guids,
                    dado.getGUID()
                )

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
