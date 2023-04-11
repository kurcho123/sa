QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('prdx_books:openBook', function(name, bookData)
    TriggerEvent('animations:client:EmoteCommandStart', {"book"})
    SetNuiFocus(true,true)
    SendNUIMessage({
        show = true,
        name = name,
        book = bookData,
    })
end)

RegisterNUICallback('escape', function(data, cb)
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    SetNuiFocus(false, false)
    cb('ok')
end)


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        SetNuiFocus(false,false)
        SendNUIMessage({
            show = false
        })
    end
end)

RegisterNetEvent('prdx_books:bookUsed', function(BookInfo)
    TriggerEvent('prdx_books:openBook', BookInfo.name, BookInfo.bookdata)
end)

RegisterNetEvent('prdx_book:openCreateBook', function(data)
    local name = data.name
    local dialog = lib.inputDialog(name .. " Printing Press",{
        { type = "input", label = "Book Name"},
        { type = "input", label = "Book Description"},
        { type = "input", label = "Page 1 (URL ending in .png/.jpg)"},
        { type = "input", label = "Page 2"},
        { type = "input", label = "Page 3"},
        { type = "input", label = "Page 4"},
        { type = "input", label = "Page 5"},
        { type = "input", label = "Page 6"},
        { type = "input", label = "Page 7"},
        { type = "input", label = "Page 8"},
        { type = "input", label = "Page 9"},
        { type = "input", label = "Page 10"},
    })
    if not dialog then return end

    local Results = {}
    local name = ''
    for k,v in pairs(dialog) do
        if tonumber(k) then
            if v ~= '' then
                Results[tonumber(k)] = v
            end
        end
    end
    TriggerServerEvent('prdx_books:server:createBook', dialog[1], dialog[2], Results)

end)

RegisterNetEvent('prdx_book:openDuplicateBook', function(data)
    local name = data.name
    local dialog2 = lib.inputDialog(name .. " Copy Press ($10/book)",{
        { type = "input", label = "Book ID"},
        { type = "number", label = "Copies"},
    })
    if not dialog2 then return end

    TriggerServerEvent('prdx_books:server:copyBook', dialog2[1], dialog2[2])

end)