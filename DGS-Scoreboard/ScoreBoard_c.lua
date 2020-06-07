loadstring(exports.dgs:dgsImportFunction())()
loadstring(exports.dgs:dgsImportOOPClass(true))()

dgsSetRenderSetting("postGUI",false)
local screenW,screenH = dgsGetScreenSize()
local mainRectAngle = dgsCreateRoundRect(0.2,true,tocolor(0,0,0,125))
local mainImage = dgsImage(0.3,0.05, 0.4,0.9,mainRectAngle,true)

local _ServerName = "ServerName"
local ServerName = mainImage:dgsLabel(0.05,0.02,0.7,0.1,_ServerName,true)
ServerName:setFont(dgsCreateFont("Font.ttf",12))

local _Players = "0/1024"
local Players = mainImage:dgsLabel(0.8,0.02,0.1,0.1,_Players,true)
dgsLabelSetHorizontalAlign(Players.dgsElement,"right","top")
Players.font = dgsCreateFont("Font.ttf",12)


local Font = dgsCreateFont("Font.ttf",12)

local PlayersRectAngle = dgsCreateRoundRect(0.2,true,tocolor(0,0,0,125))
local PlayersImage = mainImage:dgsImage(0.03,0.1,0.92,0.85,PlayersRectAngle,true)
local PlayersGridList = PlayersImage:dgsGridList(0.01,0.03,0.975,0.83, true,50,tocolor(255,255,255,0),tocolor(255,255,255),tocolor(0,0,0,0)) -- ,20,tocolor(255,255,255,0),0xFF000000,tocolor(0,0,0,125)
PlayersGridList.font = Font
local PlayersGridListElement = PlayersGridList.dgsElement
dgsSetProperty(PlayersGridListElement,"leading",10)

local PlayerNameColumn =  dgsGridListAddColumn(PlayersGridListElement,"player",0.4)
local PlayerLevelColumn =  dgsGridListAddColumn(PlayersGridListElement,"level",0.4)
local PlayerPingColumn =  dgsGridListAddColumn(PlayersGridListElement,"ping",0.2)
for i = 1, 10 do 
    local rowID = dgsGridListAddRow(PlayersGridListElement)
    local a,b,c = dgsGridListGetRowBackGroundColor(PlayersGridListElement,rowID)
    dgsGridListSetRowBackGroundColor(PlayersGridListElement,rowID,tocolor(0,0,0,0),b,c)
    dgsGridListSetItemText(PlayersGridListElement,rowID,PlayerNameColumn,tostring("Test "..i))
    
    dgsGridListSetItemColor(PlayersGridListElement,rowID,PlayerNameColumn,255,0,0)
    dgsGridListSetItemText(PlayersGridListElement,rowID,PlayerLevelColumn,tostring("Test "..i))
    dgsGridListSetItemText(PlayersGridListElement,rowID,PlayerPingColumn,tostring("Test "..i))

end

setTimer(function ()
    local counts = dgsGridListGetRowCount(PlayersGridListElement)
    local Players = getElementsByType("player")
    if counts < #Players then 
        for i = 1 , (#Players - counts) do 
            dgsGridListAddRow(PlayersGridListElement)
        end
    elseif counts > #Players then 
        for i = 1 , (counts - #Players) do 
            dgsGridListRemoveRow(PlayersGridListElement,i)
        end
    end 

    for i = 1, #Players do 
        local p = Players[i]
        local r,g,b = getPlayerNametagColor(p) 
        dgsGridListSetItemText(PlayersGridListElement,i,PlayerNameColumn,tostring(getPlayerName(p)))
    
        dgsGridListSetItemColor(PlayersGridListElement,i,PlayerNameColumn,r,g,b)
        dgsGridListSetItemText(PlayersGridListElement,i,PlayerLevelColumn,tostring(getElementData(p,"level") or "0"))
        dgsGridListSetItemText(PlayersGridListElement,i,PlayerPingColumn,tostring(getPlayerPing(p)))

    end
end,1000,0)


addEvent ("dgs-ScoreBoard:UpdateServerName",true)
addEventHandler("dgs-ScoreBoard:UpdateServerName",root,function (val,val2) _ServerName = val 
ServerName.text = val
_Players = val2
Players.text = val2 end)

-- Main Position Is 0.3,0.05
bindKey("tab","down",function()
    if dgsIsMoving(mainImage.dgsElement) then dgsStopMoving(mainImage.dgsElement) end
        if isTimer(timerScoreBoard) then killTimer(timerScoreBoard) end
    dgsSetVisible(mainImage.dgsElement,true)
    dgsMoveTo(mainImage.dgsElement,0.3,0.05,true,false,"Linear",700)
end)
bindKey("tab","up",function()
    if dgsIsMoving(mainImage.dgsElement) then dgsStopMoving(mainImage.dgsElement) end
    if isTimer(timerScoreBoard) then killTimer(timerScoreBoard) end
    dgsMoveTo(mainImage.dgsElement,1,1,true,false,"Linear",700)
    timerScoreBoard = setTimer(dgsSetVisible,700,1,mainImage.dgsElement,false)
end)
dgsMoveTo(mainImage.dgsElement,1,1,true,false,"Linear",700)
dgsSetVisible(mainImage.dgsElement,false)

bindKey("mouse2","down",function ()
    if dgsGetVisible(mainImage.dgsElement) then 
        showCursor(true)
    end
end)
bindKey("mouse2","up",function ()
        showCursor(false)
end)