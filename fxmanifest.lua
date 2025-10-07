fx_version 'cerulean'; game 'gta5'; lua54 'yes';

author 'Miruvo'
description 'Shop System using interactive peds [QBCore, QBOX]'
version '1.0.0'

shared_scripts { 
    '@ox_lib/init.lua', 
    'configuration/config.lua', 
    'locales/locale.lua', 
    'locales/funcs.lua' 
}

client_scripts { 
    'source/client/main.lua',
    'configuration/config.lua'
}

server_scripts { 
    'source/server/main.lua', 
    'source/server/versions.lua'
}

dependencies { 
    'qb-core', 
    'ox_lib', 
    'ox_target' 
}

