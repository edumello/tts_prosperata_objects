# Contexto tecnico — Edward

## Regras preservadas

- Ataque preparado: `+14`; despreparado: `+9`.
- Dano: `2d6+11`; critico `17-20/x4`.
- Ataque Poderoso: `-2 ataque`, `+5 dano`.
- Golpe Pessoal Passo do Carrasco: Preciso, Brutal, Avanco e Truque Secreto, custo `1 PM`.
- Ataque Especial: ate `2 PM` no nivel 6.
- Destruidor fica sempre ativo: dados de dano da arma que rolarem `1` ou `2`
  sao rerrolados uma vez, no dano normal e no critico.
- Preparada, Poderoso, Pesado, Golpe Pessoal, Especial e os quatro
  modificadores extras resetam depois de cada ataque concluido.
- Dano e critico usam a fotografia do ultimo ataque salvo.
- Resultados aparecem somente no chat, no verde original de Edward.
- Ataque Extra foi adquirido no nivel 6, mas nao deve ser automatizado nesta
  versao: sem botao, custo, fluxo, mensagem ou segunda rolagem.

## Interface

O painel usa Object UI XML autocontida no runtime. A imagem fisica e apenas decorativa. A migracao remove controles Classic UI antigos e preserva estado e transformacao do objeto.

## Propriedade dos dados

Dados criados pelo runtime recebem metadados com schema `1`, producer `edumello/tts_prosperata_objects:edward`, GUID do painel e tipo. Nenhum fluxo de limpeza usa nome, cor ou busca global de dados.

`LIMPAR DADOS` invalida rolagens em andamento, para os waits, destrói somente dados validados e preserva `state.ultimoAtaque`.

## Publicacao

O updater continua consultando os arquivos de `main`. A branch de UI deve ser validada com o Saved Object gerado antes de abrir o segundo PR.
