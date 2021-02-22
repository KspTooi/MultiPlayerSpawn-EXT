-- oarc_store_player_items.lua
-- May 2020
-- Adding microtransactions.

local mod_gui = require("mod-gui")

OARC_STORE_PLAYER_ITEMS = 
{
    ["Guns"] = {
        ["pistol"] = {cost = 1, count = 1, play_time_locked=false},
        ["shotgun"] = {cost = 5, count = 1, play_time_locked=false},
        ["submachine-gun"] = {cost = 10, count = 1, play_time_locked=false},
        ["flamethrower"] = {cost = 50, count = 1, play_time_locked=true},
        ["rocket-launcher"] = {cost = 50, count = 1, play_time_locked=true},
        -- ["railgun"] = {cost = 250, count = 1, play_time_locked=true}, -- SAD
    },

    ["Turrets"] = {
        ["gun-turret"] = {cost = 100, count = 1, play_time_locked=false},
        ["flamethrower-turret"] = {cost = 200, count = 1, play_time_locked=false},
        ["laser-turret"] = {cost = 250, count = 1, play_time_locked=false},
        ["artillery-turret"] = {cost = 2000, count = 1, play_time_locked=true},
    },

    ["Ammo"] = {
        ["firearm-magazine"] = {cost = 25, count = 10, play_time_locked=false},
        ["piercing-rounds-magazine"] = {cost = 50, count = 10, play_time_locked=false},
        ["shotgun-shell"] = {cost = 60, count = 10, play_time_locked=false},
        ["flamethrower-ammo"] = {cost = 50, count = 10, play_time_locked=true},
        ["rocket"] = {cost = 100, count = 10, play_time_locked=true},
        -- ["railgun-dart"] = {cost = 250, count = 10, play_time_locked=true}, -- SAD
        ["atomic-bomb"] = {cost = 2500, count = 1, play_time_locked=true},
        ["artillery-shell"] = {cost = 75, count = 1, play_time_locked=true},

    },

    ["Special"] = {
        ["repair-pack"] = {cost = 5, count = 1, play_time_locked=false},
        ["raw-fish"] = {cost = 5, count = 1, play_time_locked=false},
        ["grenade"] = {cost = 100, count = 10, play_time_locked=true},
        ["cliff-explosives"] = {cost = 250, count = 10, play_time_locked=true},
        ["artillery-targeting-remote"] = {cost = 500, count = 1, play_time_locked=true},
        ["loader"] = {cost = 250, count = 1, play_time_locked=false},
        ["fast-loader"] = {cost = 500, count = 1, play_time_locked=true},
        ["express-loader"] = {cost = 750, count = 1, play_time_locked=true},
    },

    ["Capsules/Mines"] = {
        ["land-mine"] = {cost = 250, count = 25, play_time_locked=false},
        ["defender-capsule"] = {cost = 500, count = 25, play_time_locked=false},
        ["distractor-capsule"] = {cost = 600, count = 25, play_time_locked=false},
        ["destroyer-capsule"] = {cost = 750, count = 25, play_time_locked=false},
        ["poison-capsule"] = {cost = 250, count = 10, play_time_locked=false},
        ["slowdown-capsule"] = {cost = 250, count = 10, play_time_locked=false},
    },

    ["Armor"] = {
        ["light-armor"] = {cost = 250, count = 1, play_time_locked=false},
        ["heavy-armor"] = {cost = 500, count = 1, play_time_locked=false},
        ["modular-armor"] = {cost = 1000, count = 1, play_time_locked=false},
        ["power-armor"] = {cost = 2500, count = 1, play_time_locked=false},
        ["power-armor-mk2"] = {cost = 5000, count = 1, play_time_locked=false},
    },
    
    ["Power Equipment"] = {
        ["fusion-reactor-equipment"] = {cost = 1800, count = 1, play_time_locked=false},
        ["battery-equipment"] = {cost = 500, count = 1, play_time_locked=false},
        ["battery-mk2-equipment"] = {cost = 2500, count = 1, play_time_locked=false},
        ["solar-panel-equipment"] = {cost = 50, count = 1, play_time_locked=false},
    },

--[[    ["Bot Equipment"] = {
        ["personal-roboport-equipment"] = {cost = 100, count = 1, play_time_locked=false},
        ["personal-roboport-mk2-equipment"] = {cost = 500, count = 1, play_time_locked=false},
        ["construction-robot"] = {cost = 100, count = 10, play_time_locked=false},
        ["roboport"] = {cost = 1000, count = 1, play_time_locked=false},
        ["logistic-chest-storage"] = {cost = 100, count = 1, play_time_locked=false},
    },]]

    ["Misc Equipment"] = {
        ["belt-immunity-equipment"] = {cost = 200, count = 1, play_time_locked=false},
        ["exoskeleton-equipment"] = {cost = 500, count = 1, play_time_locked=false},
        ["night-vision-equipment"] = {cost = 500, count = 1, play_time_locked=false},
        ["personal-laser-defense-equipment"] = {cost = 800, count = 1, play_time_locked=false},
        -- ["discharge-defense-equipment"] = {cost = 1, count = 1, play_time_locked=false},
        ["energy-shield-equipment"] = {cost = 500, count = 1, play_time_locked=false},
        ["energy-shield-mk2-equipment"] = {cost = 2500, count = 1, play_time_locked=false},
    },

    ["Spidertron"] = {
        ["spidertron"] = {cost = 8000, count = 1, play_time_locked=false},
        ["spidertron-remote"] = {cost = 500, count = 1, play_time_locked=false},
    },
}

function CreatePlayerStoreTab(tab_container, player)

    local player_inv = player.get_main_inventory()
    if (player_inv == nil) then return end

    local wallet = player_inv.get_item_count("coin")
    AddLabel(tab_container,
        "player_store_wallet_lbl",
        "我的现金: " .. wallet .. "  [item=coin]",
        {top_margin=5, bottom_margin=5})
    AddLabel(tab_container, "coin_info", "玩家从一些现金开始。 通过杀死敌人赚取更多的硬币。", my_note_style)
    AddLabel(tab_container,
        "player_store_note_lbl",
        "玩了一段时间后，锁定的物品变得可用...",
        my_note_style)

    local line = tab_container.add{type="line", direction="horizontal"}
    line.style.top_margin = 5
    line.style.bottom_margin = 5

    for category,section in pairs(OARC_STORE_PLAYER_ITEMS) do
        local flow = tab_container.add{name = category, type="flow", direction="horizontal"}
        for item_name,item in pairs(section) do
            local color = "[color=green]"
            if (item.cost > wallet) then
                color = "[color=red]"
            end
            local btn = flow.add{name=item_name,
                        type="sprite-button",
                        number=item.count,
                        sprite="item/"..item_name,
                        tooltip=item_name .. " 费用: "..color..item.cost.."[/color] [item=coin]",
                        style=mod_gui.button_style}
            if (item.play_time_locked and (player.online_time < TICKS_PER_MINUTE*15)) then
                btn.enabled = false
            end
        end
        local line2 = tab_container.add{type="line", direction="horizontal"}
        line2.style.top_margin = 5
        line2.style.bottom_margin = 5
    end
end

function OarcPlayerStoreButton(event)
    local button = event.element
    local player = game.players[event.player_index]

    local player_inv = player.get_inventory(defines.inventory.character_main)
    if (player_inv == nil) then return end

    local category = button.parent.name

    local item = OARC_STORE_PLAYER_ITEMS[category][button.name]

    if (player_inv.get_item_count("coin") >= item.cost) then
        player_inv.insert({name = button.name, count = item.count})
        player_inv.remove({name = "coin", count = item.cost})

        if (button.parent and button.parent.parent and button.parent.parent.player_store_wallet_lbl) then
            local wallet = player_inv.get_item_count("coin")
            button.parent.parent.player_store_wallet_lbl.caption = "可用现金: " .. wallet .. "  [item=coin]"
        end

    else
        player.print("你没有那么多钱,老板对你超不屑....")
    end
end
