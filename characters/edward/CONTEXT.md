# Contexto tecnico — Edward

## Regras preservadas

- Edward esta no nivel de personagem 9: Guerreiro 7 / Barbaro 2.
- Arma: Espada de Execucao de Adamante.
- Ataque preparado: `+15`; despreparado: `+10` pela penalidade de `-5`.
- Dano: `2d8+11`; critico `17-20/x4`.
- Ataque Poderoso: `-2 ataque`, `+5 dano`.
- Golpe Pessoal Passo do Carrasco: Preciso, Brutal, Avanco e Truque Secreto, custo `1 PM`.
- Ataque Especial: ate `2 PM`, conforme Guerreiro 7.
- Furia e um toggle persistente de cena: `+2 ataque` e `+2 dano` enquanto
  estiver ativa. Seus `2 PM` de ativacao sao controlados manualmente e nao
  entram na previa nem no PM declarado pela rolagem.
- Destruidor fica sempre ativo: dados de dano da arma que rolarem `1` ou `2`
  sao rerrolados uma vez, no dano normal e no critico.
- Preparada, Poderoso, Pesado, Golpe Pessoal, Especial e os quatro
  modificadores extras resetam depois de cada ataque concluido.
- Furia nao reseta depois do ataque e e salva/carregada junto com o painel.
- Dano e critico usam a fotografia do ultimo ataque salvo.
- Resultados aparecem somente no chat, no verde original de Edward.
- Frenesi e Ataque Extra nao sao automatizados nesta versao: sem botoes,
  custos, mensagens ou segundas rolagens automaticas.

## Interface

O painel usa Object UI XML autocontida no runtime. A imagem fisica e apenas decorativa. A migracao remove controles Classic UI antigos e preserva estado e transformacao do objeto.

A coluna de ataques segue a ordem Preparada, Poderoso, Pesado, Golpe
Pessoal, Furia e Especial. `ui.xml` e a fonte canonica; `build.ps1` incorpora
esse XML em `ataque_edward.lua` para que o updater continue autocontido.

## Propriedade dos dados

Dados criados pelo runtime recebem metadados com schema `1`, producer `edumello/tts_prosperata_objects:edward`, GUID do painel e tipo. Nenhum fluxo de limpeza usa nome, cor ou busca global de dados.

`LIMPAR DADOS` invalida rolagens em andamento, para os waits, destrói somente dados validados e preserva `state.ultimoAtaque`.

## Publicacao

O updater continua consultando os arquivos de `main`. A branch de UI deve ser validada com o Saved Object gerado antes de abrir o segundo PR.
