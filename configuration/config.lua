Config = {}

-- Choose inventory: 'qb' or 'qs' or 'ox'
Config.Inventory = 'qs' -- qb = qb-inventory/ps-inventory/lj-inventory/aj-inventory, qs = qs-inventory, ox = ox_inventory

Config.Locale = 'sv' -- Available: 'en', 'sv'

Config.Shops = {
    {
        name = 'Hardware Store',
        blip = true,
        blipSprite = 402,
        coords = vector3(55.25, -1739.56, 29.59),
        heading = 64.91,
        pedModel = 'a_m_y_eastsa_01',
        items = {
            { name = 'lockpick', label = 'Lockpick', price = 100 },
            { name = 'carlockpick', label = 'Vehicle Lockpick', price = 150 },
            { name = 'cleaningkit', label = 'Cleaning Kit', price = 80 },
            { name = 'radio', label = 'Radio', price = 250 },
            { name = 'phone', label = 'Phone', price = 300 }
        }
    },
    {
        name = 'Hardware Store',
        blip = true,
        blipSprite = 402,
        coords = vector3(2747.29, 3473.06, 55.67),
        heading = 246.94,
        pedModel = 'a_m_y_eastsa_01',
        items = {
            { name = 'lockpick', label = 'Lockpick', price = 100 },
            { name = 'carlockpick', label = 'Vehicle Lockpick', price = 150 },
            { name = 'cleaningkit', label = 'Cleaning Kit', price = 80 },
            { name = 'radio', label = 'Radio', price = 250 },
            { name = 'phone', label = 'Phone', price = 300 }
        }
    },
    {
        name = 'Uncle James',
        blip = false,
        blipSprite = 402,
        coords = vector3(2532.38, 4115.73, 38.81),
        heading = 148.1,
        pedModel = 'a_m_y_eastsa_01',
        items = {
            { name = 'electronickit', label = 'Elektronic Kit', price = 1000 },
            { name = 'trojan_usb', label = 'Trojan USB', price = 1000 }
        }
    },
    {
        name = 'Hardware Store',
        blip = true,
        blipSprite = 402,
        coords = vector3(-421.64, 6137.33, 31.88),
        heading = 203.17,
        pedModel = 'a_m_y_eastsa_01',
        items = {
            { name = 'lockpick', label = 'Lockpick', price = 100 },
            { name = 'carlockpick', label = 'Vehicle Lockpick', price = 150 },
            { name = 'cleaningkit', label = 'Cleaning Kit', price = 80 },
            { name = 'radio', label = 'Radio', price = 250 },
            { name = 'phone', label = 'Phone', price = 300 }
        }
    }
}

Config.TargetOptionsName = 'm_shop_option'

-- Global blip defaults
Config.Blip = {
    show = true,
    color = 2,
    scale = 0.8
}

-- Payment methods order shown to player
Config.PaymentMethods = {
    { id = 'cash', label = 'Cash' },
    { id = 'bank', label = 'Bank' }
}



return Config
