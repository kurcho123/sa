var notepadreader, notepadId;
document.onkeyup = function (data) {
    if (data.which == 27) {
        $.post('https://qb-notepad/escape', JSON.stringify({}));
        if (notepadreader == true) {
            let x = document.getElementById("p1").value;
            $.post('https://qb-notepad/updating', JSON.stringify({ text: x, id: notepadId }));
            $("#main").fadeOut();
            $("#main").css('display', 'none');
            notepadreader = false;
            document.getElementById("p1").value = "";
        }else {
            ownerdNotepad = document.getElementById("p1").value;
            $("#main").fadeOut();
            $("#main").css('display', 'none');
        }
    }
};

window.addEventListener('message', function(e) {
    switch(e.data.action) {
        case 'openNotepad':
            notepadreader = true;
            notepadId = e.data.id;
            if (e.data.text === undefined){
                document.getElementById("p1").value = "";
                $("#main").fadeIn();
            }else {
                $("textarea").removeAttr('disabled','disabled');
                document.getElementById("p1").value = e.data.text;
                $("#main").fadeIn();
            }
            break;
        case 'closeNotepad':
            $("#main").fadeOut();
            $("#main").css('display', 'none');
            break;
        case 'cleanNotepad':
            document.getElementById("p1").value = "";
            break;
    }
});