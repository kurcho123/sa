function isEven(n) {
    return n % 2 == 0;
}
 

window.addEventListener('message', function(event) {
    if (event.data.show == true) {
        if (event.data.book) {
            $('#books').empty();
            $('body').css('display', 'block');
            const id = event.data.id
            const book = event.data.book
            $('#books').append(`
                <div id="${id}" class="libro">
                    <div id="wrapper_libro" class="${id}">
                    </div>
                </div>
            `)
            if (isEven(book.length)) {
                book.forEach(function (item, index) {           
                    if (index == 0 || index == 1 || index == (book.length - 2) || index == (book.length - 1)) {
                        $("." + id).append(`<div class="hard"><img src="${item}" width="100%" height="100%"></div>`)
                    } else {
                        $("." + id).append(`<div><img src="${item}" width="100%" height="100%"</div>`) 
                    }
                });
            } else {
                book.forEach(function (item, index) {           
                    if (index == 0 || index == 1 || index == (book.length - 1)) {
                        $("." + id).append(`<div class="hard"><img src="${item}" width="100%" height="100%"></div>`)
                    } else {
                        $("." + id).append(`<div><img src="${item}" width="100%" height="100%"></div>`) 
                    }
                });
            }
            
            $('#wrapper_libro').turn({
                gradients: true,
                autoCenter: true,
                width: "88.75vw",
                height: "51.22vh",
                page:1,
                acceleration: true
            });
        }
    } else if (event.data.show == false) {
        $('body').css('display', 'none');
    }
});

$(document).keyup(function(e) {
    if (e.keyCode == 27) {
        $('body').css('display', 'none');
        $.post('https://prdx_books/escape', JSON.stringify({}));
    }
});