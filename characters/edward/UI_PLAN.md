# Plano de manutencao da UI V1

Este arquivo descreve como manter a UI oficial do painel Edward.

Todos os caminhos deste arquivo sao relativos a `characters/edward/`, salvo quando indicado o contrario.

## Objetivo

Manter um painel funcional e facil de ajustar no Tabletop Simulator, com:

- nomes dos ataques no PNG;
- valores dinamicos em botoes Lua;
- quatro modificadores extras nomeaveis;
- previews de PM, ataque e dano;
- D20 fisico no `ROLAR ATAQUE`;
- Golpe Pessoal `Passo do Carrasco`, com Preciso usando 2d20 e Brutal alterando a quantidade de dados de dano;
- D6 fisicos em `ROLAR DANO` e `ROLAR ATAQUE CRITICO`;
- botoes separados para ataque normal, dano critico e dano normal;
- botao `UPDATE` para baixar do GitHub o script e a imagem publicados no branch `main`.

## Camadas

### PNG

Arquivo usado no TTS:

```text
assets/edward_attack_panel.png
```

Gerado por:

```text
image_menu/build_panel.ps1
```

Preview oficial:

```text
image_menu/exports/edward_attack_panel_v1.png
```

O PNG contem:

- moldura do painel;
- cabecalho `EDWARD`;
- nome da arma;
- secoes `ATAQUES`, `MOD. EXTRAS` e `PREVIA`;
- icones;
- nomes fixos dos ataques;
- caixas vazias para valores dinamicos.

O PNG nao deve conter:

- `ON` / `OFF`;
- valores de PM;
- valores de modificador;
- previews numericos;
- labels dos botoes de rolagem.

### Lua

Arquivo:

```text
ataque_edward.lua
```

O Lua cria:

- botoes clicaveis com `self.createButton`;
- inputs de nome com `self.createInput`;
- D20 fisico com `spawnObject`;
- D6 fisicos de dano com `spawnObject`;
- valores dinamicos;
- calculos de ataque/dano;
- mensagens no chat;
- resultado detalhado no XML global;
- update via `WebRequest.get()` usando os raw URLs do GitHub.

## Layout atual

Altura:

```lua
local ALTURA_BOTAO = 0.10
```

Escala:

```lua
escala = {0.20, 0.20, 0.20}
```

Se o usuario ajustar posicoes manualmente no Lua, atualizar tambem:

```text
image_menu/manifest.json
CONTEXT.md
```

## Mod. Extras

A coluna `MOD. EXTRAS` tem quatro linhas.

Cada linha tem:

- um input de nome;
- um botao de valor;
- icone de `+` no PNG.

Parametros dos inputs:

```lua
width = 760
height = 320
font_size = 180
```

Os valores usam clique esquerdo para `+1` e clique alternativo para `-1`.

Os valores sao zerados depois de rolar ataque. Os nomes permanecem.

## D20 fisico

`ROLAR ATAQUE` deve:

1. destruir o D20 de ataque anterior;
2. spawnar um novo `Die_20`, ou `2d20` quando `GOLPE PESSOAL` estiver ON;
3. aguardar um frame para o dado descongelar;
4. rolar cada dado com `randomize(jogador)`;
5. aplicar impulso com `addForce`;
6. aplicar giro com `addTorque`;
7. aguardar todos os dados ficarem em repouso;
8. ler cada resultado com `getRotationValue()`;
9. usar esse resultado como o d20 do ataque, ou o maior resultado quando forem `2d20`.

Configuracao no Lua:

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

Para mover o dado fisico, ajustar `dadoAtaqueOffsetLocal`.
Para deixar a rolagem mais forte ou mais fraca, ajustar `dadoAtaqueForca*` e `dadoAtaqueTorque*`.

## D6 fisicos de dano

`ROLAR DANO` deve:

1. destruir os D6 de dano anteriores;
2. spawnar a quantidade de dados salva no ataque: `2d6` normal, ou `3d6` com Golpe Pessoal;
3. aguardar um frame para os dados descongelarem;
4. rolar cada dado com `randomize(jogador)`;
5. aplicar impulso com `addForce`;
6. aplicar giro com `addTorque`;
7. aguardar todos os dados ficarem em repouso;
8. ler cada resultado com `getRotationValue()`;
9. resolver `2d6 + modificador de dano salvo`.

`ROLAR ATAQUE CRITICO` deve seguir o mesmo fluxo, multiplicando a quantidade salva de dados da arma por x4: `8d6` sem Golpe Pessoal, ou `12d6` com Golpe Pessoal.

Configuracao no Lua:

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

Para mover os dados fisicos, ajustar `dadoDanoOffsetLocal` e `dadoDanoEspacamento`.
Para deixar a rolagem mais forte ou mais fraca, ajustar `dadoDanoForca*` e `dadoDanoTorque*`.

## Ordem dos botoes

Manter a ordem:

```text
preparada
poderoso
especial
especialPM
modExtra
pesado
golpePessoal
rolarAtaque
critico
rolarDano
previewPM
previewAtaque
previewDano
modExtra2
modExtra3
modExtra4
updateGithub
```

Validacao esperada:

```text
BUTTON_ORDER == CONTROLES
COUNT = 17
```

## Update via GitHub

O botao `UPDATE` fica no topo direito do painel e usa:

```text
https://raw.githubusercontent.com/edumello/tts_prosperata_objects/main/characters/edward/ataque_edward.lua
https://raw.githubusercontent.com/edumello/tts_prosperata_objects/main/characters/edward/assets/edward_attack_panel.png
```

Antes de usar o botao no Tabletop Simulator, garantir que as mudancas foram commitadas e enviadas para o branch `main`. O botao nao le arquivos locais: ele sempre baixa a versao publicada no GitHub.

## Regenerar o painel

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File image_menu\build_panel.ps1
```

A partir da raiz do repo:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File characters\edward\image_menu\build_panel.ps1
```

Esse comando atualiza:

```text
image_menu/exports/edward_attack_panel_v1.png
assets/edward_attack_panel.png
```

## Checklist antes de finalizar uma mudanca

1. `BUTTON_ORDER == CONTROLES`.
2. `COUNT = 17`.
3. `image_menu/manifest.json` abre como JSON valido.
4. `ui.xml` mantem `resultadoAtaque` e `textoAtaque`.
5. `ataque_edward.lua` usa `UI` direto para o overlay de resultado, porque ele deve ser popup de tela via Global UI.
6. `assets/edward_attack_panel.png` foi regenerado quando o PNG mudou.
7. `ROLAR ATAQUE` usa `spawnObject` + `getRotationValue`, nao `math.random(1, 20)`.
8. `ROLAR DANO` e `ROLAR ATAQUE CRITICO` usam D6 fisicos, nao rolagem interna `math.random(1, lados)`.
9. Regras e valores do personagem nao foram alterados sem registro.
10. Se a mudanca deve ser recebida pelo botao `UPDATE`, o repo foi enviado para o GitHub depois da validacao.
