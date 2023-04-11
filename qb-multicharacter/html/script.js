var selectedChar = null;
var WelcomePercentage = "30vh"
qbMultiCharacters = {}
var nationalities = ["American", "Afghan", "Albanian", "Algerian", "Andorran", "Angolan", "Antiguans", "Argentinean", "Armenian", "Australian", "Austrian", "Azerbaijani", "Bahamian", "Bahraini", "Bangladeshi", "Barbadian", "Barbudans", "Batswana", "Belarusian", "Belgian", "Belizean", "Beninese", "Bhutanese", "Bolivian", "Bosnian", "Brazilian", "British", "Bruneian", "Bulgarian", "Burkinabe", "Burmese", "Burundian", "Cambodian", "Cameroonian", "Canadian", "Cape Verdean", "Central African", "Chadian", "Chilean", "Chinese", "Colombian", "Comoran", "Congolese", "Costa Rican", "Croatian", "Cuban", "Cypriot", "Czech", "Danish", "Djibouti", "Dominican", "Dutch", "East Timorese", "Ecuadorean", "Egyptian", "Emirian", "Equatorial Guinean", "Eritrean", "Estonian", "Ethiopian", "Fijian", "Filipino", "Finnish", "French", "Gabonese", "Gambian", "Georgian", "German", "Ghanaian", "Greek", "Grenadian", "Guatemalan", "Guinea-Bissauan", "Guinean", "Guyanese", "Haitian", "Herzegovinian", "Honduran", "Hungarian", "I-Kiribati", "Icelander", "Indian", "Indonesian", "Iranian", "Iraqi", "Irish", "Israeli", "Italian", "Ivorian", "Jamaican", "Japanese", "Jordanian", "Kazakhstani", "Kenyan", "Kittian and Nevisian", "Kuwaiti", "Kyrgyz", "Laotian", "Latvian", "Lebanese", "Liberian", "Libyan", "Liechtensteiner", "Lithuanian", "Luxembourger", "Macedonian", "Malagasy", "Malawian", "Malaysian", "Maldivian", "Malian", "Maltese", "Marshallese", "Mauritanian", "Mauritian", "Mexican", "Micronesian", "Moldovan", "Monacan", "Mongolian", "Moroccan", "Mosotho", "Motswana", "Mozambican", "Namibian", "Nauruan", "Nepalese", "New Zealander", "Ni-Vanuatu", "Nicaraguan", "Nigerian", "Nigerien", "North Korean", "Northern Irish", "Norwegian", "Omani", "Pakistani", "Palauan", "Panamanian", "Papua New Guinean", "Paraguayan", "Peruvian", "Polish", "Portuguese", "Qatari", "Romanian", "Russian", "Rwandan", "Saint Lucian", "Salvadoran", "Samoan", "San Marinese", "Sao Tomean", "Saudi", "Scottish", "Senegalese", "Serbian", "Seychellois", "Sierra Leonean", "Singaporean", "Slovakian", "Slovenian", "Solomon Islander", "Somali", "South African", "South Korean", "Spanish", "Sri Lankan", "Sudanese", "Surinamer", "Swazi", "Swedish", "Swiss", "Syrian", "Taiwanese", "Tajik", "Tanzanian", "Thai", "Togolese", "Tongan", "Trinidadian or Tobagonian", "Tunisian", "Turkish", "Tuvaluan", "Ugandan", "Ukrainian", "Uruguayan", "Uzbekistani", "Venezuelan", "Vietnamese", "Welsh", "Yemenite", "Zambian", "Zimbabwean"]
var Loaded = false;
var background = document.getElementById("musica_fondo");
var confirmar = document.getElementById("click");
var consejoAud = document.getElementById("click");
var transition = document.getElementById("click");
var swipe = document.getElementById("click");
var click = document.getElementById("click");
var over_button = document.getElementById("click");

$(document).ready(function (){
    window.addEventListener('message', function (event) {
        var data = event.data;

        if (data.action == "ui") {
            if (data.toggle) {
                $('.container').show();
                $('.jugadores-on').hide();
                $('.bottombar').show();
                $('.imagenlogo').hide();
                $('.topbar').show();
                $('.topbar').css("top", "-50%");
                $('.bottombar').css("top", "50%");
                $('.fondocolor').hide();
                $('.btn-iniciar').hide();
                $(".welcomescreen").fadeIn(150);
                qbMultiCharacters.resetAll();
                musicFadeIn()
                var originalText = "Loading your experience";
                var loadingProgress = 0;
                var loadingDots = 0;
                $("#loading-text").html(originalText);

                $('.fondocolor').show();
                var DotsInterval = setInterval(function() {
                    $("#loading-text").append(".");
                    loadingDots++;
                    loadingProgress++;
                    if (loadingProgress == 3) {
                        originalText = "Valiadting your user data"
                        $("#loading-text").html(originalText);
                    }
                    if (loadingProgress == 4) {
                        originalText = "Expanding character data"
                        $("#loading-text").html(originalText);
                    }
                    if (loadingProgress == 6) {
                        originalText = "Optimizing data"
                        $("#loading-text").html(originalText);
                    }
                    if(loadingDots == 4) {
                        $("#loading-text").html(originalText);
                        loadingDots = 0;
                    }
                }, 3000);

                refreshCharacters()
                setTimeout(function(){
                    $.post('https://qb-multicharacter/setupCharacters');
                    setTimeout(function(){
                        clearInterval(DotsInterval);
                        loadingProgress = 0;
                        originalText = "Recuperando datos";
                        $(".welcomescreen").fadeOut(2000);
                        // $('.imagenlogo').addClass('entrada');
                        $(".title-screen").fadeIn(100);
                        $('.btn-iniciar').hide();
                        $(".title-screen").fadeIn(0, function() {
                            setTimeout(function() {
                                $(".imagenlogo").addClass("blinkxd");
                                qbMultiCharacters.fadeInDown('.topbar', '-95%', 2000);
                                qbMultiCharacters.fadeInDown('.bottombar', '94.5%', 2000);
                                qbMultiCharacters.fadeInDown2('.btn-iniciar', '7%', 1000);

                                $(".fondo-negro").fadeOut(1000);
                                $('.title-screen').fadeIn(1000);
                                qbMultiCharacters.fadeInDown('.imagenlogo', '35%', 2500);
                                $('.jugadores-on').html(' ' + data.players + ' Players');
                            }, 1000);
                            
                        });
                        $(".btn-iniciar").mouseenter(function() {
                            over_button.play();
                        });
                        $("#play, .btn-iniciar").click(function() {
                            confirmar.play();
                        });
                    }, 2000);
                }, 2000);
                background.currentTime = 0
            } else {
                $('.container').fadeOut(250);
                qbMultiCharacters.resetAll();
            }
        }
        if (data.action == "setupCharacters") {
            setupCharacters(event.data.characters)
        }
        if (data.action == "setupCharInfo") {
            setupCharInfo(event.data.chardata)
        }
        if (data.action == "stopMusic") {
            musicFadeOut();
        }
    });
    $('.datepicker').datepicker();
});


$('.continue-btn').click(function(e){
    e.preventDefault();
});

$('.disconnect-btn').click(function(e){
    e.preventDefault();
    $.post('https://qb-multicharacter/closeUI');
    $.post('https://qb-multicharacter/disconnectButton');
});

$(".btn-iniciar").on("click", function() {
    background.volume = 0.001;
        $(".title-screen").fadeOut(300, function() {
            qbMultiCharacters.fadeInDown('.character-info', '30%', 1700);
            qbMultiCharacters.fadeInDown('.characters-list', '30%', 1700);
            $('.jugadores-on').fadeIn();
            $('.fondocolor').hide();
            qbMultiCharacters.fadeInDown('.imagenlogo', '6%', 1700);
            $.post('https://qb-multicharacter/removeBlur');
        })
});

function setupCharInfo(cData) {
    if (cData == 'empty') {
        $('.character-info-valid').html('<span id="no-char">The selected character slot is not in use yet.<br><br>This character doesn\'t have information yet.</span>');
    } else {
        var gender = "Man"
        if (cData.charinfo.gender == 1) { gender = "Woman" }
        $('.character-info-valid').html(
        '<div class="character-info-box"><span id="info-label">Name: </span><span class="char-info-js">'+cData.charinfo.firstname+' '+cData.charinfo.lastname+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Birth date: </span><span class="char-info-js">'+cData.charinfo.birthdate+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Gender: </span><span class="char-info-js">'+gender+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Nationality: </span><span class="char-info-js">'+cData.charinfo.nationality+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Job: </span><span class="char-info-js">'+cData.job.label+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Cash: </span><span class="char-info-js">&#36; '+cData.money.cash+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Bank: </span><span class="char-info-js">&#36; '+cData.money.bank+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Phone number: </span><span class="char-info-js">'+cData.charinfo.phone+'</span></div>');
    }
}

function setupCharacters(characters) {
    $.each(characters, function(index, char){
        $('#char-'+char.cid).html("");
        $('#char-'+char.cid).data("citizenid", char.citizenid);
        setTimeout(function(){
            $('#char-'+char.cid).html('<span id="slot-name"> <i class="fa fa-user" aria-hidden="true" style="color:rgb(255, 182, 47);"></i> '+char.charinfo.firstname+' '+char.charinfo.lastname+'<span id="cid">' + char.citizenid + '</span></span>');
            $('#char-'+char.cid).data('cData', char)
            $('#char-'+char.cid).data('cid', char.cid)
        }, 100)
    })
}

$(document).on('click', '#close-log', function(e){
    e.preventDefault();
    selectedLog = null;
    $('.welcomescreen').css("filter", "none");
    $('.server-log').css("filter", "none");
    $('.server-log-info').fadeOut(250);
    logOpen = false;
});

$(document).on('click', '.character', function(e) {
    var cDataPed = $(this).data('cData');
    e.preventDefault();
    if (selectedChar === null) {
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            $(selectedChar).addClass("char-selected");
            setupCharInfo('empty')
            $("#play-text").html('<i class="fa fa-plus" aria-hidden="true"></i> Register');
            $("#play").css({"display":"block"});
            $("#delete").css({"display":"none"});
            $.post('https://qb-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        } else {
            $(selectedChar).addClass("char-selected");
            setupCharInfo($(this).data('cData'))
            $("#play-text").html('<i class="fa fa-sign-in" aria-hidden="true"></i> Play');
            $("#delete-text").html('<i class="fa fa-trash" aria-hidden="true"></i> Delete');
            $("#play").css({"display":"block"});
            $("#delete").css({"display":"block"});
            $.post('https://qb-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        }
    } else if ($(selectedChar).attr('id') !== $(this).attr('id')) {
        $(selectedChar).removeClass("char-selected");
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            $(selectedChar).addClass("char-selected");
            setupCharInfo('empty')
            $("#play-text").html('<i class="fa fa-plus" aria-hidden="true"></i> Register');
            $("#play").css({"display":"block"});
            $("#delete").css({"display":"none"});
            $.post('https://qb-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        } else {
            $(selectedChar).addClass("char-selected");
            setupCharInfo($(this).data('cData'))
            $("#play-text").html('<i class="fa fa-sign-in" aria-hidden="true"></i> Play');
            $("#delete-text").html('<i class="fa fa-trash" aria-hidden="true"></i> Delete');
            $("#play").css({"display":"block"});
            $("#delete").css({"display":"block"});
            $.post('https://qb-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        }
    }
});

var entityMap = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#39;',
    '/': '&#x2F;',
    '': '&#x60;',
    '=': '&#x3D;'
};

function escapeHtml(string) {
    return String(string).replace(/[&<>"'=/]/g, function (s) {
        return entityMap[s];
    });
}
function hasWhiteSpace(s) {
    return /\s/g.test(s);
  }
$(document).on('click', '#create', function (e) {
    e.preventDefault();
   
        let firstname= escapeHtml($('#first_name').val())
        let lastname= escapeHtml($('#last_name').val())
        let nationality= escapeHtml($('select[name=nationality]').val())
        let birthdate= escapeHtml($('#birthdate').val())
        let gender= escapeHtml($('select[name=gender]').val())
        let cid = escapeHtml($(selectedChar).attr('id').replace('char-', ''))
        
    //An Ugly check of null objects

    // Date validation

    var date = new Date(birthdate);
    var year = date.getUTCFullYear();

    if (year > 2021 || year < 1900) {
        $("#invalid-field-text").text("Date of Birth year should be no less than 1990 and no greater than 2021!");
        $(".invalid-field").fadeIn(150);
        setTimeout(function(){
            $(".invalid-field").fadeOut(150);
        }, 2500)
    } else {
        if (!firstname || !lastname || !nationality || !birthdate ){
            $("#invalid-field-text").text("First or last name must not be empty!");
            $(".invalid-field").fadeIn(150);
            setTimeout(function(){
                $(".invalid-field").fadeOut(150);
            }, 2500)
        }else{
            $.post('https://qb-multicharacter/createNewCharacter', JSON.stringify({
                firstname: firstname.trim(),
                lastname: lastname.trim(),
                nationality: nationality,
                birthdate: birthdate,
                gender: gender,
                cid: cid,
            }));
            $(".container").fadeOut(150);
            $('.characters-list').css("filter", "none");
            $('.character-info').css("filter", "none");
            qbMultiCharacters.fadeOutDown('.character-register', '125%', 400);
            refreshCharacters()
        }
    }
});

$(document).on('click', '#accept-delete', function(e){
    $.post('https://qb-multicharacter/removeCharacter', JSON.stringify({
        citizenid: $(selectedChar).data("citizenid"),
    }));
    $('.character-delete').fadeOut(150);
    $('.characters-block').css("filter", "none");
    refreshCharacters();
});

$(document).on('click', '#cancel-delete', function(e){
    e.preventDefault();
    $('.characters-block').css("filter", "none");
    $('.character-delete').fadeOut(150);
});

function refreshCharacters() {
    $('.characters-list').html('<div class="character" id="char-1" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-2" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-3" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-4" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-5" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character-btn" id="play"><p id="play-text">Select a character</p></div><div class="character-btn" id="delete"><p id="delete-text">Select a character</p></div>')
    setTimeout(function(){
        $(selectedChar).removeClass("char-selected");
        selectedChar = null;
        $.post('https://qb-multicharacter/setupCharacters');
        $("#delete").css({"display":"none"});
        $("#play").css({"display":"none"});
        qbMultiCharacters.resetAll();
    }, 100)
}

$("#close-reg").click(function (e) {
    e.preventDefault();
    $('.characters-list').css("filter", "none")
    $('.character-info').css("filter", "none")
    //mostrar
    qbMultiCharacters.fadeInDown('.character-info', '20%', 400);
    qbMultiCharacters.fadeInDown('.characters-list', '20%', 400);
    qbMultiCharacters.fadeOutDown('.character-register', '125%', 400);
})

$("#close-del").click(function (e) {
    e.preventDefault();
    $('.characters-block').css("filter", "none");
    $('.character-delete').fadeOut(150);
})

$(document).on('click', '#play', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $.post('https://qb-multicharacter/selectCharacter', JSON.stringify({
                cData: $(selectedChar).data('cData')
            }));
            setTimeout(function(){
                qbMultiCharacters.fadeOutDown('.characters-list', "-40%", 400);
                qbMultiCharacters.fadeOutDown('.character-info', "-40%", 400);
                qbMultiCharacters.resetAll();
            }, 1500);
        } else {
            $('.characters-list').css("filter", "blur(2px)")
            $('.character-info').css("filter", "blur(2px)")
            //qbMultiCharacters.fadeOutDown('.characters-list', "-40%", 400);
            qbMultiCharacters.fadeOutDown('.character-info', "-40%", 400);
            qbMultiCharacters.fadeInDown('.character-register', '25%', 1000);
            
            for (const nationality of nationalities) {
                $('#nationality').append($('<option>', {
                    value: nationality,
                    text: nationality
                }));
            }
        }
    }
});

$(document).on('click', '#delete', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $('.characters-block').css("filter", "blur(2px)")
            $('.character-delete').fadeIn(250);
            qbMultiCharacters.fadeInDown('.character-delete', '40%', 2500);
        }
        
    }
});

qbMultiCharacters.fadeOutUp = function(element, time) {
    $(element).css({"display":"block"}).animate({top: "-80.5%",}, time, function(){
        $(element).css({"display":"none"});
    });
}

qbMultiCharacters.fadeOutDown = function(element, percent, time) {
    if (percent !== undefined) {
        $(element).css({"display":"block"}).animate({top: percent,}, time, function(){
            $(element).css({"display":"none"});
        });
    } else {
        $(element).css({"display":"block"}).animate({top: "103.5%",}, time, function(){
            $(element).css({"display":"none"});
        });
    }
}

qbMultiCharacters.fadeInDown = function(element, percent, time) {
    $(element).css({"display":"block"}).animate({top: percent,}, time);
}

qbMultiCharacters.fadeInDown2 = function(element, percent, time) {
    $(element).css({"display":"block"}).animate({'margin-top': percent,}, time);
}

qbMultiCharacters.resetAll = function() {
    $('.characters-list').hide();
    $('.characters-list').css("top", "-40");
    $('.character-info').hide();
    $('.character-info').css("top", "-40");
    $('.welcomescreen').css("top", WelcomePercentage);
    $(".main-screen").fadeIn();
    $(".welcomescreen").fadeIn(300);
    $(".fondo-negro").fadeIn(0);
    $('.server-log').show();
    $('.server-log').css("top", "25%");
}

function musicFadeOut() {
    $(background).animate({ volume: 0 }, 3000);
}

function musicFadeIn() {
    background.play();
    background.volume = 0.0015;
}