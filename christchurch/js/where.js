// Scroll Pane
$('.paneWhere').jScrollPane({showArrows: true});

// Region Ready
$("input[name='region']").click(function(){
	$("#countrySelect").removeClass("disabledBlock");
	$("input[type='submit']").attr("disabled", "disabled");	
	$("input[name='country']:checked").removeAttr("checked");	
});


// Submit Ready
$("input[name='country']").click(function(){
	
	if (($("input[name='region']:checked").length > 0) && ($("input[name='country']:checked").length > 0)){
		$("input[type='submit']").removeAttr("disabled");	
	}

});

/* - Trigger for "Save" state
$("form").submit(function(){
	$("input[type='submit']").addClass("saved");
	return false;
});
*/