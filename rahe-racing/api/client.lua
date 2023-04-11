local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("racing", function()
    openTablet()
end)

-- CLIENT export - This function is exported, so it can be opened from any other client-side script by using 'exports['rahe-racing']:openRacingTablet()'
function openRacingTablet()
    openTablet()
end

RegisterNetEvent('Racing:client:setWaypoint', function(coords)
    SetNewWaypoint(coords.x, coords.y)
    QBCore.Functions.Notify('Set waypoint to race', 'success')
end)

RegisterNetEvent('Racing:client:openTablet', function()
    openTablet()
end)

-- If you wish to open the tablet via. an event not the export.
RegisterNetEvent("rahe-racing:client:openTablet")
AddEventHandler("rahe-racing:client:openTablet", function()
    TriggerEvent('animations:client:EmoteCommandStart', {"tablet2"})
    local menu = {
        {
            header = 'Paradox Underground Racing',
            isMenuHeader = true
        }
    }

    QBCore.Functions.TriggerCallback('Racing:server:getActiveRaces', function(RaceData, CurrentTime)
        if RaceData and next(RaceData) then
            for k,v in pairs(RaceData) do
                local TimeUntil = ((v.timeStamp + v.startTime) - CurrentTime)
                menu[#menu+1] = {
                    title = "Track: "..v.trackName..' | Laps: '..v.raceLaps,
                    description = 'Race starts in: '..math.floor(TimeUntil)..' seconds',
                    event = "Racing:client:setWaypoint",
                    args = v.startCoords
                }
            end
        else
            menu[#menu+1] = {
                title = "There are no listed races at this time", 
                disabled = true
            }
        end
        menu[#menu+1] = {
            title = "Open Racing Tablet", 
            event = "Racing:client:openTablet"
        }
        lib.registerContext({
            id = 'racing_menu_cl',
            title = 'Paradox Underground Racing',
            options = menu,
        })
        lib.showContext('racing_menu_cl')
    end)
end)

function notifyPlayer(message)
    QBCore.Functions.Notify(message, 'info')
end

-- You can do some logic when the tablet is closed. For example if you started an animation when opened, you can end the animation here.
RegisterNetEvent('rahe-racing:client:tabletClosed', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)