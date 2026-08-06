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
- Classe: Guerreiro 5
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
ataqueEspecialMaxPM = 2
modExtraMin = -20
modExtraMax = 20
githubScriptUrl = "https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/ataque_edward.lua"
githubImagemUrl = "https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/assets/edward_attack_panel.png"
```

Origem dos valores:

- Ataque base: Luta +10, Foco em Arma +2, Armas da Ambicao +1.
- Dano base: espada de execucao 2d6, Forca +6, Estilo de Duas Maos +5.
- Critico: margem 17-20, multiplicador x4.
- Dano critico: 8d6 + modificador de dano salvo.
- Bonus numericos nao sao multiplicados no critico.

## Golpe Pessoal

Edward possui o Golpe Pessoal `Passo do Carrasco`.

Efeitos:

- Avanco;
- Brutal;
- Preciso;
- Truque Secreto.

Custo final: `1 PM`.

Motivo do custo: Avanco `+1 PM`, Brutal `+1 PM`, Preciso `+1 PM`, Truque Secreto `-2 PM`, respeitando custo minimo de `1 PM`.

Regras automatizadas:

- quando `GOLPE PESSOAL` esta ON, o ataque usa Preciso: spawna `2d20`, usa o maior resultado e mostra os dois d20 na mensagem;
- o maior d20 calcula o total do ataque e verifica ameaca de critico;
- Brutal adiciona `+1` dado da arma ao dano salvo;
- dano normal com Golpe Pessoal: `3d6 + modificador de dano salvo`;
- dano critico com Golpe Pessoal: `12d6 + modificador de dano salvo`;
- Avanco nao altera numeros, mas aparece na mensagem;
- Truque Secreto nao altera numeros alem do custo, mas aparece na mensagem como aviso de uso uma vez por alvo por cena;
- nao ha controle automatico de alvo ou uso por alvo.

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
- `GOLPE PESSOAL`: Passo do Carrasco. Custa 1 PM, usa Preciso, Brutal, Avanco e Truque Secreto.
- `ESPECIAL`: alterna entre `OFF`, `ATAQUE`, `DANO` e `DIVIDIDO`.
- `ESPECIAL PM`: no nivel atual alterna entre 1 PM e 2 PM.

### Mod. Extras

Existem quatro modificadores extras independentes.

Cada linha tem:

- input editavel para nome;
- botao de valor;
- clique esquerdo no valor: +1;
- clique alternativo no valor: -1.

Os quatro valores somam no teste de ataque. Os nomes aparecem no chat e no painel de resultado quando o valor e diferente de zero.

Ao rolar qualquer ataque, todas as selecoes permanecem ativas: Preparada, Poderoso, Ataque Especial, Pesado, Golpe Pessoal e os valores/nomes dos quatro modificadores extras. Isso permite representar efeitos com duracao de varios turnos; o usuario desativa ou zera cada modificador manualmente quando o efeito terminar.

### Previa

- `PM GASTO`: custo total das opcoes selecionadas.
- `ATAQUE`: minimo / medio / maximo do teste de ataque.
- `DANO`: minimo / medio / maximo do dano normal.
- `UPDATE`: baixa do GitHub o Lua e a imagem publicados no branch `main`, aplica no objeto e recarrega o painel.

O preview de dano nao aplica critico automaticamente.

## Atualizacao via GitHub

O botao `UPDATE` usa `WebRequest.get()` para buscar a versao publicada em:

```text
https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/ataque_edward.lua
https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/main/characters/edward/assets/edward_attack_panel.png
```

Fluxo:

1. O jogador clica em `UPDATE`.
2. O script baixa `ataque_edward.lua` do GitHub.
3. O script valida que o arquivo parece ser o script do Edward.
4. O script troca `custom.image` do Custom Tile para a URL raw da imagem com cache buster.
5. O script chama `self.setLuaScript(scriptBaixado)`.
6. O script chama `self.reload()`.

Isso permite que um jogador use o botao em uma mesa hospedada pelo mestre, desde que o objeto ja tenha esse script instalado e a mesa permita `WebRequest`. O mestre nao precisa saber usar Git, mas a versao nova precisa estar commitada e enviada para o branch `main` do GitHub antes do clique.

Se o repositorio estiver privado, o raw URL pode nao funcionar dentro do Tabletop Simulator. Para update automatico simples, manter este repo/arquivos acessiveis publicamente.

## Estado salvo

O estado salvo oficial usa:

```lua
state = {
    preparada = false,
    poderoso = false,
    especialModo = 0,
    especialPM = 1,
    pesado = false,
    golpePessoal = false,
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
        d20Lista = {},
        totalAtaque = 0,
        modificadorAtaque = 0,
        modificadorDano = 11,
        quantidadeDadosDano = 2,
        golpePessoal = false,
        custoPM = 0,
        ameacaCritico = false,
        listaEfeitos = "Nenhum",
        resumoEfeitosChat = "Sem modificadores"
    },
    dadoAtaqueGuid = "",
    dadoAtaqueGuids = {},
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
```

`BUTTON_ORDER` e `CONTROLES` devem continuar com a mesma ordem. A validacao textual esperada e:

```text
BUTTON_ORDER == CONTROLES
COUNT = 17
```

Os inputs de nome dos modificadores extras sao criados com `self.createInput()` e nao entram na contagem dos botoes.

No PNG, os icones da coluna `ATAQUES` usam uma versao compacta (`DrawSlotIconCircle`, 50px). Os icones grandes (`DrawIconCircle`, 68px) ficam reservados aos botoes de acao da parte inferior.

## Layout calibrado

Altura e escala:

```lua
local ALTURA_BOTAO = 0.10
escala = {0.20, 0.20, 0.20}
```

Posicoes atuais:

```lua
preparada = {-1.30, 0.10, -0.33}
poderoso = {-1.30, 0.10, -0.15}
pesado = {-1.30, 0.10, 0.03}
golpePessoal = {-1.30, 0.10, 0.21}

especial = {-1.55, 0.10, 0.39}
especialPM = {-1.18, 0.10, 0.39}

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
updateGithub = {2.18, 0.10, -0.66}
```

Inputs dos nomes:

```lua
width = 760
height = 320
font_size = 180
```

## D20 fisico de ataque

`ROLAR ATAQUE` usa D20 fisico do Tabletop Simulator. Normalmente e `1d20`; com `GOLPE PESSOAL` ON, o script spawna `2d20`, le os dois resultados e usa o maior.

Configuracao no `CONFIG`:

```lua
dadoAtaqueTipo = "Die_20"
dadoAtaqueOffsetLocal = {0, 2.0, -1.35}
dadoAtaqueEspacamento = 0.55
dadoAtaqueEscala = {1.25, 1.25, 1.25}
dadoAtaqueForcaMinima = {-3, 14, -3}
dadoAtaqueForcaMaxima = {3, 18, 3}
dadoAtaqueTorqueMinimo = {-35, -35, -35}
dadoAtaqueTorqueMaximo = {35, 35, 35}
dadoAtaqueEsperaMaxima = 8
dadoAtaqueIntervaloLeitura = 0.25
```

Comportamento:

- ao clicar em `ROLAR ATAQUE`, os D20 gerados anteriormente sao destruidos;
- um novo D20 e spawnado perto do painel, ou dois D20 se `GOLPE PESSOAL` estiver ON;
- depois de um frame, o dado recebe `randomize(jogador)`, impulso com `addForce` e giro com `addTorque`;
- quando todos os dados estao em repouso, o script le `getRotationValue()` de cada um;
- o maior valor substitui a rolagem interna de `math.random(1, 20)`;
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
- um dano normal spawna a quantidade de dados salva no ataque: `2d6` sem Golpe Pessoal ou `3d6` com Golpe Pessoal;
- ao clicar em `ROLAR ATAQUE CRITICO`, os D6 de dano anteriores sao destruidos;
- um dano critico spawna os dados salvos multiplicados por x4: `8d6` sem Golpe Pessoal ou `12d6` com Golpe Pessoal;
- depois de um frame, cada dado recebe `randomize(jogador)`, impulso com `addForce` e giro com `addTorque`;
- quando todos os dados estao com `dado.resting == true`, o script le cada face com `dado.getRotationValue()`;
- o total dos D6 fisicos substitui a rolagem interna antiga de dano;
- se algum dado for removido ou nao parar a tempo, o dano nao e resolvido e o jogador recebe mensagem de erro.
- os dados spawnados recebem `measure_movement = false` para evitar rastro laranja/amarelo do Line Tool.

Regras numericas mantidas nesta feature:

- dano normal sem Golpe Pessoal: `2d6 + modificador de dano salvo`;
- dano normal com Golpe Pessoal: `3d6 + modificador de dano salvo`;
- dano critico sem Golpe Pessoal: `8d6 + modificador de dano salvo`;
- dano critico com Golpe Pessoal: `12d6 + modificador de dano salvo`;
- bonus numericos continuam nao sendo multiplicados no critico.

Se precisar ajustar onde os D6 aparecem, alterar `dadoDanoOffsetLocal` e `dadoDanoEspacamento`.
Se precisar ajustar o salto/giro dos D6, alterar `dadoDanoForca*` e `dadoDanoTorque*`.

## Resultados no chat

O primeiro campo do `resumoChat` deve usar `Player[cor].steam_name` quando disponivel. A cor do jogador (`White`, `Blue`, etc.) fica apenas como fallback se o nome Steam nao puder ser lido.

Resumos de ataque, dano e critico devem usar `printToAll(mensagem, CONFIG.corChat)` com o verde original `{r = 0.35, g = 1.00, b = 0.35}`. Antes do envio, os colchetes ASCII devem ser convertidos para `［` e `］`, pois o parser de BBCode do chat do TTS pode interpretar valores como `[18]` como marcacao e corromper mensagens posteriores. Mensagens do updater continuam com a cor padrao; `CONFIG.corErro` permanece reservado para erros.

Ataques e danos nao devem criar ou mostrar Global UI. O resultado aparece somente no chat, sem popup no centro da tela. O `ui.xml` permanece no repositorio apenas como referencia legada.

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
- Antes de usar `UPDATE` no TTS, garantir que `ataque_edward.lua` e `assets/edward_attack_panel.png` foram enviados para o branch `main` do GitHub.
