🛡️ **Secure Server-Side Price Handling**
- Removed trust in client-sent prices.
- The server no longer accepts price from the client, it fetches the correct price from Config.Shops or a cached table.
- Prevents exploits where a cheater sends price = 0 or negative values to get free items.

📦 **Item Validation & Whitelisting**
- The server checks if the requested item is actually defined in the shop config.
- If an invalid item is sent by the client, the player is denied or dropped, making item spoofing impossible.

**🧍‍♂️ Shop Proximity Check**
- Server checks that the player is within 3 meters of any shop location before allowing a purchase.
- Prevents teleporters or remote exploiters from buying items without visiting a shop.

**🔢 Purchase Quantity Limit**
- Players are now restricted to purchasing a maximum of 10 items ( can be edited ) per transaction.
- If a higher amount is requested, the server cancels the purchase and sends a notification.

🔁 **Refund on Inventory Failure**
- If the server fails to add the item to the player's inventory (e.g., due to space or bugs), the player is automatically refunded.
- Applies to both cash and bank payments.

⚡ **Optimized Price Lookup**
- Item prices are cached on server startup in a flat ItemPrices table.
- Avoids looping through all shops on every purchase, improving performance.

🌍 **Localization Support**
- Updated `locale.lua` with a new string `toomuch_items`.


📦 **Update the following :**
- Reinstall the script but keep your edits for the config.lua.
