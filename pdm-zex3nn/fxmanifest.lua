fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'ogoskar'
description 'Firma PDM | discord.gg/U7MDg48tpn'
version '1.0.0'

client_scripts {
    'client.lua'
}
server_script 'server.lua'

shared_script 'config.lua'

dependency {
    'ox_inventory'
}