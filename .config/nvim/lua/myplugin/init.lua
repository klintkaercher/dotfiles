local M = {}

-- Helper to get word under cursor
local function get_current_word()
	return vim.fn.expand("<cword>")
end

-- Helper to get the line and cursor column
local function get_cursor_context()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- 1-based row, 0-based col
	local line = vim.api.nvim_get_current_line()
	return {
		row = row,
		col = col,
		line = line,
		before = line:sub(1, col),
		after = line:sub(col + 1),
	}
end

-- Main function
function M.do_something()
	local word = get_current_word()
	local ctx = get_cursor_context()

	-- Example behavior: echo what's under and around the cursor
	vim.api.nvim_echo({
		{ "Word under cursor: " .. word, "Normal" },
		{ "\nLine context: '" .. ctx.before .. "|" .. ctx.after .. "'", "Comment" },
	}, false, {})
end

-- Register :DoSomething
vim.api.nvim_create_user_command("DoSomething", function()
	M.do_something()
end, {})

return M
