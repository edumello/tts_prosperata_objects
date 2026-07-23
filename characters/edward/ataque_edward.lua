-- =========================================================
-- CONFIGURAÇÃO DO PERSONAGEM
-- Edward / Humano Guerreiro 4 / Espada de execução
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
    ataqueEspecialMaxPM = 1,

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

    -- Cor verde do texto no chat
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
    resultadoUIFonteMaxima = 14
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
    preparada = {-1.30, ALTURA_BOTAO, -0.31},
    poderoso = {-1.30, ALTURA_BOTAO, -0.10},
    pesado = {-1.30, ALTURA_BOTAO, 0.13},

    especial = {-1.55, ALTURA_BOTAO, 0.34},
    especialPM = {-1.18, ALTURA_BOTAO, 0.34},
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
    rolarDano = {1.40, ALTURA_BOTAO, 0.68}
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
    rolarAtaque = 6,
    critico = 7,
    rolarDano = 8,
    previewPM = 9,
    previewAtaque = 10,
    previewDano = 11,
    modExtra2 = 12,
    modExtra3 = 13,
    modExtra4 = 14
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
        totalAtaque = 0,
        modificadorAtaque = 0,
        modificadorDano = CONFIG.bonusDanoBase,
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
        modExtras = criarModExtrasPadrao(),

        ultimoAtaque = criarUltimoAtaqueVazio(),
        dadoAtaqueGuid = "",
        dadoDanoGuids = {}
    }
end

local state = criarEstadoPadrao()

local esconderResultadoWaitId = nil
local dadoAtaqueObjeto = nil
local dadoAtaqueWaitId = nil
local dadoAtaqueRolagemId = 0
local dadosDanoObjetos = {}
local dadoDanoWaitId = nil
local dadoDanoRolagemId = 0

local BUTTON_ORDER = {
    "preparada",
    "poderoso",
    "especial",
    "especialPM",
    "modExtra",
    "pesado",
    "rolarAtaque",
    "critico",
    "rolarDano",
    "previewPM",
    "previewAtaque",
    "previewDano",
    "modExtra2",
    "modExtra3",
    "modExtra4"
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

local function obterDadoAtaqueAtual()
    if objetoValido(dadoAtaqueObjeto) then
        return dadoAtaqueObjeto
    end

    if state.dadoAtaqueGuid ~= nil
        and state.dadoAtaqueGuid ~= "" then
        dadoAtaqueObjeto =
            getObjectFromGUID(state.dadoAtaqueGuid)
    end

    if objetoValido(dadoAtaqueObjeto) then
        return dadoAtaqueObjeto
    end

    dadoAtaqueObjeto = nil
    state.dadoAtaqueGuid = ""

    return nil
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

    local dado =
        obterDadoAtaqueAtual()

    if dado ~= nil then
        pcall(function()
            dado.destruct()
        end)
    end

    dadoAtaqueObjeto = nil
    state.dadoAtaqueGuid = ""
end

local function posicaoSpawnDadoAtaque()
    local sucesso, posicao =
        pcall(function()
            return self.positionToWorld(
                CONFIG.dadoAtaqueOffsetLocal
            )
        end)

    if sucesso then
        return posicao
    end

    local posicaoPainel =
        self.getPosition()

    return {
        posicaoPainel.x,
        posicaoPainel.y + 2,
        posicaoPainel.z - 1.35
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

        if jogador ~= nil and jogador ~= "" then
            printToColor(
                mensagem,
                jogador,
                CONFIG.corChat
            )
        else
            printToAll(
                mensagem,
                CONFIG.corChat
            )
        end

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
        listaEfeitos = listaEfeitos,
        resumoEfeitosChat = resumoEfeitosChat
    }
end

calcularPreviewSelecionado = function()
    local calculo =
        calcularModificadoresSelecionados()

    local ataqueMin =
        1 + calculo.modificadorAtaque

    local ataqueMedio =
        10.5 + calculo.modificadorAtaque

    local ataqueMax =
        20 + calculo.modificadorAtaque

    local danoMin =
        CONFIG.quantidadeDadosDano +
        calculo.modificadorDano

    local danoMedio =
        CONFIG.quantidadeDadosDano *
        ((CONFIG.ladosDadoDano + 1) / 2) +
        calculo.modificadorDano

    local danoMax =
        CONFIG.quantidadeDadosDano *
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

    ultimo.totalAtaque =
        tonumber(dados.totalAtaque) or 0

    ultimo.modificadorAtaque =
        tonumber(dados.modificadorAtaque) or 0

    ultimo.modificadorDano =
        tonumber(dados.modificadorDano)
        or CONFIG.bonusDanoBase

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

local function finalizarAtaqueRolado(jogador, calculo, d20)
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
        jogador = jogador,
        d20 = d20,
        totalAtaque = totalAtaque,

        modificadorAtaque =
            calculo.modificadorAtaque,

        modificadorDano =
            calculo.modificadorDano,

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
    -- Mensagem detalhada
    -- -----------------------------------------------------

    local mensagem = string.format(
        "%s atacou com %s" ..
        "\nAtaque: d20 [%s] %s = %s" ..
        "\nModificador de dano salvo: %s" ..
        "\nPM declarado: %s" ..
        "\nModificadores: %s",

        tostring(jogador),
        tostring(CONFIG.nomeArma),
        tostring(d20),
        sinal(calculo.modificadorAtaque),
        tostring(totalAtaque),
        sinal(calculo.modificadorDano),
        tostring(calculo.custoPM),
        tostring(calculo.listaEfeitos)
    )

    if resultadoAutomatico ~= nil then
        mensagem =
            mensagem ..
            "\n" ..
            resultadoAutomatico
    end

    if ameacaCritico then
        mensagem =
            mensagem ..
            "\nAMEAÇA DE CRÍTICO: " ..
            "confirme que o ataque acertou. " ..
            "Use ROLAR ATAQUE CRITICO para o dano critico."
    end

    if state.pesado then
        mensagem =
            mensagem ..
            "\nATAQUE PESADO: se acertar, use " ..
            tostring(totalAtaque) ..
            " no teste para derrubar ou empurrar."
    end

    -- -----------------------------------------------------
    -- Resumo do chat
    -- -----------------------------------------------------

    local resumoChat = string.format(
        "%s | %s | ATAQUE %s (d20 %s %s) | PM %s | %s",

        tostring(jogador),
        tostring(CONFIG.nomeArma),
        tostring(totalAtaque),
        tostring(d20),
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
        resumoChat,
        CONFIG.corChat
    )

    mostrarResultado(
        mensagem,
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

local function aguardarDadoAtaque(
    rolagemId,
    dado,
    jogador,
    calculo,
    tempoDecorrido
)
    if rolagemId ~= dadoAtaqueRolagemId then
        return
    end

    if not objetoValido(dado) then
        dadoAtaqueWaitId = nil

        erroRolagemDado(
            jogador,
            "O D20 do ataque foi removido antes de parar."
        )

        atualizarBotoes()
        return
    end

    local sucessoRepouso, emRepouso =
        pcall(function()
            return dado.resting == true
        end)

    if sucessoRepouso and emRepouso then
        local d20 =
            lerResultadoD20(dado)

        dadoAtaqueWaitId = nil

        if d20 == nil then
            erroRolagemDado(
                jogador,
                "Nao foi possivel ler o valor do D20 fisico."
            )

            atualizarBotoes()
            return
        end

        finalizarAtaqueRolado(
            jogador,
            calculo,
            d20
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
            aguardarDadoAtaque(
                rolagemId,
                dado,
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

    spawnObject({
        type = CONFIG.dadoAtaqueTipo,
        position = posicaoSpawnDadoAtaque(),
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

            dadoAtaqueObjeto = dado
            state.dadoAtaqueGuid = dado.getGUID()

            pcall(function()
                dado.setName("D20 Ataque Edward")
                dado.setColorTint({0.65, 0.08, 0.08})
                dado.measure_movement = false
            end)

            impulsionarDadoAtaque(dado, jogador)

            dadoAtaqueWaitId =
                Wait.time(function()
                    aguardarDadoAtaque(
                        rolagemId,
                        dado,
                        jogador,
                        calculo,
                        0
                    )
                end, CONFIG.dadoAtaqueIntervaloLeitura)
        end
    })
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
    -- Mensagem detalhada
    -- -----------------------------------------------------

    local mensagem = string.format(
        "%s rolou o dano de %s" ..
        "\n%s: %sd%s [%s] %s = %s" ..
        "\nAtaque relacionado: %s (d20 %s)" ..
        "\nPM declarado no ataque: %s" ..
        "\nModificadores do ataque: %s",

        tostring(ultimo.jogador),
        tostring(CONFIG.nomeArma),
        tostring(tipoDano),
        tostring(quantidadeDados),
        tostring(CONFIG.ladosDadoDano),
        tostring(listaDados),
        sinal(ultimo.modificadorDano),
        tostring(totalDano),
        tostring(ultimo.totalAtaque),
        tostring(ultimo.d20),
        tostring(ultimo.custoPM),
        tostring(ultimo.listaEfeitos)
    )

    if usarCritico
        and not ultimo.ameacaCritico then
        mensagem =
            mensagem ..
            "\nCRÍTICO ATIVADO MANUALMENTE: " ..
            "o d20 não estava originalmente na margem de ameaça."
    end

    -- -----------------------------------------------------
    -- Resumo do chat
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

    printToAll(
        resumoChat,
        CONFIG.corChat
    )

    mostrarResultado(
        mensagem,
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
        CONFIG.quantidadeDadosDano

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
