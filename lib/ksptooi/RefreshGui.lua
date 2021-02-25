---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/2/25 1:17
---

local mod_gui = require("mod-gui")
require("lib.ksptooi.servernews.ServerNewsGui")

refreshButtonId = "refresh_button"
refreshGuiId = "refresh_gui"



function createRefreshGuiButton(player)

    if (mod_gui.get_button_flow(player).refresh_button == nil) then

        local btn = mod_gui.get_button_flow(player).add{name=refreshButtonId,
                                                      type="sprite-button",
                                                      sprite="item/engine-unit",
                                                        tooltip="载入主菜单",
                                                      style=mod_gui.button_style}
        btn.style.padding=4
    end

end

function refreshButtonClick(event)

    if not (event and event.element and event.element.valid) then return end

    local player = game.players[event.player_index]
    local buttonClicked = event.element.name

    if not player then
        log("Another gui click happened with no valid player...")
        return
    end


    if (buttonClicked == refreshButtonId) then


        mod_gui.get_frame_flow(player).clear()
        mod_gui.get_button_flow(player).clear()


        InitOarcGuiTabs(player)

        if global.ocfg.enable_coin_shop then
            InitOarcStoreGuiTabs(player)
        end

        createNewsGuiBtn(player)
        createRefreshGuiButton(player)


    end



end
