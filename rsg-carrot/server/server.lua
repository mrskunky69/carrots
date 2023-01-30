local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent('qbr-carrot:addHerbs')
AddEventHandler('qbr-carrot:addHerbs', function() 
	local src = source
	local Player = RSGCore.Functions.GetPlayer(src)
	local randomNumber = math.random(1,100)

	if randomNumber > 0 and randomNumber <= 70 then
		local _subRan = math.random(1,5)
			if _subRan == 1 then
				Player.Functions.AddItem('carrot', givecarrot)
				TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['carrot'], "add")
				TriggerClientEvent('RSGCore:Notify', src, 'you got a carrot')
			elseif _subRan == 3 then
				Player.Functions.AddItem('carrot', givecarrot)
				TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['carrot'], "add")
				TriggerClientEvent('RSGCore:Notify', src, 'you got carrot')
			elseif _subRan == 4 then
				Player.Functions.AddItem('carrot', givecarrot)
				TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['carrot'], "add")
				TriggerClientEvent('RSGCore:Notify', src, 'you got carrot')
			else
			TriggerClientEvent('RSGCore:Notify', src, 'you failed to find anything')
		end

	elseif randomNumber > 70 and randomNumber <= 100 then
		local _subRan = math.random(1,4)
			if _subRan == 1 then
				Player.Functions.AddItem('carrotseed', givecarrot)
				TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['carrotseed'], "add")
				TriggerClientEvent('RSGCore:Notify', src, 'you got a carrotseed')
			elseif _subRan == 2 then
				Player.Functions.AddItem('carrotseed', givecarrot)
				TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['carrotseed'], "add")
				TriggerClientEvent('RSGCore:Notify', src, 'you found carrotseed')
			else
				TriggerClientEvent('RSGCore:Notify', src, 'you failed to find anything')
			end
		end
	end)

