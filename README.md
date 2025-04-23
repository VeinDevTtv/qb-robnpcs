# qb-robnpcs

A fast, configurable FiveM/QBCore script that lets players rob ambient NPCs—with optional skill‐checks, progress bars, dynamic dispatch calls, and police escalation on failure.

---

## 🌟 Features

- **Configurable Rewards & Cooldown**  
  Set minimum/maximum cash payouts and robbery cooldown time in `config.lua`.

- **Allowed Weapons List**  
  Define which weapons permit robberies (e.g. knife, pistol, rifle).

- **Mini-Game Skill-Check** _(optional)_  
  Integrates with PS-UI for a little challenge; falls back to a simple chance roll.

- **Progress Bar Feedback** _(optional)_  
  Uses the `progressBars` resource to show a “Robbing NPC…” timer.

- **Dynamic Dispatch Calls**  
  Automatically notifies police via `qs-dispatch`, including street lookup and map blip.

- **Failure State & Police Alert**  
  On skill-check failure, NPC “calls the cops” and the player can gain a wanted-level bump.

- **Keybind / Command**  
  Press **E** (or type `/robped`) to rob the nearest NPC instead of free-aim.

---

## 📦 Installation

1. **Copy Resources**  
   Drop the `qb-robnpcs` folder into your server’s `resources/[Scripts]/` directory.

2. **Enable in `server.cfg`**  
   ```cfg
   ensure qb-robnpcs
