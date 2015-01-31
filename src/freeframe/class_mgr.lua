--========================================================================
-- @File Name			: class_mgr.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-27 18:32:02
-- @Last Modified time	: 2015-01-31 20:11:13
-- @Description			: wapan
--========================================================================

if not ClassMgr then
	ClassMgr = { class_list = {}, }
end

function ClassMgr:Reset()
	self.class_list = {}
	return 1
end

function ClassMgr:CreateClass(class_name, super)
	if self.class_list[class_name] then
		assert(false, "Class list had the class["..class_name.."].")
		return
	end
	local _class
	local type_super = type(super)
	if type_super == "string" and self.class_list[super] then
		_class = wp_class(class_name, self.class_list[super])
	elseif type_super == "table" then
		_class = wp_class(class_name, super)
	else
		_class = wp_class(class_name, super)
	end
	self.class_list[class_name] = _class
	return _class
end

function ClassMgr:RemoveClass(class_name)
	if not self.class_list[class_name] then
		return
	end
	self.class_list[class_name] = nil
end

function ClassMgr:GetClassByName(class_name)
	if not self.class_list[class_name] then
		assert(false, "No class["..class_name.."].")
		return
	end
	return self.class_list[class_name]
end

local function ResetClassMgr()
	return ClassMgr:Reset()
end
AddResetFunction("ResetClassMgr", ResetClassMgr)