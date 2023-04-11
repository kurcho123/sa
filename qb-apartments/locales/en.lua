local Translations = {
    error = {
        to_far_from_door = 'You are to far away from the Doorbell',
        nobody_home = 'There is nobody home..',
        nobody_at_door = 'There is nobody at the door...'
    },
    success = {
        receive_apart = 'You got a apartment',
        changed_apart = 'You moved apartments',
    },
    info = {
        at_the_door = 'Someone is at the door!',
    },
    text = {
        menu_header = 'Apartments',
        options = '[E] Apartment Options',
        enter_option = 'Enter Apartment',
        enter = '[E] Enter Apartment',
        ring_doorbell = 'Ring Doorbell',
        logout = '[E] Logout Character',
        change_outfit = '[E] Change Outfit',
        open_stash = '[E] Open Stash',
        move_here = '[E] Move Here ($500)',
        open_door = 'Open Door',
        leave_option = 'Leave Apartment',
        leave = '[E] Leave Apartment',
        close_menu = '⬅ Close Menu',
        tennants = 'Tennants',
        raid_apartment = 'Raid Apartment',
        xmastree = '[E] Check under tree',
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
