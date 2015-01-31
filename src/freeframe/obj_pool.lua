--========================================================================
-- @File Name			: obj_pool.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-27 17:25:06
-- @Last Modified time	: 2015-01-31 21:35:06
-- @Description			: wapan
--========================================================================

-- if not ObjPool then
-- 	ObjPool = wp_class("ObjPool")
-- end
local ObjPool = ClassMgr:CreateClass("ObjPool")

function ObjPool:_Uninit()
	if is_recycle == 1 then
		self.is_recycle = nil
		self.recycle_id_list = nil
	end
	self:RemoveAllObject()
	self.obj_pool = nil
	self.pool_name = nil
	self.next_id = nil
	return 1
end

-- is_recycle: 是否重复利用
function ObjPool:_Init(pool_name, is_recycle)
	self.obj_pool = {}
	self.next_id = 1
	self.pool_name = pool_name
	if is_recycle == 1 then
		self.is_recycle = 1
		self.recycle_id_list = {}
	end
	return 1
end

function ObjPool:IsValid()
	if self.obj_pool then
		return 1
	end
	return 0
end

function ObjPool:AddObject(obj_class_name, ...)
	local id = self:GetNextId()
	local obj_class = ClassMgr:GetClassByName(obj_class_name)
	local obj = obj_class.new()
	self.obj_pool[id] = obj
	if obj.ctor then
		return obj
	elseif obj:Init(id, obj_class_name, ...) == 1 then		
		self:UpdateNextId()
		-- Event:FireEvent(self.obj_name..".ADD", id, ...)
		return obj, id
	else
		self.obj_pool[id] = nil
		print("Add Object Error.")
	end
end

function ObjPool:RemoveObject(id, ...)
	if not id or not self.obj_pool[id] then
		return 0
	end
	-- Event:FireEvent(self.obj_name..".REMOVE", id, ...)
	self.obj_pool[id]:Uninit()
	self.obj_pool[id] = nil
	if self.is_recycle == 1 then
		self.recycle_id_list[#self.recycle_id_list + 1] = id
	end
	return 1
end


function ObjPool:GetNextId()
	local ret_id = self.next_id
	if self.is_recycle == 1 then
		local reserve_id_count = #self.recycle_id_list
		if reserve_id_count > 0 then
			ret_id = self.recycle_id_list[reserve_id_count]
		end
	end
	return ret_id
end

function ObjPool:UpdateNextId()
	if self.is_recycle == 1 then
		local reserve_id_count = #self.recycle_id_list
		if reserve_id_count > 0 then
			self.recycle_id_list[reserve_id_count] = nil
			return
		end
	end
	self.next_id = self.next_id + 1
	while (self.obj_pool[self.next_id]) do
		self.next_id = self.next_id + 1
	end
end

function ObjPool:GetObjById(id)
	if not id then
		return
	end
	return self.obj_pool[id]
end

function ObjPool:GetObjByClassName(obj_class_name)
	if self.obj_pool then
		for _, obj in ipairs(self.obj_pool) do
			if obj.ctor then
				print("The object no inherit a class.")
				return
			end
			if obj.class_name == obj_class_name then
				return obj
			end
		end
	end
end

function ObjPool:ResetId()
	self.next_id = 1
end

function ObjPool:RemoveAllObject(callback)
	for id, obj in pairs(self.obj_pool) do
		if callback then
			callback(id, obj)
		end
		self:Remove(id)
	end
end

function ObjPool:ForEach(callback, ...)
	if self.obj_pool then
		for id, obj in ipairs(self.obj_pool) do
			local ret = callback(id, obj, ...)
			if ret == 0 then
				return
			end
		end
	end
end
