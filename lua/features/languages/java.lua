-- Java lsp config
--require'lspconfig'.jdtls.setup{}
local M = {}

M.treesitter = 'java'
-- M.lspbin = 'jdtls'
-- M.lsp_key = 'jdtls'

--TODO check installation automatic
-- jdtls
-- java-debug-adapter
-- java-test

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.opt_local.foldmethod='indent'
    vim.opt_local.expandtab = true
    M.keymaps()
    M.commands()

  end
})

function M.keymaps()
  if vim.bo.filetype == 'java' then
    vim.keymap.set("n", '<leader>go', function()
      require('jdtls').organize_imports();
    end,
    {desc = "Organize Imports (Java)"})

    vim.keymap.set("n", '<leader>gu', function()
      require('jdtls').update_projects_config();
    end,
    {desc = "Update Project Config (Java)"})


    vim.keymap.set("n", '<leader>ttc', function()
      require('jdtls').test_class();
    end,
    {desc = "Run Test Class (Java)"})

    vim.keymap.set("n", '<leader>ttm', function()
      require('jdtls').test_nearest_method();
    end,
    {desc = "Run Test Nearest Method (Java)"})
  end
end

function M.commands()
  vim.api.nvim_create_user_command("JdtlsGoogleIntellij", function()
  require('jdtls').start_or_attach({
    settings = {
      java = {
        format = {
          settings = {
            -- url = "file:" .. vim.fn.expand("~/.config/jdtls/formatters/eclipse-google.xml"),
          --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
            url = "file:".. vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
            profile = "GoogleStyle",
          }
        }
      }
    }
  })
  end, {})

  vim.api.nvim_create_user_command("JdtlsGoogleEclipse", function()
  require('jdtls').start_or_attach({
    settings = {
      java = {
        format = {
          settings = {
            url = "file:".. vim.fn.stdpath "config" .. "/lang-servers/eclipse-java-google-style.xml",
            -- https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml
            profile = "GoogleStyle",
          }
        }
      }
    }
  })
  end, {})
end

function M.plugin()
  return {
    -- https://github.com/mfussenegger/nvim-jdtls
    'mfussenegger/nvim-jdtls',
    ft = 'java', -- Enable only on .java file extensions
    config = function()
      M.keymaps()
      M.setup()
      -- M.setup2()
    end
  }
end

function M.debugger()
  local dap_status_ok, dap = pcall(require, 'dap')
  if not dap_status_ok then
    return
  end

  dap.adapters.python = {
    type = 'executable';
    -- command = function(config)
    --   return get_python_path(config.root_dir)
    -- end;
    args = { '-m', 'debugpy.adapter' };
  }

  dap.configurations.java = {
    {
      name = "Debug Attach (5000)";
      type = 'java';
      request = 'attach';
      hostname = "127.0.0.1";
      port = 5000;
    },
    {
      name = "Debug Attach (8000)";
      type = 'java';
      request = 'attach';
      hostname = "127.0.0.1";
      port = 8000;
    },
    {
      name = "Debug Launch (2GB)";
      type = 'java';
      request = 'launch';
      vmArgs = "" ..
        "-Xmx2g"
    },
    {
      name = "My Custom Java Run Configuration",
      type = "java",
      request = "launch",
      -- You need to extend the classPath to list your dependencies.
      -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
      -- classPaths = {},

      -- If using multi-module projects, remove otherwise.
      -- projectName = "yourProjectName",

      -- javaExec = "java",
      mainClass = "replace.with.your.fully.qualified.MainClass",

      -- If using the JDK9+ module system, this needs to be extended
      -- `nvim-jdtls` would automatically populate this property
      -- modulePaths = {},
      vmArgs = "" ..
        "-Xmx2g "
    },
  }
end


return M
