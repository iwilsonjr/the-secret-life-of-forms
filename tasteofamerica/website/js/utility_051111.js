// JavaScript Document

$(document).ready(function(){
//Start JQuery Code

	//Prelaunch Window - Added 5/10/11
	if ($("body").attr("class").search("prelaunchWindow") > -1) {
		$.nyroModalManual({ 
			url: 'prelaunch.html',
			width: 772,
			minHeight: 480,
			closeButton: false,
			modal: true		
		});			
	}

	//Initialization - JavaScript enabled
	$(".container").removeClass("no-js");
	
	//Outside Links
	$("a.target").click(function(){
		window.open($(this).attr("href"));
		return false;
	});	
	
	//Submit Functionality
	$("#voteButton").click(function(){
	
		href = $("#bracketForm").attr("action");
		
		//Add stuff for information submission....

		  $.nyroModalManual({ //Changed 5/9/11
			url: href,
			width: 772,
			minHeight: 480,
			endFillContent: ajaxLoader,
			closeSelector: '.closeWindow'
		  });
		  
		return false;
		
	});
	
	
/*	$("#voteButton").click(function(){
	
		href = 'thankyou.html';
		errorMessage = 'errorMessage.html'; 
	
		var n = $("input:checked").length; 
		
		if (n > 0) {
	
			//Submit Form
			$("#bracketForm").ajaxSubmit({
				url: 'postForm.cfm',
				type: 'post',
				clearForm: true,
				resetForm: true, 
				success: triggerThankYou   		
			}); 
		
		} else {
		
			$.nyroModalManual({
				url: errorMessage,
				width: 772,
				minHeight: 480,	
			}); 
		}	
		
		return false; 
		
	});*/
	
	//Rules
	$("#rulesLink").nyroModal({ //Changed 5/9/11
		width: 772,
		minHeight: 480,
		endFillContent: ajaxLoader,
		closeSelector: '.closeWindow'		
	});	
	
	//Video Window
	$(".video a").nyroModal({ //Changed 5/9/11
		width: 772,
		height: 480,
		endFillContent: ajaxLoader,
		closeSelector: '.closeWindow'		
	});				

	//Selector Flags
	
	//Initialize
	selectFlag();
	
	//Click Functionality
	$(".selection strong").click(function(){
		$(this).siblings("input:radio").attr("checked","checked");		
		selectFlag();
	});
	
  //IE6 Hacks
  if ($.browser.msie && (parseInt($.browser.version) == 6)) {
	  
	$(".nonactive .matchup").children().css("display", "none");
	  
	$(".votingBlock input").hover(function() { 
		$(this).css("background-position", "-148px 0");
	  },function() {    
		$(this).css("background-position", "0 0");  
	});	  
	
  };
	
//End JQuery Code
});

//Select Flags
function selectFlag(){
	$(".picked").css("display","none");
	$(".selection input:checked").each(function(i) {
		$(this).parent().siblings(".picked").css("display","block");
    });	
}

//AJAX Loading Functions
function ajaxLoader(){
	
  //IE6 Hacks
  if ($.browser.msie && (parseInt($.browser.version) == 6)) {
	  
	$(".ajaxWindow .buttonWell input").hover(function() { 
		$(this).css("background-position", "-121px 0");
	  },function() {    
		$(this).css("background-position", "0 0");  
	});	  
	
  };	

}

//Window Reload After Closing - Added 5/9/11
function thanksClose(){ 
	window.location.href = 'brackets.html';	
}

function triggerThankYou(){ 
	$.nyroModalManual({
		url: href,
		width: 772,
		minHeight: 480,
		endFillContent: ajaxLoader,
		endRemove: thanksClose
	});
}		
