local path_package = vim.fn.stdpath("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"

return {
    path_package = path_package,
    mini_path = mini_path,
}
