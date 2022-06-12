local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local washingmoney = false

--- Memory Game has been added before washing Money: https://github.com/pushkart2/memorygame


Text3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance = #(PlayerPos - vector3(1135.92, -989.49, 46.11))
        
        if distance < 8 then
            inRange = true

            if distance < 3 then
                Text3D(1135.92, -989.49, 46.11, "WASH MONEY ~g~[E]~w~")
 --               Text3D(1135.92, -989.49, 46.11, '<FONT FACE="Fira Sans">~g~[G]~w~ Wash Money')
                if IsControlJustPressed(0, 38) then
                
                    exports["memorygame"]:thermiteminigame(8, 3, 5, 10,
                    function() -- success
                        TriggerServerEvent("apolo_moneywash:server:checkmoney")
                        print("success")
                    end,
                    function() -- failure
                        print("failure")
                    end)
                end
            end
            
        end

        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

RegisterNetEvent('apolo_moneywash:client:WashProggress')
AddEventHandler('apolo_moneywash:client:WashProggress', function(source)
    QBCore.Functions.Progressbar("wash_money", "Washing Money...", math.random(2000,40000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
	animDict = "mini@repair",
    anim = "fixing_a_ped",
    flags = 16,
	}, {}, {}, function() -- Done
    StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
    TriggerServerEvent("apolo_moneywash:server:getmoney")
    end, function() -- Cancel
    StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
    QBCore.Functions.Notify("Canceled..", "error")
end)
end)
