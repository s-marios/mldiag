local exists_previous_message = false

local get_current_line_diagnostic = function()
  local cur = vim.api.nvim_win_get_cursor(0)
  return vim.diagnostic.get(0, { lnum = cur[1] - 1 })[1]
end

-- To avoid hit-enter-prompts, first treat whitespace and truncate the message
local truncate = function(msg)
  return msg:gsub("[\n\r\t]", ". "):sub(1, vim.v.echospace)
end

local echo_diagnostics = function()
  local first_line_diag = get_current_line_diagnostic()

  if first_line_diag ~= nil then
    print(truncate(first_line_diag.message))
    exists_previous_message = true
  elseif exists_previous_message == true then
    vim.api.nvim_command('echo ')
    exists_previous_message = false
  end
end

local setup = function()
  local group_id = vim.api.nvim_create_augroup("mldiag", {})

  vim.api.nvim_create_autocmd(
    "CursorMoved",
    {
      group = group_id,
      pattern = "*",
      callback = echo_diagnostics,
    })
end

return {
  init = setup
}
