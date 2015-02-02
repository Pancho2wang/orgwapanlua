--========================================================================
-- @File Name			: obj_base.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-27 17:19:45
-- @Last Modified time	: 2015-01-31 20:33:52
-- @Description			: wapan
--========================================================================

local ObjBase = ClassMgr:CreateClass("ObjBase")

function ObjBase:_Uninit()
	-- self.obj_name = nil
	-- self.class_name = nil
	self.id = nil
	return 1
end

-- function ObjBase:_Init(id, class_name, obj_name)
function ObjBase:_Init(id)
	self.id = id
	-- self.class_name = class_name
	-- self.obj_name = obj_name
	return 1
end

function ObjBase:GetId()
	return self.id
end

function ObjBase:GetClassName()
	-- return self.class_name
	return self.__cname
end

-- function ObjBase:GetObjectName()
-- 	return self.obj_name
-- end