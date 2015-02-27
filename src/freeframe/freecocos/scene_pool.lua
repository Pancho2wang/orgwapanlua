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

function ScenePool:AddCCObject(obj_class_name, cc_object, ...)
	local obj, id = self:GetObjByClassName(obj_class_name)
	if obj then
		print("Object["..obj_class_name.."] is already add.")
		self:RemoveObject(id)
	end
	id = self:GetNextId()
	local obj_class = ClassMgr:GetClassByName(obj_class_name)
	obj = obj_class.extend(cc_object)
	if obj:Init(id, ...) == 1 then
		self.obj_pool[id] = obj
		-- self:GetObjByClassName(obj_class_name)
		print(obj:GetClassName())
		self:UpdateNextId()
		return obj, id
	else
		print("Add CCObject Error.")
	end
end