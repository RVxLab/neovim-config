local fn = require("utils.function")
local keymap = require("utils.keymap")
local os_utils = require("utils.os")
local string_utils = require("utils.string")
local table_utils = require("utils.table")
local capability_utils = require("utils.capability")

local M = {}

-- Functions
M.bind = fn.bind
M.pbind = fn.pbind
M.invoke = fn.invoke
M.noop = fn.noop
M.unpack = fn.unpack

-- Keymaps
M.lazy_key = keymap.lazy_key
M.keymap = keymap.keymap
M.n_keymap = keymap.n_keymap
M.v_keymap = keymap.v_keymap
M.x_keymap = keymap.x_keymap

-- OS
M.is_macos = os_utils.is_macos
M.when_macos = os_utils.when_macos

-- Strings
M.string_split = string_utils.string_split
M.pad_string = string_utils.pad_string
M.string_starts_with = string_utils.string_starts_with
M.string_join = string_utils.string_join

-- Tables
M.keys = table_utils.keys
M.map = table_utils.map
M.values = table_utils.values

-- Capabilities
M.get_capabilities = capability_utils.get_capabilities

return M
