function updateData(players) {
    $('.scores').empty();
    
    $.each(players, function(i) {
        if (players[i] != null) {
            $('.' + players[i].team + ' > .scores').append(
                `
                <div class="name">${players[i].name}</div><div class="score">${players[i].score}</div>\n
                `
            )
        }
    })

}



window.addEventListener('message', function (event) {
    if (event.data.type === 'show') {
        updateData(event.data.players)
        $('.container').show();
        $('.container').fadeIn();
    } else if (event.data.type === 'hide') {
        $('.container').fadeOut();
        $('.container').hide();
    }
});