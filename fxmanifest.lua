fx_version 'cerulean'
game 'gta5'
lua_54 'yes'

author 'CodeUniverse'
description 'Advanced Notification System'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'config.lua',
    'client/main.lua'
}

files {
    'html/index.html',
    'html/styles.css',
    'html/script.js'
}

exports {
    'ShowNotification',
    'RemoveNotification'
}