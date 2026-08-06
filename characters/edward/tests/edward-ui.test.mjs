import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import test from "node:test";

const here = dirname(fileURLToPath(import.meta.url));
const root = resolve(here, "..");
const uiPath = join(root, "ui.xml");
const luaPath = join(root, "ataque_edward.lua");
const manifestPath = join(root, "image_menu", "manifest.json");
const imagePath = join(root, "assets", "edward_attack_panel.png");
const sourceImagePath = join(root, "image_menu", "source", "edward_medieval_frame.png");

const requiredButtons = [
  "update",
  "toggle_preparada",
  "toggle_poderoso",
  "toggle_pesado",
  "toggle_golpe_pessoal",
  "especial_mode",
  "especial_pm_minus",
  "especial_pm_plus",
  "mod_1_minus",
  "mod_1_plus",
  "mod_2_minus",
  "mod_2_plus",
  "mod_3_minus",
  "mod_3_plus",
  "mod_4_minus",
  "mod_4_plus",
  "roll_attack",
  "roll_critical",
  "roll_damage",
  "clear_dice",
];

const requiredInputs = ["mod_name_1", "mod_name_2", "mod_name_3", "mod_name_4"];
const requiredReadouts = [
  "update_label",
  "label_preparada",
  "label_poderoso",
  "label_pesado",
  "label_golpe_pessoal",
  "state_preparada",
  "state_poderoso",
  "state_pesado",
  "state_golpe_pessoal",
  "especial_pm_value",
  "mod_1_value",
  "mod_2_value",
  "mod_3_value",
  "mod_4_value",
  "preview_pm",
  "preview_attack",
  "preview_damage",
  "roll_attack_title",
  "roll_attack_subtitle",
  "roll_critical_title",
  "roll_critical_subtitle",
  "roll_damage_title",
  "roll_damage_subtitle",
  "clear_dice_title",
  "clear_dice_subtitle",
];

function normalize(value) {
  return value.replace(/^\uFEFF/, "").replace(/\r\n?/g, "\n").trimEnd();
}

function tagForId(xml, id) {
  const escaped = id.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = xml.match(new RegExp(`<([A-Za-z][\\w]*)\\b[^>]*\\bid="${escaped}"[^>]*>`));
  return match?.[1] ?? null;
}

function tagSourceForId(xml, id) {
  const escaped = id.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  return xml.match(new RegExp(`<[A-Za-z][\\w]*\\b[^>]*\\bid="${escaped}"[^>]*>`))?.[0] ?? null;
}

function numericAttribute(tag, name) {
  const value = tag?.match(new RegExp(`\\b${name}="([0-9]+)"`))?.[1];
  assert.ok(value, `${name} ausente em ${tag}`);
  return Number(value);
}

function positionForId(xml, id) {
  const tag = tagSourceForId(xml, id);
  assert.ok(tag, `${id} ausente`);
  const offset = tag.match(/\boffsetXY="([0-9]+) -([0-9]+)"/);
  assert.ok(offset, `offsetXY invalido em ${id}`);
  return {
    x: Number(offset[1]),
    y: Number(offset[2]),
    width: numericAttribute(tag, "width"),
    height: numericAttribute(tag, "height"),
  };
}

function validateXmlShape(xml) {
  const withoutComments = xml.replace(/<!--[\s\S]*?-->/g, "");
  const tags = withoutComments.match(/<[^>]+>/g) ?? [];
  const stack = [];

  for (const raw of tags) {
    if (/^<\?/.test(raw) || /^<!/.test(raw) || /\/>$/.test(raw)) continue;
    const closing = raw.match(/^<\/\s*([\w]+)/);
    if (closing) {
      assert.equal(stack.pop(), closing[1], `tag de fechamento inesperada: ${raw}`);
      continue;
    }
    const opening = raw.match(/^<\s*([\w]+)/);
    if (opening) stack.push(opening[1]);
  }

  assert.deepEqual(stack, [], "XML contem tags nao fechadas");
}

test("Object UI e XML valido, com IDs unicos e controles reais", async () => {
  const ui = normalize(await readFile(uiPath, "utf8"));
  validateXmlShape(ui);
  assert.doesNotMatch(ui, /\btooltip\s*=/i);

  const ids = [...ui.matchAll(/\bid="([^"]+)"/g)].map((match) => match[1]);
  assert.equal(new Set(ids).size, ids.length, "IDs XML devem ser unicos");

  for (const id of requiredButtons) assert.equal(tagForId(ui, id), "Button", `${id} deve ser Button`);
  for (const id of requiredInputs) assert.equal(tagForId(ui, id), "InputField", `${id} deve ser InputField`);
  for (const id of requiredReadouts) assert.equal(tagForId(ui, id), "Text", `${id} deve ser Text`);

  const buttonTags = (ui.match(/<Button\b[^>]*>/g) ?? []).filter((tag) => /\bid="/.test(tag));
  for (const tag of buttonTags) assert.match(tag, /\bonClick="uiDispatch"/);
});

test("runtime incorpora exatamente a UI canonica e remove criacao Classic UI", async () => {
  const [ui, lua] = await Promise.all([
    readFile(uiPath, "utf8").then(normalize),
    readFile(luaPath, "utf8").then(normalize),
  ]);
  const embedded = lua.match(
    /-- BEGIN EMBEDDED OBJECT UI\nlocal OBJECT_UI_XML = \[==\[\n([\s\S]*?)\n\]==\]\n-- END EMBEDDED OBJECT UI/,
  );
  assert.ok(embedded, "bloco de Object UI incorporado ausente");
  assert.equal(normalize(embedded[1]), ui);
  assert.doesNotMatch(lua, /self\.(?:createButton|createInput|editButton|editInput)\s*\(/);
  assert.match(lua, /self\.UI\.setXml\(OBJECT_UI_XML\)/);
  assert.doesNotMatch(lua, /broadcastToAll\s*\(/);
});

test("grade 7:4 mantem controles dentro das colunas e acoes em faixa propria", async () => {
  const ui = normalize(await readFile(uiPath, "utf8"));
  assert.match(ui, /id="edwardConsole" width="1792" height="1024"/);
  assert.match(ui, /scale="0\.19 0\.20 1"/);
  const inside = (id, bounds) => {
    const item = positionForId(ui, id);
    assert.ok(item.x >= bounds.left, `${id} invade a margem esquerda`);
    assert.ok(item.x + item.width <= bounds.right, `${id} invade a margem direita`);
    assert.ok(item.y >= bounds.top, `${id} invade o titulo da secao`);
    assert.ok(item.y + item.height <= bounds.bottom, `${id} invade a area inferior`);
  };

  for (const id of ["toggle_preparada", "toggle_poderoso", "toggle_pesado", "toggle_golpe_pessoal", "especial_mode", "especial_pm_plus"])
    inside(id, { left: 30, right: 600, top: 195, bottom: 600 });

  for (const id of ["mod_name_1", "mod_1_minus", "mod_1_value", "mod_1_plus", "mod_name_4", "mod_4_plus"])
    inside(id, { left: 625, right: 1150, top: 195, bottom: 600 });

  for (const id of ["preview_pm", "preview_attack", "preview_damage"])
    assert.equal(tagForId(ui, id), "Text");

  for (const id of ["roll_attack", "roll_critical", "roll_damage", "clear_dice"])
    inside(id, { left: 90, right: 1700, top: 640, bottom: 820 });
});

test("estados usam pills legiveis e cores fixadas pelo runtime", async () => {
  const [ui, lua] = await Promise.all([
    readFile(uiPath, "utf8").then(normalize),
    readFile(luaPath, "utf8").then(normalize),
  ]);
  assert.match(ui, /class="statePill" color="#292C30" outline="#6A604A"/);
  assert.match(ui, /id="state_preparada" text="OFF"[\s\S]*?color="#C8CBD0"/);
  assert.match(lua, /uiSet\(textoId, "text", textoToggle\(ativo\)\)/);
  assert.match(lua, /ativo and "#9BE6B1" or "#C8CBD0"/);
  assert.match(lua, /return "OFF"/);
  assert.match(lua, /return "ON"/);
});

test("acoes usam sprites arredondados e rotulos sem bloquear a hitbox", async () => {
  const ui = normalize(await readFile(uiPath, "utf8"));
  const actionClasses = {
    roll_attack: "blueAction",
    roll_critical: "orangeAction",
    roll_damage: "redAction",
    clear_dice: "clearAction",
  };
  for (const [id, className] of Object.entries(actionClasses)) {
    const tag = tagSourceForId(ui, id);
    assert.match(tag, new RegExp(`\\bclass="${className}"`));
    assert.match(tag, /\btext=""/);
    assert.match(ui, new RegExp(`<Button class="${className}"[^>]*image="https://raw\\.githubusercontent\\.com/[^"]+"[\\s\\S]*?transition="ColorTint"`));
  }
  for (const id of ["roll_attack_title", "roll_attack_subtitle", "roll_critical_title", "roll_critical_subtitle", "roll_damage_title", "roll_damage_subtitle", "clear_dice_title", "clear_dice_subtitle"])
    assert.match(tagSourceForId(ui, id), /\braycastTarget="false"/);
});

test("limpeza cancela rolagens sem consumir o ataque salvo", async () => {
  const lua = normalize(await readFile(luaPath, "utf8"));
  const clearBlock = lua.match(/function limparDados\([\s\S]*?\nend\n\n-- =+\n-- ROLAR ATAQUE/);
  assert.ok(clearBlock, "funcao limparDados nao encontrada");
  assert.match(clearBlock[0], /dadoAtaqueRolagemId = dadoAtaqueRolagemId \+ 1/);
  assert.match(clearBlock[0], /dadoDanoRolagemId = dadoDanoRolagemId \+ 1/);
  assert.match(clearBlock[0], /destruirDadoAtaqueAtual\(\)/);
  assert.match(clearBlock[0], /destruirDadosDanoAtuais\(\)/);
  assert.doesNotMatch(clearBlock[0], /descartarUltimoAtaque\(\)/);
});

test("ataque reseta selecoes e preserva os quatro modificadores extras", async () => {
  const lua = normalize(await readFile(luaPath, "utf8"));
  assert.match(lua, /resetarAposAtaque\s*=\s*true/);
  assert.match(lua, /resetarModExtraAposAtaque\s*=\s*false/);
  const resetBlock = lua.match(/local function resetarSelecoesAposAtaque\(\)[\s\S]*?\nend\n\n-- =+\n-- CARREGAMENTO/);
  assert.ok(resetBlock, "funcao de reset das selecoes ausente");
  for (const field of ["preparada", "poderoso", "pesado", "golpePessoal"])
    assert.match(resetBlock[0], new RegExp(`state\\.${field} = false`));
  assert.match(resetBlock[0], /state\.especialModo = 0/);
  assert.match(resetBlock[0], /if CONFIG\.resetarModExtraAposAtaque then/);
});

test("dados recebem proveniencia e so passam pela limpeza do painel proprietario", async () => {
  const lua = normalize(await readFile(luaPath, "utf8"));
  assert.match(lua, /DICE_OWNER_PRODUCER\s*=\s*\n?\s*"edumello\/tts_prosperata_objects:edward"/);
  assert.match(lua, /dado\.setGMNotes/);
  assert.match(lua, /tostring\(dados\.ownerGuid or ""\) == guidDoPainel\(\)/);
  assert.match(lua, /dadoPertenceAoPainel\(dado, "attack"\)/);
  assert.match(lua, /dadoPertenceAoPainel\(dado, "damage"\)/);
  assert.doesNotMatch(lua, /getObjects\(\)[\s\S]{0,300}(?:D20 Ataque Edward|D6 Dano Edward)/);
});

test("manifesto, fonte medieval e imagem correspondem ao canvas 1792x1024", async () => {
  const [manifestText, png, sourcePng] = await Promise.all([
    readFile(manifestPath, "utf8"),
    readFile(imagePath),
    readFile(sourceImagePath),
  ]);
  const manifest = JSON.parse(manifestText);
  assert.equal(manifest.version, "3.2.1");
  assert.deepEqual(manifest.canvas, { width: 1792, height: 1024 });
  assert.deepEqual(manifest.objectUi.scale, [0.19, 0.2, 1]);
  assert.equal(png.toString("ascii", 1, 4), "PNG");
  assert.equal(png.readUInt32BE(16), 1792);
  assert.equal(png.readUInt32BE(20), 1024);
  assert.equal(sourcePng.toString("ascii", 1, 4), "PNG");
  assert.equal(sourcePng.readUInt32BE(16), 1659);
  assert.equal(sourcePng.readUInt32BE(20), 948);
});
