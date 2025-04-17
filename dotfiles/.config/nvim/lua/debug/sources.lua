local M = {}

local function get_lsp_clients()
  local lsp_clients = vim.lsp.get_clients()
  local lines = {}

  if #lsp_clients == 0 then
    table.insert(lines, "No active LSP clients.")
  else
    for _, client in ipairs(lsp_clients) do
      table.insert(lines, string.format("- %s:", client.name))

      -- Filetypes
      local filetypes = client.config.filetypes or {}
      table.insert(lines, string.format("  - Supports: %s", table.concat(filetypes, ", ")))

      -- Root directory
      local root_dir = client.config.root_dir or "Unknown"
      table.insert(lines, string.format("  - Root directory: %s", root_dir))

      -- Capabilities
      local capabilities = {}
      if client.server_capabilities.documentFormattingProvider then
        table.insert(capabilities, "Formatting")
      end
      if client.server_capabilities.hoverProvider then
        table.insert(capabilities, "Hover")
      end
      if client.server_capabilities.codeActionProvider then
        table.insert(capabilities, "Code Actions")
      end
      table.insert(lines, string.format("  - Capabilities: %s", table.concat(capabilities, ", ")))

      -- Workspace folders
      if client.workspace_folders then
        for _, folder in ipairs(client.workspace_folders) do
          table.insert(lines, string.format("  - Workspace folder: %s", folder.uri))
        end
      end
    end
  end

  return lines
end

local function get_nvimlint_linters()
  local has_lint, lint = pcall(require, "lint")
  local lines = {}

  if not has_lint then
    table.insert(lines, "nvim-lint not found.")
  else
    local active_linters = lint.get_running()
    if #active_linters == 0 then
      -- Check configured linters for the current filetype
      local filetype = vim.bo.filetype
      local configured_linters = lint.linters_by_ft[filetype]

      if configured_linters then
        table.insert(lines, "No active linters running. Configured linters for this filetype:")
        for _, linter in ipairs(configured_linters) do
          table.insert(lines, string.format("- %s", linter))
        end
      else
        table.insert(lines, "No active or configured linters for filetype: " .. filetype)
      end
    else
      table.insert(lines, "Active linters:")
      for _, linter in ipairs(active_linters) do
        table.insert(lines, string.format("- %s", linter))
      end
    end
  end

  return lines
end

local function get_conform_sources()
  local has_conform, conform = pcall(require, "conform")
  local lines = {}

  if not has_conform then
    table.insert(lines, "conform.nvim not found.")
  else
    local formatters_by_bufnr = conform.list_formatters() -- Fetch resolved formatter info
    if not formatters_by_bufnr or vim.tbl_isempty(formatters_by_bufnr) then
      table.insert(lines, "No conform.nvim formatters configured.")
    else
      for _, formatter_info in ipairs(formatters_by_bufnr) do
        if formatter_info.available then
          table.insert(
            lines,
            string.format("- %s (%s): %s", formatter_info.name, formatter_info.command, formatter_info.available)
          )
        else
          table.insert(
            lines,
            string.format(
              "- %s: Unavailable (%s)",
              formatter_info.name,
              formatter_info.available_msg or "Unknown reason"
            )
          )
        end
      end
    end
  end
  return lines
end

local function get_nullls_sources()
  local has_null_ls, null_ls = pcall(require, "null-ls")
  local lines = {}

  if not has_null_ls then
    table.insert(lines, "null-ls not found.")
  else
    local sources = null_ls.get_sources()
    if #sources == 0 then
      table.insert(lines, "No null-ls sources configured.")
    else
      for _, source in ipairs(sources) do
        table.insert(lines, string.format("- %s (%s)", source.name, source.method))
      end
    end
  end
  return lines
end

local function get_buffers_and_diagnostics()
  local lines = {}
  local current_bufnr = vim.api.nvim_get_current_buf()

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    -- Only include loaded, named buffers (skip unnamed/scratch buffers)
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr) ~= "" then
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local diagnostics = vim.diagnostic.get(bufnr)

      -- Add buffer header
      table.insert(lines, string.format("Buffer %d (%s):", bufnr, bufname))

      if #diagnostics == 0 then
        table.insert(lines, "  No diagnostics.")
      else
        -- Count diagnostic severities
        local counts = { error = 0, warn = 0, info = 0, hint = 0 }
        for _, diag in ipairs(diagnostics) do
          local severity = vim.diagnostic.severity[diag.severity]:lower()
          counts[severity] = (counts[severity] or 0) + 1
        end

        -- List diagnostic sources
        local seen_sources = {}
        for _, diag in ipairs(diagnostics) do
          if diag.source and not seen_sources[diag.source] then
            table.insert(lines, string.format("  - %s", diag.source))
            seen_sources[diag.source] = true
          end
        end
      end

      -- Blank line between buffers
      table.insert(lines, "")
    end
  end

  if vim.tbl_isempty(lines) then
    return { "No loaded buffers with diagnostics." }
  end

  return lines
end

function M.show_debug_sources()
  local buf = vim.api.nvim_create_buf(false, true)
  local ns_id = vim.api.nvim_create_namespace("DebugSources")

  local function add_highlighted_line(text, hl_group)
    local line_count = vim.api.nvim_buf_line_count(buf)
    vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, { text })
    vim.api.nvim_buf_add_highlight(buf, ns_id, hl_group, line_count, 0, -1)
  end

  local function build_section(s_label, s_lines)
    add_highlighted_line(string.format("--- %s ---", s_label), "Identifier")
    for _, line in ipairs(s_lines) do
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, { line })
    end
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "" })
  end

  add_highlighted_line("=== Debug Sources ===", "Title")
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, {
    "You may also want to check out: ",
    "  :CheckHealth, :ConformInfo, :NullLsInfo",
    "",
  })

  build_section("Servers (LSP)", get_lsp_clients())
  build_section("Linters (nvim-lint)", get_nvimlint_linters())
  build_section("Formatters (conform)", get_conform_sources())
  build_section("Other (null-ls)", get_nullls_sources())
  build_section("Buffers and Diagnostics", get_buffers_and_diagnostics())

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local win = vim.api.nvim_open_win(buf, true, {
    border = "rounded",
    col = math.floor((vim.o.columns - width) / 2),
    height = height,
    relative = "editor",
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    width = width,
  })

  -- Close the floating window with <q>
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_win_close(win, true)
    end,
  })
end

return M
