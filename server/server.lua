ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("error:getPlayerSkin", function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @a", {

        ['@a'] = xPlayer.identifier

    }, function(result)
    
        cb(json.decode(result[1].skin))
    
    end)

end)

ESX.RegisterServerCallback("error:cehckPerms", function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    cb(xPlayer.getGroup())

end)