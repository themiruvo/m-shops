local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config

local function addItemToPlayer(source, item, amount)
    if Config.Inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return false end
        Player.Functions.AddItem(item, amount)
        return true
    elseif Config.Inventory == 'ox' then
        local success = exports.ox_inventory:AddItem(source, item, amount)
        return success
    elseif Config.Inventory == 'qs' then
        local success = exports['qs-inventory']:AddItem(source, item, amount)
        return success
    end
    return false
end

RegisterNetEvent('m-shops:purchase', function(data)
    local src = source
    local item = data.item
    local amount = tonumber(data.amount) or 1
    local price = tonumber(data.price) or 0

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local payment = data.payment or 'cash'
    local total = price * amount

    if payment == 'cash' then
        local cash = Player.PlayerData.money.cash
        if cash < total then
            TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('not_enough_cash') })
            return
        end
        Player.Functions.RemoveMoney('cash', total)
    elseif payment == 'bank' then
        local bank = Player.PlayerData.money.bank
        if bank < total then
            TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('not_enough_bank') })
            return
        end
        Player.Functions.RemoveMoney('bank', total)
    else
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('invalid_payment') })
        return
    end

    local ok = addItemToPlayer(src, item, amount)
    if ok then
        TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = _L('purchase_success'):format(amount, item, payment) })
    else
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = _L('failed_give_item') })
        if payment == 'cash' then
            Player.Functions.AddMoney('cash', total)
        elseif payment == 'bank' then
            Player.Functions.AddMoney('bank', total)
        end
    end
end)