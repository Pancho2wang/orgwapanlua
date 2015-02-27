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
    local world_sprite = cc.Sprite:create("world.jpg")
    world_sprite:setPosition(cc.p(self.visibleSize.width/2, self.visibleSize.height/2))
    layer:addChild(world_sprite)
    local menu_item = {}
    local other_sprite = {}
    local own_sprite = nil
    local chessboard = GetChessBoard()
    local chess_x, chess_y = GetChessPos()

    local a_ball = cc.Sprite:create("ball.png")
    local content_size_w = a_ball:getContentSize().width

    local function ClickBall(event_type, sender)
        -- print(sender.touch_pos.x, sender.touch_pos.y)
        local res, path = show_way(1, 1, sender.touch_pos)
        if res == 0 then
            return
        end
        local me = layer:getChildByName("own")
        if not me then
            return
        end
        local action = {}
        for i, pos in ipairs(path) do
            if i > 1 then
                local x = 5
                local bn = 13
                local touch_x = math.ceil((pos[2] + 1)/2)
                if pos[2]%2 == 0 then
                    bn = 12
                    x = x + content_size_w/2
                    touch_x = math.ceil((pos[2] + 2)/2)
                end
                -- local jumpto = cc.JumpTo:create(0.5, cc.p(x + content_size_w/2 + content_size_w*(pos[1]-1), 120 + content_size_w*(pos[2]-1)), 60, 1)
                local temp_i = pos[1]+1-touch_x
                local jumpto = cc.JumpTo:create(0.5, cc.p(x + content_size_w/2 + content_size_w*(temp_i-1), 120 + content_size_w*(pos[2]-1)), 60, 1)
                table.insert(action, jumpto)
            end
        end
        if #action > 0 then
            me:runAction(cc.Sequence:create(unpack(action)))
        end
    end
    
    local y = 120
    for j=1,17 do
        local x = 5
        local bn = 13
        local touch_x = math.ceil((j + 1)/2)
        if j%2 == 0 then
            bn = 12
            x = x + content_size_w/2
            touch_x = math.ceil((j + 2)/2)
        end
        for i=1,bn do
            -- local ball = cc.Sprite:create("ball.png")
            -- if chess_x == i and chess_y == j then
            --     ball = cc.Sprite:create("ball2.png")
            -- end
            -- local ball = cc.MenuItemImage:create("ball.png","ball2.png")
            local ball = cc.MenuItemImage:create("dipan.png","ball2.png")
            -- if chess_x == i and chess_y == j then
            --     ball = cc.MenuItemImage:create("ball2.png","ball.png")
            -- end
            ball:setAnchorPoint(0.5,0.5)
            ball:setPosition(cc.p(x + ball:getContentSize().width/2, y))
            ball.touch_pos = {x = touch_x + i - 1, y = j}
            -- ball:setTouchEnabled(true)
            ball:registerScriptTapHandler(ClickBall)
            -- print(ball.touch_pos.x, ball.touch_pos.y)
            -- layer:addChild(ball)
            table.insert(menu_item, ball)
            if chessboard[ball.touch_pos.x][ball.touch_pos.y] > 1 then
                local ball_sprite = cc.Sprite:create("ball.png")
                ball_sprite:setAnchorPoint(0.5,0.5)
                ball_sprite:setPosition(cc.p(x + ball:getContentSize().width/2, y))
                ball_sprite:setName("other")
                table.insert(other_sprite, ball_sprite)
                -- layer:addChild(ball_sprite)
            end
            if chess_x == ball.touch_pos.x and chess_y == ball.touch_pos.y then
                own_sprite = cc.Sprite:create("ball2.png")
                own_sprite:setAnchorPoint(0.5,0.5)
                own_sprite:setPosition(cc.p(x + ball:getContentSize().width/2, y))
                own_sprite:setName("own")
                -- ball:addChild(own_sprite)
            end
            x = x + ball:getContentSize().width
        end
        y = y + content_size_w
    end
    local menu = cc.Menu:create(unpack(menu_item))
    menu:setAnchorPoint(0, 0)
    menu:setPosition(cc.p(0, 0))
    layer:addChild(menu)

    for _, ball_sprite in ipairs(other_sprite) do
        layer:addChild(ball_sprite)
    end
    layer:addChild(own_sprite)
    
	local label = cc.LabelTTF:create("Game Scene.", "Arial", 30)
	label:setColor(cc.c3b(0,0,222))
	label:setPosition(cc.p(self.visibleSize.width/2, self.visibleSize.height - 30))
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
        local scene_pool = PoolMgr:GetPoolByName("ScenePool")
        local _, id = scene_pool:GetObjByClassName("GameScene")
        scene_pool:RemoveObject(id)
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