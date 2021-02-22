-- game_opts.lua
-- Jan 2018
-- Display current game options, maybe have some admin controls here

-- Main Configuration File
require("config")
require("lib/oarc_utils")
require("lib/separate_spawns")

function GameOptionsGuiClick(event)
    if not (event and event.element and event.element.valid) then return end
    local player = game.players[event.player_index]
    local name = event.element.name

    if (name == "ban_player") then
        local pIndex = event.element.parent.ban_players_dropdown.selected_index

        if (pIndex ~= 0) then
            local banPlayer = event.element.parent.ban_players_dropdown.get_item(pIndex)
            if (game.players[banPlayer]) then
                game.ban_player(banPlayer, "被禁止进入管理面板.")
                log("Banning " .. banPlayer)
            end
        end
    end

    if (name == "restart_player") then
        local pIndex = event.element.parent.ban_players_dropdown.selected_index

        if (pIndex ~= 0) then
            local resetPlayer = event.element.parent.ban_players_dropdown.get_item(pIndex)
            if (game.players[resetPlayer]) then
                RemoveOrResetPlayer(player, false, true, true, true)
                SeparateSpawnsPlayerCreated(resetPlayer, true)
                log("Resetting " .. resetPlayer)
            end
        end
    end
end

-- Used by AddOarcGuiTab
function CreateGameOptionsTab(tab_container, player)

    if global.oarc_announcements ~= nil then
        AddLabel(tab_container, "announcement_info_label", "服务器公告:", my_label_header_style)
        AddLabel(tab_container, "announcement_info_txt", global.oarc_announcements, my_longer_label_style)
        AddSpacerLine(tab_container)
    end

    -- General Server Info:
    AddLabel(tab_container, "info_1", global.ocfg.welcome_msg, my_longer_label_style)
    AddLabel(tab_container, "info_2", global.ocfg.server_rules, my_longer_label_style)
    AddLabel(tab_container, "info_3", global.ocfg.server_contact, my_longer_label_style)
    tab_container.add{type="textfield",
                            tooltip="Come join the discord (copy this invite)!",
                            text=DISCORD_INV}
    AddSpacerLine(tab_container)

    -- Enemy Settings:
    local enemy_expansion_txt = "disabled"
    if game.map_settings.enemy_expansion.enabled then enemy_expansion_txt = "enabled" end

    local enemy_text="服务器运行时间: " .. formattime_hours_mins(game.tick) .. "\n" ..
    "当前的演变: " .. string.format("%.4f", game.forces["enemy"].evolution_factor) .. "\n" ..
    "敌方进化时间因子/污染因子/破坏因子: " .. game.map_settings.enemy_evolution.time_factor .. "/" ..
    game.map_settings.enemy_evolution.pollution_factor .. "/" ..
    game.map_settings.enemy_evolution.destroy_factor .. "\n" ..
    "敌方扩张 " .. enemy_expansion_txt

    AddLabel(tab_container, "enemy_info", enemy_text, my_longer_label_style)
    AddSpacerLine(tab_container)

    -- Soft Mods:
    local soft_mods_string = "Oarc核心"
    if (global.ocfg.enable_undecorator) then
        soft_mods_string = soft_mods_string .. ", Undecorator（删除装饰物以减小保存文件的大小）"
    end
    if (global.ocfg.enable_tags) then
        soft_mods_string = soft_mods_string .. ", 标签"
    end
    if (global.ocfg.enable_long_reach) then
        soft_mods_string = soft_mods_string .. ", Long Reach（长距离）"
    end
    if (global.ocfg.enable_autofill) then
        soft_mods_string = soft_mods_string .. ", 自动填充"
    end
    if (global.ocfg.enable_player_list) then
        soft_mods_string = soft_mods_string .. ", 玩家列表"
    end
    if (global.ocfg.enable_regrowth) then
        soft_mods_string = soft_mods_string .. ", Regrowth（定期清理未使用的块。帮助缩小地图尺寸）"
    end
    if (global.ocfg.enable_chest_sharing) then
        soft_mods_string = soft_mods_string .. ", 物品和能源共享"
    end
    if (global.ocfg.enable_magic_factories) then
        soft_mods_string = soft_mods_string .. ", 特殊地图区块"
    end
    if (global.ocfg.enable_offline_protect) then
        soft_mods_string = soft_mods_string .. ", 离线攻击抑制器（不保证100％）"
    end

    local game_info_str = "软模组: " .. soft_mods_string

    -- Spawn options:
    if (global.ocfg.enable_separate_teams) then
        game_info_str = game_info_str.."\n".."你被允许出生在你自己的团队中（有自己的研究树）。所有的队伍都很友好！"
    end
    if (global.ocfg.enable_vanilla_spawns) then
        game_info_str = game_info_str.."\n".."在默认起始区域中出生。"
    else
        game_info_str = game_info_str.."\n".."你出生在默认起始资源的区域。"
        if (global.ocfg.enable_buddy_spawn) then
            game_info_str = game_info_str.."\n".."你可以选择和朋友一起出生在相同的地方，如果选择一致。"
        end
    end
    if (global.ocfg.enable_shared_spawns) then
        game_info_str = game_info_str.."\n".."队长可以选择共享自己的重生点，并允许其他玩家加入。"
    end
    if (global.ocfg.enable_separate_teams and global.ocfg.enable_shared_team_vision) then
        game_info_str = game_info_str.."\n".."每个人 (所有团队) 有共同的目标。"
    end
    if (global.ocfg.frontier_rocket_silo) then
        game_info_str = game_info_str.."\n".."火箭发射井只能在地图上的某些区域放置！"
    end
    if (global.ocfg.enable_regrowth) then
        game_info_str = game_info_str.."\n".."地图上的旧区块会慢慢被删除随着时间的推移 (区块没有任何玩家的建筑)。"
    end
    if (global.ocfg.enable_power_armor_start or global.ocfg.enable_modular_armor_start) then
        game_info_str = game_info_str.."\n".."启用快速启动。"
    end
    if (global.ocfg.lock_goodies_rocket_launch) then
        game_info_str = game_info_str.."\n".."一些科技和物品在你发射火箭之前是锁定的！（关闭）"
    end



    AddLabel(tab_container, "game_info_label", game_info_str, my_longer_label_style)

    if (global.ocfg.enable_abandoned_base_removal) then
        AddLabel(tab_container, "leave_warning_msg", "如果你离开在  " .. global.ocfg.minimum_online_time .. " 分钟内从加入起算, 你的基地和角色将被移除。.", my_longer_label_style)
        tab_container.leave_warning_msg.style.font_color=my_color_red
    end

    -- Ending Spacer
    AddSpacerLine(tab_container)

    -- ADMIN CONTROLS
    if (player.admin) then
        player_list = {}
        for _,player in pairs(game.connected_players) do
            table.insert(player_list, player.name)
        end
        tab_container.add{name = "ban_players_dropdown",
                        type = "drop-down",
                        items = player_list}
        tab_container.add{name="ban_player", type="button", caption="封禁玩家"}
        tab_container.add{name="restart_player", type="button", caption="重置玩家"}
    end
end
