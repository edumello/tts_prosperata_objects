# Contrato da Object UI de Edward

## Canvas e orientacao

- Canvas logico: `1792x1024` (`7:4`), proximo ao painel de referencia.
- Escala calibrada no collider do Custom Tile: `0.19 0.20 1`.
- Rotacao: `0 0 180`, compensando o `rotY=180` do Saved Object.
- O PNG usa uma moldura medieval original de aco escuro, couro e bronze. A
  arte-fonte fica em `image_menu/source/edward_medieval_frame.png`.
- Cabecalho, divisores e secoes funcionais usam o mesmo canvas da Object UI.

## Controles

- Cada linha de ataque e um `<Button>` completo; o pill `ON/OFF` e apenas um
  indicador sem raycast sobre a mesma hitbox.
- As quatro acoes usam cards altos e independentes na faixa inferior.
- Nomes dos quatro extras usam `<InputField>`.
- Modificadores e PM usam botoes explicitos `-` e `+` com um `<Text>` de valor.
- Previews usam `<Text>` e nunca botoes sem acao.
- Todos os eventos passam por `uiDispatch` ou `uiEditModName`.
- Nao adicionar tooltips nativos: em objetos girados eles podem aparecer invertidos.

IDs estaveis: `toggle_*`, `especial_*`, `mod_name_1..4`, `mod_1..4_minus/plus/value`, `preview_*`, `roll_attack`, `roll_critical`, `roll_damage`, `clear_dice` e `update`.

## Sincronizacao

Edite `ui.xml` e rode `build.ps1`. Nao edite manualmente o bloco entre `BEGIN EMBEDDED OBJECT UI` e `END EMBEDDED OBJECT UI` em `ataque_edward.lua`.

Antes de entregar, rode build, testes Node, smoke MoonSharp e o Saved Object no TTS.
