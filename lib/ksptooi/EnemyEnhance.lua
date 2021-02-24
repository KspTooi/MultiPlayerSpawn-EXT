--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2021/2/20
-- Time: 19:19
-- To change this template use File | Settings | File Templates.
--
require 'utils.data_stages'
_LIFECYCLE = _STAGE.control

local event = require 'utils.event'

local entity_types = {
    ['unit'] = true,
    ['turret'] = true,
    ['unit-spawner'] = true
}

local capsules = {
    'slowdown-capsule',
    'defender-capsule',
    'destroyer-capsule',
    'laser',
    'distractor-capsule',
    'rocket',
    'poison-capsule',
    --  'grenade',
    'rocket'
    --  'grenade'
}

local wepeon ={
    'gun-turret',
    'land-mine',
    'biter-spawner'
}

local aoe ={
    'explosive-rocket',
    'grenade',
    'cluster-grenade'
}


local function generator_gun(entity,cause)

    local position = false

    if cause then
        if cause.valid then
            position = cause.position
        end
    end

    if not position then

        position = {
            entity.position.x + (-20 + math.random(0, 40))
            ,entity.position.y + (-20 + math.random(0, 40))
        }

    end

    local gen_entity_type = {
        capsules[math.random(1, 8)],
        wepeon[math.random(1, 3)],
        aoe[math.random(1, 3)]
    }

    gen_entity_instance =  entity.surface.create_entity(
        {
            name = gen_entity_type[1],
            position = entity.position,
            force = 'enemy',
            source = entity.position,
            target = position,
            max_range = 32,
            speed = 0.5
        }
    )

    if e.name == 'gun-turret' then
        local ammo_name= require 'maps.amap.enemy_arty'.get_ammo()
        e.insert{name=ammo_name, count = 200}
    end


end

local onEntityDeadEvent = function(event)

    --死亡实体
    local entity = event.entity
    --原因
    local cause = event.cause

    --实体校验
    if not (entity and entity.valid) then
        return
    end

    --原因校验
    if not cause then return end

    --如果阵营不为enemy则return
    if not entity.force.index == game.forces.enemy.index then
        return
    end


    local entity_types = {
        ["unit"] = true,
        ["turret"] = true,
        ["unit-spawner"] = true
    }


    if not entity_types[entity.type] then return end


    --如果不是用激光杀死虫子则返回
    if event.damage_type.name ~= "laser" then
        --game.print("no laser")
        return
    end

    --game.print("laser")

    if entity.name == "land-mine" then
        generator_gun(entity,cause)
        return
    end

    generator_gun(entity,cause)

end


event.add(defines.events.on_entity_died,onEntityDeadEvent)

