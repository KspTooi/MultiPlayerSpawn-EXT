---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/3/2 22:33
---

--校验GUI事件有效性
function validGuiClickEvent(event)

    if event == nil then
        return false
    end

    if event.element == nil then
        return false
    end

    if event.element.valid == false then
        return false
    end

end