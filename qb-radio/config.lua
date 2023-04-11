Config = {}

Config.PresetChannels = {
    [1] = 'PD Main',
    [2] = 'PD TAC 1',
    [3] = 'PD TAC 2',
    [4] = 'CID OPS',
    [5] = 'Fire/EMS Main',
    [6] = 'Fire/EMS TAC 1',
    [7] = 'Fire/EMS TAC 2',
    [8] = 'Fire/EMS TAC 3',
    [9] = 'SADOT Main',
    [10] = 'SADOT Alt',
}

Config.RestrictedChannels = {
    [1] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        pd_cid = true,
        clinic = true
    },
    [2] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        pd_cid = true,
        clinic = true
    },
    [3] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        pd_cid = true,
        clinic = true
    },
    [4] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        pd_cid = true,
        clinic = true
    },
    [5] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        pd_cid = true,
        clinic = true
    },
    [6] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        pd_cid = true,
        clinic = true
    },
    [7] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        pd_cid = true,
        clinic = true
    },
    [8] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        pd_cid = true,
        clinic = true
    },
    [9] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        tow = true,
        bikinitow = true,
        pd_cid = true
    },
    [10] = {
        lspd = true,
        sast = true,
        bcso = true,
        hc= true,
        marshalls = true,
        ambulance = true,
        tow = true,
        bikinitow = true,
        pd_cid = true
    }
}

Config.MaxFrequency = 999

Config.messages = {
    ["not_on_radio"] = "You're not connected to a signal",
    ["on_radio"] = "You're already connected to this signal",
    ["joined_to_radio"] = "You're connected to: ",
    ["restricted_channel_error"] = "You can not connect to this signal!",
    ["invalid_radio"] = "This frequency is not available.",
    ["you_on_radio"] = "You're already connected to this channel",
    ["you_leave"] = "You left the channel.",
    ['volume_radio'] = 'New volume ',
    ['decrease_radio_volume'] = 'The radio is already set to maximum volume',
    ['increase_radio_volume'] = 'The radio is already set to the lowest volume',
    ['increase_decrease_radio_channel'] = 'New channel ',
}
