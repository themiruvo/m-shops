# m_shops

> A modular and configurable shop system for FiveM using ox_lib and QBCore.  
Supports multiple inventory systems (`qb`, `qs`, `ox`) and payment methods (`cash`, `bank`) out of the box.

![Version](https://img.shields.io/badge/version-1.0.0-blue)  
![Language](https://img.shields.io/badge/language-Lua-yellow)  
![Framework](https://img.shields.io/badge/framework-QBCore-orange)  
![Inventory](https://img.shields.io/badge/inventory-qb%20%7C%20qs%20%7C%20ox-9cf)  
![GitHub](https://img.shields.io/badge/GitHub-themiruvo/m_shops-black?logo=github)

---

## 📋 Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Localization](#localization)
- [Dependencies](#dependencies)

---

## ℹ️ Project Information

- **👤 Author:** [themiruvo](https://github.com/themiruvo)
- **📦 Version:** 1.0.0
- **📄 License:** GPL-3.0
- **📂 Repository:** [https://github.com/themiruvo/m_shops](https://github.com/themiruvo/m_shops)

---

## ✅ Features

- 🛒 Multiple NPC Shop Locations
- 🧠 Intelligent NPC Spawning with `ox_target` interactions
- 💰 Supports `cash` and `bank` payments
- 📦 Inventory compatibility: `qb`, `qs`, `ox_inventory`
- 📚 Easy-to-configure item lists and shop setups
- 🧩 ox_lib Context Menu UI integration
- 🌍 Multi-language support via a dedicated localization system
- 🔁 Built-in version checker to stay up-to-date

---

## 📥 Installation

1. **Download** the latest version from [GitHub](https://github.com/themiruvo/m_shops).
2. Extract the folder into your server's `resources/` directory:
    ```
    resources/[scripts]/m_shops
    ```
3. Add the following line to your `server.cfg`:
    ```
    ensure m_shops
    ```
4. Open `config.lua` and adjust the configuration to suit your server.

---

## ⚙️ Configuration

All configuration options are located in `config.lua`, including:

- Shop locations
- Items sold
- NPC models
- Blip visibility
- Supported inventory system
- Language (locale)

```lua
Config.Inventory = 'qs' -- qb / qs / ox
Config.Locale = 'sv'    -- Language (see locale.lua)
```
## 💡 Usage
> Walk up to an NPC vendor at a configured shop.

- Use the ox_target interaction menu (e.g., "Bläddra").
- Browse the items and select one to purchase.
- Choose a payment method (cash or bank).
- Confirm the amount and complete your purchase.

## 🌐 Localization
- You can translate the resource using `locale.lua`.
- Default languages: English (en) and Swedish (sv)
- Easily extendable for more locales.

## 📦 Dependencies
- [QBCore](https://github.com/qbcore-framework/qb-core) or [QBOX](https://github.com/Qbox-project/qbx_core) 
- [ox_lib](https://github.com/communityox/ox_lib)
- [ox_target](https://github.com/CommunityOx/ox_target)
> - Inventory management system [ ⚠️ One required ] :

* [ox_inventory](https://github.com/CommunityOx/ox_inventory)
* [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
* qs-inventory
