--========================================================================
-- @File Name			: pool_mgr.lua
-- @Author				: pancho
-- @Email				: wcp.peok@hotmail.com
-- @Date				: 2015-01-31 20:39:26
-- @Last Modified time	: 2015-01-31 21:16:21
-- @Description			: wapan
--========================================================================
if not PoolMgr then
	PoolMgr = { pool_list = {}, }
end

function PoolMgr:Reset()
	self.pool_list = {}
	return 1
end

function PoolMgr:CreatePool(pool_name, is_recycle, ...)
	local pool_class = ClassMgr:GetClassByName(pool_name)
	local pool = pool_class.new()
	if pool:Init(pool_name, is_recycle, ...) == 1 then	
		self.pool_list[pool_name] = pool	
		return pool
	else
		print("Add Pool Error.")
	end
end

function PoolMgr:RemoveClass(pool_name)
	if not self.pool_list[pool_name] then
		return
	end
	self.pool_list[pool_name] = nil
end

function PoolMgr:GetPoolByName(pool_name)
	if not self.pool_list[pool_name] then
		assert(false, "No pool["..pool_name.."].")
		return
	end
	return self.pool_list[pool_name]
end

-- local function ResetPoolMgr()
-- 	return PoolMgr:Reset()
-- end
-- AddResetFunction("ResetPoolMgr", ResetPoolMgr)