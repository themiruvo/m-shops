local currentVersion = '1.0.0'
local versionURL = 'https://raw.githubusercontent.com/themiruvo/m-shops/refs/heads/main/version.txt'

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        print('^2[m-shops] Script Started.^0')
        print('^2[m-shops] Checking for updates...^0')
    end
end)


CreateThread(function()
    PerformHttpRequest(versionURL, function(status, response, _)
        if not response or status ~= 200 then
            print('^1[m-shops] Version check failed. Could not reach version server.^0')
            return
        end

        local latestVersion = response:gsub('%s+', '')
        if latestVersion ~= currentVersion then
            print('^3[m-shops] A new version is available: ^2' .. latestVersion .. '^3 [You are running: ^1' .. currentVersion .. '^3]')
            print('^3Download the latest version here: https://github.com/themiruvo/m-shops^0')
        else
            print('^2[m-shops] You are running the latest version [' .. currentVersion .. '].^0')
        end
    end)
end)

print([[
Script created by 
██████   ██████  ███                                           
░░██████ ██████  ░░░                                            
░███░█████░███  ████  ████████  █████ ████ █████ █████  ██████ 
░███░░███ ░███ ░░███ ░░███░░███░░███ ░███ ░░███ ░░███  ███░░███
░███ ░░░  ░███  ░███  ░███ ░░░  ░███ ░███  ░███  ░███ ░███ ░███
░███      ░███  ░███  ░███      ░███ ░███  ░░███ ███  ░███ ░███
█████     █████ █████ █████     ░░████████  ░░█████   ░░██████ 
░░░░░     ░░░░░ ░░░░░ ░░░░░       ░░░░░░░░    ░░░░░     ░░░░░░  
]])