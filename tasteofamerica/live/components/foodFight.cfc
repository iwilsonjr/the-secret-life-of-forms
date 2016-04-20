<!--- author: John Nelson  date: April 2011; update/restructure Feb 2012 --->

<!---        Section 1         --->
<!--- Component instantiation --->
<cfcomponent displayname="foodFight" hint="this component powers the special CQ Food Fight Page" author="John Nelson">
 <cffunction name="init" access="public" returntype="foodFight" output="false" hint="Initializes the foodFight object.">     
  <cfargument name="usersDSN" type="string" required="no" default="" hint="foodFight datasource." />  
  <cfscript>
   setUsersDSN(arguments.usersDSN);        
  </cfscript>
  <cfreturn this />
 </cffunction> 
 
 <cffunction name="setUsersDSN" access="private" returntype="void" output="false">
  <cfargument name="usersDSN" type="string" required="yes" hint="users datasource." />
  <cfset variables.instance.usersDSN = trim(arguments.usersDSN) />
 </cffunction> 
 
<!---        Section 2         --->
<!--- Logic ---> 
 <!---test for currentRound updated or not, switch rounds if required--->
 <cffunction name="RoundChanger" access="private" returntype="void" output="no" hint="calculate the winners and update the matchups table" >
 <cfquery name="checkCurrentRound" datasource="#variables.instance.usersDSN#" >  <!---see what the current round is--->
  SELECT DISTINCT max(Round) AS currentRound
  FROM custom_foodfight_matchUp
 </cfquery>
 <cfset currentRound = checkCurrentRound.currentRound />
 <!---get the matchups from the last round--->
 <cfset getMatchUpsRound = getMatchUps(thisRound = request.currentRound-1)/><!---in order to reuse getMatchUps method, we are manipulating thisRound: not the same as what is passed from brackets.cfm--->
   <cfif currentRound lt request.currentRound> <!---if the DB has not been updated to the most current round, run the code block below to update--->
     <cfset iterations = #getMatchUpsRound.recordCount# >
     <cfset iterations = iterations/2>
     <cfloop from="1" to="#iterations#" index="i" >
     	<cfset scoreRound = "scoreRound" & request.currentRound-1 /> <!---scoreRound2--->
        <cfquery name="getWinners" dbtype="query" >
         SELECT ID, #scoreRound#<!------>
         FROM getMatchUpsRound
         WHERE matchup = #i#
        </cfquery>
       <cfif getWinners.recordCount eq 2>
          <cfset contestant1 = getWinners['#scoreRound#'][1] />  <!---stuck here--->
          <cfset contestant2 = getWinners['#scoreRound#'][2] />
          <cfif contestant1 gt contestant2>
            <cfquery name="insertWinner" datasource="#variables.instance.usersDSN#" >
            INSERT INTO custom_foodfight_matchUp (FoodID, Round, MatchUp) 
            VALUES (#getWinners.ID[1]#, #request.currentRound#, <cfif i mod 2 eq 0>#i/2#<cfelse>#(i+1)/2#</cfif>)
            </cfquery>
          <cfelseif  contestant2 gt contestant1>
            <cfquery name="insertWinner" datasource="#variables.instance.usersDSN#" >
            INSERT INTO custom_foodfight_matchUp (FoodID, Round, MatchUp) 
            VALUES (#getWinners.ID[2]#, #request.currentRound#, <cfif i mod 2 eq 0>#i/2#<cfelse>#(i+1)/2#</cfif>)
            </cfquery>
          <cfelse>
           <cfset coinFlip = randRange(1,2) />
           <cfquery name="insertWinner" datasource="#variables.instance.usersDSN#" >
            INSERT INTO custom_foodfight_matchUp (FoodID, Round, MatchUp, CoinFlip) 
            VALUES (#getWinners.ID[coinFlip]#, #request.currentRound#, <cfif i mod 2 eq 0>#i/2#<cfelse>#(i+1)/2#</cfif>, 1)
           </cfquery>
          </cfif>
       <cfelse>error!
       </cfif>
     </cfloop>
 </cfif>
</cffunction> 
 
<!---        Section 3         --->
 <!--- HTML output --->
<cffunction name="getMatchUps" output="no" returntype="query" access="private" >
 <cfargument name="thisRound" required="yes" type="numeric">
 <cfquery name="getMatchUpsRound" datasource="#variables.instance.usersDSN#" cachedwithin="#createTimeSpan(0,0,0,0)#">
    SELECT custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation,custom_foodfight_contestants.stateAbbreviationNew, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,custom_foodfight_contestants.restaurantLink, custom_foodfight_contestants.restaurant, custom_foodfight_contestants.division, custom_foodfight_contestants.scoreRound#arguments.thisRound#, custom_foodfight_matchUp.matchUp
    FROM custom_foodfight_contestants INNER JOIN custom_foodfight_matchUp
    ON custom_foodfight_contestants.ID = custom_foodfight_matchUp.FoodID
    WHERE custom_foodfight_matchUp.Round = #arguments.thisRound#
 </cfquery>
 <cfreturn getMatchUpsRound>
</cffunction> 


<!--- get the html pairings for each round but five --->
 <cffunction name="getDivisionContestants" output="yes" access="public"  >
  <cfargument name="division" required="yes" type="string" >
  <cfargument name="currentRound" required="yes" type="numeric" >
  <cfargument name="thisRound" required="yes" type="numeric" >
  <cfargument name="currentMoment" required="no" type="date" >
  <cfargument name="roundEnd" required="no" type="date" >
    <cfif arguments.thisRound gt 1 AND arguments.thisRound lt 5><cfset roundChanger() /></cfif> <!---don't run round change logic for first round or last round--->
	<cfset roundQuery = getMatchUps(thisRound=arguments.thisRound) />
    <cfquery name="getDivisionContestantsRS" dbtype="query"  >
    SELECT *
    FROM roundQuery
    WHERE division = '#arguments.division#'
    ORDER BY matchup
    </cfquery>
   
   <cfsavecontent variable="divisionHTML" ><!---<cfdump var="#getDivisionContestantsRS#">--->
	<cfloop from="2" to="#getDivisionContestantsRS.recordcount#" step="2" index="i" >
        <fieldset class="matchup">
            <legend>Matchup ###getDivisionContestantsRS['matchup'][i]#</legend>  
            <div class="competitor">
                <span class="picked"></span>
                <label for="s#arguments.thisRound#_#getDivisionContestantsRS['matchup'][i]#_1"><strong> #getDivisionContestantsRS['stateAbbreviationNew'][evaluate(i-1)]#</strong> <em><cfif getDivisionContestantsRS['ScoreRound' & #arguments.thisRound#][evaluate(i-1)] neq "">#NumberFormat(getDivisionContestantsRS['ScoreRound' & evaluate(arguments.thisRound)][evaluate(i-1)],",")# votes<cfelse> 0 votes</cfif></em> <span>#getDivisionContestantsRS['foodName'][evaluate(i-1)]#</span></label>
                <span class="selection"> 
                    <strong>Click to <span>Select</span></strong>
                    <!---  ---><input name="#getDivisionContestantsRS['matchup'][i]#" type="radio" id="s#arguments.thisRound#_#getDivisionContestantsRS['matchup'][i]#_1" value="#getDivisionContestantsRS['ID'][evaluate(i-1)]#" <cfif arguments.roundEnd lt arguments.currentMoment >disabled="disabled"</cfif> />
                </span>
                
                <div class="menu"> 
                    <span class="top"></span>
                    
                    <div class="text">
                        <h5>#getDivisionContestantsRS['state'][evaluate(i-1)]#</h5>
                        <strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][evaluate(i-1)] neq "">#getDivisionContestantsRS['foodNameLong'][evaluate(i-1)]#<cfelse>#getDivisionContestantsRS['foodName'][evaluate(i-1)]#</cfif></strong>
                         <cfif currentRound gte 1>  
                          <div class="foodChoice">
                              <p>#getDivisionContestantsRS['foodDescription'][evaluate(i-1)]#</p>
                          </div>

                          <cfif currentRound gte 3>                        
                          <div class="beerChoice">
   
                              <h6>Beer Pairing</h6>
                              <p><a href="#getDivisionContestantsRS['beerLink'][evaluate(i-1)]#" class="beer2" target="_blank">#getDivisionContestantsRS['beer'][evaluate(i-1)]#</a></p> <!---Changed 4/23/14 - text removal---> 

                              <h6>Restaurant Pairing</h6>
                              <!---<p>The National Restaurant Association recommends:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][evaluate(i-1)]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][evaluate(i-1)]#</a></p>

                           </div>
                          </cfif>                        
                        </cfif>
                    </div>
                    
                    <span class="bottom"></span>
                
                </div>
            </div>
            <div class="competitor">
                <span class="picked"></span>
                <label for="s#arguments.thisRound#_#getDivisionContestantsRS['matchup'][i]#_2"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][i]#</strong> <em><cfif getDivisionContestantsRS['ScoreRound' & #arguments.thisRound#][evaluate(i)] neq "">#NumberFormat(getDivisionContestantsRS['ScoreRound' & evaluate(arguments.thisRound)][evaluate(i)],",")# votes<cfelse> 0 votes</cfif></em> <span>#getDivisionContestantsRS['foodName'][i]#</span></label>
                <span class="selection"> 
                    <strong>Click to <span>Select</span></strong>
                    <input name="#getDivisionContestantsRS['matchup'][i]#" type="radio" id="s#arguments.thisRound#_#getDivisionContestantsRS['matchup'][i]#_2" value="#getDivisionContestantsRS['ID'][i]#" <cfif arguments.roundEnd lt arguments.currentMoment >disabled="disabled"</cfif>  />
                </span>
                
                <div class="menu"> 
                    <span class="top"></span>
                    
                    <div class="text">
                        <h5>#getDivisionContestantsRS['state'][i]#</h5>
                        <strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][i] neq "">#getDivisionContestantsRS['foodNameLong'][i]#<cfelse>#getDivisionContestantsRS['foodName'][i]#</cfif></strong>
                        <cfif currentRound gte 1> 
                          <div class="foodChoice">
                              <p>#getDivisionContestantsRS['foodDescription'][i]#</p>
                          </div>

                          <cfif currentRound gte 3>

                            <div class="beerChoice">                         
                               <h6>Beer Pairing</h6>
                                <p><a href="#getDivisionContestantsRS['beerLink'][i]#" class="beer2" target="_blank">#getDivisionContestantsRS['beer'][i]#</a> </p><!---Changed 4/23/14 - text removal--->

                                <h6>Restaurant Pairing</h6>
                                <!---<p>The National Restaurant Association recommends:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][i]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][i]#</a></p>

                            </div>
                          </cfif>                         
                        </cfif>
                    </div>
                    
                    <span class="bottom"></span>
                
                </div>                
            </div>
        </fieldset>
	</cfloop>
   </cfsavecontent> 

  <cfreturn divisionHTML >
 </cffunction>
 
 <!--- get dummy place holder html for rounds that have not gone live yet --->
 <cffunction name="getDivisionDummyHTML" output="yes" access="public"  >
  <cfargument name="loopRun" required="yes" type="numeric" >
   <cfsavecontent variable="divisionHTML" >
	<cfloop from="1" to="#arguments.loopRun#" index="i" >
    				
        			<fieldset class="matchup">
						<legend>Matchup ##1</legend>
						<div class="competitor">
							<label><strong>S1</strong> <em>123 votes</em> <span>Food Item ##1</span></label>
						</div>
						<div class="competitor">
							<label><strong>S1</strong> <em>123 votes</em> <span>Food Item ##1</span></label>
						</div>
					</fieldset>
	</cfloop>
   </cfsavecontent> 
  <cfreturn divisionHTML >
 </cffunction>


  <!--- get html for round five where you have four contestants intead of two pairs --->
  <cffunction name="getDivisionWinners" output="yes" access="public"  >
    <!---<cfargument name="RoundQuery" required="yes" type="query" >--->
    <cfargument name="currentRound" required="yes" type="numeric" >

	<cfset RoundQuery = getMatchUps(thisRound=request.currentRound) /><!------>
    <cfquery name="getDivisionContestantsRS" dbtype="query"  >
    SELECT *
    FROM RoundQuery
    ORDER BY matchup
    </cfquery>
    
    <cfsavecontent variable="divisionHTML" >
                       <div class="west"> 
                        <h4>West</h4>
                        <fieldset class="matchup">
                        <legend>Final Matchup</legend>
 						<!--West Finalist-->
						<div class="competitor"> 
						
							<span class="picked"></span>
							
							<label for="S5_1_1"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][1]#</strong> <span>#getDivisionContestantsRS['foodName'][1]#</span></label>
							
							<span class="selection">
								<strong>Click to <span>Select</span></strong>
								<input type="radio" name="1" id="S5_1_1" value="#getDivisionContestantsRS['ID'][1]#" />
							</span>
							
							<div class="menu">
								<span class="top"></span>
								
								<div class="text">
									<h5>#getDivisionContestantsRS['state'][1]#</h5>
									<strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][1] neq "">#getDivisionContestantsRS['foodNameLong'][1]#<cfelse>#getDivisionContestantsRS['foodName'][1]#</cfif></strong>
<!---									<div>
										<p>#getDivisionContestantsRS['foodDescription'][1]#</p>
									</div>
--->									<div class="beerChoice">
										<h6>Beer Pairing</h6>
                                        <p><a href="#getDivisionContestantsRS['beerLink'][1]#" target="_blank" class="beer2">#getDivisionContestantsRS['beer'][1]#</a></p> <!---Changed 4/23/14 - text removal--->
                                        <h6>Restaurant Pairing</h6>
                                       <!--- <p>The National Restaurant Association and the Arizona Restaurant Association recommend:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][1]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][1]#</a></p>
									</div>
								</div>
								
								<span class="bottom"></span> 
							</div>
							
						</div>
						<!--West Finalist-->
						
 						<!--West Finalist 2-->
						<div class="competitor"> 
						
							<span class="picked"></span>
							
							<label for="S5_1_1"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][2]#</strong> <span>#getDivisionContestantsRS['foodName'][2]#</span></label>
							
							<span class="selection">
								<strong>Click to <span>Select</span></strong>
								<input type="radio" name="1" id="S5_1_1" value="#getDivisionContestantsRS['ID'][2]#" />
							</span>
							
							<div class="menu">
								<span class="top"></span>
								
								<div class="text">
									<h5>#getDivisionContestantsRS['state'][2]#</h5>
									<strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][2] neq "">#getDivisionContestantsRS['foodNameLong'][2]#<cfelse>#getDivisionContestantsRS['foodName'][2]#</cfif></strong>
<!---									<div>
										<p>#getDivisionContestantsRS['foodDescription'][2]#</p>
									</div>
--->								<div class="beerChoice">
										<h6>Beer Pairing</h6>
										 <p><a href="#getDivisionContestantsRS['beerLink'][2]#" target="_blank" class="beer2">#getDivisionContestantsRS['beer'][2]#</a></p> <!---Changed 4/23/14 - text removal--->
                                        <h6>Restaurant Pairing</h6>
                                        <!---<p>The National Restaurant Association and the Oregon Restaurant & Lodging Association recommend:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][2]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][2]#</a></p>
									</div>
								</div>
								
								<span class="bottom"></span> 
							</div>
							
						</div>
						<!--West Finalist 2-->
                      </fieldset>
                      </div>  

					<div class="midwest">
                        <h4>Midwest</h4>
                        <fieldset class="matchup">
                        <legend>Final Matchup</legend>
						<!--Midwest Finalist-->
						<div class="competitor"> 
						
							<span class="picked"></span>
							
							<label for="S5_1_3"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][3]#</strong> <span>#getDivisionContestantsRS['foodName'][3]#</span></label>
							
							<span class="selection">
								<strong>Click to <span>Select</span></strong>
								<input type="radio" name="1" id="S5_1_3" value="#getDivisionContestantsRS['ID'][3]#" />
							</span>
							
							<div class="menu">
								<span class="top"></span>
								
								<div class="text">
									<h5>#getDivisionContestantsRS['state'][3]#</h5>
									<strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][3] neq "">#getDivisionContestantsRS['foodNameLong'][3]#<cfelse>#getDivisionContestantsRS['foodName'][3]#</cfif></strong>
<!---									<div>
										<p>#getDivisionContestantsRS['foodDescription'][3]#</p>
									</div>
--->								<div class="beerChoice">
										<h6>Beer Pairing</h6>
										 <p><a href="#getDivisionContestantsRS['beerLink'][3]#" target="_blank" class="beer2">#getDivisionContestantsRS['beer'][3]#</a></p> <!---Changed 4/23/14 - text removal---> 
                                        <h6>Restaurant Pairing</h6>
                                        <!---<p>The National Restaurant Association and the Iowa Restaurant Association recommend:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][3]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][3]#</a></p>
									</div>
								</div>
								
								<span class="bottom"></span> 
							</div>
							
						</div>
						<!--Midwest Finalist-->
						
						<!--Midwest Finalist 2-->
						<div class="competitor"> 
						
							<span class="picked"></span>
							
							<label for="S5_1_3"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][4]#</strong> <span>#getDivisionContestantsRS['foodName'][4]#</span></label>
							
							<span class="selection">
								<strong>Click to <span>Select</span></strong>
								<input type="radio" name="1" id="S5_1_3" value="#getDivisionContestantsRS['ID'][4]#" />
							</span>
							
							<div class="menu">
								<span class="top"></span>
								
								<div class="text">
									<h5>#getDivisionContestantsRS['state'][4]#</h5>
									<strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][4] neq "">#getDivisionContestantsRS['foodNameLong'][4]#<cfelse>#getDivisionContestantsRS['foodName'][4]#</cfif></strong>
<!---									<div>
										<p>#getDivisionContestantsRS['foodDescription'][4]#</p>
									</div>
--->								<div class="beerChoice">
										<h6>Beer Pairing</h6>
										 <p><a href="#getDivisionContestantsRS['beerLink'][4]#" target="_blank" class="beer2">#getDivisionContestantsRS['beer'][4]#</a></p> <!---Changed 4/23/14 - text removal--->
                                        <h6>Restaurant Pairing</h6>
                                        <!---<p>The National Restaurant Association and the Illinois Restaurant Association recommend:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][4]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][4]#</a></p>
									</div>
								</div>
								
								<span class="bottom"></span> 
							</div>
							
						</div>
						<!--Midwest Finalist 2-->
					</fieldset>
					</div>


                      <div class="northeast">
                        <h4>Northeast</h4>
                        <fieldset class="matchup">
                        <legend>Final Matchup</legend>
                      					
						<!--Northeast Finalist-->	
						<div class="competitor"> 
						
							<span class="picked"></span>
							
							<label for="S5_1_2"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][5]#</strong> <span>#getDivisionContestantsRS['foodName'][5]#</span></label>
							
							<span class="selection">
								<strong>Click to <span>Select</span></strong>
								<input type="radio" name="1" id="S5_1_2" value="#getDivisionContestantsRS['ID'][5]#" />
							</span>
							
							<div class="menu">
								<span class="top"></span>
								
								<div class="text">
									<h5>#getDivisionContestantsRS['state'][5]#</h5>
									<strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][5] neq "">#getDivisionContestantsRS['foodNameLong'][5]#<cfelse>#getDivisionContestantsRS['foodName'][5]#</cfif></strong>
<!---									<div>
										<p>#getDivisionContestantsRS['foodDescription'][5]#</p>
									</div>
--->								<div class="beerChoice">
										<h6>Beer Pairing</h6>
										 <p><a href="#getDivisionContestantsRS['beerLink'][5]#" target="_blank" class="beer2">#getDivisionContestantsRS['beer'][5]#</a></p> <!---Changed 4/23/14 - text removal--->
                                        <h6>Restaurant Pairing</h6>
                                        <!---<p>The National Restaurant Association and the West Virginia Hospitality & Travel Association recommend:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][5]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][5]#</a></p>
									</div>
								</div>
								
								<span class="bottom"></span> 
							</div>
							
						</div>
						<!--Northeast Finalist-->	
						
						<!--Northeast Finalist 2-->						
						<div class="competitor"> 
						
							<span class="picked"></span>
							
							<label for="S5_1_2"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][6]#</strong> <span>#getDivisionContestantsRS['foodName'][6]#</span></label>
							
							<span class="selection">
								<strong>Click to <span>Select</span></strong>
								<input type="radio" name="1" id="S5_1_2" value="#getDivisionContestantsRS['ID'][6]#" />
							</span>
							
							<div class="menu">
								<span class="top"></span>
								
								<div class="text">
									<h5>#getDivisionContestantsRS['state'][6]#</h5>
									<strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][6] neq "">#getDivisionContestantsRS['foodNameLong'][6]#<cfelse>#getDivisionContestantsRS['foodName'][6]#</cfif></strong>
<!---									<div>
										<p>#getDivisionContestantsRS['foodDescription'][6]#</p>
									</div>
--->								<div class="beerChoice">
										<h6>Beer Pairing</h6>
										 <p><a href="#getDivisionContestantsRS['beerLink'][6]#" target="_blank" class="beer2">#getDivisionContestantsRS['beer'][6]#</a></p> <!---Changed 4/23/14 - text removal--->
                                        <h6>Restaurant Pairing</h6>
                                        <!---<p>The National Restaurant Association and the Restaurant Association of Maryland recommend:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][6]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][6]#</a></p>
									</div>
								</div>
								
								<span class="bottom"></span> 
							</div>
							
						</div>
						<!--Northeast Finalist 2-->	
					</fieldset>
                    </div>
                    	

                    
					<div class="southeast">
                        <h4>Southeast</h4>
                        <fieldset class="matchup">
                        <legend>Final Matchup</legend>
						<!--Southeast Finalist-->						
						<div class="competitor">
						 
							<span class="picked"></span>
							
							<label for="S5_1_4"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][7]#</strong> <span>#getDivisionContestantsRS['foodName'][7]#</span></label>
							
							<span class="selection">
								<strong>Click to <span>Select</span></strong>
								<input type="radio" name="1" id="S5_1_4" value="#getDivisionContestantsRS['ID'][7]#" />
							</span>
							
							<div class="menu">
								<span class="top"></span>
								
								<div class="text">
									<h5>#getDivisionContestantsRS['state'][7]#</h5>
									<strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][7] neq "">#getDivisionContestantsRS['foodNameLong'][7]#<cfelse>#getDivisionContestantsRS['foodName'][7]#</cfif></strong>
<!---									<div>
										<p>#getDivisionContestantsRS['foodDescription'][7]#</p>
									</div>
--->								<div class="beerChoice">
										<h6>Beer Pairing</h6>
										 <p><a href="#getDivisionContestantsRS['beerLink'][7]#" target="_blank" class="beer2">#getDivisionContestantsRS['beer'][7]#</a></p> <!---Changed 4/23/14 - text removal--->
                                        <h6>Restaurant Pairing</h6>
                                        <!---<p>The National Restaurant Association and the South Carolina Restaurant & Lodging Association recommend:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][7]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][7]#</a></p>
									</div>
								</div>
								
								<span class="bottom"></span> 
							</div>
							
						</div>
						<!--Southeast Finalist-->	
                        
						<!--Southeast Finalist 2-->						
						<div class="competitor">
						 
							<span class="picked"></span>
							
							<label for="S5_1_4"><strong>#getDivisionContestantsRS['stateAbbreviationNew'][8]#</strong> <span>#getDivisionContestantsRS['foodName'][8]#</span></label>
							
							<span class="selection">
								<strong>Click to <span>Select</span></strong>
								<input type="radio" name="1" id="S5_1_4" value="#getDivisionContestantsRS['ID'][8]#" />
							</span>
							
							<div class="menu">
								<span class="top"></span>
								
								<div class="text">
									<h5>#getDivisionContestantsRS['state'][8]#</h5>
									<strong class="foodItem"><cfif getDivisionContestantsRS['foodNamelong'][8] neq "">#getDivisionContestantsRS['foodNameLong'][8]#<cfelse>#getDivisionContestantsRS['foodName'][8]#</cfif></strong>
<!---									<div>
										<p>#getDivisionContestantsRS['foodDescription'][8]#</p>
									</div>
--->								<div class="beerChoice">
										<h6>Beer Pairing</h6>
										 <p><a href="#getDivisionContestantsRS['beerLink'][8]#" target="_blank" class="beer2">#getDivisionContestantsRS['beer'][8]#</a></p> <!---Changed 4/23/14 - text removal---> 
                                        <h6>Restaurant Pairing</h6>
                                        <!---<p>The National Restaurant Association and the Georgia Restaurant Association recommend:<br />---><a href="#getDivisionContestantsRS['restaurantLink'][8]#" class="beer2" target="_blank">#getDivisionContestantsRS['restaurant'][8]#</a></p>
									</div>
								</div>
								
								<span class="bottom"></span> 
							</div>
							
						</div>
						<!--Southeast Finalist 2-->	
                    </fieldset> 
					</div>
   </cfsavecontent>  
  <cfreturn divisionHTML >
 </cffunction>
 
 <!---        Section 4         --->
 <!--- Session Management ---> 
 
  <cffunction name="getSessionRandomNumber" access="public" returntype="string" output="false">
     <cfset var ukey = -1 />
     <cfset var ukeyRand = randrange(1, 100000) />
     <cfset ukeyTemp = #ukeyRand#&#request.keySuffix# />
     <cflock type="exclusive" scope="session" timeout="30">
      <cfset session.ukey = ukeyTemp />
      <cfset ukey = listfirst(session.ukey, "_") />
    </cflock>
   <cfreturn ukey > 
 </cffunction> 
 

</cfcomponent>