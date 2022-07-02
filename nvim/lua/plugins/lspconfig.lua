local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

lsp_installer.setup {
    automatic_installation = true,
    ensure_installed = {
        "emmet_ls",
        "cssls",
        "sumneko_lua",
        "tsserver",
        "bashls",
        "html"
    },
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

-- 2. (optional) Override the default configuration to be applied to all servers.
lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        on_attach = on_attach
    }
)

-- 3. Loop through all of the installed servers and set it up via lspconfig
for _, server in ipairs(lsp_installer.get_installed_servers()) do
  lspconfig[server.name].setup {}
    require "lsp_signature".setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  })

    --setup diagnostic
    local signs = { Error = " ", Warn = " ", Hint = "", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

     vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
      update_in_insert = true
    })

    vim.o.updatetime = 250
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'if_many',
          prefix =   '● ',  --'■', -- Could be '●', '▎', 'x',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })
end
