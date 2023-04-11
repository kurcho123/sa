exports.ox_target:addBoxZone({ -- Kildares create book
    coords = vector3(-936.65, -2038.39, 9.51),
    size = vector3(0.8, 1, 0.85),
    rotation = 315,
    debug = false,
    options = {
        {
            name = 'KildaresCreateBook',
            event = 'prdx_book:openCreateBook',
            icon = 'fas fa-book-open',
            label = 'Open Printing Press',
            name = 'Kildare Autos',
            distance = 1.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Kildares Copy Book
    coords = vector3(-935.53, -2039.84, 9.51),
    size = vector3(0.4, 1.4, 1.4),
    rotation = 315,
    debug = false,
    options = {
        {
            name = 'KildaresCopyBook',
            event = 'prdx_book:openDuplicateBook',
            icon = 'fas fa-book-open',
            label = 'Open Copying Printer',
            name = 'Kildare Autos',
            distance = 1.5
        }
    },
})

exports.ox_target:addBoxZone({ -- Glizzy Comics Create Book
    coords = vector3(-46.39, -92.79, 58.37),
    size = vector3(0.8, 1, 0.8),
    rotation = 25,
    debug = false,
    options = {
        {
            name = 'GlizzyComicsCreateBook',
            event = 'prdx_book:openCreateBook',
            icon = 'fas fa-book-open',
            label = 'Open Printing Press',
            name = 'Glizzy Comics',
            distance = 1.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Glizzy Comics Copy Book
    coords = vector3(-42.68, -90.83, 58.37),
    size = vector3(0.4, 0.4, 1.5),
    rotation = 340,
    debug = false,
    options = {
        {
            name = 'GlizzyComicsCopyBook',
            event = 'prdx_book:openDuplicateBook',
            icon = 'fas fa-book-open',
            label = 'Open Copying Printer',
            name = 'Glizzy Comics',
            distance = 1.5
        }
    },
})

exports.ox_target:addBoxZone({ -- Mayor
    coords = vector3(-526.86, -186.51, 43.37),
    size = vector3(0.8, 0.4, 0.8),
    rotation = 30,
    debug = false,
    options = {
        {
            name = 'GovernmentCreateBook',
            event = 'prdx_book:openCreateBook',
            icon = 'fas fa-book-open',
            label = 'Open Printing Press',
            name = 'Government',
            distance = 1.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- mayor 
    coords = vector3(-525.88, -188.22, 43.37),
    size = vector3(1.0, 0.4, 1.5),
    rotation = 30,
    debug = false,
    options = {
        {
            name = 'GovernmentCopyBook',
            event = 'prdx_book:openDuplicateBook',
            icon = 'fas fa-book-open',
            label = 'Open Copying Printer',
            name = 'Government',
            distance = 1.5
        }
    },
})