--========================================================================
-- @File Name			: scene_base.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-31 18:11:20
-- @Last Modified time	: 2015-01-31 20:36:34
-- @Description			: wapan
--========================================================================

local SceneBase = ClassMgr:CreateClass("SceneBase", "ObjBase")

function SceneBase:_Uninit( ... )
	-- body
	return 1
end

function SceneBase:_Init( ... )
	-- body
	return 1
end

function SceneBase:PrintTest( ... )
	-- body
	print("SceneBase========")
end