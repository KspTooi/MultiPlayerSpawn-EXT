-- rocket_launch.lua
-- May 2019

-- This is meant to extract out any rocket launch related logic to support my oarc scenario designs.

require("lib/oarc_utils")
require("config")

--------------------------------------------------------------------------------
-- Rocket Launch Event Code
-- Controls the "win condition"
--------------------------------------------------------------------------------
function RocketLaunchEvent(event)
    local force = event.rocket.force

    -- Notify players on force if rocket was launched without sat.
    if event.rocket.get_item_count("satellite") == 0 then
        for index, player in pairs(force.players) do
            player.print("你发射了火箭，但你没有在里面放卫星。")
        end
        return
    end

    -- First ever sat launch
    if not global.ocore.satellite_sent then
        global.ocore.satellite_sent = {}
        SendBroadcastMsg("Team " .. force.name .. " 是第一个发射火箭的人！")
        ServerWriteFile("rocket_events", "Team " .. force.name .. "  是第一个发射火箭的人！" .. "\n")

        for name,player in pairs(game.players) do
            SetOarcGuiTabEnabled(player, OARC_ROCKETS_GUI_TAB_NAME, true)
        end
    end

    -- Track additional satellites launched by this force
    if global.ocore.satellite_sent[force.name] then
        global.ocore.satellite_sent[force.name] = global.ocore.satellite_sent[force.name] + 1
        SendBroadcastMsg("Team " .. force.name .. "  发射了另一枚火箭。 共计 " .. global.ocore.satellite_sent[force.name])
        ServerWriteFile("rocket_events", "Team " .. force.name .. " 发射了另一枚火箭。 共计 " .. global.ocore.satellite_sent[force.name] .. "\n")

    -- First sat launch for this force.
    else
        -- game.set_game_state{game_finished=true, player_won=true, can_continue=true}
        global.ocore.satellite_sent[force.name] = 1
        SendBroadcastMsg("Team " .. force.name .. " 发射了他们的第一枚火箭！")
        ServerWriteFile("rocket_events", "Team " .. force.name .. "  发射了他们的第一枚火箭！" .. "\n")

        -- Unlock research and recipes
        if global.ocfg.lock_goodies_rocket_launch then
            for _,v in ipairs(LOCKED_TECHNOLOGIES) do
                EnableTech(force, v.t)
            end
            for _,v in ipairs(LOCKED_RECIPES) do
                if (force.technologies[v.r].researched) then
                    AddRecipe(force, v.r)
                end
            end
        end
    end
end

function CreateRocketGuiTab(tab_container, player)
    -- local frame = tab_container.add{type="frame", name="rocket-panel", caption="Satellites Launched:", direction = "vertical"}

    AddLabel(tab_container, nil, "发射的卫星:", my_label_header_style)

    if (global.ocore.satellite_sent == nil) then
        AddLabel(tab_container, nil, "还没有发射.", my_label_style)
    else
        for force_name,sat_count in pairs(global.ocore.satellite_sent) do
            AddLabel(tab_container,
                    "rc_"..force_name,
                    "Team " .. force_name .. ": " .. tostring(sat_count),
                    my_label_style)
        end
    end
end

