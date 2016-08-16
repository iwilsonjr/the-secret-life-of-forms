// JavaScript Document
window.onload = function() {
    setTimeout(function(){window.scrollTo(0, 1);}, 1);
}

if('webkitAudioContext' in window) {
	var context = new webkitAudioContext();
	var analyser = context.createAnalyser();
	var source; 
	var audio0 = new Audio();   
	audio0.src = 'files/audio/dial.mp3';
	audio0.controls = false;
	audio0.autoplay = false;
	audio0.loop = false;
	source = context.createMediaElementSource(audio0);
	source.connect(analyser);
	analyser.connect(context.destination);
	var tone1;
	var tone2;
	function setTone(e) {
		if ( typeof tone1 != 'undefined'){  tone1.disconnect(0); }
		if ( typeof tone2 != 'undefined'){  tone2.disconnect(0); }
		var freqArr = [ 
				[941, 1336] /* 0 */,
				[697, 1209] /* 1 */,
				[697, 1336] /* 2 */,
				[697, 1477] /* 3 */,
				[770, 1209] /* 4 */,
				[770, 1336] /* 5 */,
				[770, 1477] /* 6 */,
				[852, 1209] /* 7 */,
				[852, 1336] /* 8 */,
				[852, 1477] /* 9 */
			];
		tone1 = context.createOscillator();
		tone1.type = 0; // sine wave
		tone1.frequency.value = freqArr[e][0];
		//tone1.connect(context.destination);
		tone2 = context.createOscillator();
		tone2.type = 0; // sine wave
		tone2.frequency.value = freqArr[e][1];
		//tone2.connect(context.destination);
		var gainNode1 = context.createGainNode();
		var gainNode2 = context.createGainNode();
		tone1.connect(gainNode1);
		tone2.connect(gainNode2);
		gainNode1.connect(context.destination);
		gainNode2.connect(context.destination);
		gainNode1.gain.value = .2;
		gainNode2.gain.value = .2;
	}
}

$(document).ready(function(){
//Start JQuery Code
	$.mobile.ajaxEnabled = false;
	/* Site Menu */
	$("#menuLink").toggle(function(){
		$("body").removeClass("closeNavigation").addClass("openNavigation");
	}, function(){
		$("body").removeClass("openNavigation").addClass("closeNavigation");
	})
	$("#menuLink").swipeleft(function() {
    	$("body").removeClass("closeNavigation").addClass("openNavigation");
	});
	$("#menuLink").swiperight(function() {
		$("body").removeClass("openNavigation").addClass("closeNavigation");
	});
	
	$("#simLocation").change(function() {
  		$('#countryCode').val("+" + $(this).val());
	});
	
	$(".touchTone li span").not('.touchTone li span.deleteNumber').not('.touchTone li span.clearButton').on( "vmousedown", function() {
		var toneValue = $(this).text();
		if('webkitAudioContext' in window) { setTone(toneValue); tone1.noteOn(0); tone2.noteOn(0); }
	});
	$(".touchTone li span").not('.touchTone li span.deleteNumber').not('.touchTone li span.clearButton').on( "vmouseup", function() {
		if('webkitAudioContext' in window) { tone1.disconnect(0); tone2.disconnect(0); }
		var keyValue = $(this).text();
		$("#phoneNumber").val($('#phoneNumber').val() + keyValue);
	});
	
	
	
	$(".deleteNumber").click(function() {
  		$('#phoneNumber').val(
   			 function(index,value){
        	return value.substr(0,value.length-1);
		})
	});
	
	$(".deleteButton").click(function() {
  		$('#phoneNumber').val(
   			 function(index,value){
        	return value.substr(0,value.length-1);
		})
	});
	$(".clearButton").click(function() {
  		$('#phoneNumber').val("");
	});

	$(".callButton").click(function() {
		var countryCode = $('#countryCode').val();
		var phoneNumber = $('#phoneNumber').val();
		var hrefContent = "tel:" + countryCode + phoneNumber;
  		$(this).attr("href", hrefContent); 
		location.href = href;
    	return false;
	});
	
	$("body.rotary .callButton").on( "vmousedown", function() {
		$("#callButtonBkg").addClass('pressed');
	});
	$("body.rotary .callButton").on( "vmouseup", function() {
		$("#callButtonBkg").removeClass('pressed');
	});
	
	
	$(".rotary li span").click(function() {
		
		var dialNum = $(this).parent('li').attr('class').replace('dial','');
		var keyValue = $(this).text();
		$('#rotaryHolder').addClass('rotate' + dialNum);
		if('webkitAudioContext' in window) { audio0.play(); }
    		setTimeout(function() {
        $('#rotaryHolder').removeClass('rotate' + dialNum);
		if('webkitAudioContext' in window) { audio0.pause();
		audio0.currentTime = 0; }
		
		$("#phoneNumber").val($('#phoneNumber').val() + keyValue);
    	}, 1200)
	});
	 
	
		
//End JQuery Code
});	

/* Prevent links from opening in Safari when running as iOS web app */

(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone");