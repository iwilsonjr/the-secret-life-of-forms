// Scroll Pane
$('#quoteCoverages .paneQuote').jScrollPane({showArrows: true});

//Flip
$("#viewCoverages").click(function(){
	$("#quoteBox").addClass("flipped").removeClass("unflipped");		
	$('.flipBlock').addClass("is-flipped").delay(300).queue(function(next){
	 $('#quoteDisplay').css("visibility", "hidden"); 
	  $('#quoteCoverages').css("visibility", "visible");
	 next();
	 //alert('i did it');
	});	
	return false;
})

$("#viewQuote").click(function(){
	$("#quoteBox").addClass("unflipped");			
	$('.flipBlock').removeClass("is-flipped").delay(300).queue(function(next){
	 $('#quoteCoverages').css("visibility", "hidden"); 
	  $('#quoteDisplay').css("visibility", "visible");		 
	 next();
	  //alert('i did it');
	});	
	return false;
})	