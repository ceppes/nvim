local M = {}

M = {
  pyright = require('features.languages.python'),
  lua_ls = require('features.languages.lua'),
  yamlls = require('features.languages.yaml'),
  tsserver = require('features.languages.typescript'),
  cssls = require('features.languages.css'),
  helm_ls = require('features.languages.helm'),
  jsonls = require('features.languages.json'),
  docker = require('features.languages.docker'),
  markdown = require('features.languages.markdown'),
  java = require('features.languages.java'),
}

return M
