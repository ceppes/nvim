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

print("JAVA ")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.opt_local.foldmethod='indent'
    vim.opt_local.expandtab = true
  end
})


function M.keymaps()
  print("JAVA keymaps")
  vim.keymap.set('n', '<leader>og', "<Cmd>lua require'jdtls'.organize_imports()<CR>")
end


function M.plugin()
  print("JAVA Plugin")
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


function M.setup()

  local jdtls_ok, jdtls = pcall(require, "jdtls")
  if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
    return
  end

  -- Data directory - change it to your liking
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = vim.env.HOME .. '/jdtls-workspace/' .. project_name
  -- local WORKSPACE_PATH = vim.env.HOME .. "/workspace/java/"

  -- Installation location of jdtls by nvim-lsp-installer
  local JDTLS_LOCATION = vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls"
  print("JAVA setup")
  -- /home/diego/.local/share/nvim/mason/packages/jdtls
  print("JDTLS_LOCATION" .. JDTLS_LOCATION)
  -- local JDA_LOCATION = require('mason-registry').get_package('java-debug-adapter'):get_install_path()
  local JDA_LOCATION = vim.env.HOME .. "/.local/share/nvim/mason/packages/java-debug-adapter"
  print("JDA" .. JDA_LOCATION)
  -- local JTEST_LOCATION = require('mason-registry').get_package('java-test'):get_install_path()
  local JTEST_LOCATION = vim.env.HOME .. "/.local/share/nvim/mason/packages/java-test"
  print("JTEST" .. JTEST_LOCATION)


  -- Only for Linux and Mac
  local SYSTEM = "linux"
  if vim.fn.has "mac" == 1 then
    SYSTEM = "mac"
  end



  -- Needed for debugging
  local bundles = {
    vim.fn.glob(vim.env.HOME .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
  }

  -- Needed for running/debugging unit tests
  -- vim.list_extend(bundles, vim.split(vim.fn.glob( vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))
  -- TODO
  -- vim.list_extend(bundles, vim.split(vim.fn.glob( JTEST_LOCATION .. "/extension/server/*.jar", 1), "\n"))

  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
  local root_dir = require("jdtls.setup").find_root(root_markers)
  if root_dir == "" then
    return
  end


  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-javaagent:' .. JDTLS_LOCATION .. '/lombok.jar',
      '-Xmx4g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      -- Eclipse jdtls location
      '-jar', vim.env.HOME .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
      -- TODO Update this to point to the correct jdtls subdirectory for your OS (config_linux, config_mac, config_win, etc)
      '-configuration', vim.env.HOME .. '/.local/share/nvim/mason/packages/jdtls/config_' .. SYSTEM,
      '-data', workspace_dir
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    settings = {
      java = {
        -- Replace this with the absolute path to your main java version (JDK 17 or higher)
        home = os.getenv "JAVA_HOME",
        eclipse = {
          downloadSources = true,
        },
        configuration = {
          updateBuildConfiguration = "interactive",
          -- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
          -- The runtime name parameters need to match specific Java execution environments.  See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
          -- runtimes = {
          --   {
          --     name = "JavaSE-11",
          --     path = "/usr/lib/jvm/java-11-openjdk-amd64",
          --   },
          --   {
          --     name = "JavaSE-17",
          --     path = "/usr/lib/jvm/java-17-openjdk-amd64",
          --   },
          --   {
          --     name = "JavaSE-19",
          --     path = "/usr/lib/jvm/java-19-openjdk-amd64",
          --   }
          -- }
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        signatureHelp = { enabled = true },
        format = {
          enabled = true,
          -- Formatting works by default, but you can refer to a specific file/URL if you choose
          settings = {
            url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
            profile = "GoogleStyle",
          },
        },
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org"
        },
      },
      extendedClientCapabilities = extendedClientCapabilities,
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
    -- Needed for auto-completion with method signatures and placeholders
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
    flags = {
      allow_incremental_sync = true,
    },
    init_options = {
      -- References the bundles defined above to support Debugging and Unit Testing
      bundles = bundles
    },
  }

  -- Needed for debugging
  config['on_attach'] = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
  end

  -- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.

  -- for index, data in ipairs(config.settings.java.format.settings) do
  --   print("c : " .. data)
  -- end
  for index, data in ipairs(config.cmd) do
    print("cmd : " .. data)
  end

  for index, data in ipairs(config) do
    print("ddd")
    print(index)

    for key, value in pairs(data) do
        print('\t', key, value)
    end
  end

  print("JAVA start")
  jdtls.start_or_attach(config)
end


function M.setup2()

  local jdtls_ok, jdtls = pcall(require, "jdtls")
  if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
    return
  end

  -- Installation location of jdtls by nvim-lsp-installer
  local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/lsp_servers/jdtls"

  -- Data directory - change it to your liking
  local HOME = os.getenv "HOME"
  local WORKSPACE_PATH = HOME .. "/workspace/java/"

  -- Only for Linux and Mac
  local SYSTEM = "linux"
  if vim.fn.has "mac" == 1 then
    SYSTEM = "mac"
  end

  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = WORKSPACE_PATH .. project_name

  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
  local root_dir = require("jdtls.setup").find_root(root_markers)
  if root_dir == "" then
    return
  end

  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  local config = {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      -- "-jar",
      -- vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
      '-jar', vim.env.HOME .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
      -- "-configuration",
      -- JDTLS_LOCATION .. "/config_" .. SYSTEM,

      '-configuration', vim.env.HOME .. '/.local/share/nvim/mason/packages/jdtls/config_' .. SYSTEM,
      "-data",
      workspace_dir,
    },

    -- on_attach = require("config.lsp").on_attach,
    -- capabilities = require("config.lsp").capabilities,
    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        configuration = {
          updateBuildConfiguration = "interactive",
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        format = {
          enabled = true,
          settings = {
            -- url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
            -- profile = "GoogleStyle",
          },
        },
      },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
      contentProvider = { preferred = "fernflower" },
      extendedClientCapabilities = extendedClientCapabilities,
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },

    flags = {
      allow_incremental_sync = true,
    },
    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
      bundles = {},
    },
  }
  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  jdtls.start_or_attach(config)

  -- Add the commands
  -- require("jdtls.setup").add_commands()
  -- vim.api.nvim_exec(
  --   [[
  -- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
  -- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
  -- command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
  -- command! -buffer JdtJol lua require('jdtls').jol()
  -- command! -buffer JdtBytecode lua require('jdtls').javap()
  -- command! -buffer JdtJshell lua require('jdtls').jshell(),
  --   ]],
  --   false
  -- )

end

--
-- require('features.languages.java').keymaps()
-- require('features.languages.java').setup()

return M
