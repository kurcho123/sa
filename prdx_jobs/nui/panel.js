window.addEventListener('message', function (event) {
	var data = event.data;
	if (data.showmenu){
		var jobs = data.data;
		if(data.update != true){
			$(".pages").css("display", "none");
			$("body").css("display", "");
			$(".main-page").css("display", "block");
			$('.sidebar-navigation ul li').removeClass('active');
			$('#sidebar-1').addClass('active');
			openPage(0);
		}

		$('#jobs').empty();
		if (Object.keys(jobs).length > 0) {
			for (const key in jobs) {
				var item = jobs[key];
				if (item != null) {
					$("#jobs").append(`
					<div class="col-6">
						<div class="card overflow-hidden w-auto">
							<div class="card-content">
								<div class="card-body cleartfix">
									<div class="media align-items-stretch">
										<div class="align-self-center">
											<i class="${item.icon} primary font-large-2 mr-2"></i>
										</div>
										<div class="media-body">
											<h4>${item.cargo}</h4>
											<p>Deliver to: ${item.street}</p>
											<p>Distance: ~${item.distance} miles</p>
											<button onclick="selectJob(\'` + item.id + '\',\'' + item.distance + '\',\'' + item.street + `\')" class="btn btn-pink btn-darken-2 white deposit-money-btn col-6">Select Job</button>
										</div>
										<div class="align-self-center">
											<h1>` + new Intl.NumberFormat(item.location, { style: "currency", currency: "USD", maximumFractionDigits: 0, minimumFractionDigits: 0 }).format(item.payout)  + `</h1>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				`);
				}
			}
		} else {
			$("#jobs").append(`
				<p>No available jobs. Check back later.</p>
			`)
		}
	}
	if (data.hidemenu){
		$("body").css("display", "none");
	}
});

/*=================
	FUNCTIONS
=================*/

function openPage(pageN){
	if(pageN == 0){
		$(".pages").css("display", "none");
		$(".jobs").css("display", "block");
	}
}

function getPagination(pagination){
	var html = "";
	for (var i = 0; i <= 5; i++) {
		if(pagination[i] == undefined){
			return html;
		}
		html +=`
		<li onclick="openPage(` + (5+i) + `)">
			<i class="fas fa-truck"></i>
			<span class="tooltip">` + pagination[i] + `</span>
		</li>`;
	}
	return html;
}

document.onkeyup = function(data){
	if (data.which == 27){
		if ($("body").is(":visible")){
			post("close","")
		}
	}
};

$('.sidebar-navigation ul li').on('click', function() {
	$('li').removeClass('active');
	$(this).addClass('active');
});

/*=================
	CALLBACKS
=================*/

function closeUI(){
	post("close","")
}
function selectJob(job_id, job_distance, job_street){
	post("selectJob",{job_id, job_distance, job_street})
	closeUI()
}
function post(name,data){
	$.post("https://prdx_jobs/"+name,JSON.stringify(data),function(datab){
		if (datab != "ok"){
			console.log(datab);
		}
	});
}
