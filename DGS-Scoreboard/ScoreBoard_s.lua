function updateScoreBoardDetails()
    triggerClientEvent("dgs-ScoreBoard:UpdateServerName",root,getServerName(),getPlayerCount().."/"..getMaxPlayers())
end

addEventHandler("onResourceStart",resourceRoot,function ()
    setTimer(function ()
        updateScoreBoardDetails()
    end,1000,1)
end)

addEventHandler("onPlayerJoin",root,updateScoreBoardDetails)
addEventHandler("onPlayerLeft",root,updateScoreBoardDetails)