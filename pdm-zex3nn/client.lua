ESX = exports["es_extended"]:getSharedObject()

local PlayerData = {}
local GUI = {}
local JobBlips = {}
local publicBlip = false


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    deleteBlips()
	blips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
  blips()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    Wait(1000)
    deleteBlips()
	blips()
end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

function blips()
	
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'pdm' then

		for k,v in pairs(Config.Blipy)do
                if v.Type == 1 then 
                 local blip2 = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
                 SetBlipSprite (blip2, 310)
                 SetBlipDisplay(blip2, 4)
                 SetBlipScale  (blip2, v.Scale)
                 SetBlipColour (blip2, v.Colour)
                 SetBlipAsShortRange(blip2, true)
         
                 BeginTextCommandSetBlipName("STRING")
                 AddTextComponentString(v.Name)
                 EndTextCommandSetBlipName(blip2)
                 table.insert(JobBlips, blip2)
            end
        end

		
	end

    for k,v in pairs(Config.Blipy)do

            if v.Type == 2 then 
             local blip2 = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
     
             SetBlipSprite (blip2, 569)
             SetBlipDisplay(blip2, 4)
             SetBlipScale  (blip2, 0.8)
             SetBlipColour (blip2, 66)
             SetBlipAsShortRange(blip2, true)
     
             BeginTextCommandSetBlipName("STRING")
             AddTextComponentString(v.Name)
             EndTextCommandSetBlipName(blip2)
            end
         end




end
----------------------------------------------------------------------------------------
--                                  UBRANIA                                           --
----------------------------------------------------------------------------------------



function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
  
	  if skin.sex == 0 then
		if Config.Ubrania[job].male ~= nil then
		  TriggerEvent('skinchanger:loadClothes', skin, Config.Ubrania[job].male)
		else
      exports.dopeNotify:SendNotification({					
        text = '<b><i class="fas fa-bell"></i> POWIADOMIENIE</span></b></br><span style="color: #a9a29f;">'.. _U('no_outfit')'',
        type = "info",
        timeout = 3000,
        layout = "topRight"
      })
		end
	  else
		if Config.Ubrania[job].female ~= nil then
		  TriggerEvent('skinchanger:loadClothes', skin, Config.Ubrania[job].female)
		else
      exports.dopeNotify:SendNotification({					
        text = '<b><i class="fas fa-bell"></i> POWIADOMIENIE</span></b></br><span style="color: #a9a29f;">'.. _U('no_outfit')'',
        type = "info",
        timeout = 3000,
        layout = "topRight"
      })
		end
	  end
  
	end)
  end





function OtworzubraniamenuMafia()

  local playerPed = GetPlayerPed(-1)

  local elements = {
    { label = ('Ubrania Cywilne'), value = 'citizen_wear' }, 
	{ label = ('Rekrut'), value = 'klapek' },
    { label = ('Członek'), value = 'czlonek' },
    { label = ('Szef'), value = 'szef' },
  }


  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = ('Szatnia'),
      align    = 'center',
      elements = elements,
    },
    function(data, menu)

      cleanPlayer(playerPed)

      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)
      end

      if data.current.value == 'klapek' then
        setUniform(data.current.value, playerPed)
      elseif data.current.value == 'czlonek' then
      setUniform(data.current.value, playerPed)
      elseif data.current.value == 'szef' then
      setUniform(data.current.value, playerPed)
      end
      


    end,
    function(data, menu)
      menu.close()

    end
  )
end




----------------------------------------------------------------------------------------
--                                  POJAZDY                                           --
----------------------------------------------------------------------------------------
local hasVehicle = false
RegisterNetEvent('unknown-mafia:spawnVehicle')
AddEventHandler('unknown-mafia:spawnVehicle', function(vehicle)
    local playerPed = GetPlayerPed(-1)
    local coords    = vec3(-1532.28, 85.62, 56.72)
    local heading = 356.6870

    ESX.Game.SpawnVehicle(vehicle, coords, heading, function(vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        TriggerServerEvent('neey_keys:addKey', GetVehicleNumberPlateText(vehicle))
        SetVehicleCustomPrimaryColour(vehicle, 102, 0, 153)
        SetVehicleCustomSecondaryColour(vehicle, 102, 0, 153)
        hasVehicle = true
    end)
end)


RegisterNetEvent('unknown-mafia:removeVehicle')
AddEventHandler('unknown-mafia:removeVehicle', function(vehicle)
    if hasVehicle then
    local U123 = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(U123, true)
    SetEntityAsMissionEntity(U123, true)
    TriggerServerEvent('neey_keys:removeKey', GetVehicleNumberPlateText(vehicle))
    DeleteVehicle(vehicle)
    ESX.ShowNotification('Zwrócileś pojazd!')
    hasVehicle = false
    else
    ESX.ShowNotification('Nie wyjąłeś żadnego pojazdu!')
    end
end)

function spawnVehicleFromMenu()
    ESX.UI.Menu.CloseAll()

    local elements = {}

    for i=1, #Config.Vehicles, 1 do
        table.insert(elements, {label = Config.Vehicles[i].label, value = Config.Vehicles[i].name})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
    {
        title    = 'Garaż',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        TriggerEvent('unknown-mafia:spawnVehicle', data.current.value)
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        menu.close()
    end)
end


----------------------------------------------------------------------------------------


Citizen.CreateThread(function()
    RequestModel(GetHashKey(Config.Requestped))
    while not HasModelLoaded(GetHashKey(Config.Requestped)) do
      Citizen.Wait(200)
    end

	for k,v in pairs(Config.Pedy)do
			local mafia =  CreatePed(4, Config.HashPed, v.Pos.x, v.Pos.y, v.Pos.z-0.1, v.Pos.h, false, true)
			SetEntityHeading(mafia, v.Pos.h)
			FreezeEntityPosition(mafia, true)
			SetEntityInvincible(mafia, true)
			SetBlockingOfNonTemporaryEvents(mafia, true)
    end
end)

function bossmenumafia()
  ESX.UI.Menu.CloseAll()
  TriggerEvent('esx_society:openBossMenu', 'pdm', function(data, menu)
  menu.close()
end)
end


AddEventHandler('unknown:bossmenumafia')
RegisterNetEvent('unknown:bossmenumafia', function()
  bossmenumafia()
end)


Citizen.CreateThread(function()
    exports.qtarget:AddCircleZone("Szatnia", vector3(117.43, -1964.65, 21.58), 0.66, {
        name = "Szatnia",
        useZ = true,              
            }, {
              options = {
                {
                    action = function()
                        OtworzubraniamenuMafia()
                    end,
                    icon = "fa-solid fa-shirt",
                    label = "Przebierz się",
                    job = "pdm",
    
                },
            },
            distance = 3.0
    })	
    
    exports.qtarget:AddCircleZone("Garaż", vector3(-1536.48, 82.35, 56.77), 0.31, {
        name = "Garaż",
        useZ = true,              
            }, {
              options = {
                {
                    action = function()
                        spawnVehicleFromMenu()
                    end,
                    icon = "fa-solid fa-car",
                    label = "Wyciągnij pojazd",
                    job = "pdm",
                    canInteract = function()
                        if hasVehicle then
                            return false
                        end
                        return true
                    end,
    
                },
                {
                    event = "unknown-mafia:removeVehicle",
                    icon = "fa-solid fa-car",
                    label = "Zwróć pojazd",
                    job = 'pdm',
                 canInteract = function()
                    if hasVehicle then
                        return true
                    end
                    return false
                end,
                },
            },
            distance = 3.0
    })	
    exports.qtarget:AddCircleZone("bossmenumafia", vector3(-1529.20, 149.61, 60.60), 0.21, {
      name = "bossmenumafia",
      useZ = true,              
          }, {
            options = {
              {
                  event = "unknown:bossmenumafia",
                  icon = "fas fa-address-book",
                  label = "Akcje szefa",
                  job = {["pdm"] = 4},
  
              },
          },
          distance = 3.0
  })	
end)