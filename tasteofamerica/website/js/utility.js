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
$("#voteButton, #voteButton2").click(function(){ //Changed 
	
		href = 'thankyou.html';
		errorMessage = 'errorMessage.html';  //add jn
	
	    var n = $("input:checked").length;  //add jn to validate at least one button selected
		if (n > 0) {
			
           // submit the form 
             $("#bracketForm").ajaxSubmit({
/*				url: 'postForm.cfm',
				type: 'post',*/
				url: 'brackets.html',
				type: 'get',				
				clearForm: true,
				resetForm: true, 
                success: triggerThankYou   		
			}); //ajzxSumbit
      }  //if
		
		else {
		    $.nyroModalManual({
			url: errorMessage,
			width: 772,
			minHeight: 480		    
	      }); 
		}	
		return false; 	
	       });
	
	
	
	//Rules
	$("#rulesLink, #methodLink").nyroModal({ //Changed 5/21/12
		width: 772,
		minHeight: 480,
		closeSelector: '.closeWindow'
	});	
	
	//Video Window
	$(".video a").nyroModal({
		width: 772,
		height: 480,
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
  
  //Hover Functionality Extended - 5/21/12  
  if ($.browser.msie && (parseInt($.browser.version) <= 7)) {	  

	$(".active .competitor").mouseover(function() { 
		$(".selection").css("left","-9999px");
		$(".menu").css("left","-9999px");		
		leftShift = ($(this).offset().left) + 120;
		$(this).children(".selection").css("left",leftShift + 'px');
		$(this).children(".selection").css("display","block"); 		
		$(this).children(".menu").css("left",leftShift + 'px');
		$(this).children(".menu").css("display","block"); 		
	});		

	$(".finals .competitor").mouseover(function() { 
		$(".selection").css("left","-9999px");
		$(".menu").css("left","-9999px");		
		leftShift = $(this).offset().left;
		$(this).children(".selection").css("left",leftShift + 'px');
		$(this).children(".selection").css("display","block");		
		$(this).children(".menu").css("left",leftShift + 'px');
		$(this).children(".menu").css("display","block"); 		
	});	
	
	$(".selection").mouseout(function() { 
		$(".selection").css("left","-9999px");
		$(".menu").css("left","-9999px");		
	});		
	
	$(".menu").mouseout(function() { 
		$(".selection").css("left","-9999px");	
		$(".menu").css("left","-9999px");
	});		
	
  };  
  //Hover Functionality Extended - 5/21/12   


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
 
 /*load the validation for the send to a friend form*/
$("#sendFriend").validate({  
                    
    submitHandler: function(form) {    
   $("#sendFriend").ajaxSubmit( { url:'postFriendEmail.cfm', type: 'post', resetForm: true, success: thanksSubmit});           
  return false;
    },  
    rules: {       
    yourEmail: {
    required: true,
    email: true},
    friendsEmail: {
    required: true,
    email: true}
    },
  messages: {
    yourEmail: "Please enter a valid email address.",
    friendsEmail: "Please enter a valid email address."
  },  
  errorPlacement: function(error, element) {       
    error.insertBefore(element);  
  }  
  });

  //IE6 Hacks
  if ($.browser.msie && (parseInt($.browser.version) == 6)) {
	  
	$(".ajaxWindow .buttonWell input").hover(function() { 
		$(this).css("background-position", "-121px 0");
	  },function() {    
		$(this).css("background-position", "0 0");  
	});	  
	
  };	

}


function triggerThankYou() { 
	//Remove all radio selections
	$(".picked").css("display","none");

	//Thank You Page
	$.nyroModalManual({
		url: 'thankyou.html',
		width: 772,
		minHeight: 680,
		endFillContent: ajaxLoader,
		closeSelector: '.closeWindow',
        endRemove: thanksClose
	}) //nyro
}		

//Window Reload After Closing - Added 5/9/11
function thanksClose(){ 
	window.location.href = 'brackets.html'; /* brackets.cfm */	
}

function thanksSubmit(){ 
	$.nyroModalRemove();	
}


