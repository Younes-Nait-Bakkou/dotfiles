local M = {}

M.setup = function()
    local url = os.getenv("LLM_NVIM_URL") or "https://api.github.com/voice-invoke"
    local model = os.getenv("LLM_MODEL") or "gpt-4o-mini"
    local api_type = os.getenv("LLM_API_TYPE") or "openai"

    local opts = {
        prompt = "You are a professional programmer.",

        ------------------- set your model parameters -------------------
        -- You can choose to configure multiple models as needed.
        -----------------------------------------------------------------

        --- style1: set single model parameters
        -- url = "https://models.inference.ai.azure.com/chat/completions",
        -- model = "gpt-4o-mini",
        -- api_type = "openai",
        --

        -- url = "https://models.inference.ai.azure.com/chat/completions",
        url = "https://models.github.ai/inference/chat/completions",
        model = "gpt-4o-mini",
        api_type = "openai",
        max_tokens = 4096,
        temperature = 0.3,
        top_p = 0.7,
        fetch_key = function()
            return os.getenv("GITHUB_LLM_KEY")
        end,

        prefix = {
            user = { text = "😃 ", hl = "Title" },
            assistant = { text = "  ", hl = "Added" },
        },

        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,
        streaming_handler = require("llm.stream").popup(),

        -- style2: set parameters of multiple models
        -- (If you need to use multiple models and frequently switch between them.)
        -- models = {
        --     {
        --         name = "ChatGPT",
        --         url = "https://models.inference.ai.azure.com/chat/completions",
        --         model = "gpt-4o-mini",
        --         api_type = "openai",
        --         fetch_key = function()
        --             return os.getenv("GITHUB_LLM_KEY")
        --         end,
        --     },
        --     {
        --         name = "ChatGLM",
        --         url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
        --         model = "glm-4-flash",
        --         api_type = "zhipu",
        --         max_tokens = 8000,
        --         fetch_key = function()
        --             return vim.env.GLM_KEY
        --         end,
        --         temperature = 0.3,
        --         top_p = 0.7,
        --     },
        -- },

        ---------------- set your keymaps for interaction ---------------
        keys = {
            -- The keyboard mapping for the input window.
            ["Input:Submit"] = { mode = "n", key = "<cr>" },
            ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },
            ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },

            -- only works when "save_session = true"
            ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
            ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },

            -- The keyboard mapping for the output window in "split" style.
            ["Output:Ask"] = { mode = "n", key = "i" },
            ["Output:Cancel"] = { mode = "n", key = "<C-c>" },
            ["Output:Resend"] = { mode = "n", key = "<C-r>" },

            -- The keyboard mapping for the output and input windows in "float" style.
            ["Session:Toggle"] = { mode = "n", key = "<leader>ac" },
            ["Session:Close"] = { mode = "n", key = { "<esc>", "Q" } },

            -- Scroll
            ["PageUp"] = { mode = { "i", "n" }, key = "<C-b>" },
            ["PageDown"] = { mode = { "i", "n" }, key = "<C-f>" },
            ["HalfPageUp"] = { mode = { "i", "n" }, key = "<C-u>" },
            ["HalfPageDown"] = { mode = { "i", "n" }, key = "<C-d>" },
            ["JumpToTop"] = { mode = "n", key = "gg" },
            ["JumpToBottom"] = { mode = "n", key = "G" },
        },

        ---------------------- set your app tools  ----------------------
        -- app_handler = {
        --     OptimCompare = {
        --         handler = tools.action_handler,
        --         opts = {
        --             fetch_key = function()
        --                 return vim.env.GITHUB_TOKEN
        --             end,
        --             url = "https://models.inference.ai.azure.com/chat/completions",
        --             model = "gpt-4o-mini",
        --             api_type = "openai",
        --             language = "Chinese",
        --         },
        --         ["Your Tool Name"] = {
        --             -- handler =
        --             -- opts = {
        --             --    fetch_key = function() return <your api key> end
        --             -- }
        --             -- url = "https://xxx",
        --             -- model = "xxx"
        --             -- api_type = ""
        --         },
        --         -- ...
        --     },
        -- },
    }

    require("llm").setup(opts)
end

return M
