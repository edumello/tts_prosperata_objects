# Edward Attack Panel V1

Este projeto automatiza os ataques do personagem Edward em Tabletop Simulator.
Esta e a primeira versao oficial do painel e do script.

Todos os caminhos deste arquivo sao relativos a `characters/edward/`, salvo quando indicado o contrario.

## Arquivos principais

```text
ataque_edward.lua
ui.xml
assets/edward_attack_panel.png
image_menu/build_panel.ps1
image_menu/manifest.json
```

## Personagem

- Nome: Edward
- Raca: Humano
- Classe: Guerreiro 4
- Arma: Espada de execucao

Valores atuais no Lua:

```lua
nomeArma = "Espada de execucao"
bonusAtaqueBase = 13
quantidadeDadosDano = 2
ladosDadoDano = 6
bonusDanoBase = 11
margemCritico = 17
multiplicadorCritico = 4
ataqueEspecialMaxPM = 1
modExtraMin = -20
modExtraMax = 20
```

Origem dos valores:

- Ataque base: Luta +10, Foco em Arma +2, Armas da Ambicao +1.
- Dano base: espada de execucao 2d6, Forca +6, Estilo de Duas Maos +5.
- Critico: margem 17-20, multiplicador x4.
- Dano critico: 8d6 + modificador de dano salvo.
- Bonus numericos nao sao multiplicados no critico.

## Fluxo de uso

1. Configure os ataques e modificadores no painel.
2. Clique em `ROLAR ATAQUE`.
3. O script remove o D20 de ataque anterior, spawna um novo D20 fisico, rola o dado e le a face superior quando ele parar.
4. O script salva uma fotografia do ataque: d20, total, modificador de dano, PM e lista de efeitos.
5. Se o ataque acertar, clique em `ROLAR DANO`.
6. Se for critico, clique em `ROLAR ATAQUE CRITICO`.
7. O dano sempre usa a fotografia salva do ultimo ataque, nao o estado atual dos botoes.

Para manter o popup compacto, ataques normais nao mostram mais as frases "Ataque armazenado" e "Clique em ROLAR DANO caso tenha acertado". O ataque continua sendo salvo do mesmo jeito.

## Controles

### Ataques

- `PREPARADA`: sem preparar, a espada sofre -5 no ataque.
- `PODEROSO`: -2 no ataque e +5 no dano.
- `PESADO`: custa 1 PM e permite usar o total do ataque para derrubar ou empurrar.
- `ESPECIAL`: alterna entre `OFF`, `ATAQUE`, `DANO` e `DIVIDIDO`.
- `ESPECIAL PM`: no nivel atual fica em 1 PM.

### Mod. Extras

Existem quatro modificadores extras independentes.

Cada linha tem:

- input editavel para nome;
- botao de valor;
- clique esquerdo no valor: +1;
- clique alternativo no valor: -1.

Os quatro valores somam no teste de ataque. Os nomes aparecem no chat e no painel de resultado quando o valor e diferente de zero.

Ao rolar ataque, os valores dos quatro modificadores extras voltam para zero. Os nomes continuam salvos.

### Previa

- `PM GASTO`: custo total das opcoes selecionadas.
- `ATAQUE`: minimo / medio / maximo do teste de ataque.
- `DANO`: minimo / medio / maximo do dano normal.

O preview de dano nao aplica critico automaticamente.

## Estado salvo

O estado salvo oficial usa:

```lua
state = {
    preparada = false,
    poderoso = false,
    especialModo = 0,
    especialPM = 1,
    pesado = false,
    modExtras = {
        { nome = "EXTRA 1", valor = 0 },
        { nome = "EXTRA 2", valor = 0 },
        { nome = "EXTRA 3", valor = 0 },
        { nome = "EXTRA 4", valor = 0 }
    },
    ultimoAtaque = {
        disponivel = false,
        jogador = "",
        d20 = 0,
        totalAtaque = 0,
        modificadorAtaque = 0,
        modificadorDano = 11,
        custoPM = 0,
        ameacaCritico = false,
        listaEfeitos = "Nenhum",
        resumoEfeitosChat = "Sem modificadores"
    },
    dadoAtaqueGuid = "",
    dadoDanoGuids = {}
}
```

Um ultimo ataque valido exige:

```lua
ultimoAtaque.disponivel == true
and ultimoAtaque.d20 >= 1
and ultimoAtaque.d20 <= 20
```

## Indices dos botoes

Os indices dependem da ordem de `self.createButton`.

```lua
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
```

`BUTTON_ORDER` e `CONTROLES` devem continuar com a mesma ordem. A validacao textual esperada e:

```text
BUTTON_ORDER == CONTROLES
COUNT = 15
```

Os inputs de nome dos modificadores extras sao criados com `self.createInput()` e nao entram na contagem dos botoes.

## Layout calibrado

Altura e escala:

```lua
local ALTURA_BOTAO = 0.10
escala = {0.20, 0.20, 0.20}
```

Posicoes atuais:

```lua
preparada = {-1.30, 0.10, -0.31}
poderoso = {-1.30, 0.10, -0.10}
pesado = {-1.30, 0.10, 0.13}

especial = {-1.55, 0.10, 0.34}
especialPM = {-1.18, 0.10, 0.34}

modExtraNome1 = {-0.10, 0.10, -0.27}
modExtraNome2 = {-0.10, 0.10, -0.07}
modExtraNome3 = {-0.10, 0.10, 0.13}
modExtraNome4 = {-0.10, 0.10, 0.33}

modExtra = {0.70, 0.10, -0.28}
modExtra2 = {0.70, 0.10, -0.08}
modExtra3 = {0.70, 0.10, 0.12}
modExtra4 = {0.70, 0.10, 0.32}

previewPM = {2.25, 0.10, -0.27}
previewAtaque = {2.25, 0.10, 0.03}
previewDano = {2.25, 0.10, 0.33}

rolarAtaque = {-1.18, 0.10, 0.68}
critico = {0.12, 0.10, 0.68}
rolarDano = {1.40, 0.10, 0.68}
```

Inputs dos nomes:

```lua
width = 760
height = 320
font_size = 180
```

## D20 fisico de ataque

`ROLAR ATAQUE` usa um D20 fisico do Tabletop Simulator.

Configuracao no `CONFIG`:

```lua
dadoAtaqueTipo = "Die_20"
dadoAtaqueOffsetLocal = {0, 2.0, -1.35}
dadoAtaqueEscala = {1.25, 1.25, 1.25}
dadoAtaqueForcaMinima = {-3, 14, -3}
dadoAtaqueForcaMaxima = {3, 18, 3}
dadoAtaqueTorqueMinimo = {-35, -35, -35}
dadoAtaqueTorqueMaximo = {35, 35, 35}
dadoAtaqueEsperaMaxima = 8
dadoAtaqueIntervaloLeitura = 0.25
```

Comportamento:

- ao clicar em `ROLAR ATAQUE`, o D20 gerado anteriormente e destruido;
- um novo D20 e spawnado perto do painel;
- depois de um frame, o dado recebe `randomize(jogador)`, impulso com `addForce` e giro com `addTorque`;
- quando `dado.resting == true`, o script le `dado.getRotationValue()`;
- esse valor substitui a rolagem interna de `math.random(1, 20)`;
- se o dado for removido ou nao parar a tempo, o ataque nao e salvo e o jogador recebe mensagem de erro.
- o dado spawnado recebe `measure_movement = false` para evitar rastro laranja/amarelo do Line Tool.

Se precisar ajustar onde o dado aparece, alterar somente `dadoAtaqueOffsetLocal`.
Se precisar ajustar o salto/giro do dado, alterar `dadoAtaqueForca*` e `dadoAtaqueTorque*`.

## D6 fisicos de dano

`ROLAR DANO` e `ROLAR ATAQUE CRITICO` usam D6 fisicos do Tabletop Simulator.

Configuracao no `CONFIG`:

```lua
dadoDanoTipo = "Die_6"
dadoDanoOffsetLocal = {0, 2.0, 1.35}
dadoDanoEspacamento = 0.48
dadoDanoEscala = {1.05, 1.05, 1.05}
dadoDanoForcaMinima = {-3, 12, -3}
dadoDanoForcaMaxima = {3, 16, 3}
dadoDanoTorqueMinimo = {-30, -30, -30}
dadoDanoTorqueMaximo = {30, 30, 30}
dadoDanoEsperaMaxima = 8
dadoDanoIntervaloLeitura = 0.25
```

Comportamento:

- ao clicar em `ROLAR DANO`, os D6 de dano anteriores sao destruidos;
- um dano normal spawna `2d6`;
- ao clicar em `ROLAR ATAQUE CRITICO`, os D6 de dano anteriores sao destruidos;
- um dano critico spawna `8d6`;
- depois de um frame, cada dado recebe `randomize(jogador)`, impulso com `addForce` e giro com `addTorque`;
- quando todos os dados estao com `dado.resting == true`, o script le cada face com `dado.getRotationValue()`;
- o total dos D6 fisicos substitui a rolagem interna antiga de dano;
- se algum dado for removido ou nao parar a tempo, o dano nao e resolvido e o jogador recebe mensagem de erro.
- os dados spawnados recebem `measure_movement = false` para evitar rastro laranja/amarelo do Line Tool.

Regras numericas mantidas nesta feature:

- dano normal: `2d6 + modificador de dano salvo`;
- dano critico: `8d6 + modificador de dano salvo`;
- bonus numericos continuam nao sendo multiplicados no critico.

Se precisar ajustar onde os D6 aparecem, alterar `dadoDanoOffsetLocal` e `dadoDanoEspacamento`.
Se precisar ajustar o salto/giro dos D6, alterar `dadoDanoForca*` e `dadoDanoTorque*`.

## UI XML

O XML global usa estes IDs:

```xml
id="resultadoAtaque"
id="textoAtaque"
```

O Lua deve usar a Global UI para este overlay:

```lua
UI.setValue("textoAtaque", mensagem)
UI.show("resultadoAtaque")
UI.hide("resultadoAtaque")
```

Motivo: quando este XML fica na Object UI do painel e o Lua usa `self.UI`, o popup e renderizado preso ao objeto em 3D, podendo aparecer atras/embaixo do tile. Para manter o comportamento original de popup na tela, usar Global UI.

O script gera uma copia embutida de `ui.xml` com `criarResultadoXml()` e chama `garantirResultadoGlobalUI()` no `onLoad` e antes de mostrar o resultado. Se o Global UI da mesa ainda nao tiver `id="resultadoAtaque"`, o script adiciona esse XML automaticamente.

A copia embutida e gerada a partir dos campos `CONFIG.resultadoUI*`. Para mudar o tamanho do popup, alterar no topo de `ataque_edward.lua`:

```lua
resultadoUILargura = 460
resultadoUIAltura = 190
resultadoUIPosicao = "0 70"
resultadoUITextoLargura = 420
resultadoUITextoAltura = 150
resultadoUIFonteMinima = 9
resultadoUIFonteMaxima = 14
```

Quando o id `resultadoAtaque` ja existe no Global UI, `garantirResultadoGlobalUI()` reaplica esses atributos com `UI.setAttributes()` no `onLoad`.

Tamanho calibrado do overlay de resultado:

```xml
width="460"
height="190"
position="0 70"
color="rgba(0,0,0,0.86)"
textoAtaque width="420"
textoAtaque height="150"
resizeTextMinSize="9"
resizeTextMaxSize="14"
```

Para exportar o objeto com `Save Object`, nao colocar este XML na aba UI/XML do objeto. O objeto salvo leva a copia do XML dentro do Lua e instala o painel no Global UI ao carregar.

## Asset do painel

O painel final usado pelo Tabletop Simulator fica em:

```text
assets/edward_attack_panel.png
```

O preview/export oficial fica em:

```text
image_menu/exports/edward_attack_panel_v1.png
```

Regenerar:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File image_menu\build_panel.ps1
```

A partir da raiz do repo, use:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File characters\edward\image_menu\build_panel.ps1
```

O canvas do PNG e `2048x640`.

## Regras para mudancas

- Nao alterar regras ou valores do personagem sem registrar explicitamente.
- Se alterar a ordem de criacao de botoes, atualizar `BUTTON`, `BUTTON_ORDER`, `CONTROLES` e `image_menu/manifest.json`.
- Se mexer no PNG em posicoes clicaveis, ajustar tambem `LAYOUT`.
- Dano deve sempre usar `state.ultimoAtaque`.
- Manter `ataque_edward.lua` como script Lua completo para Tabletop Simulator.
