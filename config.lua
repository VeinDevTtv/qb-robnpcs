-- config.lua
Config = {}

-- Money rewards
Config.minAmount       = 50        -- minimum cash reward
Config.maxAmount       = 200       -- maximum cash reward

-- Cooldown between robberies (ms)
Config.cooldown        = 60 * 1000

-- Maximum distance to rob
Config.robRange        = 3.0

-- Which weapons allow you to rob
Config.allowedWeapons  = {
    [`weapon_unarmed`] = false,
    [`weapon_knife`]   = true,
    [`weapon_pistol`]  = true,
    [`weapon_m4`]      = true,
    -- add others you want
}

-- Skill-check settings
Config.useSkillCheck           = true
Config.skillCheckSuccessChance = 0.7    -- fallback chance if skill library unavailable

-- Dispatch settings
Config.dispatch = {
    job      = { "police" },
    code     = "10-32",
    text     = "Street Robbery",
    blipData = {
        sprite  = 480,
        scale   = 0.5,
        colour  = 1,
        time    = 20 * 1000
    }
}
