local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local PlayerGang = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback("prdx_business:getSalaries", function(BusinessSalaries)
        PlayerJob = QBCore.Functions.GetPlayerData().job
        PlayerGang = QBCore.Functions.GetPlayerData().gang
    end)
    SendNUIMessage({reset = true})
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    SendNUIMessage({reset = true})
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
    SendNUIMessage({reset = true})
end)

RegisterNetEvent('QBCore:Client:UpdateObject', function()
	QBCore = exports['qb-core']:GetCoreObject()
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        PlayerGang = QBCore.Functions.GetPlayerData().gang
    end
end)

RegisterNetEvent('prdx_bossmenu:client:openMenu', function()
    local menu = {
        {
            title = "Boss Menu", 
            event = "prdx_bossmenu:client:openBossMenu"
        },
        {
            title = "Supply Orders", 
            event = "prdx_gopostal:client:supplyOrdersMenu",
            args = true
        },
    }

    if PlayerJob.name == "realestate" and PlayerJob.grade.level == 4 then
        menu[#menu+1] = {
            title = "Realty Management", 
            event = "prdx_realty:client:openMenu"
        }
    end
    lib.registerContext({
        id = 'business_management_menu',
        title = 'Business Management Options',
        options = menu,
    })
    lib.showContext('business_management_menu')
end)

-- MENU
RegisterNetEvent('prdx_bossmenu:client:openBossMenu', function(update)
    if PlayerJob.isboss or PlayerGang.isboss then
        QBCore.Functions.TriggerCallback('prdx_bossmenu:server:GetMenuData', function(data)
            SetNuiFocus(true, true)
            SendNUIMessage(
                {
                    ['showmenu'] = true,
                    ['update'] = update or false,
                    ['business'] = data.business,
                    ['job'] = PlayerJob.name or "unemployed",
                    ['jobLevel'] = (PlayerJob.grade and PlayerJob.grade.level) or nil,
                    ['gang'] = PlayerGang.name or "none",
                    ['gangLevel'] = (PlayerGang.grade and PlayerGang.grade.level) or nil,
                    ['citizenid'] = QBCore.Functions.GetPlayerData().citizenid,
                    ['allJobs'] = QBCore.Shared.Jobs,
                    ['allGangs'] = QBCore.Shared.Gangs
                }
            )
        end)
    else
        QBCore.Functions.Notify("Not an owner", 'error')
    end
end)

RegisterNetEvent('prdx_bossmenu:client:openIngredientsMenu', function()
    QBCore.Functions.TriggerCallback('prdx_bossmenu:server:GetMenuData', function(data)
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                ['ingredients'] = true,
                ['business'] = data.business,
            }
        )
    end)
end)

-- -- STORAGE OPTIONS --

RegisterNetEvent('prdx_bossmenu:client:giveJob')
AddEventHandler('prdx_bossmenu:client:giveJob', function(data)
    local player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    if data.job then
        TriggerServerEvent("prdx_bossmenu:server:giveJob", {target = player, type = "job"})
    elseif data.gang then
        TriggerServerEvent("prdx_bossmenu:server:giveJob", {target = player, type = "gang"})
    end
end)

-- NUI CALLBACKS
RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("fireEmployee", function(data)
    TriggerServerEvent("prdx_bossmenu:server:fireEmployee", {target = data.employee, job = data.fireJob, gang = data.fireGang})
    Wait(500)
    TriggerEvent("prdx_bossmenu:client:openBossMenu", true)
end)

RegisterNUICallback("changeRank", function(data)
    TriggerServerEvent("prdx_bossmenu:server:updateGrade", {target = data.employee, targetjob = QBCore.Shared.SplitStr(data.rank, "-")[1], grade = QBCore.Shared.SplitStr(data.rank, "-")[2], job = data.rankJob, gang = data.rankGang})
    Wait(500)
    TriggerEvent("prdx_bossmenu:client:openBossMenu", true)
end)

RegisterNUICallback("updateItemPrice", function(data)
    TriggerServerEvent("prdx_business:server:setPrice", PlayerJob.name, data.item, data.price)
end)

RegisterNUICallback("updateGradeSalary", function(data)
    TriggerServerEvent("prdx_business:server:setSalary", PlayerJob.name, data.grade, data.salary)
end)

RegisterNUICallback("orderIngredients", function(data)
    TriggerServerEvent("prdx_gopostal:server:placeOrder", data, PlayerJob.name, GetEntityCoords(cache.ped))
end)

RegisterNetEvent('prdx_bossmenu:openAccountManager', function()
    local menu = {
        {
            title = "Lookup Account", 
            event = "prdx_bossmenu:lookupAccount"
        },
        {
            title = "Delete Account", 
            event = "prdx_bossmenu:deleteAccount",
        },
    }
    lib.registerContext({
        id = 'account_manager_menu',
        title = 'Maze Bank Account Manager',
        options = menu,
    })
    lib.showContext('account_manager_menu')
end)

AddEventHandler('prdx_bossmenu:lookupAccount', function()
    local dialog = lib.inputDialog("Maze Bank Account Lookup",{
        { type = "input", label = "Bank Account"},
    })
    if not dialog then return end

    TriggerServerEvent('prdx_bossmenu:viewAccount', dialog[1])

end)

RegisterNetEvent('prdx_bossmenu:client:depositTill', function()
    local menu = {
        {
            title = "Open Receipt Drop-Box", 
            event = "target:client:openStash",
            args = {"till_deposit", "till_deposit"}
        },
        {
            title = "Deposit Receipts", 
            serverEvent = "inventory:server:sellStash",
            args = {'till_deposit', true}  
        },
    }
    lib.registerContext({
        id = 'deposit_till_menu',
        title = 'Deposit Till Receipts',
        options = menu,
    })
    lib.showContext('deposit_till_menu')
end)