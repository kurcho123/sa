var page = 0;
var business;
var job;
var jobLevel;
var gang;
var gangLevel;
var citizenid;
var allJobs;
var allGangs;
window.addEventListener("message", (event) => {
	var item = event.data;
	if (item.showmenu){
		business = item.business;
		job = item.job;
		jobLevel = item.jobLevel;
		gang = item.gang;
		gangLevel = item.gangLevel;
		citizenid = item.citizenid;
		allJobs = item.allJobs;
		allGangs = item.allGangs;

		var items = business.items;
		var prices = business.prices;
		var ingredients = business.ingredients

		if(item.update != true){
			$(".pages").css("display", "none");
			$("body").css("display", "");
			$(".main-page").css("display", "block");
			$('.sidebar-navigation ul li').removeClass('active');
			$('#sidebar-1').addClass('active');
			openPage(0);
		} else {
			refreshJobs()
		}

		/*
		 * STATISTICS PAGE
		*/

		switch(job) {
			case "lspd":
			case "bcso":
			case "sast":
			case "pd_cid":
			case "marshalls":
				$('#ind').show();
				$('#sidebar-1').show();
				$('#sidebar-'+job).show();
	
				$('#department-balance').empty();
				$('#department-balance').append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business.balance));
				$('#total-fines').empty();
				$('#total-fines').append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business.fines));
				$('#total-arrests').empty();
				$('#total-arrests').append(new Intl.NumberFormat('en-US').format(business.arrests));
				$('#personnel').empty();
				$('#personnel').append(new Intl.NumberFormat('en-US').format(business.personnel.length));
			case "hc":
				var depts = {"lspd": true, "bcso": true, "sast": true, "pd_cid": true, "hc": true}
				$('#hc').show();
				$('#sidebar-1').show();
				for (var dept in depts) {
					$('#sidebar-'+dept).show();
					// balance
					$('#department-balance-'+dept).empty();
					$('#department-balance-'+dept).append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business[dept].balance));
					// fines
					$('#total-fines-'+dept).empty();
					$('#total-fines-'+dept).append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business[dept].fines));
					//arrests
					$('#total-arrests-'+dept).empty();
					$('#total-arrests-'+dept).append(new Intl.NumberFormat('en-US').format(business[dept].arrests));
					// personnel
					$('#personnel-'+dept).empty();
					$('#personnel-'+dept).append(new Intl.NumberFormat('en-US').format(business[dept].personnel.length));
				}
				break
			case "ambulance":
				$('#ems').show();
				$('#sidebar-1').show();
				$('#sidebar-ambulance').show();
				$('#department-balance-ems').empty();
				$('#department-balance-ems').append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business.balance));
				$('#total-treated').empty();
				$('#total-treated').append(new Intl.NumberFormat('en-US').format(business.revives));
				$('#total-hospital').empty();
				$('#total-hospital').append(new Intl.NumberFormat('en-US').format(business.patients));
				$('#personnel-ems').empty();
				$('#personnel-ems').append(new Intl.NumberFormat('en-US').format(business.personnel.length));
				break
			case "tow":
				$('#tow').show();
				$('#sidebar-1').show();
				$('#sidebar-tow').show();
				$('#department-balance-tow').empty();
				$('#department-balance-tow').append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business.balance));
				$('#total-impounds').empty();
				$('#total-impounds').append(new Intl.NumberFormat('en-US').format(business.impounds));
				$('#total-repairs').empty();
				$('#total-repairs').append(new Intl.NumberFormat('en-US').format(business.repairs));
				$('#personnel-tow').empty();
				$('#personnel-tow').append(new Intl.NumberFormat('en-US').format(business.personnel.length));
				break
			default:
				if (job != "unemployed") {
					$('#bus').show();
					$('#sidebar-1').show();
					$('#sidebar-business').show();
					$('#sidebar-products').show();
					$('#sidebar-salaries').show();
					$('#sidebar-ingredients').show();
					$('#department-balance-bus').empty();
					$('#department-balance-bus').append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business.balance));
					$('#total-profits').empty();			
					$('#total-profits').append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business.profits));
					$('#total-sales').empty();
					$('#total-sales').append(new Intl.NumberFormat('en-US').format(business.sales));
					$('#personnel-bus').empty();
					$('#personnel-bus').append(new Intl.NumberFormat('en-US').format(business.personnel.length));
					$('#grades-page-list').empty();
					for (const key in allJobs[job].grades) {
						var jGrade = allJobs[job].grades[key];
						var gName = jGrade.name;
						var gSalary = jGrade.payment;
						$('#grades-page-list').append(`
							<li class="d-flex justify-content-between">
								<div class="d-flex flex-row align-items-center">
									<div class="ml-2">
										<h6 class="mb-0">${gName}</h6>
									</div>
								</div>
								<div class="block">
									<label for="input-salary">$/25m</label>
									<input job_grade="${key}" id="input-salary" type="number" name="amount" min="0" required="required">
									<button id="changeGradeSalary" class="btn btn-blue btn-darken-2 white" style="margin-left:10px" data-grade="${key}">Update Salary</button>
								</div>
							</li>
						`);
						$('input[job_grade='+key+']').val(gSalary);
					}
				} else if (gang != "none") {
					$('#ind').hide();
					$('#hc').hide();
					$('#ems').hide();
					$('#tow').hide();
					$('#bus').hide();
					$('#gang').show();
					$('[id^="sidebar-"]').hide();
					$('#sidebar-1').show();
					$('#sidebar-gang').show();
		
					$('#department-balance-gang').empty();
					$('#department-balance-gang').append(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(business.balance));
				
					$('#personnel-gang').empty();
					$('#personnel-gang').append(new Intl.NumberFormat('en-US').format(business.personnel.length));
				}
		}

		if (items) {
			$('#products').empty();
			for (const key in items) {
				var itemName = items[key].name
				var itemLabel = items[key].label
				var itemPrice = prices[itemName] || 0
				$('#products').append(`
					<div class="col-4">
						<div class="card overflow-hidden w-auto">
							<div class="card-content">
								<div class="card-body cleartfix">
									<div class="media align-items-stretch">
										<div class="media-body">
											<h4>${itemLabel}</h4>
											<div class="block" style="display: flex; justify-content: space-between">
												<label for="input-price" style="position: relative; top: 4px; font-size: 24px;">$</label>
												<input item_id="${itemName}" style="padding: 2; width: 9vw" id="input-price" type="number" name="amount" min="0" required="required">
												<button id="setPrice" class="btn btn-blue btn-darken-2 white" style="padding: 10 !important" data-item="${itemName}">Update Price</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				`)
				$('input[item_id='+itemName+']').val(itemPrice);
			}
		}

		if (ingredients) {
			ingredientsPage(ingredients)
		}

	} else if (item.reset) {
		$('[id^="sidebar-"]').hide();
		$('.stats').hide();
	} else if (item.ingredients) {
		business = item.business;
		var ingredients = business.ingredients

		$(".pages").css("display", "none");
		$("body").css("display", "");
		$(".ingredients").css("display", "block");
		$('.sidebar-navigation ul li').removeClass('active');
		$('#sidebar-ingredients').addClass('active');
		$('#sidebar-ingredients').show();
		$('#ingredients').show();
		openPage(13);

		ingredientsPage(ingredients)
	}
});

/*=================
	FUNCTIONS
=================*/

function openPage(pageN){
	if(pageN == 0){
		$(".pages").css("display", "none");
		$(".main-page").css("display", "block");
	}
	if(pageN >= 1 && pageN < 11){
		$(".pages").css("display", "none");
		$(".personnel-page").css("display", "block");
	}
	if(pageN == 11){
		$(".pages").css("display", "none");
		$(".products").css("display", "block");
	}
	if(pageN == 12){
		$(".pages").css("display", "none");
		$(".grades").css("display", "block");
	}
	if(pageN == 13){
		$(".pages").css("display", "none");
		$(".ingredients").css("display", "block");
	}
	page = pageN;
	refreshJobs()
}

function refreshJobs(){
	var pages = {1: "lspd", 2: "bcso", 3: "sast", 4: "pd_cid", 5: "hc", 6: "marshalls", 7: "ambulance", 8: "tow"}
	var colors = {"lspd": "lightblue", "bcso": "green", "sast": "darkblue", "hc": "black", "marshalls": "darkgreen", "ambulance": "red", "tow": "orange", "pd_cid": "#B08D57"}

	$('#personnel-page-list').empty();
	if (job == "hc") {
		if (page > 0) {
			for (const key in business[pages[page]].personnel) {
				var pName = business[pages[page]].personnel[key].name;
				var pSalary = business[pages[page]].personnel[key].salary;
				var pRank = business[pages[page]].personnel[key].grade.name;
				var pLevel = business[pages[page]].personnel[key].level;
				var pJob = business[pages[page]].personnel[key].job;
				var disabled = false;
				if (pLevel >= jobLevel) {
					disabled = true;
				}
				if (pages[page] == pJob) {
					if (pJob == job && disabled == true) {
						$('#personnel-page-list').append(`
						<li class="d-flex justify-content-between">
							<div class="d-flex flex-row align-items-center"><i class="fas fa-user" style="color: ${colors[pJob]}"></i>
								<div class="ml-2">
									<h6 class="mb-0">${pName}</h6>
									<div class="d-flex flex-row mt-1 text-black-50 small">
										<div><i class="fas fa-coins"></i><span class="ml-2">Salary: ${pSalary} $/25m</span></div>
										<div class="ml-3"><i class="fas fa-sitemap"></i><span class="ml-2">Rank: ${pRank}</span></div>
									</div>
								</div>
							</div>
							<div class="d-flex flex-row align-items-center">
								<button id="fireEmployee" class="btn btn-blue btn-darken-2 white" data-employee="${business[pages[page]].personnel[key].empSource}" data-job="${pJob}" disabled>Fire</button>
								<button id="changeEmployeeRank" class="btn btn-blue btn-darken-2 white" style="margin-left:10px" data-employee="${business[pages[page]].personnel[key].empSource}" data-job="${pJob}" disabled>Manage</button>
							</div>
						</li>
					`);
					}
					else {
						$('#personnel-page-list').append(`
						<li class="d-flex justify-content-between">
							<div class="d-flex flex-row align-items-center"><i class="fas fa-user" style="color: ${colors[pJob]}"></i>
								<div class="ml-2">
									<h6 class="mb-0">${pName}</h6>
									<div class="d-flex flex-row mt-1 text-black-50 small">
										<div><i class="fas fa-coins"></i><span class="ml-2">Salary: ${pSalary} $/25m</span></div>
										<div class="ml-3"><i class="fas fa-sitemap"></i><span class="ml-2">Rank: ${pRank}</span></div>
									</div>
								</div>
							</div>
							<div class="d-flex flex-row align-items-center">
								<button id="fireEmployee" class="btn btn-blue btn-darken-2 white" data-employee="${business[pages[page]].personnel[key].empSource}" data-job="${pJob}">Fire</button>
								<button id="changeEmployeeRank" class="btn btn-blue btn-darken-2 white" style="margin-left:10px" data-employee="${business[pages[page]].personnel[key].empSource}" data-job="${pJob}">Manage</button>
							</div>
						</li>
					`);
					}
				}
			}
		}
	} else {
		for (const key in business.personnel) {
			var pName = business.personnel[key].name;
			var pSalary = business.personnel[key].salary;
			var display;
			if (!pSalary) {
				pSalary = "N/A";
				display = "none";
			}
			var pRank = business.personnel[key].grade.name;
			var pLevel = business.personnel[key].level;
			var pJob = business.personnel[key].job;
			var pGang = business.personnel[key].gang;
			var disabled = false;
			if (pJob) {
				if (pLevel >= jobLevel) {
					disabled = true;
				}
			} else if (pGang) {
				if (pLevel >= gangLevel) {
					disabled = true;
				}
			}
			if ((pJob == job || pGang == gang) && disabled == true) {
				$('#personnel-page-list').append(`
				<li class="d-flex justify-content-between">
					<div class="d-flex flex-row align-items-center"><i class="fas fa-user" style="color: ${colors[pJob]}"></i>
						<div class="ml-2">
							<h6 class="mb-0">${pName}</h6>
							<div class="d-flex flex-row mt-1 text-black-50 small">
								<div style="display: ${display}"><i class="fas fa-coins"></i><span class="ml-2">Salary: ${pSalary} $/25m</span></div>
								<div class="ml-3"><i class="fas fa-sitemap"></i><span class="ml-2">Rank: ${pRank}</span></div>
							</div>
						</div>
					</div>
					<div class="d-flex flex-row align-items-center">
						<button id="fireEmployee" class="btn btn-blue btn-darken-2 white" data-employee="${business.personnel[key].empSource}" disabled>Fire</button>
						<button id="changeEmployeeRank" class="btn btn-blue btn-darken-2 white" style="margin-left:10px" data-employee="${business.personnel[key].empSource}" disabled>Manage</button>
					</div>
				</li>
			`);
			}
			else {
				$('#personnel-page-list').append(`
					<li class="d-flex justify-content-between">
						<div class="d-flex flex-row align-items-center"><i class="fas fa-user" style="color: ${colors[pJob]}"></i>
							<div class="ml-2">
								<h6 class="mb-0">${pName}</h6>
								<div class="d-flex flex-row mt-1 text-black-50 small">
									<div style="display: ${display}"><i class="fas fa-coins"></i><span class="ml-2">Salary: ${pSalary} $/25m</span></div>
									<div class="ml-3"><i class="fas fa-sitemap"></i><span class="ml-2">Rank: ${pRank}</span></div>
								</div>
							</div>
						</div>
						<div class="d-flex flex-row align-items-center">
							<button id="fireEmployee" class="btn btn-blue btn-darken-2 white" data-employee="${business.personnel[key].empSource}">Fire</button>
							<button id="changeEmployeeRank" class="btn btn-blue btn-darken-2 white" style="margin-left:10px" data-employee="${business.personnel[key].empSource}">Manage</button>
						</div>
					</li>
				`);
			}
		}
	}
}

function setMaxAmount(item_id,amount){
	$('#form_amount').empty();
	$('#form_amount').append(`
		<input type="number" min="1" max="` + amount + `" name="amount" class="form-control" placeholder="Product amount" required="required"> 
	`);
}

function getStarsHTML(value){
	var html = "";
	for (var i = 1; i <= 5; i++) {
		if(i <= value){
			html += '<li class="list-inline-item m-1"><i class="fa fa-star amber font-large-1"></i></li>';
		}else{
			html += '<li class="list-inline-item m-1"><i class="fa fa-star-o amber font-large-1"></i></li>';
		}
	}
	return html;
}

function getPagination(pagination){
	var html = "";
	for (var i = 0; i <= 5; i++) {
		if(pagination[i] == undefined){
			return html;
		}
		html +=`
		<li onclick="openPage(` + (5+i) + `)">
			<i class="fas fa-store"></i>
			<span class="tooltip">` + pagination[i] + `</span>
		</li>`;
	}
	return html;
}

document.onkeyup = function(data){
	if (data.which == 27){
		if ($("body").is(":visible")){
			closeUI()
		}
	}
};

$('.sidebar-navigation ul li').on('click', function() {
	$('li').removeClass('active');
	$(this).addClass('active');
});


function timeConverter(UNIX_timestamp,locale){
	var a = new Date(UNIX_timestamp * 1000);
	var time = a.toLocaleString(locale);
	return time;
  }

$(document).on('click','#changeEmployeeRank',function(){
	jQuery.noConflict(); 
	$('#changeRankModal').data("employee", $(this).data("employee"))
	$('#changeRankModal').data("job", $(this).data("job"))

	$("#ranks").empty();
	if (job == "hc") {
		$("#ranks").append(`
			<optgroup id="lspd-group" label="LSPD"></optgroup>
			<optgroup id="bcso-group" label="BCSO"></optgroup>
			<optgroup id="sast-group" label="SAST"></optgroup>
			<optgroup id="pd_cid-group" label="CID"></optgroup>
			<optgroup id="hc-group" label="HC"></optgroup>
		`)
		for (const key in allJobs["lspd"].grades) {
			$("#lspd-group").append(`
				<option value="lspd-${key}">${allJobs["lspd"].grades[key].name}</option>
			`)
		}
		for (const key in allJobs["bcso"].grades) {
			$("#bcso-group").append(`
				<option value="bcso-${key}">${allJobs["bcso"].grades[key].name}</option>
			`)
		}
		for (const key in allJobs["sast"].grades) {
			$("#sast-group").append(`
				<option value="sast-${key}">${allJobs["sast"].grades[key].name}</option>
			`)
		}
		for (const key in allJobs["pd_cid"].grades) {
			$("#pd_cid-group").append(`
				<option value="pd_cid-${key}">${allJobs["pd_cid"].grades[key].name}</option>
			`)
		}
		for (const key in allJobs["hc"].grades) {
			$("#hc-group").append(`
				<option value="hc-${key}">${allJobs["hc"].grades[key].name}</option>
			`)
		}
	} else if (job != "unemployed") {
		$("#ranks").append(`
			<optgroup id="${job}-group" label="${allJobs[job].label}"></optgroup>
		`)
		for (const key in allJobs[job].grades) {
			$("#"+job+"-group").append(`
				<option value="${job}-${key}">${allJobs[job].grades[key].name}</option>
			`)
		}
	} else if (gang != "none") {
		$("#ranks").append(`
			<optgroup id="${gang}-group" label="${allGangs[gang].label}"></optgroup>
		`)
		for (const key in allGangs[gang].grades) {
			$("#"+gang+"-group").append(`
				<option value="${gang}-${key}">${allGangs[gang].grades[key].name}</option>
			`)
		}
	}

	$('#changeRankModal').modal('show'); 
});

function changeEmployeeRank(){
	var employee = $('#changeRankModal').data("employee");
	var rank = $("#ranks").val();
	var rankJob = job;
	if ($('#changeRankModal').data("job")) {
		fireJob = $('#changeRankModal').data("job");
	}
	var rankGang = gang;
	post("changeRank", {employee, rank, rankJob, rankGang});
}

$(document).on('click','#fireEmployee',function(){
	jQuery.noConflict(); 
	$('#fireModal').data("employee", $(this).data("employee"))
	$('#fireModal').data("job", $(this).data("job"))
	$('#fireModal').modal('show'); 
});

function fireEmployee(){
	var employee = $('#fireModal').data("employee");
	var fireJob = job;
	if ($('#fireModal').data("job")) {
		fireJob = $('#fireModal').data("job");
	}
	var fireGang = gang;
	post("fireEmployee", {employee, fireJob, fireGang})
}

$(document).on('click','#setPrice',function(){
	var item = $(this).data("item");
	var price = $('input[item_id='+item+']').val();
	post("updateItemPrice", {item, price})
});

$(document).on('click','#changeGradeSalary',function(){
	var grade = $(this).data("grade");
	var salary = $('input[job_grade='+grade+']').val();
	post("updateGradeSalary", {grade, salary})
});

function ingredientsPage(ingredients){
	var cost = 0;
	$('#ingredients').empty();
	for (const key in ingredients) {
		var itemName = key
		var itemLabel = ingredients[key].label
		var itemPrice = ingredients[key].buyprice
		$('#ingredients').append(`
			<div class="col-4">
				<div class="card overflow-hidden w-auto">
					<div class="card-content">
						<div class="card-body cleartfix">
							<div class="media align-items-stretch">
								<div class="media-body">
									<div style="display: flex; justify-content: space-between">
										<h4>${itemLabel}</h4>
										<h4>$${itemPrice}</h4>
									</div>
									<div style="display:flex; justify-content: space-between">
										<label for="ingredient-amount">Order Amount:</label>
										<input data-item_id="${itemName}" data-item_price="${itemPrice}" style="padding: 2" class="ingredient-amount" type="number" name="amount" min="0" value="0">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		`)
	}
	$(".ingredient-amount").change(function(){
		cost = 0;
		$('.ingredient-amount').each(function(i, obj) {
			if ($(this).val() > 0) {
				cost += $(this).val() * $(this).data("item_price");
				$(this).parent().parent().parent().parent().parent().parent().css("border-color", "#7f3cbe")
			} else {
				$(this).parent().parent().parent().parent().parent().parent().css("border-color", "rgba(0,0,0,.125)")
			}
		});
		$(".current-cost").html(`Total Cost: $${cost}`)
	});
};

$(document).on('click','#orderIngredients',function(){
	var order = {}
	$('.ingredient-amount').each(function(i, obj) {
		if ($(this).val() > 0) {
			order[$(this).data("item_id")] = $(this).val();
			$(this).val("0");
		}
	});
	if(Object.keys(order).length != 0) {
		post("orderIngredients", order)
	}
});

/*=================
	CALLBACKS
=================*/

function closeUI(){
	$("body").css("display", "none");
	post("close","")
}

function post(name,data){
	$.post("https://prdx_bossmenu/"+name,JSON.stringify(data))
}