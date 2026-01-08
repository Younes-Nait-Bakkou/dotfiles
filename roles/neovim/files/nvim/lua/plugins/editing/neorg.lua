return {
    "nvim-neorg/neorg",
    version = "*", -- Pin Neorg to the latest stable release
    cmd = "Neorg",
    config = function()
        require("configs.neorg")
    end,
}
