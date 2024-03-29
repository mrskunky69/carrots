local CollectPrompt
local active = false
local amount = 0
local cooldown = 0
local oldBush = {}
local checkbush = 0
local bush


local Plantgroup = GetRandomIntInRange(0, 0xffffff)
print('Plantgroup: ' .. Plantgroup)

function CollectHerbs()
    Citizen.CreateThread(function()
        local str = 'Collect'
        local wait = 0
        CollectPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(CollectPrompt, 0xD9D0E1C0)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(CollectPrompt, str)
        PromptSetEnabled(CollectPrompt, true)
        PromptSetVisible(CollectPrompt, true)
        PromptSetHoldMode(CollectPrompt, true)
        PromptSetGroup(CollectPrompt, Plantgroup)
        PromptRegisterEnd(CollectPrompt)
    end)
end

Citizen.CreateThread(function()
    Wait(2000)
    CollectHerbs()
    while true do
        Wait(1)
        local playerped = PlayerPedId()
        if checkbush < GetGameTimer() and not IsPedOnMount(playerped) and not IsPedInAnyVehicle(playerped) and not eat and cooldown < 1 then
            bush = GetClosestBush()
            checkbush = GetGameTimer() + 500
        end
        if bush then
            if active == false then
                local PlantgroupName  = CreateVarString(10, 'LITERAL_STRING', "Gather")
                PromptSetActiveGroupThisFrame(Plantgroup, PlantgroupName)
            end
            if PromptHasHoldModeCompleted(CollectPrompt) then
                active = true
                oldBush[tostring(bush)] = true
                goCollect()
            end
        end
    end
end)

function goCollect()
    local playerPed = PlayerPedId()
    RequestAnimDict("mech_pickup@plant@tobacco")
    while not HasAnimDictLoaded("mech_pickup@plant@tobacco") do
        Wait(100)
    end
    local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, `WORLD_HUMAN_FARMER_RAKE`, 0, true)
    Wait(7000)
    ClearPedTasks(ped)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    TaskStartScenarioInPlace(ped, `WORLD_HUMAN_FARMER_WEEDING`, 0, true)
    Wait(8000)
    ClearPedTasks(ped)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    TriggerServerEvent('qbr-carrot:addHerbs')
    active = false
    ClearPedTasks(playerPed)
end

Citizen.CreateThread(function()
    while true do
        Wait(60000)
        if amount > 0 then
            amount = amount - 1
        end
    end
end)

function GetClosestBush()
    local playerped = PlayerPedId()
    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, GetEntityCoords(playerped), 2.0, itemSet, 3, Citizen.ResultAsInteger())
    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            local model_hash = GetEntityModel(entity)
            if (model_hash ==  856203211 or model_hash ==  1773521797 or model_hash ==  -47938942 or model_hash ==  -1537045221 or model_hash ==  746968307) and not oldBush[tostring(entity)] then
              if IsItemsetValid(itemSet) then
                  DestroyItemset(itemSet)
              end
              return entity
            end
        end
    else
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end
end