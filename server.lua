--================================--
--          Copy Fit v2           --
--          by JellyJam           --
--      License: GNU GPL 3.0      --
--================================--

RegisterCommand("copy", function(source, args, rawCommand)
    local target = tostring(args[1])
    if GetEntityModel(GetPlayerPed(source)) == GetEntityModel(GetPlayerPed(target)) then
        TriggerClientEvent("getOutfit", target, source, false)
    else
        TriggerClientEvent("getOutfit", target, source, true)
    end
end)

RegisterNetEvent("sendToServer")
AddEventHandler("sendToServer", function(outfit, props, model, target, diffModels)
    TriggerClientEvent("setPed", target, outfit, props, model, diffModels)
end)
