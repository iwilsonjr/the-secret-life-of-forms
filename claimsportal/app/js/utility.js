// JavaScript Document

$(document).ready(function(){
//Start JQuery Code

$("#options").change(function(){
	
	switch($(this).val()){
		case "0":
			selection = "0";
		break;
		case "1":
			selection = "0";
		break;
		case "2":
			selection = "1";
		break;
		case "3":
			selection = "1";
		break;
		case "4":
			selection = "2";
		break;
		case "5":
			selection = "2";
		break;
		case "6":
			selection = "3";
		break;
		case "7":
			selection = "4";
		break;
		case "8":
			selection = "5";
		break;	
		default:
			selection = "";
		break;																					
	}
	
	$(".optionList").addClass("hide");
	
	if (selection != "") {
		$("#option-" + selection).removeClass("hide");
	}

});

$("#addTraveller").click(function(){
	$("#another").removeClass("hide");
	$(".addProvider").addClass("hide");
	return false;
});

$("#deleteProvider").click(function(){
	$("#another").addClass("hide");
	$(".addProvider").removeClass("hide");
	$("#another input[type='radio']").removeAttr("checked");
	return false;
});

$("#addExpense").click(function(){
	$(".summaryBlock").removeClass("hideSummary");
	//return false;
});

//Summary Block - Changed 11/22/13
$(".deleteLink").click(function(){
	id = $(this).attr("href");
	
	$.fancybox.open([ 
	{href: 'modal-delete.html'}   
	], {
		type: 'ajax',
		padding: 0,
		minWidth: 400,
		minHeight: 175,
		closeBtn: true,
		wrapCSS: "saveBox",
		afterLoad: function(){
			$("input").live("click", function(){
				$(id).addClass("hideSummary");
				$(id).next(".infoForm").children(".uploadArea").addClass("hideSummary");				
				$.fancybox.close();
			});
		}
	});		
	return false;
});

$(".editLink").click(function(){
	$(this).parents(".summaryBlock").addClass("hideSummary");
	return false;
});

//Help Tips - Initialize
$(".help").each(function()
{  
  var contentHelp = $($(this).attr("href")).html();
  
  $(this).qtip({
	  content: contentHelp,
	   show: 'click',		
	   hide: 'click'   
  });
});

$(".formLink").each(function()
{  
  var contentHelp = $($(this).attr("href")).html();
  
  $(this).qtip({
	  content: contentHelp,
	   show: 'click',		
	   hide: 'click'   
  });
});

$(".formLink").click(function(){
	return false;
});

$("#contact").each(function()
{  
  var contentHelp = $($(this).attr("href")).html();
  
  $(this).qtip({
	  content: contentHelp,
	  show: 'click',		
	  hide: 'click',
	  style: {
	  	classes: 'contactBox'
	  }	      
  });
});

$(".help, #contact").click(function(){
	$(".qtip").qtip("hide");	 
	return false; 
});

$(".qtip .closeWindow").live("click",function(){
	$(".qtip").qtip("hide").delay(0);
	return false; 
});

$(".fancybox").fancybox({
	type: 'ajax',
	padding: 0,
	minWidth: 400,
	minHeight: 175,
	closeBtn: true,
	wrapCSS: "saveBox"//,
	/*afterLoad: function(){
		$(".fancybox-close").click(function(){	
						alert("yes");
			//$.fancybox.close();
		});
	}	*/
});

$(".deleteFile").on("click",function(){
	 return false;
});

/* Placeholders/Plugin */
$('input, textarea').placeholder();


// Review Page Declarations Toggle
if (($("[name='person']:checked").val() == "amPerson")){
	$("#amPerson").removeClass("hide");
	$("#onBehalf").addClass("hide");
} else if ($("[name='person']:checked").val() == "onBehalf"){
	$("#onBehalf").removeClass("hide");
	$("#amPerson").addClass("hide");			
}

$("[name='person']").click(function(){
  if (($(this).val() == "amPerson")){
	$("#amPerson").removeClass("hide");	
	$("#onBehalf").addClass("hide");
  } else if ($(this).val() == "onBehalf"){
	$("#onBehalf").removeClass("hide");	
	$("#amPerson").addClass("hide");
  }
});

//Provide Location
if (($("[name='returned']:checked").val() == "yes")){
	$(".luggage").removeClass("hide");
} else {
	$(".luggage").addClass("hide");			
}

$("[name='returned']").click(function(){
  if (($(this).val() == "yes")){
	$(".luggage").removeClass("hide");
  } else {
	$(".luggage").addClass("hide");	
  }
});

//Describe Incident
if (($("[name='loss']:checked").val() == "loss")){
	$(".loss").removeClass("hide");
	$(".theft").addClass("hide");
	$(".damage").addClass("hide");	
} else if ($("[name='loss']:checked").val() == "theft"){
	$(".loss").addClass("hide");
	$(".theft").removeClass("hide");
	$(".damage").addClass("hide");	
} else if ($("[name='loss']:checked").val() == "damage"){
	$(".loss").addClass("hide");
	$(".theft").addClass("hide");
	$(".damage").removeClass("hide");				
}

$("[name='loss']").click(function(){
  if (($(this).val() == "loss")){
	$(".loss").removeClass("hide");
	$(".theft").addClass("hide");
	$(".damage").addClass("hide");	
  } else if ($(this).val() == "theft"){
	$(".loss").addClass("hide");
	$(".theft").removeClass("hide");
	$(".damage").addClass("hide");
  } else if ($(this).val() == "damage"){
	$(".loss").addClass("hide");
	$(".theft").addClass("hide");
	$(".damage").removeClass("hide");			
  }
});

if (($("[name='rental']:checked").val() == "yes")){
	$(".rental").removeClass("hide");
} else {
	$(".rental").addClass("hide");			
}

$("[name='rental']").click(function(){
  if (($(this).val() == "yes")){
	$(".rental").removeClass("hide");
  } else {
	$(".rental").addClass("hide");	
  }
});

if (($("[name='weatherDelay']:checked").val() == "no")){
	$(".weather").removeClass("hide");
} else {
	$(".weather").addClass("hide");			
}

$("[name='weatherDelay']").click(function(){
  if (($(this).val() == "no")){
	$(".weather").removeClass("hide");
  } else {
	$(".weather").addClass("hide");	
  }
});

if (($("[name='careloss']:checked").val() == "yes")){
	$(".policeyes").removeClass("hide");
	$(".policeno").addClass("hide");	
} else if ($("[name='careloss']:checked").val() == "no"){
	$(".policeyes").addClass("hide");
	$(".policeno").removeClass("hide");				
}

$("[name='careloss']").click(function(){
  if (($(this).val() == "yes")){
	$(".policeyes").removeClass("hide");
	$(".policeno").addClass("hide");	
  } else if ($(this).val() == "no"){
	$(".policeyes").addClass("hide");
	$(".policeno").removeClass("hide");			
  }
});

if (($("[name='careTheft']:checked").val() == "yes")){
	$(".theftyes").removeClass("hide");
	$(".theftno").addClass("hide");	
} else if ($("[name='careTheft']:checked").val() == "no"){
	$(".theftyes").addClass("hide");
	$(".theftno").removeClass("hide");				
}

$("[name='careTheft']").click(function(){
  if (($(this).val() == "yes")){
	$(".theftyes").removeClass("hide");
	$(".theftno").addClass("hide");	
  } else if ($(this).val() == "no"){
	$(".theftyes").addClass("hide");
	$(".theftno").removeClass("hide");			
  }
});

//Provide Expenses
if (($("[name='agent']:checked").val() == "yes")){
	$(".agent").removeClass("hide");
} else {
	$(".agent").addClass("hide");			
}

$("[name='agent']").click(function(){
  if (($(this).val() == "yes")){
	$(".agent").removeClass("hide");
  } else {
	$(".agent").addClass("hide");	
  }
});

//Additional Details
if (($("[name='insurance']:checked").val() == "yes")){
	$(".insurance").removeClass("hide");
} else {
	$(".insurance").addClass("hide");			
}

$("[name='insurance']").click(function(){
  if (($(this).val() == "yes")){
	$(".insurance").removeClass("hide");
  } else {
	$(".insurance").addClass("hide");	
  }
});

if (($("[name='gst']:checked").val() == "yes")){
	$(".gst").removeClass("hide");
} else {
	$(".gst").addClass("hide");			
}

$("[name='gst']").click(function(){
  if (($(this).val() == "yes")){
	$(".gst").removeClass("hide");
  } else {
	$(".gst").addClass("hide");	
  }
});

if (($("[name='source']:checked").val() == "yes")){
	$(".source").removeClass("hide");
} else {
	$(".source").addClass("hide");			
}

$("[name='source']").click(function(){
  if (($(this).val() == "yes")){
	$(".source").removeClass("hide");
  } else {
	$(".source").addClass("hide");	
  }
});

//Financial Details
if (($("[name='credit']:checked").val() == "yes")){
	$(".credit").removeClass("hide");
} else {
	$(".credit").addClass("hide");	
}

$("[name='credit']").click(function(){
  if (($(this).val() == "yes")){
	$(".credit").removeClass("hide");
  } else {
	$(".credit").addClass("hide");	
  }
});

//Document Upload Demo (first choice) - Changed 11/21/13
if (($("[name$=document1]:checked").val() == "no")){
	$("[id$=description1-1]").removeClass("hide");
	$("[id$=description1-0]").addClass("hide");
} else if (($("[name$=document1]:checked").val() == "yes")) {
	$("[id$=description1-1]").addClass("hide");
	$("[id$=description1-0]").removeClass("hide");
}

$("[name$=document1]").click(function(){
  if (($(this).val() == "no")){
	$("[id$=description1-1]").removeClass("hide");
	$("[id$=description1-0]").addClass("hide");		
  } else if (($(this).val() == "yes")){
	$("[id$=description1-1]").addClass("hide");
	$("[id$=description1-0]").removeClass("hide");			
  }
});

$("[for='group1upload-0']").click(function(){
	$.fancybox.open([ 
	{href: 'modal-upload.html'}   
	], {
		type: 'ajax',
		padding: 0,
		closeBtn: true,
		wrapCSS: "uploadBox" 
	});	
	return false;
});

$(".uploadError").click(function(){
	$.fancybox.open([ 
	{href: 'modal-upload.html'}   
	], {
		type: 'ajax',
		padding: 0,
		closeBtn: true,
		wrapCSS: "uploadBox" 
	});	
	return false;
});

$(".timeoutError").click(function(){
	$.fancybox.open([ 
	{href: 'modal-timeout.html'}   
	], {
		type: 'ajax',
		padding: 0,
		closeBtn: true,
		wrapCSS: "uploadBox" 
	});	
	return false;
});


// Add Document to Upload V2 Page

$("#addDoc").click(function(){
	$('#upload2').removeClass('hide');
	return false;
});



//End JQuery Code
});

