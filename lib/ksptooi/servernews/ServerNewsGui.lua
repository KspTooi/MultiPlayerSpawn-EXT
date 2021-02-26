---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/2/25 22:33
---

local mod_gui = require("mod-gui")
require("lib/oarc_utils")

newsGuiBtnId = "news_button"

newsGuiId = "news_gui"

newsGuiTitleId = "news_gui_title_btn"

newsGuiConfirmBtnId = "news_gui_confirm_btn"



function createNewsGuiBtn(player)

    if mod_gui.get_button_flow(player).changeLogButtonId == nil then

        local btn = mod_gui.get_button_flow(player).add({
            name = newsGuiBtnId,
            type = "sprite-button",
            sprite="item/blueprint-book",
            tooltip = extConf.displayVersion.." (点击查看服务器公告)",
            style = mod_gui.button_style
        })

    end

end

---显示服务器公告
local function createNewsGui(player)

    if ((player.gui.screen["welcome_msg"] ~= nil) or
            (player.gui.screen["spawn_opts"] ~= nil) or
            (player.gui.screen["shared_spawn_opts"] ~= nil) or
            (player.gui.screen["join_shared_spawn_wait_menu"] ~= nil) or
            (player.gui.screen["buddy_spawn_opts"] ~= nil) or
            (player.gui.screen["buddy_wait_menu"] ~= nil) or
            (player.gui.screen["buddy_request_menu"] ~= nil) or
            (player.gui.screen["wait_for_spawn_dialog"] ~= nil)) then
        log("DisplayWelcomeTextGui called while some other dialog is already displayed!")
        return false
    end

    local wGui = player.gui.screen.add{name = newsGuiId,
                                       type = "frame",
                                       direction = "vertical",
                                       caption="服务器公告"}

    wGui.auto_center=true

    wGui.style.maximal_width = SPAWN_GUI_MAX_WIDTH
    wGui.style.maximal_height = SPAWN_GUI_MAX_HEIGHT


    AddLabel(wGui, "news_gui_text", extConf.serverNews, my_label_style)


    -- Confirm button
    AddSpacerLine(wGui)

    local button_flow = wGui.add{type = "flow"}
    button_flow.style.horizontal_align = "right"
    button_flow.style.horizontally_stretchable = true

    button_flow.add{name = newsGuiConfirmBtnId,
                    type = "button",
                    caption="确认",
                    style = "confirm_button"}

    return true
end



---公告按钮点击
function newsGuiBtnClick(event)

    if not (event and event.element and event.element.valid) then return end

    local player = game.players[event.player_index]
    local buttonClicked = event.element.name

    if not player then
        log("Another gui click happened with no valid player...")
        return
    end


    if (buttonClicked == newsGuiBtnId) then
        createNewsGui(player)
    end


end


---公告确认按钮点击
function newsGuiConfirmBtnClick(event)

    if not (event and event.element and event.element.valid) then return end

    local player = game.players[event.player_index]
    local buttonClicked = event.element.name

    if not player then
        log("Another gui click happened with no valid player...")
        return
    end


    if (buttonClicked == newsGuiConfirmBtnId) then

        if (player.gui.screen.news_gui ~= nil) then
            player.gui.screen.news_gui.destroy()
        end

    end

end