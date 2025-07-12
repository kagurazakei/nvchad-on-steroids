local mc = require("multicursor-nvim")

mc.setup()

local set = vim.keymap.set

-- Add or skip cursor above/below the main cursor.
set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

-- Add or skip matching word/selection
set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

-- Mouse controls
set("n", "<c-leftmouse>", mc.handleMouse)
set("n", "<c-leftrelease>", mc.handleMouseRelease)

-- Enable/disable
set({ "n", "x" }, "<c-q>", mc.toggleCursor)
set("n", "ga", mc.addCursorOperator)
set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors)

-- Align
set("n", "<leader>a", mc.alignCursors)

-- Split selections by regex
set("x", "S", mc.splitCursors)
set("x", "M", mc.matchCursors)

-- Restore
set("n", "<leader>gv", mc.restoreCursors)

-- Match all
set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

-- Rotate between cursors
set("x", "<leader>t", function() mc.transposeCursors(1) end)
set("x", "<leader>T", function() mc.transposeCursors(-1) end)

-- Append/insert
set("x", "I", mc.insertVisual)
set("x", "A", mc.appendVisual)

-- Sequence mode
set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement)
set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement)

-- Search
set("n", "<leader>/n", function() mc.searchAddCursor(1) end)
set("n", "<leader>/N", function() mc.searchAddCursor(-1) end)
set("n", "<leader>/s", function() mc.searchSkipCursor(1) end)
set("n", "<leader>/S", function() mc.searchSkipCursor(-1) end)
set("n", "<leader>/A", mc.searchAllAddCursors)

-- Diagnostic
set({ "n", "x" }, "]d", function() mc.diagnosticAddCursor(1) end)
set({ "n", "x" }, "[d", function() mc.diagnosticAddCursor(-1) end)
set({ "n", "x" }, "]s", function() mc.diagnosticSkipCursor(1) end)
set({ "n", "x" }, "[S", function() mc.diagnosticSkipCursor(-1) end)
set({ "n", "x" }, "md", function()
  mc.diagnosticMatchCursors({ severity = vim.diagnostic.severity.ERROR })
end)

-- Operator mode
set({ "n", "x" }, "<leader>m", mc.operator)

-- Keymap layer (for when cursors are active)
mc.addKeymapLayer(function(layerSet)
  layerSet({ "n", "x" }, "<left>", mc.prevCursor)
  layerSet({ "n", "x" }, "<right>", mc.nextCursor)
  layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
  layerSet("n", "<esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

-- Custom highlights
vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "MultiCursorMatchPreview", { link = "Search" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
