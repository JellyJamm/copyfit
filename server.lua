--================================--
--          Copy Fit v1           --
--          by JellyJam           --
--      License: GNU GPL 3.0      --
--================================--

RegisterCommand("copy", function(source, args, rawCommand)
    local targetPlayer = tostring(args[1])
    TriggerClientEvent("getOutfit", targetPlayer, source)
end)

RegisterNetEvent("sendToServer")
AddEventHandler("sendToServer", function(outfit, targetPlayer)
    TriggerClientEvent("setPed", targetPlayer, outfit)
end)
