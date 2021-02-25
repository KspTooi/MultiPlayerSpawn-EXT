---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/2/25 11:12
---

require("lib.ksptooi.commons.PlayerLib")
require("lib.ksptooi.teleport.TpRequestStorage")



---发送传送请求
function teleportToPlayer(command)

    if(command.parameter == nil)then
        game.print("缺少参数")
        return
    end

    local player = game.players[command.player_index]

    local target = game.players[command.parameter]


    if validPlayer(target) then
        player.print("玩家不存在")
        return
    end


    insertTpRequest(player,target)
    player.print("传送请求已经发送至:"..target.name.." 等待对方接受")


    --player.teleport({target.position.x,target.position.y},GAME_SURFACE_NAME)
end


---接受请求
function teleportAccept(command)

    local target = game.players[command.player_index]

    local tpReq = getTpRequest(target)

    if tpReq == nil then
        target.print("当前没有待处理传送请求")
        return
    end

    if validPlayer(tpReq.from)then
        target.print("接受请求失败,玩家不可用.")
        return
    end


    player.print("接受请求成功.")

end


commands.add_command("tpa","tpa",teleportToPlayer)

commands.add_command("tpaccept","tpa",teleportAccept)

commands.add_command("tpdeny","tpa",teleportToPlayer)