local function showTb(t)
	for i,m in ipairs(t) do
		local str = ""
		for j,n in ipairs(m) do
			str = str .. n .. " | "
		end
		print("| " .. str)
	end
end

local grid = {
	{0,2,0,},
	{0,0,2,},
	{0,2,0,},
}
local gvalue = {
	{0,0,0,},
	{0,0,0,},
	{0,0,0,},
}
local touch = {x=3,y=3}

local function checkPosValid(x, y)
	if x < 1 or x > 3 or y < 1 or y > 3 then
		return 0
	end

	if grid[x][y] ~= 0 then
		return 0
	end

	if gvalue[x][y] == '#' then
		return 0
	end
	return 1
end

local function find_first(x, y)
	gvalue[x][y] = '#'
	if 1 == checkPosValid(x-1,y) then
        if touch.x == x-1 and touch.y == y then
            gvalue[x-1][y] = '#'  
            return 1 
        end
    end
    if 1 == checkPosValid(x+1,y) then
	    if touch.x == x+1 and touch.y == y then
	        gvalue[x+1][y] = '#'  
	        return 1 
	    end
	end
    if 1 == checkPosValid(x,y-1) then
	    if touch.x == x and touch.y == y-1 then
	        gvalue[x][y-1] = '#'  
	        return 1 
	    end
	end
    if 1 == checkPosValid(x,y+1) then
	    if touch.x == x and touch.y == y+1 then
	        gvalue[x][y+1] = '#'  
	        return 1 
	    end
	end
	gvalue[x][y] = 0
	return 0
end

local function find_path(x, y)
	print(x, y)
    if 1 == checkPosValid(x,y) then
        if touch.x == x and touch.y == y then
            gvalue[x][y] = '#'  
            return 1 
        end
        gvalue[x][y] = '#'
        
        -- right
  		if y+1 < 3 and grid[x][y+1] > 1 then
  			if 1 == find_path(x, y+2) then  
	            return 1
	  		end
  		end

  		-- down
  		if x+1 < 3 and grid[x+1][y] > 1 then
  			if 1 == find_path(x+2, y) then  
	            return 1
	        end
    	end

    	-- left
    	if y-1 > 0 and grid[x][y-1] > 1 then
        	if 1 == find_path(x, y-2) then
	            return 1
	  		end
	  	end

	  	-- up
  		if x-1 > 0 and grid[x-1][y] > 1 then
	  		if 1 == find_path(x-2, y) then  
	            return 1
	  		end
  		end
  		
        gvalue[x][y] = 0  
        return 0
    end

    return 0
end

local function showPath(x, y)
	local res = 0
	if 0 == checkPosValid(touch.x, touch.y) or (touch.x == x and touch.y == y) then
		print("touch valid.")
		return res
	end
	if 1 == find_first(x, y) then
		print("aaa")
		showTb(gvalue)
		res = 1
	end
	if 1 == find_path(x, y) then
		print("bbb")
		showTb(gvalue)
		res = 1
	end
	gvalue = {
		{0,0,0,},
		{0,0,0,},
		{0,0,0,},
	}
	print("ccc")
	return res
end

local function main()
   	io.write("operate is 'q'[exit] >> ")
    local op = io.read()
    while op ~= 'q' do
	    io.write("touch.x >> ")
	    local x = tonumber(io.read())
	    io.write("touch.y >> ")
	    local y = tonumber(io.read())
	    if x and y and 1<=x and x<=3 and 1<=y and y<=3 then
	    	touch.x = x
	    	touch.y = y
	    	showPath(1,1)
	    end
	    io.write("operate is 'q'[exit] >> ")
	    op = io.read()
	end
	os.exit()
end

main()