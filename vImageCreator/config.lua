---
Config = {}
Config.DiscordWebHook = 'https://discord.com/api/webhooks/905382029066113044/m4O7_m3jwcyzbL0WnwmujG0V79lwQI-3tl_iWRviXbbKo1RKoXs2-vtPDGpKdC7tHkpS'
Config.save = 'json' -- kvp, json
Config.vehicle_table = 'vehicles' -- vehicle table must have model column (name not hash)
Config.useSQLvehicle = false -- use mysql async to fetch vehicle table else SqlVehicleTable will use
Config.SqlVehicleTable = QBCore and QBCore.Shared and QBCore.Shared.Vehicles and QBCore.Shared.Vehicles or {} -- example qbcore shared vehicle

-- Custom Category
Config.Category = 'all' -- select a custom category | set this to 'all' if you want to Screenshot all vehicle categories

-- Permission
Config.owners = {
    ['license:4ab00203b911f37baf9b135734ee06dfd6352d54'] = true,
    --add more here
}