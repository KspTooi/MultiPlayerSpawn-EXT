---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/2/26 13:53
---

local unitSpawner = "unit-spawner"

local damageType_Laser = "laser"

local damageType_Explosion = "explosion"

local damageType_Fire = "explosion"

local damageType_Electric = "electric"

local damageType_Physical = "physical"

--造成伤害的实体
local causeType_LaserTurret = "laser-turret"
local causeType_GunTurret = "gun-turret"

--喷火器
local causeType_Flamethrower = "flamethrower-turret"

--进攻无人机
local causeType_Destroyer = "destroyer"
--掩护无人机
local causeType_Distractor = "distractor"
--防御无人机
local causeType_Defender = "defender"

local causeType_Spidertron = "spidertron"



--校验是否为激光塔
function isLaserTurret(entity)
    return entity.name == causeType_LaserTurret
end

--校验是否为机枪塔
function isGunTurret(entity)
    return entity.name == causeType_GunTurret
end

--校验是否为火焰塔
function isFlamethrowerTurret(entity)
    return entity.name == causeType_Flamethrower
end

--校验是否为蜘蛛
function isSpidertron(entity)
    return entity.name == causeType_Spidertron
end

--校验是否为无人机
function isDrone(entity)

    if entity.name == causeType_Destroyer then
        return true
    end

    if entity.name == causeType_Defender then
        return true
    end

    if entity.name == causeType_Distractor then
        return true
    end

    return false

end

--校验是否为炮塔
function isTurret(entity)
    if isLaserTurret(entity)then
        return true
    end
    if isGunTurret(entity)then
        return true
    end
    if isFlamethrowerTurret(entity)then
        return true
    end
    return false
end


--校验是否为激光伤害
function isLaserDamage(damageType)
    return damageType.name == damageType_Laser
end

--校验是否为爆炸伤害
function isExplosionDamage(damageType)
    return damageType.name == damageType_Explosion
end

--校验是否为热能伤害
function isFireDamage(damageType)
    return damageType.name ~= damageType_Fire
end

--校验为电磁伤害
function isElectricDamage(damageType)
    return damageType.name == damageType_Electric
end

--校验为动能伤害
function isPhysicalDamage(damageType)
    return damageType.name == damageType_Physical
end


--校验该物体是否是虫巢
function isUnitSpawner(entity)
    return entity.type == unitSpawner
end



--校验 实体 原因与阵营
function validForEntityAndCause(event,validForce)

    local entity = event.entity

    local cause = event.cause

    --实体校验
    if entity == nil and not entity.valid then
        return false
    end

    --原因校验
    if cause == nil then
        return false
    end

    ---如果不开启阵营校验则不进行阵营的校验
    if validForce ~= true then
        return true
    end

    --阵营校验
    if not entity.force.index == game.forces.enemy.index then
        return false
    end

    return true

end

