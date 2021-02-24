-- example-config.lua (Rename this file to config.lua to use it)
-- Oct 3 2020 (updated on)
-- Configuration Options
--
-- You should be safe to leave most of the settings here as defaults if you want.
-- The only thing you definitely want to change are the welcome messages.

--------------------------------------------------------------------------------
-- Messages
-- You will want to change some of these to be your own.
--------------------------------------------------------------------------------

-- This stuff is shown in the welcome GUI and Info panel. Make sure it's valid.
WELCOME_MSG_TITLE = "欢迎来玩~~"
WELCOME_MSG = "" -- Printed to player on join as well.
SERVER_MSG = "这个服务器基于OARC场景进行二次开发与优化.\n 原链接:https://github.com/Oarcinae/FactorioScenarioMultiplayerSpawn"

SCENARIO_INFO_MSG = "请阅读以下内容:\n"..
"版本:1.35-S 小规模更新\n"..
"更新内容:\n"..
"1:平衡性小幅修正\n"..
"2:优化地图,减少空间占用.\n"..
"3:修复大量BUG\n"..
"4:商店改进\n"..
"5:略微修正了虫子被激光击杀时抛出武器的速度与范围\n"..
"6:优化了出生点机制,从这个版本开始玩家重生点将会更加接近地图中心\n\n\n"..

"警告:在改变/拆除其他玩家设施时须征得他人同意.\n"..
"每位玩家将独立发展.同时科技树也将独立.\n"..
"初始资金建议购买装备插件,用来清理虫巢赚取更多金币\n"..
"定期清理无用区块,下线时蜘蛛最好放置到基地里\n"..
"如果你在前15分钟退出服务器,你的基地和角色将会被删除!"

CONTACT_MSG = "欢迎加入我们的Q群:860179317"
DISCORD_INV = ""

------------------------------------------------------------------------------------------------------------------------
-- Module Enables
-- Each of the following things enable special features. These can't be changed once the game starts.
------------------------------------------------------------------------------------------------------------------------

---启用好友重生功能 能够让玩家选择与好友一起重生
-- This allows 2 players to spawn next to each other in the wilderness, each with their own starting point. It adds more
-- GUI selection options.
ENABLE_BUDDY_SPAWN = true

---启用这个选项之后 玩家只能在地图上的[特殊区块]创建火箭发射平台
-- Frontier style rocket silo mode. This means you can't build silos, but some spawn out in the wild for you to use.
-- if ENABLE_MAGIC_FACTORIES=false, you will find a few special areas to launch rockets from.
-- If ENABLE_MAGIC_FACTORIES=true, you must buy a silo at one of the special chunks.
FRONTIER_ROCKET_SILO_MODE = false

---启用这个功能以缩小地图尺寸
-- Enable Undecorator. Removes decorative items to reduce save file size.
ENABLE_UNDECORATOR = true

---启用玩家自定义标签功能
-- Enable Tags (Players can add a name-tag to explain what type of role they are doing if they want.)
ENABLE_TAGS = true

---启用从远处出生功能
-- Enable Long Reach
ENABLE_LONGREACH = true

---启用自动填充功能
-- Enable Autofill (My autofill is very simplistic, if you are using a similar mod disable this!)
ENABLE_AUTOFILL = true

---启用装载机
-- Enable vanilla loaders
ENABLE_LOADERS = true

---启用自动矿工侦测功能
-- Enable auto decon of miners (My miner decon is very simplistic, if you are using a similar mod disable this!)
ENABLE_MINER_AUTODECON = true

---启用玩家列表功能
-- Enable Playerlist
ENABLE_PLAYER_LIST = true
---玩家列表显示离线玩家
PLAYER_LIST_OFFLINE_PLAYERS = true -- List offline players as well.

---启用团队共享功能
-- Enable shared vision between teams (all teams are COOP regardless)
ENABLE_SHARED_TEAM_VISION = true

---启动地图清理功能
-- Cleans up unused chunks periodically. Helps keep map size down.
ENABLE_REGROWTH = true

---启用玩家基地自动移除功能(玩家加入不久后便退出则清理他的基地)
-- This removes player bases when they leave shortly after joining. Only works if you have regrowth enabled!
ENABLE_ABANDONED_BASE_REMOVAL = true

---启用研究队列功能
-- Enable the research queue by default for all forces.
ENABLE_RESEARCH_QUEUE = true

---启用这个功能可以让敌人掉落硬币 同时会启用硬币商店功能
-- This enables coin drops from enemies and a shop (GUI) to buy stuff from.
ENABLE_COIN_SHOP = true

---启用物品与能量共享系统
-- Enable item & energy sharing system. 
ENABLE_ITEM_AND_ENERGY_SHARING = true -- REQUIRES ENABLE_COIN_SHOP=true!

---启用这个功能 玩家将能够在地图上的[特殊区块]构建快速工厂
-- Enable magic chunks around the map that let you buy powerful factories that smelt/assemble/process very very quickly.
ENABLE_MAGIC_FACTORIES = true -- REQUIRES ENABLE_COIN_SHOP=true!

---启用这个功能开启玩家离线保护
-- This inhibits enemy attacks on bases where all players are offline.
-- Not 100% guaranteed.
ENABLE_OFFLINE_PROTECTION = true

---科技系数乘数
-- This allows you to set the tech price multiplier for the game, but 
-- have it only affect the main force. We just pad all non-main forces lab prod bonus.
-- This has no effect unless the tech multiplier is more than 1!
ENABLE_FORCE_LAB_PROD_BONUS = true

---启用这个选项后 某些科技与合成将会锁定 直到玩家发射火箭后方可解锁
-- Lock various recipes and technologies behind a rocket launch.
-- Each team/force must launch their own rocket to unlock this!
LOCK_GOODIES_UNTIL_ROCKET_LAUNCH = true
LOCKED_TECHNOLOGIES = {
    {t="atomic-bomb"},{t="power-armor-mk2"},{t="artillery"},{t="spidertron"}
}
LOCKED_RECIPES = {
    {r="productivity-module-3"},{r="speed-module-3"}
}

---在玩家第一次重生的时候给予物品
-- Give cheaty items on start.
ENABLE_POWER_ARMOR_QUICK_START = false
ENABLE_MODULAR_ARMOR_QUICK_START = false

------------------------------------------------------------------------------------------------------------------------
-- MAP CONFIGURATION OPTIONS
-- In past versions I had a way to config map settings here to be used for cmd
-- line launching, but now you should just be using --map-gen-settings and
-- --map-settings option since it works with --start-server-load-scenario
-- Read the README.md file for instructions.
------------------------------------------------------------------------------------------------------------------------

-- This scales resources so that even if you spawn "far away" from the center
-- of the map, resources near to your spawn point scale so you aren't
-- surrounded by 100M patches or something. This is useful depending on what
-- map gen settings you pick.
SCALE_RESOURCES_AROUND_SPAWNS = true

------------------------------------------------------------------------------------------------------------------------
-- Alien Options
------------------------------------------------------------------------------------------------------------------------

-- Adjust enemy spawning based on distance to spawns. All it does it make things
-- more balanced based on your distance and makes the game a little easier.
-- No behemoth worms everywhere just because you spawned far away.
-- If you're trying out the vanilla spawning, you might want to disable this.
OARC_MODIFIED_ENEMY_SPAWNING = true

------------------------------------------------------------------------------------------------------------------------
-- Starting Items
------------------------------------------------------------------------------------------------------------------------
---首次加入时提供给玩家的物品
-- Items provided to the player the first time they join
PLAYER_SPAWN_START_ITEMS = {
    ["pistol"]=1,
    ["firearm-magazine"]=100,
    ["iron-plate"]=50,
    ["burner-mining-drill"] = 3,
    ["stone-furnace"] = 4,
    ["coal"] = 50,
    ["stone"] = 50,
    ["coin"] = 20, -- Don't give coins unless you have shared chests enabled.
}

---每次重生后提供的物品 默认不启用
-- Items provided after EVERY respawn (disabled by default)
PLAYER_RESPAWN_START_ITEMS = {
    -- {name="pistol", count=1},
    -- {name="firearm-magazine", count=100}
}

------------------------------------------------------------------------------------------------------------------------
---距离选项
-- Distance Options
------------------------------------------------------------------------------------------------------------------------

---无法翻译
-- This is the radius, in chunks, that a spawn area is from any other generated
-- chunks. It ensures the spawn area isn't too near generated/explored/existing
-- area. The larger you make this, the further away players will spawn from
-- generated map area (even if it is not visible on the map!).
CHECK_SPAWN_UNGENERATED_CHUNKS_RADIUS = 1

---近距离重生选项 当玩家进行近距离重生的时候 会尽可能的保持在这个范围里
-- Near Distance in chunks
-- When a player selects "near" spawn, they will be in or as close to this range as possible.
--NEAR_MIN_DIST = 50
--NEAR_MAX_DIST = 100
NEAR_MIN_DIST = 10
NEAR_MAX_DIST = 15

-- Far Distance in chunks
-- When a player selects "far" spawn, they will be at least this distance away.
FAR_MIN_DIST = 200
FAR_MAX_DIST = 300



------------------------------------------------------------------------------------------------------------------------
---资源和基地选项
-- Resource & Spawn Circle Options
------------------------------------------------------------------------------------------------------------------------

-- This is where you can modify what resources spawn, how much, where, etc.
-- Once you have a config you like, it's a good idea to save it for later use
-- so you don't lost it if you update the scenario.
OARC_CFG = {

    -- Misc spawn related config.
    gen_settings = {

        ---玩家基地大小
        -- THIS IS WHAT SETS THE SPAWN CIRCLE SIZE!
        -- Create a circle of land area for the spawn
        -- If you make this much bigger than a few chunks, good luck.
        land_area_tiles = CHUNK_SIZE*2,

        ---启用这个选项将允许玩家生成护城河
        -- Allow players to choose to spawn with a moat
        moat_choice_enabled = true,

        ---如果更改生成区域的大小 则可能也需要对此进行调整
        -- If you change the spawn area size, you might have to adjust this as well
        moat_size_modifier = 1,

        ---起始资源形态 true=圆形 false 方形
        -- Start resource shape. true = circle, false = square.
        resources_circle_shape = true,

        ---强制玩家基地的陆地完全变成草方块
        -- Force the land area circle at the spawn to be fully grass
        force_grass = true,

        ---启用这个选项以在玩家基地周围生成一圈树
       -- Spawn a circle/octagon of trees around the base outline.
        tree_circle = true,
        tree_octagon = false,
    },

    ---安全区
    -- Safe Spawn Area Options
    -- The default settings here are balanced for my recommended map gen settings (close to train world).
    safe_area =
    {

        ---玩家基地安全区半径(安全区完全没有虫族)
        -- Safe area has no aliens
        -- This is the radius in tiles of safe area.
        safe_radius = CHUNK_SIZE*6,

        ---玩家基地警告区半径 (警示区大量减少虫族)
        -- Warning area has significantly reduced aliens
        -- This is the radius in tiles of warning area.
        warn_radius = CHUNK_SIZE*12,


        -- 1 : X (spawners alive : spawners destroyed) in this area
        warn_reduction = 20,

        ---危险区半径(危险区略微减少虫族)
        -- Danger area has slightly reduce aliens
        -- This is the radius in tiles of danger area.
        danger_radius = CHUNK_SIZE*32,


        -- 1 : X (spawners alive : spawners destroyed) in this area
        danger_reduction = 5,
    },

    -- Location of water strip (horizontal)
    water = {
        x_offset = -4,
        y_offset = -48,
        length = 8
    },

    -- Handle placement of starting resources
    resource_rand_pos_settings =
    {
        -- Autoplace resources (randomly in circle)
        -- This will ignore the fixed x_offset/y_offset values in resource_tiles.
        -- Only works for resource_tiles at the moment, not oil patches/water.
        enabled = true,
        -- Distance from center of spawn that resources are placed.
        radius = 45,
        -- At what angle (in radians) do resources start.
        -- 0 means starts directly east.
        -- Resources are placed clockwise from there.
        angle_offset = 2.32, -- 2.32 is approx SSW.
        -- At what andle do we place the last resource.
        -- angle_offset and angle_final determine spacing and placement.
        angle_final = 4.46 -- 4.46 is approx NNW.
    },

    ---地图区块
    -- Resource tiles
    -- If you are running with mods like bobs/angels, you'll want to customize this.
    resource_tiles =
    {
        ["iron-ore"] =
        {
            amount = 6000,
            size = 16,
            x_offset = -29,
            y_offset = 16
        },
        ["copper-ore"] =
        {
            amount = 6000,
            size = 16,
            x_offset = -28,
            y_offset = -3
        },
        ["stone"] =
        {
            amount = 6000,
            size = 16,
            x_offset = -27,
            y_offset = -34
        },
        ["coal"] =
        {
            amount = 6000,
            size = 16,
            x_offset = -27,
            y_offset = -20
        }--,
        -- ["uranium-ore"] =
        -- {
        --     amount = 0,
        --     size = 0,
        --     x_offset = 17,
        --     y_offset = -34
        -- }

        -- ####### Bobs + Angels #######
        -- DISABLE STARTING OIL PATCHES!
        -- Coal                = coal
        -- Saphirite           = angels-ore1
        -- Stiratite           = angels-ore3
        -- Rubyte              = angels-ore5
        -- Bobmonium           = angels-ore6

        -- ########## Bobs Ore ##########
        -- Iron                = iron-ore
        -- Copper              = copper-ore
        -- Coal                = coal
        -- Stone               = stone
        -- Tin                 = tin-ore
        -- Lead (Galena)       = lead-ore

        -- See https://github.com/Oarcinae/FactorioScenarioMultiplayerSpawn/issues/11#issuecomment-479724909
        -- for full examples.
    },

    ---特殊资源区块 比如石油
    -- Special resource patches like oil
    resource_patches =
    {
        ["crude-oil"] =
        {
            num_patches = 3,
            amount = 9000000,
            x_offset_start = -3,
            y_offset_start = 48,
            x_offset_next = 6,
            y_offset_next = 0
        }
    },
}

---------------------------------------
-- Other Forces/Teams Options
---------------------------------------

---启用团队分割功能
---这个选项可以让玩家创建独立的团队
-- Separate teams
-- This allows you to join your own force/team. Everyone is still COOP/PvE, all
-- teams are friendly and cease-fire.
ENABLE_SEPARATE_TEAMS = true

---主团队的名称
-- Main force is what default players join
MAIN_FORCE = "Main Force"


---启用这个选项 玩家将可以允许其他人加入他的团队
-- Enable if players can allow others to join their base.
-- And specify how many including the host are allowed.
ENABLE_SHARED_SPAWNS = true
---团队最大成员数量限制
MAX_PLAYERS_AT_SHARED_SPAWN = 3

---启用全局聊天
-- Share local team chat with all teams
-- This makes it so you don't have to use /s
-- But it also means you can't talk privately with your own team.
ENABLE_SHARED_TEAM_CHAT = true

---------------------------------------
---特殊动作冷却
-- Special Action Cooldowns
---------------------------------------
RESPAWN_COOLDOWN_IN_MINUTES = 15

---要求玩家至少在线多少分钟 否则将删除他的基地和人物
-- Require playes to be online for at least X minutes
-- Else their character is removed and their spawn point is freed up for use
MIN_ONLINE_TIME_IN_MINUTES = 15

--------------------------------------------------------------------------------
---特殊区块设置
-- Frontier Rocket Silo Options
--------------------------------------------------------------------------------

-- Number of silos found in the wild.
-- These will spawn in a circle at given distance from the center of the map
-- If you set this number too high, you'll have a lot of delay at the start of the game.
SILO_NUM_SPAWNS = 5

-- How many chunks away from the center of the map should the silo be spawned
SILO_CHUNK_DISTANCE = 200

-- If this is enabled, you get silos at the positions specified below.
-- (The other settings above are ignored in this case.)
SILO_FIXED_POSITION = false

-- If you want to set fixed spawn locations for some silos.
SILO_POSITIONS = {{x = -1000, y = -1000},
                  {x = -1000, y = 1000},
                  {x = 1000,  y = -1000},
                  {x = 1000,  y = 1000}}

-- Set this to false so that you have to search for the silo's.
ENABLE_SILO_VISION = true

-- Add beacons around the silo (Philip's mod)
ENABLE_SILO_BEACONS = false
ENABLE_SILO_RADAR = false

-- Allow silos to be built by the player, but forces them to build in
-- the fixed locations. If this is false, silos are built and assigned
-- only to the main force. This can cause a problem for non main forces
-- when playing with LOCK_GOODIES_UNTIL_ROCKET_LAUNCH enabled.
ENABLE_SILO_PLAYER_BUILD = true


--------------------------------------------------------------------------------
-- Long Reach Options
--------------------------------------------------------------------------------
BUILD_DIST_BONUS = 64
REACH_DIST_BONUS = BUILD_DIST_BONUS
RESOURCE_DIST_BONUS = 2

--------------------------------------------------------------------------------
---自动填充炮弹选项
-- Autofill Options
--------------------------------------------------------------------------------
AUTOFILL_TURRET_AMMO_QUANTITY = 10

--------------------------------------------------------------------------------
-- ANTI-Griefing stuff ( I don't personally maintain this as I don't care for it.)
-- These things were added from other people's requests/changes and are disabled by default.
--------------------------------------------------------------------------------
-- Enable this to disable deconstructing from map view, and setting a time limit
-- on ghost placements.
ENABLE_ANTI_GRIEFING = false

-- Makes blueprint ghosts dissapear if they have been placed longer than this
-- ONLY has an effect if ENABLE_ANTI_GRIEFING is true!
GHOST_TIME_TO_LIVE = 10 * TICKS_PER_MINUTE

---启用队友伤害
-- I like keeping this off... set to true if you want to shoot your own chests
-- and stuff.
ENABLE_FRIENDLY_FIRE = true


------------------------------------------------------------------------------------------------------------------------
-- EXPERIMENTAL FEATURES
-- The following things are not recommended unless you really know what you are doing and are okay with crashes and
-- editing lua code.
------------------------------------------------------------------------------------------------------------------------

-- This turns on writing chat and certain events to specific files so that I can use that for discord integration. I
-- suggest you leave this off unless you know what you are doing.
ENABLE_SERVER_WRITE_FILES = true

-- Enable this to have a vanilla style starting spawn. This changes the experience pretty drastically. If you enable
-- this, you will NOT get the option to spawn using the "pre-fab" fixed layout spawns. This is because the spawn types
-- just don't balance well with each other.
ENABLE_VANILLA_SPAWNS = false

-- Vanilla spawn point options (only applicable if ENABLE_VANILLA_SPAWNS is enabled.)

-- Num total spawns pre-assigned (minimum number)
-- Points are in an even grid layout.
VANILLA_SPAWN_COUNT = 60

-- Num tiles between each spawn. (I recommend at least 1000)
VANILLA_SPAWN_SPACING = 2000

-- Silo Islands
-- This options is only valid when used with ENABLE_VANILLA_SPAWNS and FRONTIER_ROCKET_SILO_MODE!
-- This spreads out rocket silos on every OTHER island/vanilla spawn
SILO_ISLANDS_MODE = false

---这是重新生长的一部分，如果两个都启用，则任何不活动且没有实体的块都将 最终会随着时间的推移而被删除。请勿将其与MODS一起使用！
-- This is part of regrowth, and if both are enabled, any chunks which aren't active and have no entities will
-- eventually be deleted over time. DO NOT USE THIS WITH MODS!
ENABLE_WORLD_EATER = true
