exports.ox_target:addBoxZone({ -- Public Crypto
    name = "Crypto Public Zone",
    coords = vec3(1272.25, -1711.0, 54.15),
    size = vec3(0.3, 0.5, 0.55),
    rotation = 22.5,
    debug = false,
    options = {
        {
            event = 'target:client:openStash',
            args = {'cryptosell', 'cryptosell'},
            icon = 'fas fa-computer',
            label = 'Open Computer',
            distance = 2.5
        },
        {
            icon = 'fas fa-computer',
            label = 'Start Decryption',
            event = 'prdx_crypto:client:confirmPublicDecypt',
            distance = 2.5
        },
    },
})

exports.ox_target:addBoxZone({ -- Private Crypto
    name = "Crypto Private Zone",
    coords = vec3(908.9, -3207.95, -97.2),
	size = vec3(0.45, 0.35, 0.4),
	rotation = 22.5,
    debug = false,
    groups = {["nismos"] = 0, ["madrazo"] = 0, ["chaotek"] = 0},
    options = {
        {
            event = 'target:client:openStash',
            args = {'cryptoprivatesell', 'cryptoprivatesell'},
            icon = 'fas fa-computer',
            label = 'Open Computer',
            distance = 2.5
        },
        {
            icon = 'fas fa-computer',
            label = 'Start Decryption',
            event = 'prdx_crypto:client:confirmPrivateDecypt',
            distance = 2.5
        },
    },
})