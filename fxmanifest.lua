fx_version('cerulean')
games({ 'gta5' })

author "ツ ERROR"

shared_script('config.lua');

server_scripts({

    "@mysql-async/lib/MySQL.lua",
    "server/server.lua"

});

client_scripts({

    "client/*.lua",
    "lib/pmenu.lua"

});