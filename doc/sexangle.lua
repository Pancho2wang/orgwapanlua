local function showTb(t)
	for i,m in pairs(t) do
		local str = ""
		for j,n in pairs(m) do
			str = str .. n .. " | "
		end
		print("| " .. str)
	end
end
local function clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

-- 棋盘
-- -1 不显示； 0 没棋子； 1 自己的棋子； 2~~ 其他棋子
-- local chessboard = {
-- 	[1] = {0,},	--1
-- 	[2] = {0,0,0,}, --3
-- 	[3] = {0,0,0,0,0,}, --5
-- 	[4] = {0,0,0,0,0,0,0,}, --7
-- 	[5] = {0,0,0,0,0,0,0,0,0,},  --9
-- 	[6] = {0,0,0,0,0,0,0,0,0,0,0,}, --11
-- 	[7] = {0,0,0,0,0,0,0,0,0,0,0,0,0,}, --13
-- 	[8] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --15
-- 	[9] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[10] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[11] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[12] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[13] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[14] = {nil,nil,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --15
-- 	[15] = {nil,nil,nil,nil,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --13
-- 	[16] = {nil,nil,nil,nil,nil,nil,0,0,0,0,0,0,0,0,0,0,0,}, --11
-- 	[17] = {nil,nil,nil,nil,nil,nil,nil,nil,0,0,0,0,0,0,0,0,0,}, --9
-- 	[18] = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0,0,0,0,0,0,0,}, --7
-- 	[19] = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0,0,0,0,0,}, --5
-- 	[20] = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0,0,0,}, --3
-- 	[21] = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0,},  --1
-- }
-- local chessboard = {
-- 	[1] = {0,},	--1
-- 	[2] = {0,0,0,}, --3
-- 	[3] = {0,0,0,0,0,}, --5
-- 	[4] = {0,0,0,0,0,0,0,}, --7
-- 	[5] = {0,0,0,0,0,0,0,0,0,},  --9
-- 	[6] = {0,0,0,0,0,0,0,0,0,0,0,}, --11
-- 	[7] = {0,0,0,0,0,0,0,0,0,0,0,0,0,}, --13
-- 	[8] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --15
-- 	[9] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[10] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[11] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[12] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[13] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
-- 	[14] = {[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --15
-- 	[15] = {[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --13
-- 	[16] = {[7]=0,[8]=0,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --11
-- 	[17] = {[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --9
-- 	[18] = {[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --7
-- 	[19] = {[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --5
-- 	[20] = {[15]=0,[16]=0,[17]=0,}, --3
-- 	[21] = {[17]=0,},  --1
-- }

local chessboard = {
	[1] = {1,},	--1
	[2] = {2,0,0,}, --3
	[3] = {0,0,0,0,0,}, --5
	[4] = {2,0,0,0,0,0,0,}, --7
	[5] = {0,0,0,0,0,0,0,0,0,},  --9
	[6] = {2,0,0,0,0,0,0,0,0,0,0,}, --11
	[7] = {0,0,0,0,0,0,0,0,0,0,0,0,0,}, --13
	[8] = {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --15
	[9] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
	[10] = {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
	[11] = {0,2,0,2,0,2,0,2,0,2,0,2,0,0,0,0,0,}, --17
	[12] = {0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,}, --17
	[13] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}, --17
	[14] = {[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=2,[16]=0,[17]=0,}, --15
	[15] = {[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --13
	[16] = {[7]=0,[8]=0,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=2,[16]=0,[17]=0,}, --11
	[17] = {[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --9
	[18] = {[11]=0,[12]=0,[13]=0,[14]=0,[15]=2,[16]=0,[17]=0,}, --7
	[19] = {[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,}, --5
	[20] = {[15]=0,[16]=0,[17]=0,}, --3
	[21] = {[17]=0,},  --1
}
local chessclone = clone(chessboard)
local touch = {x=19,y=15}
local path = {}
local function IsLegalPosition(x, y)
	if x < 1 or x > table.getn(chessboard) then
		return 0
	end
	if not chessboard[x] or not chessboard[x][y] then
		return 0
	end
	if chessboard[x][y] < 0 or chessboard[x][y] > 1 then
		return 0
	end
	if chessclone[x][y] == '#' then
		return 0
	end
	return 1
end

local function find_way(x, y)
	print("=====", x, y)
	if 1 == IsLegalPosition(x,y) then
        if touch.x == x and touch.y == y then
            chessclone[x][y] = '#'  
            table.insert(path, {x, y})
            return 1 
        end
        chessclone[x][y] = '#'
        table.insert(path, {x, y})
        
        --left
        if chessboard[x-1] and chessboard[x-1][y] and chessboard[x-1][y] > 1 then
        	if 1 == find_way(x-2, y) then
        		return 1
        	end
        end

        --upleft
        if chessboard[x][y+1] and chessboard[x][y+1] > 1 then
        	if 1 == find_way(x, y+2) then
        		return 1
        	end
        end

       	--upright
       	if chessboard[x+1] and chessboard[x+1][y+1] and chessboard[x+1][y+1] > 1 then
        	if 1 == find_way(x+2, y+2) then
        		return 1
        	end
        end

        --right
        if chessboard[x+1] and chessboard[x+1][y] and chessboard[x+1][y] > 1 then
        	if 1 == find_way(x+2, y) then
        		return 1
        	end
        end

        --downright
        if chessboard[x][y-1] and chessboard[x][y-1] > 1 then
        	if 1 == find_way(x, y-2) then
        		return 1
        	end
        end

        --downleft
        if chessboard[x-1] and chessboard[x-1][y-1] and chessboard[x-1][y-1] > 1 then
        	if 1 == find_way(x-2, y-2) then
        		return 1
        	end
        end

        chessclone[x][y] = 0  
        table.remove(path)
        return 0
    end

    return 0
end
-- local pos = {
-- 	 {5,5}, --X坐标为1，Y的上限是5，下限是5
--      {5,6}, --X坐标为2，Y的上限是5，下限是6
--      {5,7}, --X坐标为3，Y的上限是5，下限是7
--      {5,8}, --X坐标为4，Y的上限是5，下限是8
--      {1,13}, --X坐标为5，Y的上限是1，下限是13
--      {2,13}, --6
--      {3,13}, --7
--      {4,13}, --8
--      {5,13}, --9
--      {5,14}, --10
--      {5,15}, --11
--      {5,16}, --12
--      {5,17}, --13
--      {10,13}, --14
--      {11,13}, --15
--      {12,13}, --16
--      {13,13}, --17
-- }

-- function IsLegalPosition(x, y)
-- 	if x < 1 or x > 17 then
-- 		return 0
-- 	end
-- 	if y < pos[x][1] or y > pos[x][2] then
-- 		return 0
-- 	end
-- 	return 1
-- end

-- local grid = {
-- 	{0,2,0,},
-- 	{0,0,2,},
-- 	{0,2,0,},
-- }
-- local gvalue = {
-- 	{0,0,0,},
-- 	{0,0,0,},
-- 	{0,0,0,},
-- }
-- local touch = {x=3,y=3}

-- local function checkPosValid(x, y)
-- 	if x < 1 or x > 3 or y < 1 or y > 3 then
-- 		return 0
-- 	end

-- 	if grid[x][y] ~= 0 then
-- 		return 0
-- 	end

-- 	if gvalue[x][y] == '#' then
-- 		return 0
-- 	end
-- 	return 1
-- end

-- local function find_first(x, y)
-- 	gvalue[x][y] = '#'
-- 	if 1 == checkPosValid(x-1,y) then
--         if touch.x == x-1 and touch.y == y then
--             gvalue[x-1][y] = '#'  
--             return 1 
--         end
--     end
--     if 1 == checkPosValid(x+1,y) then
-- 	    if touch.x == x+1 and touch.y == y then
-- 	        gvalue[x+1][y] = '#'  
-- 	        return 1 
-- 	    end
-- 	end
--     if 1 == checkPosValid(x,y-1) then
-- 	    if touch.x == x and touch.y == y-1 then
-- 	        gvalue[x][y-1] = '#'  
-- 	        return 1 
-- 	    end
-- 	end
--     if 1 == checkPosValid(x,y+1) then
-- 	    if touch.x == x and touch.y == y+1 then
-- 	        gvalue[x][y+1] = '#'  
-- 	        return 1 
-- 	    end
-- 	end
-- 	gvalue[x][y] = 0
-- 	return 0
-- end

-- local function find_path(x, y)
-- 	print(x, y)
--     if 1 == checkPosValid(x,y) then
--         if touch.x == x and touch.y == y then
--             gvalue[x][y] = '#'  
--             return 1 
--         end
--         gvalue[x][y] = '#'
        
--         -- right
--   		if y+1 < 3 and grid[x][y+1] > 1 then
--   			if 1 == find_path(x, y+2) then  
-- 	            return 1
-- 	  		end
--   		end

--   		-- down
--   		if x+1 < 3 and grid[x+1][y] > 1 then
--   			if 1 == find_path(x+2, y) then  
-- 	            return 1
-- 	        end
--     	end

--     	-- left
--     	if y-1 > 0 and grid[x][y-1] > 1 then
--         	if 1 == find_path(x, y-2) then
-- 	            return 1
-- 	  		end
-- 	  	end

-- 	  	-- up
--   		if x-1 > 0 and grid[x-1][y] > 1 then
-- 	  		if 1 == find_path(x-2, y) then  
-- 	            return 1
-- 	  		end
--   		end
  		
--         gvalue[x][y] = 0  
--         return 0
--     end

--     return 0
-- end

-- local function showPath(x, y)
-- 	local res = 0
-- 	if 0 == checkPosValid(touch.x, touch.y) or (touch.x == x and touch.y == y) then
-- 		print("touch valid.")
-- 		return res
-- 	end
-- 	if 1 == find_first(x, y) then
-- 		print("aaa")
-- 		showTb(gvalue)
-- 		res = 1
-- 	end
-- 	if 1 == find_path(x, y) then
-- 		print("bbb")
-- 		showTb(gvalue)
-- 		res = 1
-- 	end
-- 	gvalue = {
-- 		{0,0,0,},
-- 		{0,0,0,},
-- 		{0,0,0,},
-- 	}
-- 	print("ccc")
-- 	return res
-- end

local function show_way(x, y)
	print("begin===", x, y)
	if 1 == find_way(x, y) then
		print("success!!!!!!")
		showTb(chessclone)
		chessclone = clone(chessboard)
		touch[x] = 19
		touch[y] = 15
		showTb(path)
		path = {}
		return 1
	end
	print("failed!!!!")
	showTb(chessclone)
	chessclone = clone(chessboard)
	touch[x] = 19
	touch[y] = 15
	showTb(path)
	path = {}
	return 0
end

local function main()
	local a = {nil,nil,1,3,5,}
	for i,v in pairs(a) do
		print(i .. "--" .. v)
	end
	if a[1] == nil then
		print("==="..tostring(table.getn(a)))
	end
   	io.write("operate is 'q'[exit] >> ")
    local op = io.read()
    while op ~= 'q' do
	    io.write("touch.x >> ")
	    local x = tonumber(io.read())
	    io.write("touch.y >> ")
	    local y = tonumber(io.read())
	    if x and y then
	    	touch.x = x
	    	touch.y = y
	    	-- showPath(1,1)
	    	show_way(1,1)
	    end
	    io.write("operate is 'q'[exit] >> ")
	    op = io.read()
	end
	os.exit()
end

main()