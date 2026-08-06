# Contrato da Object UI de Edward

## Canvas e orientacao

- Canvas logico: `2048x640`.
- Escala: `0.25 0.25 1`.
- Rotacao: `0 0 180`, compensando o `rotY=180` do Saved Object.
- O PNG contem somente moldura, cabecalho e secoes estaticas.

## Controles

- Ataques e acoes usam `<Button>` com hitbox igual ao card visivel.
- Nomes dos quatro extras usam `<InputField>`.
- Modificadores e PM usam botoes explicitos `-` e `+` com um `<Text>` de valor.
- Previews usam `<Text>` e nunca botoes sem acao.
- Todos os eventos passam por `uiDispatch` ou `uiEditModName`.
- Nao adicionar tooltips nativos: em objetos girados eles podem aparecer invertidos.

IDs estaveis: `toggle_*`, `especial_*`, `mod_name_1..4`, `mod_1..4_minus/plus/value`, `preview_*`, `roll_attack`, `roll_critical`, `roll_damage`, `clear_dice` e `update`.

## Sincronizacao

Edite `ui.xml` e rode `build.ps1`. Nao edite manualmente o bloco entre `BEGIN EMBEDDED OBJECT UI` e `END EMBEDDED OBJECT UI` em `ataque_edward.lua`.

Antes de entregar, rode build, testes Node, smoke MoonSharp e o Saved Object no TTS.
