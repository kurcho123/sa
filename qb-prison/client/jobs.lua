local joblist = {}
local equipmentlist = {}
local markers = {}
local supplyCount = 0
local hasJobSupplies = false
local taskscomplete = 0
local showMarker = nil
local currentJobName = nil
local currentMarker = nil
local currentRewardName = nil

-- Cooldowns, add for each new job
local cooldowns = { ["canteen"] = false, ["bunks"] = false, ["yardwork"] = false,}

-- Setup Crafting, Check if jobs are enabled
CreateThread(function()
    if Config.DynamicJobsEnabled == true then
    TriggerEvent('prison:client:setupjobstartingpoints')	
    SetupCrafting()
    end
end)

--Task Logic (Skillcheck + Progress Bar)
RegisterNetEvent('prison:client:starttask', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {data.jobaction, 0})
    -- local result = exports["skillcheck"]:StartCheck(5, 3
    local result = lib.skillCheck({'easy', 'easy', 'easy'})
    if result == true then 
        --Run Progress Bar
        QBCore.Functions.Progressbar(data.jobaction, data.label, data.fastTime, false, true, {
            disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function()
                TriggerEvent('prison:client:completetask', data.jobname)
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})                              
                TriggerServerEvent('prison:server:ItemReward', PickReward(currentRewardName), true)                                             
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    else 
        --Run Longer Progress Bar
        QBCore.Functions.Progressbar(data.jobaction, data.label, data.slowTime, false, true, {
            disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function()
            TriggerEvent('prison:client:completetask', data.jobname)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})                      
            TriggerServerEvent('prison:server:ItemReward', PickReward(currentRewardName), false)
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    end
end)

--Task Finished Logic
RegisterNetEvent('prison:client:completetask', function(jobn)
    showMarker = nil
    local jobname = jobn    
    taskscomplete = taskscomplete + 1
    if (taskscomplete >= 5) then
        if math.random(1, 100) <= 15 then  
            jailTime = jailTime - math.random(1, 2)
            QBCore.Functions.Notify("You've worked some time off, " .. jailTime .. " Months left in jail.")         
        end
    end       
    TriggerEvent('prison:client:removetask', jobname) 
end)

--Delete the zone on task completion
RegisterNetEvent('prison:client:removetask', function(jname) 
    exports['qb-target']:RemoveZone(jname)
    ClearLastMarker()
    
    -- Completed all tasks and now on cooldown 
    if taskscomplete == Config.PrisonJobTypes[currentJobName].jobconfig.taskcount then
        taskscomplete = 0
        local timeReduction = math.random(Config.PrisonJobTypes[currentJobName].jobconfig.minTimeReduction, Config.PrisonJobTypes[currentJobName].jobconfig.maxTimeReduction)
        jailTime = jailTime - timeReduction
        QBCore.Functions.Notify("Job Complete, " .. jailTime .. " Months left in jail.", "success", 10000)
        SetupStashPoly()
    else
        QBCore.Functions.Notify("Task Complete, tasks remaining: " .. Config.PrisonJobTypes[currentJobName].jobconfig.taskcount - taskscomplete, "success", 5000)
        TriggerEvent('prison:client:continuedynamicjob', currentJobName)
    end
end)

--Setup the job starting/supply locations
RegisterNetEvent('prison:client:setupjobstartingpoints', function()
    for k, v in pairs(Config.PrisonJobTypes) do   
        supply = Config.PrisonJobTypes[k].supplyzone
        
        exports.ox_target:addBoxZone({
            coords = vec3(supply.location.x, supply.location.y, supply.location.z),
            size = vec3(supply.width, supply.length, supply.maxZ - supply.minZ),
            rotation = supply.heading,
            debug = false,
            options = {
                {
                    event = 'prison:client:startdynamicjob',
                    label = supply.label,
                    heading = supply.heading,
                    jobname = k .. ".PrisonJob",
                    action = supply.action,
                    configname = supply.zonename,
                },
                {
                    event = 'prison:client:abortjob',
                    label = "Abort Job",
                    configname = supply.zonename,
                    jobname = ".PrisonJob",
                },
            },
        })
    end
end)

--Setup Polyzones for currently active job
RegisterNetEvent('prison:client:startdynamicjob', function(data)
    local jobnames = data.configname
    if not cooldowns[jobnames] then
        cooldowns[jobnames] = true
        TriggerCooldown(jobnames)
        --Good to start the job
        currentJobName = jobnames
        currentRewardName = data.configname
        taskscomplete = 0
        local currentTaskNumber = math.random(1, #Config.PrisonJobTypes[data.configname].sites)
        QBCore.Functions.Notify("Job Started, " .. tostring(Config.PrisonJobTypes[currentJobName].jobconfig.taskcount) .. " tasks remaining", "error") 
        joblocation = Config.PrisonJobTypes[data.configname].sites[currentTaskNumber]
        joblocation.location = vec3(joblocation.location.x, joblocation.location.y, joblocation.location.z - 1)
        if data.configname == "bunks" then
            for k,v in pairs(Config.PrisonJobTypes["bunks"].sites) do
                exports['qb-target']:RemoveZone("PrisonStash." .. k)
            end
        end

        exports['qb-target']:AddBoxZone("PrisonJobCurrentTask", joblocation.location, joblocation.length, joblocation.width, {
            name = "PrisonJobCurrentTask",
            heading = joblocation.heading,
            debugPoly = false,
            minZ = joblocation.minZ-2,
            maxZ = joblocation.maxZ-1
            }, {
                options = {
                    {
                        type = "client",
                        event = 'prison:client:starttask',
                        icon = "",
                        label = joblocation.label,
                        heading = joblocation.heading,
                        jobname = "PrisonJobCurrentTask",
                        jobaction = joblocation.action,
                        slowTime = joblocation.slowTime,
                        fastTime = joblocation.fastTime,
                    },
                },
                distance = 3.0
            }
        )

        currentMarker = Config.PrisonJobTypes[jobnames].sites[currentTaskNumber]
        showmarker()
    else
        QBCore.Functions.Notify("You've started this job too recently, find another!", "error")
    end
end)

--Setup Polyzones for currently active job
RegisterNetEvent('prison:client:continuedynamicjob', function(data)
    local jobnames = data
    local currentTaskNumber = math.random(1, #Config.PrisonJobTypes[data].sites)        
    joblocation = Config.PrisonJobTypes[data].sites[currentTaskNumber]
    joblocation.location = vec3(joblocation.location.x, joblocation.location.y, joblocation.location.z - 1)
    exports['qb-target']:AddBoxZone("PrisonJobCurrentTask", joblocation.location, joblocation.length, joblocation.width, {
        name = "PrisonJobCurrentTask",
        heading = joblocation.heading,
        debugPoly = false,
        minZ = joblocation.minZ-2,
        maxZ = joblocation.maxZ-1
        }, {
            options = {
                {
                    type = "client",
                    event = 'prison:client:starttask',
                    icon = "",
                    label = joblocation.label,
                    heading = joblocation.heading,
                    jobname = "PrisonJobCurrentTask",
                    jobaction = joblocation.action,
                    slowTime = joblocation.slowTime,
                    fastTime = joblocation.fastTime,
                },
            },
            distance = 3.0
        }
    )
    currentMarker = Config.PrisonJobTypes[jobnames].sites[currentTaskNumber]
    showmarker()
end)

--Reset Job Progress
RegisterNetEvent('prison:client:abortjob', function(data)
    showMarker = false
    supplyCount = 0
    hasJobSupplies = false
    taskscomplete = 0
    for k, v in pairs(Config.PrisonJobTypes[data.configname].sites) do
        joblocations = Config.PrisonJobTypes[data.configname].sites
        exports['qb-target']:RemoveZone(k .. data.jobname)
    end  
    QBCore.Functions.Notify("Job Aborted!", "error")  
    SetupStashPoly()
end)

-- Visual Feedback for current task
function showmarker()
    showMarker = true
    CreateThread(function()
        while showMarker ~= false do
            Wait(1) 
            DrawMarker(0, currentMarker.location.x, currentMarker.location.y, currentMarker.location.z + currentMarker.markerOffset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, true, false, false, true, false, false, false)
        end
    end)
end

-- Remove the last marker
function ClearLastMarker()
    showMarker = false
end

-- Setup Crafting Bench
function SetupCrafting()
    -- exports['qb-target']:AddBoxZone("PrisonCraftingBench", vector3(1661.51, 2583.52, 45.61), 0.7, 1.3, {
    --     name = "PrisonCraftingBench", heading = 135.29, debugPoly = false, minZ = 44.56, maxZ = 45.66 },
    --     {
    --         options = {
    --             {
    --                 type = "client",
    --                 event = "inventory:client:PrisonCrafting",
    --                 icon = 'fas fa-hand-sparkles',
    --                 label = "Open Crafting Station",
    --                 craftingItems = Config.PrisonCraftingItems,
    --             },
    --         },
    --         distance = 2.5
    --     }
    -- )

    local hash = joaat("prop_cs_trolley_01")
    RequestModel(hash)  
    local waiting = 0
    while not HasModelLoaded(hash) do
        waiting = waiting + 100
        Wait(100)
        if waiting > 5000 then 
            break
        end
    end 
    local prop = CreateObject(hash, vector3(1661.51, 2583.52, 44.56), false, false, true)
    local ent = Entity(prop)
    ent.state:set(prop, 80001171, true)
    SetEntityRotation(ent, 0.0, 0.0, 135.29, 0, true)
    FreezeEntityPosition(prop, true)
end

-- Trigger cooldowns for individual jobs
function TriggerCooldown(jobname)
    cooldowns[jobname] = true
    
    SetTimeout(Config.PrisonJobTypes[jobname].jobconfig.jobCooldown, function()
        cooldowns[jobname] = false
    end)
end

-- Probability table reward picking
function PickReward(rewardTable)
   local sum = 0
   for _, chance in pairs(Config.PrisonJobTypes[rewardTable].rewardTable) do
      sum = sum + chance
   end

   local rand = math.random(sum)
   local rewardName
   for key, chance in pairs(Config.PrisonJobTypes[rewardTable].rewardTable) do
      rewardName = key
      rand = rand - chance
      if rand <= 0 then break end
   end

   return rewardName
end

AddEventHandler('prdx_prison:client:prisonBuyerMenu', function(data)
	local SellMenu = ''
	for k,v in pairs(Config.PrisonSellPrices) do
		SellMenu = SellMenu..exports.ox_inventory:Items()[k]["label"]..':		$'..v..'  \n'
	end
    local menu = {
        {
            title = "Current Prices:", 
            description = SellMenu,
            disabled = true,
        },
		{
            title = "Open Sell Box", 
            event = "target:client:openStash",
            args = data
        },
        {
            title = "Sell Items", 
            event = "prdx_prison:client:sellJailStashMenu"
        }   
    }
    lib.registerContext({
		id = 'prison_buyer_menu',
		title = 'Prison Buyer',
		options = menu,
	})
	lib.showContext('prison_buyer_menu')
end)

AddEventHandler('prdx_prison:client:sellJailStashMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'jailsell', true}
        }     
    }
    lib.registerContext({
		id = 'sell_jail_stash_menu',
		title = 'Sell Jail Stuff',
        menu = 'prison_buyer_menu',
		options = menu,
	})
	lib.showContext('sell_jail_stash_menu')
end)

-- Poly & Marker Debuging
-- RegisterCommand("PrisonTest", function()    
--     local locations = {}
--     locations = Config.PrisonJobTypes["yardwork"].sites
--     for k, v in pairs(locations) do
--         exports['qb-target']:AddBoxZone(".JobPoly." .. k, locations[k].location, locations[k].length, locations[k].width, {name = ".JobPoly." .. k, heading = locations[k].heading, debugPoly = true, minZ = locations[k].minZ, maxZ = locations[k].maxZ }, {options = {{event = "", icon = 'fas fa-box', label = "DEBUG POLY",},},distance = 5.0})
--     end

--     locations = Config.PrisonJobTypes["bunks"].sites
--     for k, v in pairs(locations) do
--         exports['qb-target']:AddBoxZone(".JobPoly." .. k, locations[k].location, locations[k].length, locations[k].width, {name = ".JobPoly." .. k, heading = locations[k].heading, debugPoly = true, minZ = locations[k].minZ, maxZ = locations[k].maxZ }, {options = {{event = "", icon = 'fas fa-box', label = "DEBUG POLY",},},distance = 5.0})
--     end

--     locations = Config.PrisonJobTypes["canteen"].sites
--     for k, v in pairs(locations) do
--         exports['qb-target']:AddBoxZone(".JobPoly." .. k, locations[k].location, locations[k].length, locations[k].width, {name = ".JobPoly." .. k, heading = locations[k].heading, debugPoly = true, minZ = locations[k].minZ, maxZ = locations[k].maxZ }, {options = {{event = "", icon = 'fas fa-box', label = "DEBUG POLY",},},distance = 5.0})
--     end
--     ShowAllMarkers()
-- end)

-- Debug to display all markers
function ShowAllMarkers()
    local locations = {}
    locations = Config.PrisonJobTypes["yardwork"].sites
    while true do 
        Wait(1)
        for k,v in pairs(locations) do
            local currMarker = v 
            DrawMarker(0, currMarker.location.x, currMarker.location.y, currMarker.location.z + currMarker.markerOffset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, true, false, false, true, false, false, false)
        end
    end
end