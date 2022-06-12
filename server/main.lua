local QBCore = exports['qb-core']:GetCoreObject()

local ItemList = {
    ["markedbills"] = "markedbills"
}

RegisterServerEvent('apolo_moneywash:server:getmoney')
AddEventHandler('apolo_moneywash:server:getmoney', function()
    local src = source
	local total_worth = 0
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local markedbills = Player.Functions.GetItemByName('markedbills')
	for itemkey, item in pairs(Player.PlayerData.items) do
		if type(item.info) ~= 'string' and tonumber(item.info.worth) then
			total_worth = math.random(50,400)
	if Player.PlayerData.items ~= nil then
        if markedbills ~= nil then
            if markedbills.amount >= 1 then
                Player.Functions.RemoveItem("markedbills", 1, false)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['markedbills'], "remove", 1)
         
                Player.Functions.AddMoney("cash", total_worth)
				TriggerClientEvent('QBCore:Notify', src, "MONEY WASHED")             
				break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "MARKED MONEYS?!", 'error')     
                    end              
            else
                TriggerClientEvent('QBCore:Notify', src, "MARKED MONEYS?!", 'error')               
            end
        end
	end
end
end)


RegisterServerEvent('apolo_moneywash:server:checkmoney')
AddEventHandler('apolo_moneywash:server:checkmoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local markedbills = Player.Functions.GetItemByName('markedbills')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if markedbills ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "markedbills" and Player.PlayerData.items[k].amount >= 1 then 
                        local amount = Player.PlayerData.items[k].amount
					    TriggerClientEvent("apolo_moneywash:client:WashProggress", src)
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "MARKED MONEYS?!", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "MARKED MONEYS?!", 'error')
                break

            end
        end
    end
end)

