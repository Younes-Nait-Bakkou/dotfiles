local function get_java_runtimes()
    local runtimes = {}
    local seen_versions = {} -- Keep track of versions we've already found

    local search_paths = {
        "/usr/lib/jvm",
        vim.fn.expand("~/.sdkman/candidates/java"),
        vim.fn.expand("~/.jenv/versions"),
    }

    for _, root_path in ipairs(search_paths) do
        if vim.fn.isdirectory(root_path) == 1 then
            local handle = vim.loop.fs_scandir(root_path)
            if handle then
                while true do
                    local name, type = vim.loop.fs_scandir_next(handle)
                    if not name then
                        break
                    end

                    if type == "directory" or type == "link" then
                        local full_path = root_path .. "/" .. name
                        local version = nil

                        -- 1. Match specific "java-1.X" (e.g. java-1.17.0 -> 17)
                        local legacy_match = name:match("java%-1%.(%d+)") or name:match("jdk%-1%.(%d+)")

                        -- 2. Match standard "java-X" (e.g. java-21 -> 21)
                        local standard_match = name:match("java%-(%d+)") or name:match("jdk%-(%d+)")

                        -- 3. Match bare versions "X.Y.Z" (e.g. 17.0.1 -> 17)
                        local bare_match = name:match("^(%d+)%.")

                        if legacy_match then
                            version = legacy_match
                        elseif standard_match then
                            version = standard_match
                        elseif bare_match then
                            if bare_match == "1" then
                                version = name:match("^1%.(%d+)")
                            else
                                version = bare_match
                            end
                        end

                        -- THE FIX: Only add if we haven't seen this version yet
                        if version and not seen_versions[version] then
                            if vim.fn.executable(full_path .. "/bin/java") == 1 then
                                table.insert(runtimes, {
                                    name = "JavaSE-" .. version,
                                    path = full_path,
                                })
                                seen_versions[version] = true -- Mark as seen
                            end
                        end
                    end
                end
            end
        end
    end

    return runtimes
end

-- @param package_name string
-- @return table
local function get_mason_package_paths(package_name)
    local mason_registry = require("mason-registry")

    if not mason_registry.has_package("jdtls") then
        vim.notify("The packge " .. package_name .. " is not installed via Mason!", vim.log.levels.WARN)
        return {
            share_path = "",
            package_path = "",
        }
    end

    local mason_path = vim.fn.expand("$MASON")

    local mason_share_path = mason_path .. "/share"
    local mason_packages_path = mason_share_path .. "/packages"

    local share_path = mason_share_path .. "/" .. package_name
    local package_path = mason_packages_path .. "/" .. package_name

    return {
        share = share_path,
        packages = package_path,
    }
end

local function get_jdtls()
    local paths = get_mason_package_paths("jdtls")

    -- Find the launcher jar
    local launcher = vim.fn.glob(paths.share .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    -- Determine OS
    local SYSTEM = "linux"
    if vim.fn.has("mac") == 1 then
        SYSTEM = "mac"
    elseif vim.fn.has("unix") == 1 then
        SYSTEM = "linux"
    elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        SYSTEM = "win"
    end

    -- Get config path for the OS
    local config = paths.packages .. "/config_" .. SYSTEM
    -- Get lombok jar
    local lombok = paths.share .. "/lombok.jar"

    return launcher, config, lombok
end

local function get_bundles()
    local java_debug_paths = get_mason_package_paths("java-debug-adapter")
    local java_test_paths = get_mason_package_paths("java-test")

    local bundles = {
        vim.fn.glob(java_debug_paths.share .. "/com.microsoft.java.debug.plugin-*.jar", true),
    }

    -- Add all of the Jars for running tests in debug mode to the bundles list
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_paths.share .. "/*.jar", true), "\n"))

    return bundles
end

local function get_workspace()
    local home = os.getenv("HOME")
    local workspace_path = home .. "/code/jdtls-workspace/"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = workspace_path .. project_name
    vim.fn.mkdir(workspace_dir, "p")

    return workspace_dir
end

local function java_keymaps()
    -- Register commands
    vim.cmd(
        "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
    )
    vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
    vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
    vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

    -- Keymaps
    vim.keymap.set(
        "n",
        "<leader>Jo",
        "<Cmd>lua require('jdtls').organize_imports()<CR>",
        { desc = "[J]ava [O]rganize Imports", buffer = true }
    )

    vim.keymap.set(
        "n",
        "<leader>Jv",
        "<Cmd>lua require('jdtls').extract_variable()<CR>",
        { desc = "[J]ava Extract [V]ariable", buffer = true }
    )
    vim.keymap.set(
        "v",
        "<leader>Jv",
        "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
        { desc = "[J]ava Extract [V]ariable", buffer = true }
    )

    vim.keymap.set(
        "n",
        "<leader>JC",
        "<Cmd>lua require('jdtls').extract_constant()<CR>",
        { desc = "[J]ava Extract [C]onstant", buffer = true }
    )
    vim.keymap.set(
        "v",
        "<leader>JC",
        "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
        { desc = "[J]ava Extract [C]onstant", buffer = true }
    )

    vim.keymap.set(
        "n",
        "<leader>Jt",
        "<Cmd>lua require('jdtls').test_nearest_method()<CR>",
        { desc = "[J]ava [T]est Method", buffer = true }
    )
    vim.keymap.set(
        "v",
        "<leader>Jt",
        "<Esc><Cmd>lua require('jdtls').test_nearest_method(true)<CR>",
        { desc = "[J]ava [T]est Method", buffer = true }
    )

    vim.keymap.set(
        "n",
        "<leader>JT",
        "<Cmd>lua require('jdtls').test_class()<CR>",
        { desc = "[J]ava [T]est Class", buffer = true }
    )

    vim.keymap.set("n", "<leader>Ju", "<Cmd>JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config", buffer = true })
end

local function setup_jdtls()
    local my_runtimes = get_java_runtimes()

    vim.print(vim.inspect(my_runtimes))
    local JAVA_HOME = vim.env.JAVA_HOME
    -- Get access to the jdtls plugin and all of its functionality
    local jdtls = require("jdtls")

    -- Get the paths to the jdtls jar, operating specific configuration directory, and lombok jar
    local launcher, os_config, lombok = get_jdtls()

    -- Get the path you specified to hold project information
    local workspace_dir = get_workspace()

    -- Get the bundles list with the jars to the debug adapter, and testing adapters
    local bundles = get_bundles()

    -- -- Determine the root directory of the project by looking for these specific markers
    local root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
    print("Launcher", launcher)
    print("os_config", os_config)
    print("lombok", lombok)
    print("workspace_dir", workspace_dir)
    print("root_dir", root_dir)

    -- -- Tell our JDTLS language features it is capable of
    -- local capabilities = {
    --     workspace = {
    --         configuration = true,
    --     },
    --     textDocument = {
    --         completion = {
    --             snippetSupport = false,
    --         },
    --     },
    -- }

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- for k, v in pairs(lsp_capabilities) do
    --     capabilities[k] = v
    -- end

    -- Get the default extended client capablities of the JDTLS language server
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    -- Modify one property called resolveAdditionalTextEditsSupport and set it to true
    -- extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- Set the command that starts the JDTLS language server jar
    local cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. lombok,
        "-Xmx4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        launcher,
        "-configuration",
        os_config,
        "-data",
        workspace_dir,
    }
    print("cmd", cmd)

    -- Configure settings in the JDTLS server
    local settings = {
        java = {
            home = JAVA_HOME,
            -- Enable code formatting
            format = {
                enabled = true,
                -- Use the Google Style guide for code formatting
                settings = {
                    url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            -- Enable downloading archives from eclipse automatically
            eclipse = {
                downloadSources = true,
            },
            -- Enable downloading archives from maven automatically
            maven = {
                downloadSources = true,
            },
            -- Enable method signature help
            signatureHelp = {
                enabled = true,
            },
            -- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
            contentProvider = {
                preferred = "fernflower",
            },
            -- Setup automatical package import oranization on file save
            saveActions = {
                organizeImports = true,
            },
            -- Customize completion options
            completion = {
                -- When using an unimported static method, how should the LSP rank possible places to import the static method from
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                -- Try not to suggest imports from these packages in the code action window
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
                -- Set the order in which the language server should organize imports
                importOrder = {
                    "java",
                    "jakarta",
                    "javax",
                    "com",
                    "org",
                },
            },
            sources = {
                -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
                organizeImports = {
                    starThreshold = 9999,
                    staticThreshold = 9999,
                },
            },
            -- How should different pieces of code be generated?
            codeGeneration = {
                -- When generating toString use a json format
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                -- When generating hashCode and equals methods use the java 7 objects method
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                -- When generating code use code blocks
                useBlocks = true,
            },
            -- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
            configuration = {
                updateBuildConfiguration = "interactive",
                -- Configure Java runtimes you have installed
                -- Add or remove entries based on your installed JDKs
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = JAVA_HOME,
                    },
                },
            },
            -- enable code lens in the lsp
            referencesCodeLens = {
                enabled = true,
            },
            -- enable inlay hints for parameter names,
            inlayHints = {
                parameterNames = {
                    enabled = "all",
                },
            },
        },
    }

    -- Create a table called init_options to pass the bundles with debug and testing jar, along with the extended client capablies to the start or attach function of JDTLS
    local init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
    }

    -- Function that will be run once the language server is attached to add custom command for running the current class
    local run_compiled_class = require("commands.java.run_compiled_class")

    local function on_language_status(_, result)
        local command = vim.api.nvim_command
        command("echohl ModeMsg")
        command(string.format('echo "%s"', result.message))
        command("echohl None")
    end

    -- Function that will be ran once the language server is attached
    local on_attach = function(_, bufnr)
        -- Map the Java specific key mappings once the server is attached
        java_keymaps()

        -- Setup the java debug adapter of the JDTLS server
        require("jdtls.dap").setup_dap()

        -- Find the main method(s) of the application so the debug adapter can successfully start up the application
        -- Sometimes this will randomly fail if language server takes to long to startup for the project, if a ClassDefNotFoundException occurs when running
        -- the debug tool, attempt to run the debug tool while in the main class of the application, or restart the neovim instance
        -- Unfortunately I have not found an elegant way to ensure this works 100%
        require("jdtls.dap").setup_dap_main_class_configs()
        -- Enable jdtls commands to be used in Neovim
        -- require("jdtls.setup").add_commands()
        -- Refresh the codelens
        -- Code lens enables features such as code reference counts, implemenation counts, and more.
        -- vim.lsp.codelens.refresh()

        -- Setup a function that automatically runs every time a java file is saved to refresh the code lens
        -- vim.api.nvim_create_autocmd("BufWritePost", {
        --     pattern = { "*.java" },
        --     callback = function()
        --         local _, _ = pcall(vim.lsp.codelens.refresh)
        --     end,
        -- })

        run_compiled_class.setup(bufnr)
    end

    -- Create the configuration table for the start or attach function
    local config = {
        cmd = cmd,
        root_dir = root_dir,
        settings = settings,
        capabilities = capabilities,
        init_options = init_options,
        on_attach = on_attach,
        handlers = {
            ["language/status"] = on_language_status,
            ["$/progress"] = function(_, result, ctx)
                -- disable progress updates.
                -- print("progress")
                -- print(vim.inspect(result))
            end,
        },
    }
    return config
end

return {
    setup_jdtls = setup_jdtls,
}
