//Carousels
function mycarousel_initCallback(carousel) {
   
	$(".jcarousel-next").each(function(index) {  
	 
	   $(this).bind("click", function() {
		   if (!$(this).hasClass("jcarousel-next-disabled")){	
			
				//Check each one and move accordingly	   
				for (var i = 1; i < 7; i++) {
				
					if (i != $(this).siblings(".jcarousel-clip").children("ul").attr("id").replace("list","")) {
						
						test = $("#list" + i + " input[type='radio']:checked+label").text();
						startPoint = test - (test % 10) + 1;
						
						var carouselCounter = $("#list" + i).data("jcarousel");	
						carouselCounter.scroll($.jcarousel.intval(startPoint));
						
					};
				};
				//Check each one and move accordingly						
		   };
			carousel.next();	   
		});
		
	});
	
	$(".jcarousel-prev").each(function(index2) {  
	 
	   $(this).bind("click", function() {
		   if (!$(this).hasClass("jcarousel-prev-disabled")){	
				
				//Check each one and move accordingly	   
				for (var j = 1; j < 7; j++) {
				
					if (j != $(this).siblings(".jcarousel-clip").children("ul").attr("id").replace("list","")) {
						
						test = $("#list" + j + " input[type='radio']:checked+label").text();
						startPoint = test - (test % 10) + 1;
						
						var carouselCounter = $("#list" + j).data("jcarousel");	
						carouselCounter.scroll($.jcarousel.intval(startPoint));
						
					};
				};
				//Check each one and move accordingly						
		   };
			carousel.prev();	   
		});
		
	});	
	
};

$("#list1").jcarousel({
	scroll: 10,
	initCallback: mycarousel_initCallback	
});

$("#list2").jcarousel({
	scroll: 10
});

$("#list3").jcarousel({
	scroll: 10	
});

$("#list4").jcarousel({
	scroll: 10
});

$("#list5").jcarousel({
	scroll: 10
});

$("#list6").jcarousel({
	scroll: 10
});

//Add Travellers
$("#addTraveller").click(function(){

	$(".travellerList > li.hide:first").removeClass("hide");
	$(".deleteLink").addClass("hide");
	$(".travellerList > li:not('.hide'):last .deleteLink").removeClass("hide");

	if ($(".travellerList > li.hide").length == 0) {
		$(this).addClass("hide");	
	}
	
	$("input[type='submit']").attr("disabled", "disabled");
		
	return false;
	
});

//Remove Travellers
$(".deleteLink").click(function(){

	$(".deleteLink").addClass("hide");
	$(".travellerList > li:not('.hide'):last").addClass("hide")
	$(".travellerList > li:not('.hide'):last .deleteLink").removeClass("hide");
	$(".travellerList > li.hide input:checked").removeAttr("checked");	
	
	if ($(".travellerList > li.hide").length != 0) {
		$("#addTraveller").removeClass("hide");	
	}
	
	if ($(".travellerList > li:not('.hide') :checked").length == $(".travellerList > li:not('.hide')").length){
		$("input[type='submit']").removeAttr("disabled");	
	}
			
	return false;
	
});

//Flip Switch
$('#liveNZ').toggleSwitch();


$(".nzResidents label").click(function(){
	$("#liveNZ option").removeAttr("selected");
})
$(".ui-slider-handle").focus(function(){
	$("#liveNZ option").removeAttr("selected");
})

// Submit Ready
$("input[name^='age']").click(function(){
	
	if ($(".travellerList > li:not('.hide') :checked").length == $(".travellerList > li:not('.hide')").length){
		$("input[type='submit']").removeAttr("disabled");	
	}
			
});

$("input[type='submit']").click(function(){
	
	if ($("#liveNZ").val() == "No"){
		$(".warning").addClass("showWarning");
		return false
	}
			
});