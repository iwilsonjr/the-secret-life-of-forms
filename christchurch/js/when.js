//Datepicker


//Formatted Today's Date - Initialization
function getTodaysDate(){
  var t = new Date();
  year = t.getFullYear();
  if (t.getDate() < 10) {
	  day = "0" + t.getDate();
  }
  else {
	  day = t.getDate();
  }
  if ((t.getMonth() + 1) < 10) {
	  month = "0" + (t.getMonth() + 1);
  }
  else {
	  month = t.getMonth() + 1;
  }

  return (day + '/' + month + '/' + year);
 }
 
var currentDate = getTodaysDate();

//Departure - Changed 3/28/13
$("#departure").datepicker({
	dateFormat: "dd/mm/yy",
	dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
	minDate: 0,  
	showOtherMonths: true
});

//Return - Changed 3/28/13
$("#return").datepicker({
	dateFormat: "dd/mm/yy",
	dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
	minDate: 0,  
	showOtherMonths: true
});

//Initialization - Departure Value
$("#departure").datepicker("setDate", currentDate);
$("#departureDate").val($("#departure").val());
	
//Departure Select	
$(document).on("change", "#departure", function(){
	$("#departureDate").val($(this).val());
	$("#returnDate").val($(this).val());
	$("#return").datepicker("option", "minDate", $(this).val());		
	$("#return").datepicker("setDate", $(this).val());
	//alert($(this).val());
});	

//Return Select	
$(document).on("change", "#return", function(){
	$("#returnDate").val($(this).val());
	$("input[type='submit']").removeAttr("disabled");	
});	

