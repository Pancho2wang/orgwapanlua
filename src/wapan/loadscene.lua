--========================================================================
-- @File Name           : loadscene.lua
-- @Author              : pancho
-- @Email               : wcp.peok@hotmail.com
-- @Date                : 2015-01-29 00:43:48
-- @Last Modified time  : 2015-01-31 17:50:59
-- @Description         : wapan
--========================================================================

local LoadScene = ClassMgr:CreateClass("LoadScene", "SceneBase")

function LoadScene:_Init()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self:addChild(self:createLayer())
    return 1
end

function LoadScene:createLayer()
	local layer = cc.Layer:create()
	local label = cc.LabelTTF:create("Hello World.", "Arial", 24)
	label:setColor(cc.c3b(0,0,255))
	label:setPosition(cc.p(self.visibleSize.width/2, self.visibleSize.height/2))
	layer:addChild(label)

	local function menuCallbackOpenPopup()
		-- local scene = ClassMgr:GetClassByName("GameScene")
  --   	local sceneGame = scene.create()
        local sceneGame = PoolMgr:GetPoolByName("ScenePool"):AddCCObject("GameScene", cc.Scene:create())
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