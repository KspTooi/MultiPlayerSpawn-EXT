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
    --'defender-capsule',
    'destroyer-capsule',
--    'laser',
    --'distractor-capsule',
    --'rocket',
    --'poison-capsule',
    --  'grenade',
    'explosive-rocket'
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
        capsules[math.random(1, 3)],
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

    if gen_entity_instance.name == 'gun-turret' then
        local ammo_name= require 'maps.amap.enemy_arty'.get_ammo()
        gen_entity_instance.insert{name=ammo_name, count = 200}
    end


end


local function generator_explosive_rocket(entity,cause)

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
                name = gen_entity_type[3],
                position = entity.position,
                force = 'enemy',
                source = entity.position,
                target = position,
                max_range = 32,
                speed = 0.5
            }
    )

    if gen_entity_instance.name == 'gun-turret' then
        local ammo_name= require 'maps.amap.enemy_arty'.get_ammo()
        gen_entity_instance.insert{name=ammo_name, count = 200}
    end


end

local function generator_nuclear_rocket(entity,cause)

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
                name = "atomic-rocket",
                position = entity.position,
                force = 'enemy',
                source = entity.position,
                target = position,
                max_range = 32,
                speed = 0.5
            }
    )

    if gen_entity_instance.name == 'gun-turret' then
        local ammo_name= require 'maps.amap.enemy_arty'.get_ammo()
        gen_entity_instance.insert{name=ammo_name, count = 200}
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



    if not entity_types[entity.type] then
        return
    end



    --如果是被实体杀死的
    if cause.valid then

        --如果是激光塔
        if event.cause.name == "laser-turret" then
            generator_explosive_rocket(entity,cause)
            generator_explosive_rocket(entity,cause)
            return
        end



        --如果杀死的是虫巢
        if entity.type == "unit-spawner" then

            --如果是激光塔杀的虫巢
            if event.cause.name == "unit-spawner" then
                generator_explosive_rocket(entity,cause)
                generator_explosive_rocket(entity,cause)
            end

            --如果是机枪塔杀的虫巢
            if event.cause.name == "gun-turret" then
                generator_explosive_rocket(entity,cause)
                generator_explosive_rocket(entity,cause)
            end

--[[            --如果是蜘蛛杀的虫巢
            if event.cause.name == "spidertron" then
                generator_nuclear_rocket(entity,cause)
                return
            end

            --如果是人坐在蜘蛛里
            if event.cause.vehicle ~= nil then

                if not event.cause.vehicle.valid then
                    generator_explosive_rocket(entity,cause)
                    return
                end

                if event.cause.vehicle.name == "spidertron" then
                    generator_nuclear_rocket(entity,cause)
                end

            end]]

        end

    end




    --如果不是用激光杀死虫子则返回
    if event.damage_type.name ~= "laser" then
        --game.print("no laser")
        return
    end


    --如果是用激光杀死虫巢
    if entity.type == "unit-spawner" then
        generator_explosive_rocket(entity,cause)
        generator_explosive_rocket(entity,cause)
    end



    --land-mine地雷
    if entity.name == "land-mine" then
        generator_gun(entity,cause)
        return
    end


    generator_gun(entity,cause)

end


event.add(defines.events.on_entity_died,onEntityDeadEvent)

