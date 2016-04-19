// JavaScript Document

//Date Mask
$("input[id^='dob']").mask("99/99/9999");


//IE9 Fix - Placeholders - Added 3/28/13

//Placeholder Support - IE9 does not support
function supportsPlaceholder() {
  var i = document.createElement('input');
  return 'placeholder' in i;
}

//Placeholder/Value Fix - IE9
if (!supportsPlaceholder()){
	
	$("input").each(function(){
	  if($(this).val()=="" && $(this).attr("placeholder")!=""){
		$(this).val($(this).attr("placeholder"));
		$(this).focus(function(){
		  if($(this).val()==$(this).attr("placeholder")) $(this).val("");
		});
		$(this).blur(function(){
		  if($(this).val()=="") $(this).val($(this).attr("placeholder"));
		});
	  }
	});

}


$("form").submit(function(){
	
	//Placeholder/Value Fix - IE9
	if (!supportsPlaceholder()){	
		$("input").each(function(){
			if($(this).val()==$(this).attr("placeholder")) $(this).val("");
		});
	}

});