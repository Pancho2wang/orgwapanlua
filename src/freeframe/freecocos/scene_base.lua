--========================================================================
-- @File Name			: scene_base.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-31 18:11:20
-- @Last Modified time	: 2015-01-31 20:36:34
-- @Description			: wapan
--========================================================================

local SceneBase = ClassMgr:CreateClass("SceneBase", "ObjBase")
-- local SceneBase = ClassMgr:CreateClass("SceneBase", function()
--     return cc.Scene:create()
-- end)

function SceneBase:_Uninit( ... )
	return 1
end

function SceneBase:_Init( ... )
	return 1
end