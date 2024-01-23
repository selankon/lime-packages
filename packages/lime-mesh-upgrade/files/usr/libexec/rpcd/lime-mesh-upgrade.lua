#!/usr/bin/env lua

--[[
  Copyright (C) 2013-2023 LibreMesh.org
  This is free software, licensed under the GNU AFFERO GENERAL PUBLIC LICENSE Version 3

  Copyright 2023 Selankon <selankon@selankon.xyz>
]] --
local json = require 'luci.jsonc'
local mesh_upgrade = require 'lime-mesh-upgrade'


local function become_main_node(msg)
    local result = mesh_upgrade.become_main_node(msg)
    return utils.printJson(result)
end

local function get_main_node_status(msg)
    local result = mesh_upgrade.get_main_node_status(msg)
    return utils.printJson(result)
end

local function start_firmware_upgrade_transaction(msg)
    local result = mesh_upgrade.start_firmware_upgrade_transaction(msg)
    return utils.printJson(result)
end

local methods = {
    become_master_node = {},
    get_main_node_status = {},
    start_firmware_upgrade_transaction = {},
}

if arg[1] == 'list' then utils.printJson(methods) end

if arg[1] == 'call' then
    local msg = utils.rpcd_readline()
    msg = json.parse(msg)
    if      arg[2] == 'become_main_node' then become_main_node(msg)
    elseif  arg[2] == 'get_main_node_status' then get_main_node_status(msg)
    elseif  arg[2] == 'start_firmware_upgrade_transaction' then start_firmware_upgrade_transaction(msg)
    else utils.printJson({ error = "Method not found" })
    end
end
