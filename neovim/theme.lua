local colours = {
	bg = "#f7f7f7",
	bghl = "#eff5d6",
	bgdark = "#d7d7d7",

	value = "#222222",
	light = "#555555",
}

-- *.*
local groups = {
	Type = { fg = colours.light, bg = colours.bg },
	Normal = { fg = colours.value, bg = colours.bg },
	Special = { fg = colours.light, bg = colours.bg, italic = true, bold = true },
	Function = { fg = colours.light, bg = colours.bg, italic = true, bold = true },

	Search = { fg = colours.value, bg = colours.bghl },
	Visual = { fg = colours.value, bg = colours.bghl },
	CurSearch = { fg = colours.value, bg = colours.bghl },
	SearchInc = { fg = colours.value, bg = colours.bghl },
	Cursor = { fg = colours.value, bg = colours.bghl, force = true },

	String = { fg = colours.light, bg = colours.bghl },
	Number = { fg = colours.light, bg = colours.bghl },
	Operator = { fg = colours.light, bg = colours.bg },

	Identifier = { fg = colours.value, bg = colours.bg, italic = true },
	Comment = { fg = colours.light, bg = colours.bg, italic = true },
	PreProc = { fg = colours.light, bg = colours.bghl, italic = true },
	Keyword = { fg = colours.value, bg = colours.bghl, italic = true },
}

-- *.ocaml, *.ml, *.mli
local ocaml_groups = {
	ocamlEncl = { fg = colours.light, bg = colours.bg },
	ocamlEqual = { fg = colours.value, bg = colours.bg },
	ocamlArrow = { fg = colours.value, bg = colours.bg },
	ocamlKeyChar = { fg = colours.value, bg = colours.bg },
	ocamlKeyword = { fg = colours.value, bg = colours.bghl },
	ocamlConstructor = { fg = colours.value, bg = colours.bghl, italic = true },
}

-- oil
local oil_groups = {
	OilDir = { fg = colours.light, bg = colours.bg },
	OilFile = { fg = colours.light, bg = colours.bghl },
}

vim.api.nvim_command("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.api.nvim_exec("syntax reset", false)
end

local function set_highlight_groups(groups)
	for group, colour in pairs(groups) do
		vim.api.nvim_set_hl(0, group, colour)
	end
end

local function create_highlight_autocmd(pattern, groups)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = pattern,
		callback = function()
			set_highlight_groups(groups)
		end,
	})
end

set_highlight_groups(groups)
create_highlight_autocmd({ "ocaml", "reason" }, ocaml_groups)
create_highlight_autocmd({ "oil" }, oil_groups)

vim.api.nvim_set_keymap("n", "rr", ":w<CR>:source %<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", ":Inspect<CR>", { noremap = true, silent = true })
