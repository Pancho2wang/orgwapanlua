--========================================================================
-- @File Name           : loadscene.lua
-- @Author              : pancho
-- @Email               : wcp.peok@hotmail.com
-- @Date                : 2015-01-29 00:43:48
-- @Last Modified time  : 2015-01-31 17:50:59
-- @Description         : wapan
--========================================================================

local ca = wp_class("ca")
-- ca.__index = ca
function ca:ctor( ... )
    -- body
end
function ca:_Init( ... )
    -- body
    self.a = 1
    print("init ca")
    return 1
end
function ca:changeca( ... )
    self.a = 5
end
function ca:printca( ... )
    print("ca")
end
local cb = wp_class("cb", ca)
-- cb.__index = cb
function cb:ctor( ... )
    -- body
end
function cb:_Init( ... )
    -- body
    self.b = 2
    print("cb init")
    return 1
end
function cb:printcb( ... )
    self.a = 3
    print("cb")
end

-- local LoadScene = wp_class("LoadScene", function()
-- 	return cc.Scene:create()
-- end)
local LoadScene = ClassMgr:CreateClass("LoadScene", function()
    return cc.Scene:create()
end)

function LoadScene.create()
    local j = "ldjfldhfl"
    print(type(j))
    local a = ca.new()
    local b = cb.new()
    a:Init()
    b:Init()
    b:printcb()
    ShowTB(b)
    print("=============")
    ShowTB(a)
    print("---------------")
    
    local x = cb.new()
    print("x =======")
    x:Init()
    x:changeca()
    ShowTB(x)
    x:printcb()
    x:printca()
	local scene = LoadScene.new()
	scene:addChild(scene:createLayer())
	return scene
end

function LoadScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self:addChild(self:createLayer())
end

function LoadScene:createLayer()
	local layer = cc.Layer:create()
	local label = cc.LabelTTF:create("Hello World.", "Arial", 24)
	label:setColor(cc.c3b(0,0,255))
	label:setPosition(cc.p(self.visibleSize.width/2, self.visibleSize.height/2))
	layer:addChild(label)

	local function menuCallbackOpenPopup()
		-- DofileScript()
		local scene = ClassMgr:GetClassByName("GameScene")
    	local sceneGame = scene.create()
		cc.Director:getInstance():pushScene(sceneGame)
    end

    -- add the left-bottom "tools" menu to invoke menuPopup
    local menuToolsItem = cc.MenuItemImage:create("menu1.png", "land.png")
    menuToolsItem:setPosition(0, 0)
    menuToolsItem:registerScriptTapHandler(menuCallbackOpenPopup)
    local menuTools = cc.Menu:create(menuToolsItem)
    local itemWidth = menuToolsItem:getContentSize().width + 100
    local itemHeight = menuToolsItem:getContentSize().height
    menuTools:setPosition(itemWidth, itemHeight)
    layer:addChild(menuTools)

	return layer
end

function LoadScene:PlayBGMusic( ... )
	local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("background.mp3") 
    cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
    local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
    cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)
end

-- local function AddLoadSceneClass()
--     ClassMgr:Add("LoadScene", LoadScene)
--     return 1
-- end

-- AddInitFunction("AddLoadSceneClass", AddLoadSceneClass)