// JavaScript Document

$(document).ready(function(){
//Start JQuery Code

	// Scroll Pane - initialize
	$('#faqBlock').jScrollPane({showArrows: true});


	$(".btnTab").toggle(function(){
		$(".infoBlock").removeClass("closeTab").addClass("openTab");
		return false;
	}, function(){
		$(".infoBlock").addClass("closeTab");
		return false;
	});
	
	//FAQs
	$(".opener").toggle(function(){
		$(this).parent("li").addClass("selected");
		$('#faqBlock').jScrollPane({showArrows: true});		
		return false;
	},function(){
		$(this).parent("li").removeClass("selected");
		$('#faqBlock').jScrollPane({showArrows: true});			
		return false;
	});	
	
	
//End JQuery Code
});

