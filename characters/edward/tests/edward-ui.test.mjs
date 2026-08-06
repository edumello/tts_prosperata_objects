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
  "especial_pm_value",
  "mod_1_value",
  "mod_2_value",
  "mod_3_value",
  "mod_4_value",
  "preview_pm",
  "preview_attack",
  "preview_damage",
];

function normalize(value) {
  return value.replace(/^\uFEFF/, "").replace(/\r\n?/g, "\n").trimEnd();
}

function tagForId(xml, id) {
  const escaped = id.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = xml.match(new RegExp(`<([A-Za-z][\\w]*)\\b[^>]*\\bid="${escaped}"[^>]*>`));
  return match?.[1] ?? null;
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

test("dados recebem proveniencia e so passam pela limpeza do painel proprietario", async () => {
  const lua = normalize(await readFile(luaPath, "utf8"));
  assert.match(lua, /DICE_OWNER_PRODUCER\s*=\s*\n?\s*"edumello\/tts_prosperata_objects:edward"/);
  assert.match(lua, /dado\.setGMNotes/);
  assert.match(lua, /tostring\(dados\.ownerGuid or ""\) == guidDoPainel\(\)/);
  assert.match(lua, /dadoPertenceAoPainel\(dado, "attack"\)/);
  assert.match(lua, /dadoPertenceAoPainel\(dado, "damage"\)/);
  assert.doesNotMatch(lua, /getObjects\(\)[\s\S]{0,300}(?:D20 Ataque Edward|D6 Dano Edward)/);
});

test("manifesto e imagem correspondem ao canvas 2048x640", async () => {
  const [manifestText, png] = await Promise.all([
    readFile(manifestPath, "utf8"),
    readFile(imagePath),
  ]);
  const manifest = JSON.parse(manifestText);
  assert.equal(manifest.version, "2.0.0");
  assert.deepEqual(manifest.canvas, { width: 2048, height: 640 });
  assert.equal(png.toString("ascii", 1, 4), "PNG");
  assert.equal(png.readUInt32BE(16), 2048);
  assert.equal(png.readUInt32BE(20), 640);
});
