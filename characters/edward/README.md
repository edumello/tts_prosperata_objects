# Edward Attack Panel

Painel de Tabletop Simulator para automatizar os ataques de Edward, Humano Soldado Guerreiro 5, com Espada de Execucao.

## Arquitetura

- `ataque_edward.lua`: runtime autocontido usado pelo objeto e pelo updater.
- `ui.xml`: fonte canonica da Object UI XML.
- `build.ps1`: gera a imagem, incorpora o XML no Lua e produz um Saved Object de teste.
- `assets/edward_attack_panel.png`: fundo decorativo sem controles ou valores duplicados.
- `tests/`: validacao estrutural e smoke do runtime no MoonSharp do TTS.

Todos os controles sao componentes XML reais. O carregamento remove botoes e inputs da Classic UI deixados por versoes anteriores, sem recarregar ou mover o Custom Tile.

## Build e testes

Na raiz do repositorio:

```powershell
npm run build:edward
npm test
npm run test:smoke
```

O build gera `characters/edward/dist/Edward_Attack_Panel_UI_Test.json`. Para testar assets de uma branch ainda nao incorporada, informe seu raw URL:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File characters/edward/build.ps1 `
  -AssetUrl "https://raw.githubusercontent.com/edumello/tts_prosperata_objects/refs/heads/agent/edward-panel-ui/characters/edward/assets/edward_attack_panel.png"
```

## Limpar dados

Cada dado recebe em `GMNotes` o projeto produtor, o GUID do painel proprietario e o tipo `attack` ou `damage`. `LIMPAR DADOS`:

- cancela waits e callbacks pendentes;
- remove apenas dados pertencentes a essa instancia;
- preserva o ultimo ataque e todos os modificadores;
- ignora dados manuais, dados antigos sem marca e dados de outra copia.

## Update

`UPDATE` baixa de `main` o runtime autocontido e a imagem, aplica ambos e recarrega o mesmo objeto. Como o XML esta incorporado no Lua, nao existe uma terceira requisicao nem risco de versoes incompatíveis entre interface e logica.
