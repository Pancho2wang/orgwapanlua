--========================================================================
-- @File Name           : gamescene.lua
-- @Author              : pancho
-- @Email               : wcp.peok@hotmail.com
-- @Date                : 2015-01-27 14:19:56
-- @Last Modified time  : 2015-01-30 00:54:57
-- @Description         : wapan
--========================================================================

local GameScene = ClassMgr:CreateClass("GameScene", "SceneBase")

function GameScene:_Init()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self:addChild(self:createLayer())
    return 1
end

function GameScene:_Uninit( ... )
    return 1
end

function GameScene:createLayer()
	local layer = cc.Layer:create()
	local label = cc.LabelTTF:create("Game Scene.", "Arial", 30)
	label:setColor(cc.c3b(222,222,0))
	label:setPosition(cc.p(self.visibleSize.width/2, self.visibleSize.height/2))
	layer:addChild(label)

    local function menuCallbackOpenPopup()
        local scene_pool = PoolMgr:GetPoolByName("ScenePool")
        -- local scene = scene_pool:GetObjById(1)
        local sceneGame = scene_pool:AddCCObject("GameScene", cc.Scene:create())
        cc.Director:getInstance():popScene()
        cc.Director:getInstance():pushScene(sceneGame)
    end
     -- add the left-bottom "tools" menu to invoke menuPopup
    local menuToolsItem = cc.MenuItemImage:create("menu1.png", "land.png")
    menuToolsItem:setPosition(0, 0)
    menuToolsItem:registerScriptTapHandler(menuCallbackOpenPopup)

    local function menuCallbackReloadFile()
        DofileScript()
    end
    local reloadItem = cc.MenuItemImage:create("menu1.png", "land.png")
    reloadItem:setPosition(100, 0)
    reloadItem:registerScriptTapHandler(menuCallbackReloadFile)

    local function backScene()
        cc.Director:getInstance():popScene()
    end
    local backItem = cc.MenuItemImage:create("menu1.png", "land.png")
    backItem:setPosition(200, 0)
    backItem:registerScriptTapHandler(backScene)

    local menuTools = cc.Menu:create(menuToolsItem, reloadItem, backItem)
    local itemWidth = menuToolsItem:getContentSize().width
    local itemHeight = menuToolsItem:getContentSize().height
    menuTools:setPosition(itemWidth, itemHeight)
    layer:addChild(menuTools)

	return layer
end

function GameScene:PlayBGMusic( ... )
	local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("background.mp3") 
    cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
    local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
    cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)
end