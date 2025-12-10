local M = {}

-- Lsp bin path from Mason :
-- cd ~/.local/share/nvim/mason/bin

M = {
    python = require("features.languages.python"),
    lua = require("features.languages.lua"),
    yaml = require("features.languages.yaml"),
    css = require("features.languages.css"),
    helm = require("features.languages.helm"),
    json = require("features.languages.json"),
    docker = require("features.languages.docker"),
    markdown = require("features.languages.markdown"),
    java = require("features.languages.java"),
    shell = require("features.languages.shell"),
    xml = require("features.languages.xml"),
    html = require("features.languages.html"),
    clangd = require("features.languages.cpp"),
    sql = require("features.languages.sql"),
    ts_ls = require("features.languages.typescript"),
    vtsls = require("features.languages.vtsls"),
    tailwindcss = require("features.languages.tailwindcss"),
    vue_ls = require("features.languages.vue"),
    -- gopls = require('features.languages.go'),
    -- swift = require('features.languages.swift'),
    rust_analyzer = require("features.languages.rust"),
}

return M
