local postals = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while ESX.PlayerData.job == nil do
        Citizen.Wait(500)
    end
    
    Citizen.Wait()

    local file = LoadResourceFile(GetCurrentResourceName(), 'ocrp-postals.json')
    postals = json.decode(file)

    while true do
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        local nearestPostal = nil
        local minDistance = math.huge 
        
        for k, v in pairs(postals) do
            local distance = Vdist(x, y, z, v["x"], v["y"], v["z"])
            if distance < minDistance then
                minDistance = distance
                nearestPostal = v["code"]
            end
        end
    
        SendNUIMessage({
            action = "infos",
            job = ESX.PlayerData.job.label,
            rang = ESX.PlayerData.job.grade_name,
            street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z)),
            plz = nearestPostal
        })
        Citizen.Wait(3500)
    end
end)

RegisterCommand('hidejobhud', function()
    SendNUIMessage({
        action = "hide"
    })
end)

RegisterCommand('showjobhud', function()
    SendNUIMessage({
        action = "show"
    })
end)

RegisterNetEvent('startProgressbar')
AddEventHandler('startProgressbar', function(time, msg, stopMsg)
    SendNUIMessage({
        action = "progress",
        time = time,
        msg = msg,
        stopMsg = stopMsg
    })
end)