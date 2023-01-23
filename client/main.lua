ESX = nil
playerData = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	playerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)

    ESX.PlayerData = playerData

end)

RegisterNetEvent("esx:setJob", function(job)

    ESX.PlayerData.job = job

end)

local function keyRegister(openname, name, key, action)
    RegisterKeyMapping(openname, name, 'keyboard', key)
    RegisterCommand(openname, function()
        if (action ~= nil) then
            action();
        end
    end, false)
end

local function LoadPlayerModel(model)

    model = model or "mp_m_freemode_01"

    local name = GetHashKey(model)

    if IsModelInCdimage(name) and IsModelValid(name) then
        RequestModel(name)
        while not HasModelLoaded(name) do
            RequestModel(name)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), name)
        SetModelAsNoLongerNeeded(name)
        
        SetPedDefaultComponentVariation(PlayerPedId())

    end

end

local pedmenu = {}

pedmenu.Base = {

    Header = {"commonmenu", "interaction_bgd"},
    Color = {color_Green},
    HeaderColor = {255, 255, 255},
    Title = 'Menu Ped'

}

pedmenu.Data = {currentMenu = "liste des peds"}

pedmenu.Events = {

    onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)

        if not string.find(btn.name, "Reprendre") then

            LoadPlayerModel(btn.model)

            return

        end

        ESX.TriggerServerCallback("error:getPlayerSkin", function(skin) 
            
            LoadPlayerModel()

            TriggerEvent("skinchanger:loadSkin", skin)

        end)

    end

}

pedmenu.Menu = {

    ['liste des peds'] = {

        b = function()

            local all_peds = {

                {name = "Reprendre mon ~b~personnage", ask = "→", askX = true}

            }

            for _,v in pairs(Config.peds) do 

                all_peds[#all_peds+1] = {

                    name = v.label,
                    ask = "→",
                    askX = true,
                    model = v.model

                }

            end

            return all_peds

        end

    }

}

keyRegister("pedmenu", "Menu Ped", Config.key, function()

    ESX.TriggerServerCallback("error:cehckPerms", function(group)

        for k,v in pairs(Config.perms) do 

            if group == v then

                CreateMenu(pedmenu)

                break
    
            end

        end
        
    end)

end)