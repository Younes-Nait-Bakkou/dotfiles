local harpoon = require("harpoon")
local wk = require("which-key")
local conf = require("telescope.config").values

-- basic telescope configuration
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers")
        .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        })
        :find()
end

-- REQUIRED
harpoon:setup({})
-- REQUIRED

wk.add({
    {
        "<leader>h",
        function()
            harpoon:list():add()
        end,
        desc = "Add to Harpoon List",
    },
    {
        "<C-e>",
        function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Toggle Harpoon Quick Menu",
    },
    {
        "<C-S-P>",
        function()
            harpoon:list():prev()
        end,
        desc = "Previous Buffer in Harpoon",
    },
    {
        "<C-S-N>",
        function()
            harpoon:list():next()
        end,
        desc = "Next Buffer in Harpoon",
    },
    {

        "<C-e>",
        function()
            toggle_telescope(harpoon:list())
        end,
        desc = "Open harpoon window",
    },
})
