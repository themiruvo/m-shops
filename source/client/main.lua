local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config

local spawnedPeds = {}

local function loadModel(model)
    local modelHash = GetHashKey(model)
    RequestModel(modelHash)
    local timeout = GetGameTimer() + 5000 

    while not HasModelLoaded(modelHash) do
        Wait(10)
        if GetGameTimer() > timeout then
            print(("[m-shops] Failed to load model: %s"):format(model))
            return nil
        end
    end

    return modelHash
end

local function openShopMenu(shop)
    local menu = {
        id = 'shop_' .. shop.name,
        title = shop.name,
        options = {}
    }

    for _, item in ipairs(shop.items or {}) do
        menu.options[#menu.options + 1] = {
            title = ('%s - %s kr'):format(item.label, item.price),
            description = _L('buy_item_desc'),
            icon = 'fa-solid fa-cart-shopping',
            event = 'm-shops:openPaymentMenu',
            args = {
                shop = shop.name,
                item = item
            }
        }
    end

    lib.registerContext(menu)
    lib.showContext(menu.id)
end

RegisterNetEvent('m-shops:openPaymentMenu', function(data)
    local item = data.item
    local shopName = data.shop

    local payMenu = {
        id = 'payment_menu_' .. item.name,
        title = _L('buy_item_title', item.label, item.price),
        menu = 'shop_' .. shopName,
        options = {}
    }

    for _, method in ipairs(Config.PaymentMethods) do
        payMenu.options[#payMenu.options + 1] = {
            title = method.label,
            description = _L('pay_with', method.label),
            icon = 'fa-solid fa-money-bill',
            onSelect = function()
                local dialog = lib.inputDialog(_L('buy_item_input', item.label), {
                    { type = 'number', label = 'Amount', name = 'amount', required = true, min = 1 }
                })
                if not dialog then return end

                local amount = tonumber(dialog.amount) or 1
                TriggerServerEvent('m-shops:purchase', {
                    item = item.name,
                    amount = amount,
                    payment = method.id
                })
            end
        }
    end

    lib.registerContext(payMenu)
    lib.showContext(payMenu.id)
end)

local function spawnShopPeds()
    for i, shop in ipairs(Config.Shops) do
        local modelHash = loadModel(shop.pedModel)
        if not modelHash then
            print(("[m-shops] Could not load ped model for shop %d"):format(i))
            goto continue
        end

        local ped = CreatePed(4, modelHash, shop.coords.x, shop.coords.y, shop.coords.z - 1.0, shop.heading or 0.0, false, true)
        if not DoesEntityExist(ped) then
            print(("[m-shops] Failed to create ped for shop %d"):format(i))
            goto continue
        end

        SetEntityAsMissionEntity(ped, true, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        spawnedPeds[i] = ped


        local options = {
            {
                name = 'shop_' .. shop.name,
                label = _L('browse'),
                icon = 'fa-solid fa-store',
                distance = 2.5,
                onSelect = function()
                    openShopMenu(shop)
                end
            }
        }

        exports.ox_target:addLocalEntity(ped, options)
        SetModelAsNoLongerNeeded(modelHash)

        ::continue::
    end
end

AddEventHandler('onResourceStop', function(resName)
    if GetCurrentResourceName() ~= resName then return end
    for _, ped in ipairs(spawnedPeds) do
        if ped and DoesEntityExist(ped) then
            exports.ox_target:removeLocalEntity(ped)
            DeleteEntity(ped)
        end
    end
end)

local blips = {}
CreateThread(function()
    spawnShopPeds()

    if Config.Blip and Config.Blip.show then
        for i, shop in ipairs(Config.Shops) do
            if shop.blip ~= false then
                local sprite = shop.blipSprite or 52
                local b = AddBlipForCoord(shop.coords.x, shop.coords.y, shop.coords.z)
                SetBlipSprite(b, sprite)
                SetBlipScale(b, Config.Blip.scale or 0.8)
                SetBlipColour(b, Config.Blip.color or 2)
                SetBlipAsShortRange(b, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(shop.name or 'Shop')
                EndTextCommandSetBlipName(b)
                blips[#blips + 1] = b
            end
        end
    end
end)
