--========================================================================
-- @File Name           : main.lua
-- @Author              : pancho
-- @Email               : wcp.peok@hotmail.com
-- @Date                : 2015-01-27 13:50:05
-- @Last Modified time  : 2015-01-29 00:46:16
-- @Description         : wapan
--========================================================================

cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")

-- CC_USE_DEPRECATED_API = true
require "cocos.init"
require "freeframe.init"
require "wapan.init"

-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    assert(RequireScript() == 1)
    local scene_pool = PoolMgr:CreatePool("ScenePool")

    -- initialize director
    local director = cc.Director:getInstance()
    local glview = director:getOpenGLView()
    if nil == glview then
        glview = cc.GLViewImpl:createWithRect("HelloLua", cc.rect(0,0,CONFIG_SCREEN_WIDTH,CONFIG_SCREEN_HEIGHT))
        director:setOpenGLView(glview)
    end

    glview:setDesignResolutionSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT, cc.ResolutionPolicy.NO_BORDER)

    --turn on display FPS
    director:setDisplayStats(DEBUG_FPS_SHOW)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(DEBUG_FPS)

	
    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or 
       (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
       (cc.PLATFORM_OS_MAC == targetPlatform) then
        cclog("result is ")
		--require('debugger')()
        
    end
    
    -- local scene = ClassMgr:GetClassByName("LoadScene")
    -- local sceneGame = scene.create()

    local sceneGame = scene_pool:AddObject("LoadScene")
	if cc.Director:getInstance():getRunningScene() then
		cc.Director:getInstance():replaceScene(sceneGame)
	else
		cc.Director:getInstance():runWithScene(sceneGame)
	end
    return 1
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
