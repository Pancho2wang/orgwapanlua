--========================================================================
-- @File Name			: scene_pool.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-31 20:51:12
-- @Last Modified time	: 2015-01-31 20:52:44
-- @Description			: wapan
--========================================================================

local ScenePool = ClassMgr:CreateClass("ScenePool", "ObjPool")

function ScenePool:_Uninit( ... )
	return 1
end

function ScenePool:_Init( ... )
	return 1
end