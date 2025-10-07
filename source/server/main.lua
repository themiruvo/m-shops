local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config
local ItemPrices = {}

for _, shop in pairs(Config.Shops) do
    for _, item in pairs(shop.items) do
        if not ItemPrices[item.name] then
            ItemPrices[item.name] = item.price
        end
    end
end

local function getItemPrice(itemName)
    return ItemPrices[itemName]
end

local function addItemToPlayer(source, item, amount)
    if Config.Inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return false end
        Player.Functions.AddItem(item, amount)
        return true
    elseif Config.Inventory == 'ox' then
        return exports.ox_inventory:AddItem(source, item, amount)
    elseif Config.Inventory == 'qs' then
        return exports['qs-inventory']:AddItem(source, item, amount)
    end
    return false
end

RegisterNetEvent('m-shops:purchase', function(data)
    local src = source
    local itemName = data.item
    local amount = tonumber(data.amount) or 1

    if not itemName or amount <= 0 then
        DropPlayer(src, '[m-shops] Invalid purchase request.')
        return
    end


    if amount > 10 then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('toomuch_items') })
        return
    end

    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local isNearShop = false

    for _, shop in ipairs(Config.Shops) do
        if #(playerCoords - shop.coords) < 3.0 then 
            isNearShop = true
            break
        end
    end

    if not isNearShop then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('notnear') })
        return
    end

    local price = getItemPrice(itemName)
    if not price then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('itemnotfound') })
        return
    end

    local total = price * amount
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local payment = data.payment or 'cash'
    local hasMoney = false

    if payment == 'cash' then
        hasMoney = Player.PlayerData.money.cash >= total
        if hasMoney then Player.Functions.RemoveMoney('cash', total) end
    elseif payment == 'bank' then
        hasMoney = Player.PlayerData.money.bank >= total
        if hasMoney then Player.Functions.RemoveMoney('bank', total) end
    else
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('invalid_payment') })
        return
    end

    if not hasMoney then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('not_enough_' .. payment) })
        return
    end

    local ok = addItemToPlayer(src, itemName, amount)
    if ok then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'success',
            description = _L('purchase_success'):format(amount, itemName, payment)
        })
    else
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('failed_give_item') })
        Player.Functions.AddMoney(payment, total)
    end
end)
