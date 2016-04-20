<cfset foodFight = CreateObject("component","components.foodFight").init(usersDSN='#application.DSN#') /> <!---html static framework is populated with dynamic brackets; next time do all logic in cfc--->
<!---<cfoutput> #request.currentRound#::::::::::::::#request.isLive#:::::::::#request.currentMoment# <cflock type="exclusive" timeout="20"><cfif structkeyexists(session, "ukey")>#session.ukey#</cfif></cflock></cfoutput>
--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
	<title>CQ Roll Call's Taste of America</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, user-scalable=no" />
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link href="css/nyroModal.css" rel="stylesheet" type="text/css" media="screen" />
	<!--[if IE 8]><link href="css/legacy.css" rel="stylesheet" type="text/css" /><![endif]-->
	<meta property="og:image" content="http://www.rollcalltasteofamerica.com/images/logos/logo-toa-fb.png"/>	
</head>

<body>

<!--Container Wrapper--> 
<div class="containerWrapper">

	<!--Site Header-->
	<div class="header"> <a href="/"><img src="images/logos/logo-taste_america.png" alt="Taste of America [Logo]" width="220" height="291" /></a>
		<h1>Roll Call/A Taste of America</h1>
	</div>
	<!--Site Header--> 

	<!--Container-->
	<form action="" class="container no-js" id="bracketForm" method="post" name="bracketForm">
	
	
	<!--Ad Space-->
	<div class="adSpace"> 
		<script type="text/javascript">
			var ord = window.ord || Math.floor(Math.random()*10e12);
			document.write('<script type="text/javascript" src="http://ad.doubleclick.net/N4218/adj/RollCall/TOA;pos=left;tile=1;sz=180x150;ord=' + ord + '?"><\/script>');
</script>
<noscript>
<a href="http://ad.doubleclick.net/N4218/jump/RollCall/TOA;pos=left;tile=1;sz=180x150;ord=1234567890?">
	<img src="http://ad.doubleclick.net/N4218/ad/RollCall/TOA;pos=left;tile=1;sz=180x150;ord=1234567890?" />
</a>
</noscript>


	</div>
	<!--Ad Space-->
	
	<!--Ad Space-->	
	<div class="adSpace adRight">
	<script type="text/javascript">
		var ord = window.ord || Math.floor(Math.random()*10e12);
		document.write('<script type="text/javascript" src="http://ad.doubleclick.net/N4218/adj/RollCall/TOA;pos=right;tile=2;sz=180x150;ord=' + ord + '?"><\/script>');
</script>
<noscript>
<a href="http://ad.doubleclick.net/N4218/jump/RollCall/TOA;pos=right;tile=2;sz=180x150;ord=1234567890?">
	<img src="http://ad.doubleclick.net/N4218/ad/RollCall/TOA;pos=right;tile=2;sz=180x150;ord=1234567890?" />
</a>
</noscript>

	</div>
	<!--Ad Space-->

	<!--Content Wrapper-->	
	<div class="contentWrapper <cfif request.currentRound eq 1 AND currentMoment lt roundOneStart>week0<cfelseif request.currentRound eq 1>week1<cfelseif request.currentRound eq 2>week2<cfelseif request.currentRound eq 3>week3<cfelseif request.currentRound eq 4>week4<cfelseif request.currentRound eq 5>week5</cfif>"> <!---Changed 4/23/14 - Including Early Voting--->

		<div class="topSection">
			<p><strong>It's back!</strong> Prove which state has the best food in America. Vote with your taste buds and support your state by choosing your favorite regional cuisine. Make your selections then click vote!</p>
			
			<!-- Social Media -->
			<ol class="socialLinks">
				<li>
					<a class="shareFacebook" href="#"><img src="images/links/link-facebook.png" alt="Share on Facebook" width="72" height="36" /></a>
				</li>
				<li>
					<a class="shareTwitter" href="#"><img src="images/links/link-twitter.png" alt="Share on Twitter" width="72" height="36" /></a>
				</li>
				<li>
					<a class="shareGoogle" href="#"><img src="images/links/link-google.png" alt="Share on Google+" width="72" height="36" /></a>
				</li>						
			</ol>
			<!-- Social Media -->
						
			<ul class="rounds">
				<li class="round1">Round 1 <span>May 4-8</span></li>
				<li class="round2">Round 2 <span>May 11-15</span></li>
				<li class="round3">Round 3 <span>May 18-29</span></li>
				<li class="round4">Final Round <span>June 1-5</span></li>
				<li class="round3">Round 3 <span>May 18-29</span></li>
				<li class="round2">Round 2 <span>May 11-15</span></li>
				<li class="round1">Round 1 <span>May 4-8</span></li>
			</ul>
		</div>	
		
		<!--Content-->
		<div class="content">

		   <cfif request.isLive eq 1><!---added to hide button between rounds --->
			<p class="votingBlock"><span>Make your picks then click vote. </span><input type="submit" name="vote" value="Vote" id="voteButton" /></p>
		   </cfif>

			<h2 class="hide">Matchups</h2>
			
			<ul class="hide">
				<li><a href="#round1">Week #1</a></li>
				<li><a href="#round2">Week #2</a></li>
				<li><a href="#round3">Week #3</a></li>
				<li><a href="#round4">Week #4</a></li>
				<li><a href="#winners">Regional Winners</a></li>
			</ul>
			
			<!--First Round-->
			<div id="round1" class="brackets firstRound <cfif request.currentRound eq 1 AND request.isLive eq 1>active<cfelse> </cfif>"> <!---Changed 4/23/14 - For Early Voting and First Round--->
			
				<h3>Week #1</h3>
				
				<!--First Round - West-->
                <div class="west">
				
					<h4>West</h4>
				<cfset divisionContestants = foodFight.getDivisionContestants(division='West', currentRound=request.currentRound, thisRound=1, currentMoment=request.currentMoment, roundEnd=request.roundOneEnd) />
				<cfoutput>#divisionContestants#</cfoutput>
				</div>
				<!--First Round - West-->
				
				<!--First Round - Midwest-->								
				<div class="midwest">
				
					<h4>Midwest</h4>
					
				<cfset divisionContestants = foodFight.getDivisionContestants(division='Midwest', currentRound=request.currentRound, thisRound=1, currentMoment=request.currentMoment, roundEnd=request.roundOneEnd) />
				<cfoutput>#divisionContestants#</cfoutput>
				</div>
				<!--First Round - Midwest-->	
				
				<!--First Round - Northeast-->									
				<div class="northeast">
				
					<h4>Northeast</h4>
					
				<cfset divisionContestants = foodFight.getDivisionContestants(division='Northeast', currentRound=request.currentRound, thisRound=1, currentMoment=request.currentMoment, roundEnd=request.roundOneEnd) />
				<cfoutput>#divisionContestants#</cfoutput>
				</div>
				<!--First Round - Northeast-->	
				
				<!--First Round - Southeast-->									
				<div class="southeast">
				
					<h4>Southeast</h4>
					
				<cfset divisionContestants = foodFight.getDivisionContestants(division='Southeast', currentRound=request.currentRound, thisRound=1, currentMoment=request.currentMoment, roundEnd=request.roundOneEnd) />
				<cfoutput>#divisionContestants#</cfoutput>
				<div> 
				<!--First Round - Southeast-->		

				<!--Keep This-->
				</div>
				</div>	
				<!--Keep This-->
											
			</div>
			<!--First Round--> 
			
			<!--QuarterFinals-->
			<div id="round2" class="brackets quarters <cfif request.currentRound eq 2 AND request.roundTwoEnd gt request.currentMoment>active<cfelseif request.currentRound gte 2> <cfelse>nonactive</cfif>">
			
				<h3>Week #2</h3>
				
				<!--Quarters - West-->						
				<div class="west">
				
					<h4>West</h4>
					<!--- get the dummy html unless the round active--then get actual contestants --->
					<cfif request.currentRound gte 2><cfset divisionContestants = foodFight.getDivisionContestants(division='West', currentRound=request.currentRound, thisRound=2, currentMoment=request.currentMoment, roundEnd=request.roundTwoEnd) /><cfelse><cfset divisionContestants = foodFight.getDivisionDummyHTML(loopRun=4) /></cfif>
				<cfoutput>#divisionContestants#</cfoutput>
               </div>
				<!--Quarters - West-->	
				
				<!--Quarters - Midwest-->									
				<div class="midwest">
				
					<h4>Midwest</h4>
					
					<!--- get the dummy html unless the round active--then get actual contestants --->
                    <cfif request.currentRound gte 2><cfset divisionContestants = foodFight.getDivisionContestants(division='Midwest', currentRound=request.currentRound, thisRound=2, currentMoment=request.currentMoment, roundEnd=request.roundTwoEnd) /><cfelse><cfset divisionContestants = foodFight.getDivisionDummyHTML(loopRun=4) /></cfif>
				<cfoutput>#divisionContestants#</cfoutput>
             	</div>
				<!--Quarters - Midwest-->					
				
				<!--Quarters - Northeast-->					
				<div class="northeast">
				
					<h4>Northeast</h4>
					
					<!--- get the dummy html unless the round active--then get actual contestants --->
                    <cfif request.currentRound gte 2><cfset divisionContestants = foodFight.getDivisionContestants(division='Northeast', currentRound=request.currentRound, thisRound=2, currentMoment=request.currentMoment, roundEnd=request.roundTwoEnd) /><cfelse><cfset divisionContestants = foodFight.getDivisionDummyHTML(loopRun=4) /></cfif>
				<cfoutput>#divisionContestants#</cfoutput>
				</div>
				<!--Quarters - Northeast-->	
				
				<!--Quarters - Southeast-->									
				<div class="southeast">
				
					<h4>Southeast</h4>
					
					<!--- get the dummy html unless the round active--then get actual contestants --->
                    <cfif request.currentRound gte 2><cfset divisionContestants = foodFight.getDivisionContestants(division='Southeast', currentRound=request.currentRound, thisRound=2, currentMoment=request.currentMoment, roundEnd=request.roundTwoEnd) /><cfelse><cfset divisionContestants = foodFight.getDivisionDummyHTML(loopRun=4) /></cfif>
				<cfoutput>#divisionContestants#</cfoutput>
				</div>
				<!--Quarters - Southeast-->	
										
			</div>
			<!--QuarterFinals--> 
			
			<!--Semifinals--><!---  --->
			<div id="round3" class="brackets semis <cfif request.currentRound eq 3 AND request.roundThreeEnd gt request.currentMoment>active<cfelseif request.currentRound gte 3> <cfelse>nonactive</cfif>">
			
				<h3>Week #3</h3>
				
				<!--Semifinals - West-->				
				<div class="west">
				
					<h4>West</h4>
					
					<!--- get the dummy html unless the round active--then get actual contestants --->
					<cfif request.currentRound gte 3><cfset divisionContestants = foodFight.getDivisionContestants(division='West', currentRound=request.currentRound, thisRound=3, currentMoment=request.currentMoment, roundEnd=request.roundThreeEnd) /><cfelse><cfset divisionContestants = foodFight.getDivisionDummyHTML(loopRun=2) /></cfif>
				<cfoutput>#divisionContestants#</cfoutput>
				</div>
				<!--Semifinals - West-->
				
				<!--Semifinals - Midwest-->								
				<div class="midwest">
				
					<h4>Midwest</h4>
					
					<!--- get the dummy html unless the round active--then get actual contestants --->
					<cfif request.currentRound gte 3><cfset divisionContestants = foodFight.getDivisionContestants(division='Midwest', currentRound=request.currentRound, thisRound=3, currentMoment=request.currentMoment, roundEnd=request.roundThreeEnd) /><cfelse><cfset divisionContestants = foodFight.getDivisionDummyHTML(loopRun=2) /></cfif>
				<cfoutput>#divisionContestants#</cfoutput>
				</div>
				<!--Semifinals - Midwest-->	
								
				<!--Semifinals - Northeast-->
												
				<div class="northeast">
				
					<h4>Northeast</h4>
					
				<!--- get the dummy html unless the round active--then get actual contestants --->
				<cfif request.currentRound gte 3><cfset divisionContestants = foodFight.getDivisionContestants(division='Northeast', currentRound=request.currentRound, thisRound=3, currentMoment=request.currentMoment, roundEnd=request.roundThreeEnd) /><cfelse><cfset divisionContestants = foodFight.getDivisionDummyHTML(loopRun=2) />					                </cfif>
				<cfoutput>#divisionContestants#</cfoutput>	
       			</div>
				<!--Semifinals - Northeast-->	
				
				<!--Semifinals - Southeast-->									
				<div class="southeast">
				
					<h4>Southeast</h4>
					
				<cfif request.currentRound gte 3><cfset divisionContestants = foodFight.getDivisionContestants(division='Southeast', currentRound=request.currentRound, thisRound=3, currentMoment=request.currentMoment, roundEnd=request.roundThreeEnd) /><cfelse><cfset divisionContestants = foodFight.getDivisionDummyHTML(loopRun=2) />					                </cfif>
				<cfoutput>#divisionContestants#</cfoutput>	
				</div>
				<!--Semifinals - Southeast-->
							
			</div>
			<!--Semifinals--> 
			
			
			<!--Winners-->			
            <div id="round4" class="brackets finals <cfif request.currentRound eq 4>active<cfelseif request.currentRound gt 4> <cfelse>nonactive</cfif>">
				<h3>Week #4</h3>

 				<!---Changed 4/23/14--->
			    <cfif request.currentRound eq 4 >             
			     <cfset divisionContestants = foodFight.getDivisionWinners( currentRound=request.currentRound, thisRound=4) /><cfoutput>#divisionContestants#</cfoutput>
                <cfelseif request.currentRound EQ 5>
				  <h2>Winner</h2>
				  <img src="images/logos/logo-taste_america-final.png" width="163" height="167" alt="2014 Roll Call's Taste of America">
				  <!---<p>Check back on June 26th for your National Champion</p>--->
                  <p>Your 2014 Taste of America Champion is Utah's Cherry Cobbler</p>
    			</cfif>
 				<!---Changed 4/23/14--->

			</div>
			<!--Winners--> 

			<!--Second Vote Button-->
            <cfif request.isLive eq 1> <!---added to hide button between rounds --->
			<p class="votingBlock secondVoting"><span>Make your picks then click vote.</span><input type="submit" name="vote2" value="Vote" id="voteButton2" /></p>
            </cfif>			
			<!--Second Vote Button-->
			
		</div>
		<!--Content--> 
		
	</div>
	<!--Content Wrapper-->
    <cfset ukey = foodfight.getSessionRandomNumber() /> <!---get a random number key from component and set it equal to hidden form field--->
	<cfoutput>
      <input type="hidden" name="ukey" value="#ukey#" />
	</cfoutput>	

</form>
<!--Container--> 

</div>
<!--Container Wrapper--> 

<!--Footer Wrapper-->
<div class="footerWrapper">

	<!---<!--Footer-->
	<div class="footer">
			<div class="sponsors">
			<h3>Sponsored By:</h3>
			<ul>
				<!--<li><a href="#"><img src="images/logos/logo-abd.png" width="161" height="136" alt="American Beer Distributors" /></a></li>
				<li><a href="#"><img src="images/logos/logo-placeholder1.png" width="161" height="136"  alt="Logo #1" /></a></li>
				<li><a href="#"><img src="images/logos/logo-placeholder2.png" width="161" height="136" alt="Logo #2" /></a></li>
				<li><a href="#"><img src="images/logos/logo-placeholder3.png" width="161" height="136" alt="Logo #3" /></a></li>-->
				<li><a href="http://www.beerinstitute.org" target="_new"><img src="images/logos/logo-beer-institute.png" width="161" height="136" alt="American Beer Institute" /></a></li>				
				<li><a href="http://www.cqrollcall.com" target="_new"><img src="images/logos/logo-cqrollcall.png" width="161" height="136" alt="CQ Roll Call" /></a></li>
			</ul>
		</div>
		<p class="footerNotice"><strong>Early Voting</strong> for Round 1 ends on Friday, May 9th at 5 PM &bull; <strong>Voting for Round 1</strong> continues Monday, May 12th at 9 AM and ends on Friday, May 23rd at 5 PM<br /><strong>Round 2</strong> begins Monday, May 26th at 9 AM and ends on Friday, May 30th at 5 PM &bull; <strong>Round 3</strong> begins Monday, June 2nd at 9 AM and ends Friday, June 6th at NOON<br /><strong>Round 4</strong> begins Monday, June 9th at 9 AM and ends Friday, June 20th at 5 PM &bull; <strong>Winners</strong> announced at the Congressional Baseball Game on June 25, 2014</p>

		<p class="copyRight">&copy;2014 CQ Roll Call <span>|</span> <a id="rulesLink" href="rules.html">Contest Rules</a></p>
	</div>
	<!--Footer-->--->
    
    
<!--Footer-->
<div class="footer">
<div class="sponsors">
<h3>Sponsored By:</h3>
<ul>
<li><a href="http://www.nbwa.org" target="_blank"><img src="images/logos/logo-abd.png" alt="NWBA" width="71" height="180" /></a></li>
<li><a href="http://www.affi.org" target="_blank"><img src="images/logos/logo-affi.png" alt="American Frozen Food Institute" width="269" height="180" /></a></li>
</ul>
<h3 class="broughtBy">Brought to you by:</h3>
<ul class="broughtBy">
<li><a href="http://corporate.cqrollcall.com" target="_blank"><img src="images/logos/logo-cqrollcall.png" alt="CQ Roll Call" width="90" height="182" alt="CQ Roll Call" /></a></li>
</ul>
</div>
<p class="footerNotice">
				<strong>Round 1</strong> begins Monday, May 4th at 9 AM and ends on Friday, May 8th at 5 PM &bull; 
				<strong>Round 2</strong> begins Monday, May 11th at 9 AM and ends on Friday, May 15th at 5 PM<br />
				<strong>Round 3</strong> begins Monday, May 18th at 9 AM and ends Friday, May 29th at 5 PM &bull;
				<strong>Round 4</strong> begins Monday, June 1st at 9 AM and ends Friday, June 5th at 5 PM <br />
				Winners announced at the Congressional Baseball Game on June 11, 2015</p>

<p class="copyRight">&copy;2015 CQ Roll Call <span>|</span> <a id="rulesLink" href="rules.html">Contest Rules</a></p>
</div>
<!--Footer-->


</div>
<!--Footer Wrapper-->

	<!-- Google Analytics -->
	<script type="text/javascript">

	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-302712-19']);
	  _gaq.push(['_trackPageview']);

	  (function() {
	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();

	</script>
	<!-- Google Analytics -->

	<!--JavaScript Calls--> 
	<script src="library/jquery-1.4.4.min.js" type="text/javascript"></script> 
	<script src="library/jquery.nyroModal-1.6.2.pack.js" type="text/javascript"></script> 
	<script src="library/jquery.form.js" type="text/javascript"></script> 
	<script src="library/jquery.validate.js" type="text/javascript"></script> 
	<script src="js/utility.js" type="text/javascript"></script> 
	<!--JavaScript Calls-->

</body>
</html>
