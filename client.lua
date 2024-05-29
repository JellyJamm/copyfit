--================================--
--          Copy Fit v2           --
--          by JellyJam           --
--      License: GNU GPL 3.0      --
--================================--

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

RegisterNetEvent("getOutfit")
AddEventHandler("getOutfit", function(target, diffModels)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    local outfit = {}
    local props = {}

    for i = 1, 11 do
        local drawable = GetPedDrawableVariation(ped, i)
        local texture =  GetPedTextureVariation(ped, i)
        local palette = GetPedPaletteVariation(ped, i)
        table.insert(outfit, {drawable = drawable, texture = texture, palette = palette})
    end -- Get Ped Drawables
    for i = 0, 7 do
        local index = GetPedPropIndex(ped, i)
        local textureIndex = GetPedPropTextureIndex(ped, i)
        table.insert(props, {index = index, textureIndex = textureIndex})
    end -- Get Ped Props

    TriggerServerEvent("sendToServer", outfit, props, model, target, diffModels)
    notify("~g~ID:"..target.." ~w~copied your outfit")
end)

RegisterNetEvent("setPed")
AddEventHandler("setPed", function(outfit, props, model, diffModels)

    if diffModels then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
    end

    local ped = PlayerPedId()

    for i = 1, 11 do
        SetPedComponentVariation(ped, i, outfit[i].drawable, outfit[i].texture, outfit[i].palette)
    end-- Set Ped Components
    for i = 0, 7 do
        if props[i + 1].index ~= -1 then
            SetPedPropIndex(ped, i, props[i + 1].index, props[i + 1].textureIndex, false)
        else
            ClearPedProp(ped, i)
        end
    end -- Set Ped Props

    notify("~b~Outfit successfully copied")
end)
