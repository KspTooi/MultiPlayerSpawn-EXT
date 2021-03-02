---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/3/2 23:15
---

---Gui点击事件处理器(总线)

---事件存储表(list)

---@string elName 元素的注册名称
---@func elFunc 元素的点击方法
local registerList = {

}


---注册事件
---@string elementName 点击的元素名称(ID)
---@function func 点击元素后执行的方法
function registerClickEvent(elementName,func)

    local reg = {
        elName = elementName,
        elFunc = func
    }

    table.insert(registerList,reg)
end

---遍历事件存储表查找指定事件的实例
---@string 元素名
function getEvent(elementName)

    for i,v in pairs(registerList) do

        if v.elName == elementName then
            return v;
        end

    end

end


---处理点击事件
---@param event "待分配的事件"
function handlerClick(event)

    local em = getEvent(event.element.name)

    if em == nil then
        return
    end

    em.elFunc(event)
end



local regElName = "button"

function clickButton()
    print("按钮被点击了")
end


--注册事件
registerClickEvent(regElName,clickButton)

--获取事件
local em = getEvent("button")

em.elFunc()