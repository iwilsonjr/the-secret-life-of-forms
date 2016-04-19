
$("input[type='submit']").removeAttr("disabled");

//Fancybox
$(".target").fancybox({	
	type: 'ajax',
	afterLoad: function(){
		$(".fancybox-inner").addClass("contentBlock").addClass("ajaxBlock");		
		$("#ajaxWindow").jScrollPane({showArrows: true});			
	}
});