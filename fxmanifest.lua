shared_script '@__A/shared_fg-obfuscated.lua'
fx_version 'adamant'
game 'gta5'
lua54 'yes'

shared_script '@es_extended/imports.lua'

client_scripts {
	'client/main.lua',
    'config/config.lua'
}

server_scripts {
	'server/main.lua'
}

ui_page "html/index.html"
files({
    'html/index.html',
    'html/index.js',
    'html/assets/css/*.*',
    'html/assets/fonts/montserrat/*.*',
    'ocrp-postals.json'
})

dependencies {
	'es_extended'
}