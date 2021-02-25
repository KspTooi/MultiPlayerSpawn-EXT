-- oarc_store_map_features.lua
-- May 2020
-- Adding microtransactions.

require("lib/shared_chests")
require("lib/map_features")
local mod_gui = require("mod-gui")

OARC_STORE_MAP_TEXT = 
{
    special_chests = "用于共享或监控物品和能量的特殊建筑。这将把16格内最近的木箱(离你)转换成你选择的特殊建筑。确保留下足够的空间! 组合器和蓄能器可以占据周围的几块格子。",
    special_chunks = "可以在地图上的特殊空块上建造的地图功能。你必须站在一个空的特殊块内才能建造这些。每个玩家只能建造一种类型的东西。 [color=red]这些功能是永久性的，不能被移除![/color]",
    special_buttons = "特殊的按钮，如传送回家和挖水。",
    seller_buttons = "用于卖出物品获取现金",
    reset_buttons = "重置你的玩家和基地。 [color=red]谨慎选择！ 无法撤消。[/color] 如果您没有基地和自己的部队，则可能无法使用某些选项。"
}

-- N = number already purchased
-- Cost = initial + (additional * ( N^multiplier ))
OARC_STORE_MAP_FEATURES = 
{
    special_chests = {
        ["logistic-chest-storage"] = {
            initial_cost = 2600,
--            additional_cost = 20,
--            multiplier_cost = 2,
--            max_cost = 200,
            -- limit = 100,
            text="输入箱子，用于存放共享物品。"},
        ["logistic-chest-requester"] = {
            initial_cost = 2600,
--            additional_cost = 50,
--            multiplier_cost = 2,
--            max_cost = 4000,
            -- limit = 100,
            text="输出箱子，用于请求共享物品。"},
        ["constant-combinator"] = {
            initial_cost = 2600,
            text="组合器设置，用于监视共享项目。"},
        ["accumulator"] = {
            initial_cost = 2600,
--            additional_cost = 50,
--            multiplier_cost = 2,
--            max_cost = 2000,
            -- limit = 100,
            text="共享能源系统的输入。 [color=red]只有在充电到50%时才开始共享.[/color]"},
        ["electric-energy-interface"] = {
            initial_cost = 2600,
--            additional_cost = 100,
--            multiplier_cost = 2,
--            max_cost = 4000,
            -- limit = 100,
            text="共享能源系统的输出。 [color=red]不会给其他特殊电接口供电! 特别是你不能用它来驱动特殊的块![/color]"},
        ["deconstruction-planner"] = {
            initial_cost = 100,
            text="移除范围内最近的特殊建筑。 不退款！"},
    },

    special_chunks = {
        ["electric-furnace"] = {
            initial_cost = 5000,
--            additional_cost = 1000,
--            multiplier_cost = 2,
            -- limit = 3,
            text="在这里建一个特殊的炉块，包含4个电炉，以非常高的速度运行。 [color=red]需要来自共享存储的能量。 插件没有效果！[/color]"},
        ["oil-refinery"] = {
            initial_cost = 5000,
--            additional_cost = 1000,
--            multiplier_cost = 2,
            -- limit = 3,
            text="在这里建造一个特殊的炼油厂。 包含2个炼油厂和一些化工厂，以非常高的速度运行。 [color=red]需要来自共享存储的能量。 插件没有效果！[/color]"},
        ["assembling-machine-3"] = {
            initial_cost = 6500,
--            additional_cost = 1000,
--            multiplier_cost = 2,
            -- limit = 3,
            text="在这里建造一个特殊的组装机块。包含6台组装机，以非常高的速度运行。 [color=red]需要来自共享存储的能量。 插件没有效果！[/color]"},
        ["centrifuge"] = {
            initial_cost = 5000,
--            additional_cost = 1000,
--            multiplier_cost = 2,
            -- limit = 1,
            text="在这里建造一个特殊的离心机块。 包含1个离心机，以非常高的速度运行。 [color=red]需要来自共享存储的能量。 插件没有效果！[/color]"},
        ["rocket-silo"] = {
            initial_cost = 8000,
--            additional_cost = 0,
--            multiplier_cost = 2,
--            max_cost = 10000,
            -- limit = 2,
            text="将这个特殊块转换为火箭发射台。这样你就可以在这里建造一个火箭发射井了!"},
    },

    -- special_chunks_upgrades = {
    --     ["big-electric-pole"] = {
    --         cost = 0,
    --         text = "Upgrade your special chunk so that it pulls power from the cloud! Refills the accumulator from the cloud automatically if it falls below 50%."
    --     }

    -- }

    special_buttons = {
        ["assembling-machine-1"] = {
            initial_cost = 350,
            text="传送回家。"}
--[[        ["offshore-pump"] = {
            initial_cost = 5000,
            text="把最近的空木箱变成水!"
        }]]
    },

    seller_buttons = {
        ["raw-fish"] = { initial_cost = 10, text="卖出五条鱼"}
    },

    reset_buttons = {
        ["electronic-circuit"] = {
            initial_cost = 7500,
            solo_force = true,
            text="[color=red]请勿尝试 点击即清空!这不能被撤销![/color]一般重置,这个选项会完全清空你的建筑,载具与科技,但会保留背包"
        },
        ["advanced-circuit"] = {
            initial_cost = 7500,
            solo_force = true,
            text="[color=red]请勿尝试 点击即清空!这不能被撤销![/color]放弃基地,这个选项会将你的建筑保留,建筑会被移动到地图上的中立位置,但不会被任何玩家所有.你可以保留你的背包"
        },
        ["processing-unit"] = {
            initial_cost = 20,
            text="[color=red]请勿尝试 点击即清空!这不能被撤销![/color]完全重置,这个选项会清空你的建筑,载具与科技 还有背包!并重新开局"
        }
    }
}

function CreateMapFeatureStoreTab(tab_container, player)

    local player_inv = player.get_main_inventory()
    if (player_inv == nil) then return end

    local wallet = player_inv.get_item_count("coin")

    local fish = player_inv.get_item_count("raw-fish")

    AddLabel(tab_container,
        "map_feature_store_wallet_lbl",
        "我的现金： " .. wallet .. "  [item=coin]",
        {top_margin=5, bottom_margin=5})

    AddLabel(tab_container,
        "map_feature_store_wallet_lbl1",
        "拥有的鱼： " .. fish .. "  [item=raw-fish] 折合现金:" ..fish*2,
        {top_margin=5, bottom_margin=5})



    AddLabel(tab_container, "coin_info", "玩家从一些硬币开始。 通过杀死敌人或钓鱼赚取更多的硬币。", my_note_style)

    local line = tab_container.add{type="line", direction="horizontal"}
    line.style.top_margin = 5
    line.style.bottom_margin = 5

    for category,section in pairs(OARC_STORE_MAP_FEATURES) do

        if (not global.ocfg.enable_chest_sharing and (category == "special_chests")) then
            goto SKIP_CATEGORY
        end

        if (not global.ocfg.enable_magic_factories and (category == "special_chunks")) then
            goto SKIP_CATEGORY
        end

        AddLabel(tab_container,
                nil,
                OARC_STORE_MAP_TEXT[category],
                {bottom_margin=5, maximal_width = 400, single_line = false})
        local flow = tab_container.add{name = category, type="flow", direction="horizontal"}

        for item_name,item in pairs(section) do

            local blocked = false
            if (item.solo_force and ((player.force.name == global.ocfg.main_force) or
                                     (not global.ocore.playerSpawns[player.name]))) then
                blocked = true
            end

            local count = OarcMapFeaturePlayerCountGet(player, category, item_name)
            local cost = OarcMapFeatureCostScaling(player, category, item_name)
            local color = "[color=green]"

            if ((cost > wallet) or (cost < 0) or blocked) then
                color = "[color=red]"
            end

            local btn = flow.add{name=item_name,
                        type="sprite-button",
                        -- number=item.count,
                        sprite="item/"..item_name,
                        -- tooltip=item.text.." Cost: "..color..cost.."[/color] [item=coin]",
                        style=mod_gui.button_style }

            if (cost < 0) then
                btn.enabled = false
                btn.tooltip = item.text .. "\n "..color..
                                 "限制: ("..count.."/"..item.limit..") [/color]"
            elseif (blocked) then
                btn.enabled = false
                btn.tooltip = item.text .. " (这只允许拥有衍生的玩家使用自己的力量。如果你的部队中有其他玩家，他们必须先重置你才能使用这个。)" .." Cost: "..color..cost.."[/color] [item=coin]"
            elseif (item.limit) then
                btn.tooltip = item.text .. "\nCost: "..color..cost.."[/color] [item=coin] "..
                                "限制: ("..count.."/"..item.limit..")"
            else
                btn.tooltip = item.text.." 费用: "..color..cost.."[/color] [item=coin]"
            end
            
        end

        -- Spacer
        local line2 = tab_container.add{type="line", direction="horizontal"}
        line2.style.top_margin = 5
        line2.style.bottom_margin = 5

        ::SKIP_CATEGORY::
    end
end

function OarcMapFeatureInitGlobalCounters()
    global.oarc_store = {}
    global.oarc_store.pmf_counts = {}
end

function OarcMapFeaturePlayerCreatedEvent(player)
    global.oarc_store.pmf_counts[player.name] = {}
end

function OarcMapFeaturePlayerCountGet(player, category_name, feature_name)
    if (not global.oarc_store.pmf_counts[player.name][feature_name]) then
        global.oarc_store.pmf_counts[player.name][feature_name] = 0
        return 0
    end
    
    return global.oarc_store.pmf_counts[player.name][feature_name]
end

function OarcMapFeaturePlayerCountChange(player, category_name, feature_name, change)

    if (not global.oarc_store.pmf_counts[player.name][feature_name]) then
        if (change < 0) then
            log("ERROR - OarcMapFeaturePlayerCountChange - Removing when count is not set??")
        end
        global.oarc_store.pmf_counts[player.name][feature_name] = change
        return
    end

    -- Update count
    global.oarc_store.pmf_counts[player.name][feature_name] = global.oarc_store.pmf_counts[player.name][feature_name] + change

    -- Make sure we don't go below 0.
    if (global.oarc_store.pmf_counts[player.name][feature_name] < 0) then
        global.oarc_store.pmf_counts[player.name][feature_name] = 0
    end
end



-- Return cost (0 or more) or return -1 if disabled.
function OarcMapFeatureCostScaling(player, category_name, feature_name)

    local map_feature = OARC_STORE_MAP_FEATURES[category_name][feature_name]

    -- Check limit first.
    local count = OarcMapFeaturePlayerCountGet(player, category_name, feature_name)
    if (map_feature.limit and (count >= map_feature.limit)) then
        return -1
    end

    if (map_feature.initial_cost and map_feature.additional_cost and map_feature.multiplier_cost) then
        local calc_cost = (map_feature.initial_cost + (map_feature.additional_cost*(count^map_feature.multiplier_cost)))
        if (map_feature.max_cost) then
            return math.min(map_feature.max_cost, calc_cost)
        else
            return calc_cost
        end
    else
        return map_feature.initial_cost
    end
end

function OarcMapFeatureStoreButton(event)

    --取按钮实例
    local button = event.element

    --取玩家实例
    local player = game.players[event.player_index]

    --取玩家inv实例
    local player_inv = player.get_inventory(defines.inventory.character_main)

    --判断inv是否为空
    if (player_inv == nil) then
        return end

    --取玩家inv中coin
    local wallet = player_inv.get_item_count("coin")


    --不明白
    local map_feature = OARC_STORE_MAP_FEATURES[button.parent.name][button.name]


    if(button.name == "raw-fish") then
        
        if(player_inv.get_item_count("raw-fish") < 2)then
            player.print("你没有那么多鱼,老板对你超级不屑...")
            return
        end

        --减钱
        player_inv.remove({name = "raw-fish", count = 5})
        player_inv.insert({name = "coin", count = 10})
        player.print("你成功卖出5条鱼 获得现金:10")

    end


    --计算花费
    -- Calculate cost based on how many player has purchased?
    local cost = OarcMapFeatureCostScaling(player, button.parent.name, button.name)



    -- Check if we have enough money
    if (wallet < cost) then
        player.print("你没有那么多钱,老板对你超不屑....")
        return
    end

    if (player.vehicle) then
        player.print("先生，请先下车，然后再尝试购买...")
        return
    end

    -- Each button has a special function
    local result = false
    if (button.name == "logistic-chest-storage") then
        result = ConvertWoodenChestToSharedChestInput(player)
    elseif (button.name == "logistic-chest-requester") then
        result = ConvertWoodenChestToSharedChestOutput(player)
    elseif (button.name == "constant-combinator") then
        result = ConvertWoodenChestToSharedChestCombinators(player)
    elseif (button.name == "accumulator") then
        result = ConvertWoodenChestToShareEnergyInput(player)
    elseif (button.name == "electric-energy-interface") then
        result = ConvertWoodenChestToShareEnergyOutput(player)
    elseif (button.name == "deconstruction-planner") then
        result = DestroyClosestSharedChestEntity(player)
    elseif (button.name == "electric-furnace") then
        result = RequestSpawnSpecialChunk(player, SpawnFurnaceChunk, button.name)
    elseif (button.name == "oil-refinery") then
        result = RequestSpawnSpecialChunk(player, SpawnOilRefineryChunk, button.name)
    elseif (button.name == "assembling-machine-3") then
        result = RequestSpawnSpecialChunk(player, SpawnAssemblyChunk, button.name)
    elseif (button.name == "centrifuge") then
        result = RequestSpawnSpecialChunk(player, SpawnCentrifugeChunk, button.name)
    elseif (button.name == "rocket-silo") then
        result = RequestSpawnSpecialChunk(player, SpawnSiloChunk, button.name)
    elseif (button.name == "assembling-machine-1") then
        SendPlayerToSpawn(player)
        result = true
    elseif (button.name == "offshore-pump") then
        result = ConvertWoodenChestToWaterFill(player)
    elseif (button.name == "electronic-circuit") then
        ResetPlayerAndDestroyForce(player)
        result = true
    elseif (button.name == "advanced-circuit") then
        ResetPlayerAndAbandonForce(player)
        result = true
    elseif (button.name == "processing-unit") then
        ResetPlayerAndMergeForceToNeutral(player)
        result = true
    end

    -- On success, we deduct money
    if (result) then
        player_inv.remove({name = "coin", count = cost})
    end

    -- Refresh GUI:
    FakeTabChangeEventOarcStore(player)
end
