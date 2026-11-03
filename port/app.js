"use strict";

(() => {
  const STORAGE_KEY = "fieldplot.c2ip.workspace.v1";
  const HOSTILITY = [
    { value: 1501, label: "Unknown", color: "#e2c36d" },
    { value: 1502, label: "Assumed friend", color: "#70a9de" },
    { value: 1503, label: "Friend", color: "#70a9de" },
    { value: 1504, label: "Neutral", color: "#6bc6a0" },
    { value: 1505, label: "Suspect", color: "#df837e" },
    { value: 1506, label: "Hostile", color: "#df837e" }
  ];
  const ECHELONS = [
    [1101, "Team", "•"], [1102, "Squad", "••"], [1103, "Section", "•••"],
    [1104, "Platoon", "|||"], [1105, "Company", "∥"], [1106, "Battalion", "Ⅱ"],
    [1107, "Regiment", "Ⅲ"], [1108, "Brigade", "Ⅹ"], [1109, "Division", "ⅩⅩ"],
    [1110, "Corps", "ⅩⅩⅩ"], [1111, "Army", "ⅩⅩⅩⅩ"],
    [1112, "Army group", "Army gp"], [1113, "Theater", "Theater"], [1114, "Command", "Command"]
  ];
  const UNIT_TYPES = [
    ["", "Not specified"], ["120300", "Amphibious"], ["120400", "Antitank / antiarmor"],
    ["120500", "Armor / mechanized"], ["120600", "Army aviation"], ["120800", "Aviation, fixed wing"],
    ["121100", "Infantry"], ["121200", "Observer"], ["121300", "Reconnaissance"],
    ["121400", "Sea, air, land (SEAL)"], ["121500", "Sniper"], ["130300", "Field artillery"],
    ["140700", "Engineer"]
  ];
  const TOOLS = [
    { id: "select", label: "Select / move", glyph: "↖" },
    { id: "unit", label: "Place unit", glyph: "▣" },
    { id: "line", label: "Line", glyph: "╱", code: "Line", type: 1002 },
    { id: "arrow", label: "Arrow", glyph: "➝", code: "900000", type: 0 },
    { id: "axis", label: "Axis advance", glyph: "➤", code: "151403", type: 1010 },
    { id: "ambush", label: "Ambush", glyph: "⌁", code: "141700", type: 1011 },
    { id: "circle", label: "Circle", glyph: "◯", code: "Circle", type: 1012 },
    { id: "rectangle", label: "Rectangle", glyph: "□", code: "Rectangle", type: 1004 },
    { id: "freehand", label: "Freehand", glyph: "〰", code: "FreeHand", type: 1006 },
    { id: "breach", label: "Breach", glyph: "⋈", code: "340200", type: 1015 }
  ];

  const canvas = document.getElementById("editor-canvas");
  const ctx = canvas.getContext("2d");
  const canvasWrap = document.getElementById("canvas-wrap");
  const elements = {
    name: document.getElementById("document-name"),
    saveState: document.getElementById("save-state"),
    orgTab: document.getElementById("org-tab"),
    overlayTab: document.getElementById("overlay-tab"),
    contentsTitle: document.getElementById("contents-title"),
    count: document.getElementById("item-count"),
    list: document.getElementById("item-list"),
    addUnit: document.getElementById("add-unit-button"),
    toolsSection: document.getElementById("tools-section"),
    toolList: document.getElementById("tool-list"),
    canvasEyebrow: document.getElementById("canvas-eyebrow"),
    canvasTitle: document.getElementById("canvas-title"),
    help: document.getElementById("canvas-help"),
    emptyHint: document.getElementById("empty-hint"),
    inspectorTitle: document.getElementById("inspector-title"),
    inspectorSubtitle: document.getElementById("inspector-subtitle"),
    inspectorContent: document.getElementById("inspector-content"),
    inspectorEmpty: document.getElementById("inspector-empty"),
    zoom: document.getElementById("zoom-label"),
    toast: document.getElementById("toast"),
    clearMap: document.getElementById("clear-map-button")
  };

  let state = loadLocalState();
  let zoom = 1;
  let backgroundImage = null;
  let toastTimer = 0;
  let drag = null;

  function loadLocalState() {
    try {
      const saved = localStorage.getItem(STORAGE_KEY);
      return saved ? normalizeDocument(JSON.parse(saved)) : newDocument();
    } catch (error) {
      console.error("Could not read the saved C2IP workspace.", error);
      return newDocument();
    }
  }

  function newDocument() {
    return {
      name: "Untitled operation",
      mode: "org",
      units: [],
      actions: [],
      references: [],
      selectedUnitId: null,
      selectedActionId: null,
      activeTool: "select"
    };
  }

  function field(source, name, fallback) {
    if (!source || typeof source !== "object") return fallback;
    const key = Object.keys(source).find(candidate => candidate.toLowerCase() === name.toLowerCase());
    return key === undefined || source[key] === null ? fallback : source[key];
  }

  function list(value) {
    if (Array.isArray(value)) return value;
    return value && typeof value === "object" ? [value] : [];
  }

  function number(value, fallback = 0) {
    const result = Number(value);
    return Number.isFinite(result) ? result : fallback;
  }

  function normalizeUnit(raw, index) {
    return {
      id: `unit-${Date.now()}-${index}-${Math.random().toString(36).slice(2, 7)}`,
      unitName: String(field(raw, "UnitName", `Unit ${index + 1}`)),
      unitType: number(field(raw, "UnitType", 0)),
      unitTypeCode: String(field(raw, "UnitTypeCode", "")),
      echelon: number(field(raw, "Echelon", 1100)),
      hostility: number(field(raw, "Hostility", 1501)),
      isHQ: Boolean(number(field(raw, "IsHQ", 0))),
      xPos: number(field(raw, "xPos", 60 + (index % 4) * 145)),
      yPos: number(field(raw, "yPos", 55 + Math.floor(index / 4) * 100)),
      treePos: number(field(raw, "TreePos", index + 1)),
      markForDisbl: Boolean(number(field(raw, "markForDisbl", 0)))
    };
  }

  function actionPoints(raw) {
    const nested = field(raw, "points", field(raw, "ActionPoints", null));
    if (Array.isArray(nested)) {
      return nested.flatMap(point => {
        const x = field(point, "x", field(point, "xPos", null));
        const y = field(point, "y", field(point, "yPos", null));
        return point && Number.isFinite(Number(x)) && Number.isFinite(Number(y))
          ? [{ x: number(x), y: number(y) }]
          : [];
      });
    }
    const xs = field(raw, "XPOS", []);
    const ys = field(raw, "YPOS", []);
    if (!Array.isArray(xs) || !Array.isArray(ys)) return [];
    return xs.map((x, i) => ({ x: number(x), y: number(ys[i]) }))
      .filter(p => p.x !== 0 || p.y !== 0);
  }

  function normalizeAction(raw, index) {
    const points = actionPoints(raw);
    return {
      id: `action-${Date.now()}-${index}-${Math.random().toString(36).slice(2, 7)}`,
      actionName: String(field(raw, "ActionName", `Action ${index + 1}`)),
      actionType: number(field(raw, "ActionType", 0)),
      actionTypeCode: String(field(raw, "ActionTypeCode", "Line")),
      points,
      editableText: String(field(raw, "editableText", ""))
    };
  }

  function normalizeDocument(input) {
    if (!input || typeof input !== "object") throw new Error("The selected file is not a C2IP JSON object.");
    const data = field(input, "TaskOrg", field(input, "Overlay", input));
    if (!data || typeof data !== "object") throw new Error("The file does not contain a TaskOrg or Overlay object.");
    const mode = field(input, "mode", field(input, "Overlay", null) ? "overlay" : "org");
    return {
      name: String(field(data, "name", field(data, "C2IPName", "Imported C2IP"))),
      mode: mode === "overlay" ? "overlay" : "org",
      units: list(field(data, "Units", [])).map(normalizeUnit),
      actions: list(field(data, "Actions", [])).map(normalizeAction),
      references: list(field(data, "refC2IPs", [])).filter(Boolean),
      selectedUnitId: null,
      selectedActionId: null,
      activeTool: "select"
    };
  }

  function saveLocal() {
    try {
      const serializable = { ...state, selectedUnitId: null, selectedActionId: null, activeTool: "select" };
      localStorage.setItem(STORAGE_KEY, JSON.stringify(serializable));
      elements.saveState.textContent = "Saved locally";
      elements.saveState.classList.remove("unsaved");
    } catch (error) {
      elements.saveState.textContent = "Local save unavailable";
      console.error("Could not save this workspace in browser storage.", error);
    }
  }

  function changed() {
    elements.saveState.textContent = "Saving…";
    window.clearTimeout(changed.timer);
    changed.timer = window.setTimeout(() => {
      saveLocal();
      render();
    }, 120);
  }

  function notify(message) {
    elements.toast.textContent = message;
    elements.toast.classList.add("visible");
    window.clearTimeout(toastTimer);
    toastTimer = window.setTimeout(() => elements.toast.classList.remove("visible"), 2600);
  }

  function colorForHostility(value) {
    return (HOSTILITY.find(item => item.value === Number(value)) || HOSTILITY[0]).color;
  }

  function hostilityName(value) {
    return (HOSTILITY.find(item => item.value === Number(value)) || HOSTILITY[0]).label;
  }

  function echelonName(value) {
    return (ECHELONS.find(item => item[0] === Number(value)) || [0, "Not specified"])[1];
  }

  function toolForAction(action) {
    const code = String(action.actionTypeCode);
    const legacyTools = {
      "141700": "ambush",
      "151400": "axis",
      "151401": "axis",
      "151402": "axis",
      "151403": "axis",
      "151404": "axis",
      "151405": "axis",
      "151406": "axis",
      "151407": "axis",
      "151408": "axis",
      "340200": "breach"
    };
    const mapped = legacyTools[code];
    return TOOLS.find(tool => tool.code === code) ||
      TOOLS.find(tool => tool.id === mapped) ||
      TOOLS.find(tool => tool.id === "line");
  }

  function render() {
    elements.name.textContent = state.name;
    document.title = `${state.name} — Fieldplot`;
    const overlay = state.mode === "overlay";
    elements.orgTab.classList.toggle("active", !overlay);
    elements.overlayTab.classList.toggle("active", overlay);
    elements.orgTab.setAttribute("aria-selected", String(!overlay));
    elements.overlayTab.setAttribute("aria-selected", String(overlay));
    elements.contentsTitle.textContent = overlay ? "Map items" : "Units";
    elements.addUnit.querySelector("span").textContent = overlay ? "Add unit" : "Add unit";
    elements.toolsSection.hidden = !overlay;
    elements.canvasEyebrow.textContent = overlay ? "SITUATION OVERLAY" : "ORDER OF BATTLE";
    elements.canvasTitle.textContent = overlay ? "Map overlay" : "Organization chart";
    elements.help.textContent = overlay
      ? "Choose a tool, then click or drag on the map · Select items to move or edit"
      : "Drag units to reposition · Select a unit to edit its details";
    elements.count.textContent = String(state.units.length + (overlay ? state.actions.length : 0));
    renderList();
    renderTools();
    renderInspector();
    elements.emptyHint.hidden = state.units.length > 0 || state.actions.length > 0;
    canvasWrap.classList.toggle("drawing", overlay && state.activeTool !== "select");
    elements.zoom.textContent = `${Math.round(zoom * 100)}%`;
    drawCanvas();
  }

  function renderList() {
    const items = state.mode === "overlay"
      ? [...state.units.map(item => ({ kind: "unit", item })), ...state.actions.map(item => ({ kind: "action", item }))]
      : state.units.map(item => ({ kind: "unit", item }));
    elements.list.replaceChildren();
    for (const { kind, item } of items) {
      const selected = kind === "unit" ? item.id === state.selectedUnitId : item.id === state.selectedActionId;
      const button = document.createElement("button");
      button.type = "button";
      button.className = `list-item${selected ? " selected" : ""}`;
      const dot = document.createElement("i");
      dot.className = "unit-dot";
      dot.style.backgroundColor = kind === "unit" ? colorForHostility(item.hostility) : "var(--accent)";
      const name = document.createElement("span");
      name.className = "list-item-name";
      name.textContent = kind === "unit" ? item.unitName : item.actionName;
      const meta = document.createElement("span");
      meta.className = "list-item-meta";
      meta.textContent = kind === "unit" ? echelonName(item.echelon) : (toolForAction(item)?.label || "Action");
      button.append(dot, name, meta);
      button.addEventListener("click", () => selectItem(kind, item.id));
      elements.list.append(button);
    }
  }

  function renderTools() {
    elements.toolList.replaceChildren();
    for (const tool of TOOLS) {
      const button = document.createElement("button");
      button.type = "button";
      button.className = `tool-button${state.activeTool === tool.id ? " active" : ""}`;
      const glyph = document.createElement("span");
      glyph.className = "tool-glyph";
      glyph.textContent = tool.glyph;
      const label = document.createElement("span");
      label.textContent = tool.label;
      button.append(glyph, label);
      button.addEventListener("click", () => {
        state.activeTool = tool.id;
        state.selectedUnitId = null;
        state.selectedActionId = null;
        render();
      });
      elements.toolList.append(button);
    }
    elements.clearMap.hidden = !backgroundImage;
  }

  function makeField(label, control, hint) {
    const wrapper = document.createElement("div");
    wrapper.className = "field";
    const title = document.createElement("label");
    title.textContent = label;
    title.htmlFor = control.id;
    wrapper.append(title, control);
    if (hint) {
      const note = document.createElement("span");
      note.className = "small-note";
      note.textContent = hint;
      wrapper.append(note);
    }
    return wrapper;
  }

  function inputControl(id, value, onChange, type = "text") {
    const input = document.createElement("input");
    input.id = id;
    input.type = type;
    input.value = String(value);
    input.addEventListener("change", () => onChange(input.value));
    return input;
  }

  function selectControl(id, value, options, onChange) {
    const select = document.createElement("select");
    select.id = id;
    for (const option of options) {
      const element = document.createElement("option");
      element.value = String(option.value);
      element.textContent = option.label;
      select.append(element);
    }
    select.value = String(value);
    select.addEventListener("change", () => onChange(select.value));
    return select;
  }

  function renderInspector() {
    elements.inspectorContent.replaceChildren();
    const unit = state.units.find(item => item.id === state.selectedUnitId);
    const action = state.actions.find(item => item.id === state.selectedActionId);
    const item = unit || action;
    elements.inspectorContent.hidden = !item;
    elements.inspectorEmpty.hidden = Boolean(item);
    if (!item) {
      elements.inspectorTitle.textContent = "Nothing selected";
      elements.inspectorSubtitle.textContent = "Select a unit on the canvas to inspect or edit it.";
      return;
    }

    if (unit) {
      elements.inspectorTitle.textContent = unit.unitName || "Unit";
      elements.inspectorSubtitle.textContent = state.mode === "overlay" ? "Unit symbol on the map overlay" : "Unit in the organization chart";
      const name = inputControl("unit-name", unit.unitName, value => updateUnit(unit, "unitName", value));
      elements.inspectorContent.append(makeField("Unit name", name));
      const type = selectControl("unit-type", unit.unitTypeCode, UNIT_TYPES.map(([value, label]) => ({ value, label })), value => updateUnit(unit, "unitTypeCode", value));
      elements.inspectorContent.append(makeField("Unit type", type));
      const echelon = selectControl("unit-echelon", unit.echelon, [[1100, "Not specified"], ...ECHELONS].map(([value, label]) => ({ value, label })), value => updateUnit(unit, "echelon", Number(value)));
      elements.inspectorContent.append(makeField("Echelon", echelon));
      const hostility = selectControl("unit-hostility", unit.hostility, HOSTILITY.map(({ value, label }) => ({ value, label })), value => updateUnit(unit, "hostility", Number(value)));
      elements.inspectorContent.append(makeField("Hostility", hostility));
      const hq = document.createElement("input");
      hq.type = "checkbox";
      hq.checked = unit.isHQ;
      hq.addEventListener("change", () => updateUnit(unit, "isHQ", hq.checked));
      const hqLabel = document.createElement("label");
      hqLabel.className = "check-field";
      hqLabel.append(hq, document.createTextNode("Headquarters"));
      elements.inspectorContent.append(hqLabel);
      if (state.mode === "overlay") {
        elements.inspectorContent.append(makeField("Map coordinates", coordinateReadout(unit.xPos, unit.yPos)));
      } else {
        const x = inputControl("unit-x", unit.xPos, value => updateUnit(unit, "xPos", number(value)), "number");
        const y = inputControl("unit-y", unit.yPos, value => updateUnit(unit, "yPos", number(value)), "number");
        const pair = document.createElement("div");
        pair.className = "field-pair";
        pair.append(makeField("X position", x), makeField("Y position", y));
        elements.inspectorContent.append(pair);
      }
      elements.inspectorContent.append(makeInspectorActions(unit));
      return;
    }

    elements.inspectorTitle.textContent = action.actionName || "Drawing";
    elements.inspectorSubtitle.textContent = `${toolForAction(action)?.label || "Tactical drawing"} · ${action.points.length} point${action.points.length === 1 ? "" : "s"}`;
    const name = inputControl("action-name", action.actionName, value => updateAction(action, "actionName", value));
    elements.inspectorContent.append(makeField("Label", name));
    const coords = action.points.length ? action.points.map(point => `(${Math.round(point.x)}, ${Math.round(point.y)})`).join("  ") : "No geometry";
    const readout = document.createElement("div");
    readout.className = "coordinate-readout";
    readout.textContent = coords;
    elements.inspectorContent.append(makeField("Geometry", readout, "Drag the drawing on the canvas to reposition it."));
    elements.inspectorContent.append(makeInspectorActions(action));
  }

  function coordinateReadout(x, y) {
    const readout = document.createElement("div");
    readout.className = "coordinate-readout";
    readout.textContent = `${Math.round(x)}, ${Math.round(y)}`;
    return readout;
  }

  function makeInspectorActions(item) {
    const actions = document.createElement("div");
    actions.className = "inspector-actions";
    if (state.mode === "org" && item.unitName) {
      const up = makeActionButton("Move up", () => reorderUnit(item, -1), "button-quiet button-small");
      const down = makeActionButton("Move down", () => reorderUnit(item, 1), "button-quiet button-small");
      actions.append(up, down);
    }
    actions.append(makeActionButton("Delete", () => deleteItem(item), "button button-quiet button-small danger-button"));
    return actions;
  }

  function makeActionButton(label, callback, className) {
    const button = document.createElement("button");
    button.type = "button";
    button.className = `button ${className}`;
    button.textContent = label;
    button.addEventListener("click", callback);
    return button;
  }

  function updateUnit(unit, property, value) {
    unit[property] = value;
    elements.inspectorTitle.textContent = unit.unitName || "Unit";
    changed();
  }

  function updateAction(action, property, value) {
    action[property] = value;
    elements.inspectorTitle.textContent = action.actionName || "Drawing";
    changed();
  }

  function selectItem(kind, id) {
    state.selectedUnitId = kind === "unit" ? id : null;
    state.selectedActionId = kind === "action" ? id : null;
    state.activeTool = "select";
    render();
  }

  function addUnit(x, y) {
    const unit = normalizeUnit({
      UnitName: `Unit ${state.units.length + 1}`,
      UnitType: 0,
      UnitTypeCode: "",
      Echelon: 1104,
      Hostility: 1503,
      IsHQ: 0,
      XPOS: x ?? 70 + (state.units.length % 4) * 150,
      YPOS: y ?? 70 + Math.floor(state.units.length / 4) * 110,
      TREEPOS: state.units.length + 1
    }, state.units.length);
    state.units.push(unit);
    state.selectedUnitId = unit.id;
    state.selectedActionId = null;
    state.activeTool = "select";
    changed();
  }

  function reorderUnit(unit, direction) {
    unit.yPos = Math.max(30, unit.yPos + direction * 60);
    changed();
  }

  function deleteItem(item) {
    if (item.unitName !== undefined) {
      state.units = state.units.filter(unit => unit.id !== item.id);
      state.selectedUnitId = null;
    } else {
      state.actions = state.actions.filter(action => action.id !== item.id);
      state.selectedActionId = null;
    }
    changed();
  }

  function setMode(mode) {
    state.mode = mode;
    state.selectedUnitId = null;
    state.selectedActionId = null;
    state.activeTool = mode === "overlay" ? "select" : "select";
    saveLocal();
    render();
  }

  function unitSymbol(unit, x, y, selected) {
    const color = colorForHostility(unit.hostility);
    ctx.save();
    ctx.translate(x, y);
    if (unit.markForDisbl) ctx.globalAlpha = .52;
    ctx.fillStyle = "#182430";
    ctx.strokeStyle = selected ? "#f2bd66" : color;
    ctx.lineWidth = selected ? 2 : 1.5;
    ctx.beginPath();
    ctx.rect(-21, -17, 42, 34);
    ctx.fill();
    ctx.stroke();
    ctx.strokeStyle = color;
    ctx.lineWidth = 1.2;
    const code = unit.unitTypeCode;
    if (code.startsWith("12") || code.startsWith("13") || code.startsWith("14")) {
      ctx.beginPath();
      ctx.moveTo(-14, -5);
      ctx.lineTo(14, -5);
      ctx.moveTo(-14, 5);
      ctx.lineTo(14, 5);
      ctx.stroke();
    }
    if (unit.isHQ) {
      ctx.beginPath();
      ctx.moveTo(0, -17);
      ctx.lineTo(0, -25);
      ctx.stroke();
      ctx.beginPath();
      ctx.arc(0, -27, 2, 0, Math.PI * 2);
      ctx.fillStyle = color;
      ctx.fill();
    }
    ctx.restore();
    ctx.fillStyle = selected ? "#f4d293" : "#c8d2db";
    ctx.font = "11px 'DM Sans', sans-serif";
    ctx.textAlign = "center";
    ctx.textBaseline = "top";
    ctx.fillText(unit.unitName || "Unit", x, y + 23, 150);
    ctx.fillStyle = "#84939f";
    ctx.font = "9px 'DM Mono', monospace";
    ctx.fillText(echelonName(unit.echelon), x, y + 37, 150);
  }

  function drawAction(action, selected) {
    const points = action.points;
    if (!points.length) return;
    const tool = toolForAction(action);
    const start = points[0];
    const end = points[points.length - 1];
    const color = selected ? "#f2bd66" : "#e5a84b";
    ctx.save();
    ctx.strokeStyle = color;
    ctx.fillStyle = color;
    ctx.lineWidth = selected ? 2.8 : 2;
    ctx.lineJoin = "round";
    ctx.lineCap = "round";
    if (tool.id === "circle") {
      ctx.beginPath();
      ctx.ellipse((start.x + end.x) / 2, (start.y + end.y) / 2, Math.max(Math.abs(end.x - start.x) / 2, 2), Math.max(Math.abs(end.y - start.y) / 2, 2), 0, 0, Math.PI * 2);
      ctx.stroke();
    } else if (tool.id === "rectangle") {
      ctx.strokeRect(start.x, start.y, end.x - start.x, end.y - start.y);
    } else if (tool.id === "axis") {
      drawAxis(start, end, color);
    } else if (tool.id === "ambush") {
      ctx.beginPath();
      ctx.moveTo(start.x, start.y);
      ctx.lineTo(end.x, end.y);
      ctx.stroke();
      ctx.beginPath();
      ctx.arc(start.x, start.y, 13, Math.PI * .1, Math.PI * .9);
      ctx.stroke();
      ctx.beginPath();
      ctx.arc(start.x + 12, start.y, 13, Math.PI * .1, Math.PI * .9);
      ctx.stroke();
    } else if (tool.id === "breach") {
      const direction = unitVector(start, end);
      const offset = { x: -direction.y * 12, y: direction.x * 12 };
      ctx.beginPath();
      ctx.moveTo(start.x + offset.x, start.y + offset.y);
      ctx.lineTo(end.x + offset.x, end.y + offset.y);
      ctx.moveTo(start.x - offset.x, start.y - offset.y);
      ctx.lineTo(end.x - offset.x, end.y - offset.y);
      ctx.stroke();
    } else {
      ctx.beginPath();
      ctx.moveTo(start.x, start.y);
      for (const point of points.slice(1)) ctx.lineTo(point.x, point.y);
      ctx.stroke();
      if (tool.id === "arrow" && points.length > 1) drawArrowHead(start, end, color);
    }
    if (selected) {
      for (const point of points) {
        ctx.beginPath();
        ctx.arc(point.x, point.y, 3, 0, Math.PI * 2);
        ctx.fill();
      }
    }
    ctx.restore();
  }

  function unitVector(start, end) {
    const dx = end.x - start.x;
    const dy = end.y - start.y;
    const length = Math.max(Math.hypot(dx, dy), 1);
    return { x: dx / length, y: dy / length };
  }

  function drawArrowHead(start, end, color) {
    const vector = unitVector(start, end);
    const angle = Math.atan2(vector.y, vector.x);
    ctx.save();
    ctx.translate(end.x, end.y);
    ctx.rotate(angle);
    ctx.beginPath();
    ctx.moveTo(0, 0);
    ctx.lineTo(-12, -6);
    ctx.lineTo(-12, 6);
    ctx.closePath();
    ctx.fillStyle = color;
    ctx.fill();
    ctx.restore();
  }

  function drawAxis(start, end, color) {
    const vector = unitVector(start, end);
    const perpendicular = { x: -vector.y * 13, y: vector.x * 13 };
    ctx.beginPath();
    ctx.moveTo(start.x + perpendicular.x, start.y + perpendicular.y);
    ctx.lineTo(end.x + perpendicular.x, end.y + perpendicular.y);
    ctx.moveTo(start.x - perpendicular.x, start.y - perpendicular.y);
    ctx.lineTo(end.x - perpendicular.x, end.y - perpendicular.y);
    ctx.moveTo(start.x, start.y);
    ctx.lineTo(end.x, end.y);
    ctx.stroke();
    drawArrowHead(start, end, color);
  }

  function drawCanvas() {
    const rect = canvas.getBoundingClientRect();
    if (!rect.width || !rect.height) return;
    const ratio = window.devicePixelRatio || 1;
    const width = Math.round(rect.width * ratio);
    const height = Math.round(rect.height * ratio);
    if (canvas.width !== width || canvas.height !== height) {
      canvas.width = width;
      canvas.height = height;
    }
    ctx.setTransform(ratio * zoom, 0, 0, ratio * zoom, 0, 0);
    ctx.clearRect(0, 0, rect.width / zoom, rect.height / zoom);
    if (backgroundImage && state.mode === "overlay") {
      const scale = Math.min(rect.width / backgroundImage.width, rect.height / backgroundImage.height, 1);
      const mapWidth = backgroundImage.width * scale;
      const mapHeight = backgroundImage.height * scale;
      ctx.globalAlpha = .8;
      ctx.drawImage(backgroundImage, 0, 0, mapWidth, mapHeight);
      ctx.globalAlpha = 1;
    }
    if (state.mode === "org" && state.units.length > 1) {
      const sorted = [...state.units].sort((a, b) => a.treePos - b.treePos || a.yPos - b.yPos);
      ctx.save();
      ctx.strokeStyle = "#566777";
      ctx.lineWidth = 1;
      for (let index = 1; index < sorted.length; index += 1) {
        const current = sorted[index];
        let parent = null;
        for (let p = index - 1; p >= 0; p -= 1) {
          if (sorted[p].treePos < current.treePos) {
            parent = sorted[p];
            break;
          }
        }
        if (parent) {
          ctx.beginPath();
          ctx.moveTo(parent.xPos + 21, parent.yPos + 4);
          ctx.lineTo(current.xPos - 21, current.yPos + 4);
          ctx.stroke();
        }
      }
      ctx.restore();
    }
    if (state.mode === "overlay") {
      for (const action of state.actions) drawAction(action, action.id === state.selectedActionId);
    }
    for (const unit of state.units) {
      unitSymbol(unit, unit.xPos, unit.yPos, unit.id === state.selectedUnitId);
    }
    ctx.setTransform(1, 0, 0, 1, 0, 0);
  }

  function canvasPoint(event) {
    const rect = canvas.getBoundingClientRect();
    return { x: (event.clientX - rect.left) / zoom, y: (event.clientY - rect.top) / zoom };
  }

  function unitAt(point) {
    for (let index = state.units.length - 1; index >= 0; index -= 1) {
      const unit = state.units[index];
      if (Math.abs(point.x - unit.xPos) <= 23 && Math.abs(point.y - unit.yPos) <= 21) return unit;
    }
    return null;
  }

  function distanceToSegment(point, start, end) {
    const dx = end.x - start.x;
    const dy = end.y - start.y;
    const lengthSquared = dx * dx + dy * dy;
    if (!lengthSquared) return Math.hypot(point.x - start.x, point.y - start.y);
    const t = Math.max(0, Math.min(1, ((point.x - start.x) * dx + (point.y - start.y) * dy) / lengthSquared));
    return Math.hypot(point.x - (start.x + t * dx), point.y - (start.y + t * dy));
  }

  function actionAt(point) {
    for (let index = state.actions.length - 1; index >= 0; index -= 1) {
      const action = state.actions[index];
      const points = action.points;
      if (!points.length) continue;
      const tool = toolForAction(action);
      if (tool.id === "rectangle" || tool.id === "circle") {
        const start = points[0];
        const end = points[points.length - 1];
        const lowX = Math.min(start.x, end.x) - 6;
        const highX = Math.max(start.x, end.x) + 6;
        const lowY = Math.min(start.y, end.y) - 6;
        const highY = Math.max(start.y, end.y) + 6;
        if (point.x >= lowX && point.x <= highX && point.y >= lowY && point.y <= highY) return action;
      } else {
        for (let p = 1; p < points.length; p += 1) {
          if (distanceToSegment(point, points[p - 1], points[p]) <= 9) return action;
        }
        if (points.length === 1 && Math.hypot(point.x - points[0].x, point.y - points[0].y) <= 9) return action;
      }
    }
    return null;
  }

  function pointerDown(event) {
    if (event.button !== 0) return;
    const point = canvasPoint(event);
    if (state.mode === "overlay" && state.activeTool !== "select") {
      if (state.activeTool === "unit") {
        addUnit(point.x, point.y);
        return;
      }
      const tool = TOOLS.find(item => item.id === state.activeTool);
      if (!tool || !tool.code) return;
      const action = {
        id: `action-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`,
        actionName: tool.label,
        actionType: tool.type,
        actionTypeCode: tool.code,
        points: [point],
        editableText: ""
      };
      state.actions.push(action);
      state.selectedActionId = action.id;
      state.selectedUnitId = null;
      drag = { kind: "draw", item: action, lastPoint: point };
      canvas.setPointerCapture(event.pointerId);
      render();
      return;
    }
    const unit = unitAt(point);
    if (unit) {
      selectItem("unit", unit.id);
      drag = { kind: "unit", item: unit, lastPoint: point };
      canvas.setPointerCapture(event.pointerId);
      return;
    }
    const action = state.mode === "overlay" ? actionAt(point) : null;
    if (action) {
      selectItem("action", action.id);
      drag = { kind: "action", item: action, lastPoint: point };
      canvas.setPointerCapture(event.pointerId);
      return;
    }
    state.selectedUnitId = null;
    state.selectedActionId = null;
    render();
  }

  function pointerMove(event) {
    if (!drag) return;
    const point = canvasPoint(event);
    const dx = point.x - drag.lastPoint.x;
    const dy = point.y - drag.lastPoint.y;
    if (drag.kind === "draw") {
      const tool = toolForAction(drag.item);
      const points = drag.item.points;
      if (tool.id === "freehand") {
        if (Math.hypot(dx, dy) >= 2) points.push(point);
      } else if (points.length === 1) {
        points.push(point);
      } else {
        points[1] = point;
      }
      drag.lastPoint = point;
    } else if (drag.kind === "unit") {
      drag.item.xPos += dx;
      drag.item.yPos += dy;
      drag.lastPoint = point;
    } else {
      for (const p of drag.item.points) {
        p.x += dx;
        p.y += dy;
      }
      drag.lastPoint = point;
    }
    drawCanvas();
  }

  function pointerUp() {
    if (!drag) return;
    if (drag.kind === "draw" && drag.item.points.length === 1) {
      drag.item.points.push({ x: drag.item.points[0].x + 1, y: drag.item.points[0].y + 1 });
    }
    drag = null;
    changed();
  }

  function exportDocument() {
    const overlay = state.mode === "overlay";
    const unitRecords = state.units.map(unit => ({
      UNITNAME: unit.unitName,
      UNITTYPE: unit.unitType,
      UNITTYPECODE: unit.unitTypeCode,
      ECHELON: unit.echelon,
      HOSTILITY: unit.hostility,
      ISHQ: unit.isHQ ? 1 : 0,
      XPOS: Math.round(unit.xPos),
      YPOS: Math.round(unit.yPos),
      TREEPOS: unit.treePos,
      MARKFORDEL: 0,
      MARKFORDISBL: unit.markForDisbl ? 1 : 0
    }));
    const document = {
      [overlay ? "Overlay" : "TaskOrg"]: {
        C2IPName: state.name,
        Units: unitRecords,
        ...(overlay ? { Actions: state.actions.map(exportAction) } : {}),
        refC2IPs: state.references.length ? state.references : null
      }
    };
    return JSON.stringify(document, null, 2);
  }

  function exportAction(action) {
    const xs = Array(100).fill(0);
    const ys = Array(100).fill(0);
    action.points.slice(0, 100).forEach((point, index) => {
      xs[index] = Math.round(point.x);
      ys[index] = Math.round(point.y);
    });
    return {
      ACTIONNAME: action.actionName,
      ACTIONTYPE: action.actionType,
      ACTIONTYPECODE: action.actionTypeCode,
      ACTIONPOINTSNUMBER: action.points.length,
      XPOS: xs,
      YPOS: ys,
      EDITABLETEXT: action.editableText
    };
  }

  function downloadFile(contents, filename, mimeType) {
    const blob = new Blob([contents], { type: mimeType });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = filename;
    document.body.append(link);
    link.click();
    link.remove();
    URL.revokeObjectURL(url);
  }

  function safeFilename(name) {
    return (name || "c2ip").replace(/[<>:"/\\|?*\x00-\x1f]/g, "-").trim() || "c2ip";
  }

  document.getElementById("open-button").addEventListener("click", () => document.getElementById("open-file").click());
  document.getElementById("open-file").addEventListener("change", async event => {
    const file = event.target.files && event.target.files[0];
    if (!file) return;
    try {
      state = normalizeDocument(JSON.parse(await file.text()));
      saveLocal();
      render();
      notify(`Opened ${file.name}`);
    } catch (error) {
      console.error("Could not open the selected C2IP file.", error);
      notify(`Could not open file: ${error.message}`);
    } finally {
      event.target.value = "";
    }
  });
  document.getElementById("download-button").addEventListener("click", () => {
    downloadFile(exportDocument(), `${safeFilename(state.name)}.c2ip`, "application/json");
    notify("C2IP file exported.");
  });
  document.getElementById("new-button").addEventListener("click", () => {
    if ((state.units.length || state.actions.length) && !window.confirm("Start a new workspace? The current workspace remains saved in this browser.")) return;
    state = newDocument();
    state.name = `Untitled operation`;
    saveLocal();
    render();
    notify("New workspace ready.");
  });
  elements.orgTab.addEventListener("click", () => setMode("org"));
  elements.overlayTab.addEventListener("click", () => setMode("overlay"));
  elements.addUnit.addEventListener("click", () => addUnit());
  document.getElementById("empty-add-button").addEventListener("click", () => addUnit());
  canvas.addEventListener("pointerdown", pointerDown);
  canvas.addEventListener("pointermove", pointerMove);
  canvas.addEventListener("pointerup", pointerUp);
  canvas.addEventListener("pointercancel", pointerUp);
  canvas.addEventListener("pointerleave", event => { if (drag && event.buttons === 0) pointerUp(); });
  document.getElementById("zoom-in").addEventListener("click", () => { zoom = Math.min(2, zoom + .1); render(); });
  document.getElementById("zoom-out").addEventListener("click", () => { zoom = Math.max(.5, zoom - .1); render(); });
  document.getElementById("fit-button").addEventListener("click", () => { zoom = 1; render(); });
  document.getElementById("map-file").addEventListener("change", event => {
    const file = event.target.files && event.target.files[0];
    if (!file) return;
    const url = URL.createObjectURL(file);
    const image = new Image();
    image.onload = () => {
      if (backgroundImage && backgroundImage.src.startsWith("blob:")) URL.revokeObjectURL(backgroundImage.src);
      backgroundImage = image;
      state.mode = "overlay";
      render();
      notify("Background map loaded. It is not embedded in exported .c2ip files.");
      URL.revokeObjectURL(url);
    };
    image.onerror = () => {
      URL.revokeObjectURL(url);
      notify("Could not load that image as a map.");
    };
    image.src = url;
    event.target.value = "";
  });
  elements.clearMap.addEventListener("click", () => {
    backgroundImage = null;
    render();
    notify("Background map removed.");
  });
  window.addEventListener("resize", drawCanvas);

  let editingDocumentName = false;
  elements.name.addEventListener("dblclick", () => {
    if (editingDocumentName) return;
    editingDocumentName = true;
    const input = document.createElement("input");
    input.value = state.name;
    input.setAttribute("aria-label", "Workspace name");
    input.style.cssText = "width:min(360px,35vw);height:27px;padding:2px 6px;border:1px solid #e5a84b;border-radius:4px;background:#121c26;color:#e6edf3;font:600 13px 'DM Sans',sans-serif";
    elements.name.replaceWith(input);
    input.focus();
    input.select();
    const finish = () => {
      state.name = input.value.trim() || "Untitled operation";
      input.replaceWith(elements.name);
      editingDocumentName = false;
      changed();
    };
    input.addEventListener("keydown", event => {
      if (event.key === "Enter") input.blur();
      if (event.key === "Escape") { input.value = state.name; input.blur(); }
    });
    input.addEventListener("blur", finish, { once: true });
  });

  render();
})();
