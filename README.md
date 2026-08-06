# Tabletop Simulator RPG Tools

Repositorio para scripts, paineis e assets de personagens usados na mesa de RPG no Tabletop Simulator.

## Estrutura

```text
characters/
  edward/
    ataque_edward.lua
    ui.xml
    assets/
    image_menu/
    CONTEXT.md
    UI_PLAN.md
```

Cada personagem deve ficar em sua propria pasta dentro de `characters/`, com script, assets, documentacao e ferramentas de geracao isolados.

## Personagens

- [Edward](characters/edward/README.md)

## Convencoes

- Use nomes de pastas sem espaco e sem acento para facilitar URLs publicas no GitHub.
- Mantenha `CONTEXT.md` atualizado dentro da pasta do personagem sempre que mudar regras, layout ou fluxo de exportacao.
- Resultados de ataque e dano do Edward sao publicados somente no chat do TTS.
