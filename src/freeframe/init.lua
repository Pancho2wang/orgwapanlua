--========================================================================
-- @File Name			: init.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-27 14:13:16
-- @Last Modified time	: 2015-01-31 21:05:51
-- @Description			: wapan
--========================================================================

local FREEFRAME_NAME = string.sub(..., 1, -6)

require (FREEFRAME_NAME .. ".common")

AddRequireFile(FREEFRAME_NAME .. ".class_mgr")
AddRequireFile(FREEFRAME_NAME .. ".pool_mgr")
AddRequireFile(FREEFRAME_NAME .. ".obj_pool")
AddRequireFile(FREEFRAME_NAME .. ".obj_base")

AddRequireFile(FREEFRAME_NAME .. ".freecocos.scene_pool")
AddRequireFile(FREEFRAME_NAME .. ".freecocos.scene_base")

