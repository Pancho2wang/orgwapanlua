--========================================================================
-- @File Name			: init.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-27 16:13:39
-- @Last Modified time	: 2015-01-31 20:49:30
-- @Description			: wapan
--========================================================================

local PROJECT_NAME = string.sub(..., 1, -6)

AddProjectFile(PROJECT_NAME .. ".config")
AddProjectFile(PROJECT_NAME .. ".sexangle")
AddProjectFile(PROJECT_NAME .. ".loadscene")
AddProjectFile(PROJECT_NAME .. ".gamescene")