return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        vtsls = function()
          local group = vim.api.nvim_create_augroup("vtsls_organizeimports_fix", { clear = true })

          vim.api.nvim_create_autocmd("LspAttach", {
            group = group,
            callback = function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)

              if client and client.name == "vtsls" then
                client.commands = client.commands or {}
                client.commands["_typescript.didOrganizeImports"] = function()
                  -- no-op
                end
              end
            end,
          })
        end,
      },
    },
  },
}
