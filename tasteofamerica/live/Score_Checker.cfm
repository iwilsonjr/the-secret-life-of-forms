<!---1--->
 <cfquery name="getMatchUpsRound1" datasource="#application.DSN#" >
    SELECT custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp, count(custom_foodfight_score_link_R1.foodID) as totalVotes
    FROM custom_foodfight_contestants INNER JOIN custom_foodfight_matchUp
    ON custom_foodfight_contestants.ID = custom_foodfight_matchUp.FoodID
    LEFT JOIN custom_foodfight_score_link_R1 ON custom_foodfight_contestants.ID = custom_foodfight_score_link_R1.foodID
    WHERE custom_foodfight_matchUp.Round = 1
    GROUP BY custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp
	ORDER BY custom_foodfight_contestants.ID
 </cfquery>

 <cfquery name="getMatchUpsRound1New" datasource="#application.DSN#" >
    SELECT ID,foodName, ScoreRound1
    FROM custom_foodFight_Contestants
    ORDER BY ID
 </cfquery>
<!---2---> <!---Assuming no zero vote contestants--->
 <cfquery name="getMatchUpsRound2" datasource="#application.DSN#" >
    SELECT custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp, count(custom_foodfight_score_link_R2.foodID) as totalVotes
    FROM custom_foodfight_contestants INNER JOIN custom_foodfight_matchUp
    ON custom_foodfight_contestants.ID = custom_foodfight_matchUp.FoodID
    LEFT JOIN custom_foodfight_score_link_R2 ON custom_foodfight_contestants.ID = custom_foodfight_score_link_R2.foodID
    WHERE custom_foodfight_matchUp.Round = 2
    GROUP BY custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp
	ORDER BY custom_foodfight_contestants.ID
 </cfquery>

 <cfquery name="getMatchUpsRound2New" datasource="#application.DSN#" >
    SELECT ID,foodName, ScoreRound2
    FROM custom_foodFight_Contestants
    WHERE scoreRound2 != 0
    ORDER BY ID
 </cfquery>
<!---3---> 
  <cfquery name="getMatchUpsRound3" datasource="#application.DSN#" >
    SELECT custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp, count(custom_foodfight_score_link_R3.foodID) as totalVotes
    FROM custom_foodfight_contestants INNER JOIN custom_foodfight_matchUp
    ON custom_foodfight_contestants.ID = custom_foodfight_matchUp.FoodID
    LEFT JOIN custom_foodfight_score_link_R3 ON custom_foodfight_contestants.ID = custom_foodfight_score_link_R3.foodID
    WHERE custom_foodfight_matchUp.Round = 3
    GROUP BY custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp
	ORDER BY custom_foodfight_contestants.ID
 </cfquery>

 <cfquery name="getMatchUpsRound3New" datasource="#application.DSN#" >
    SELECT ID,foodName, ScoreRound3
    FROM custom_foodFight_Contestants
    WHERE scoreRound3 != 0
    ORDER BY ID
 </cfquery>
 <!---4--->
  <cfquery name="getMatchUpsRound4" datasource="#application.DSN#" >
    SELECT custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp, count(custom_foodfight_score_link_R4.foodID) as totalVotes
    FROM custom_foodfight_contestants INNER JOIN custom_foodfight_matchUp
    ON custom_foodfight_contestants.ID = custom_foodfight_matchUp.FoodID
    LEFT JOIN custom_foodfight_score_link_R4 ON custom_foodfight_contestants.ID = custom_foodfight_score_link_R4.foodID
    WHERE custom_foodfight_matchUp.Round = 4
    GROUP BY custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp
	ORDER BY custom_foodfight_contestants.ID
 </cfquery>

 <cfquery name="getMatchUpsRound4New" datasource="#application.DSN#" >
    SELECT ID,foodName, ScoreRound4
    FROM custom_foodFight_Contestants
    WHERE scoreRound4 != 0
    ORDER BY  custom_foodfight_contestants.ID
 </cfquery>
<!---5---> 
  <cfquery name="getMatchUpsRound5" datasource="#application.DSN#" >
    SELECT custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp, count(custom_foodfight_score_link_R5.foodID) as totalVotes
    FROM custom_foodfight_contestants INNER JOIN custom_foodfight_matchUp
    ON custom_foodfight_contestants.ID = custom_foodfight_matchUp.FoodID
    LEFT JOIN custom_foodfight_score_link_R5 ON custom_foodfight_contestants.ID = custom_foodfight_score_link_R5.foodID
    WHERE custom_foodfight_matchUp.Round = 5
    GROUP BY custom_foodfight_contestants.ID,custom_foodfight_contestants.foodName, custom_foodfight_contestants.foodNameLong, 
    custom_foodfight_contestants.foodDescription, custom_foodfight_contestants.state, 
    custom_foodfight_contestants.stateAbbreviation, custom_foodfight_contestants.beerLink, custom_foodfight_contestants.beer,
    custom_foodfight_contestants.division, custom_foodfight_contestants.bracketPosition, custom_foodfight_matchUp.matchUp
	ORDER BY custom_foodfight_contestants.ID
 </cfquery>

 <cfquery name="getMatchUpsRound5New" datasource="#application.DSN#" >
    SELECT ID,foodName, ScoreRound5
    FROM custom_foodFight_Contestants
    WHERE scoreRound5 != 0
    ORDER BY  custom_foodfight_contestants.ID
 </cfquery>
 
 
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<cfset loopcount = 1 />
<cfloop query="getMatchUpsRound1" >
 <cfoutput>
   
   <span <cfif getMatchUpsRound1.totalVotes neq getMatchUpsRound1New.scoreRound1[evaluate(loopcount)] OR getMatchUpsRound1.foodName neq getMatchUpsRound1New.foodName[evaluate(loopcount)]>style="background-color: yellow;"</cfif> >
   #loopcount#))   #getMatchUpsRound1.foodName#:: #getMatchUpsRound1.totalVotes#----------#getMatchUpsRound1New.foodName[evaluate(loopcount)]#:: #getMatchUpsRound1New.scoreRound1[evaluate(loopcount)]#<br />
   <hr />
   </span>
 </cfoutput>
<cfset loopcount = loopcount + 1 />
</cfloop>
<p style="background-color: blue;">Round 2</p>
<!---2--->
<cfset loopcount = 1 />
<cfloop query="getMatchUpsRound2" >
 <cfoutput>
   
   <span <cfif getMatchUpsRound2.totalVotes neq getMatchUpsRound2New.scoreRound2[evaluate(loopcount)] OR getMatchUpsRound2.foodName neq getMatchUpsRound2New.foodName[evaluate(loopcount)]>style="background-color: yellow;"</cfif> >
   #loopcount#))   #getMatchUpsRound2.foodName#:: #getMatchUpsRound2.totalVotes#----------#getMatchUpsRound2New.foodName[evaluate(loopcount)]#:: #getMatchUpsRound2New.scoreRound2[evaluate(loopcount)]#<br />
   <hr />
   </span>
 </cfoutput>
<cfset loopcount = loopcount + 1 />
</cfloop>

<p style="background-color: blue;">Round 3</p>
<!---3--->
<cfset loopcount = 1 />
<cfloop query="getMatchUpsRound3" >
 <cfoutput>
   
   <span <cfif getMatchUpsRound3.totalVotes neq getMatchUpsRound3New.scoreRound3[evaluate(loopcount)] OR getMatchUpsRound3.foodName neq getMatchUpsRound3New.foodName[evaluate(loopcount)]>style="background-color: yellow;"</cfif> >
   #loopcount#))   #getMatchUpsRound3.foodName#:: #getMatchUpsRound3.totalVotes#----------#getMatchUpsRound3New.foodName[evaluate(loopcount)]#:: #getMatchUpsRound3New.scoreRound3[evaluate(loopcount)]#<br />
   <hr />
   </span>
 </cfoutput>
<cfset loopcount = loopcount + 1 />
</cfloop>

<p style="background-color: blue;">Round 4</p>
<!---4--->
<cfset loopcount = 1 />
<cfloop query="getMatchUpsRound4" >
 <cfoutput>
   
   <span <cfif getMatchUpsRound4.totalVotes neq getMatchUpsRound4New.scoreRound4[evaluate(loopcount)] OR getMatchUpsRound4.foodName neq getMatchUpsRound4New.foodName[evaluate(loopcount)]>style="background-color: yellow;"</cfif> >
   #loopcount#))   #getMatchUpsRound4.foodName#:: #getMatchUpsRound4.totalVotes#----------#getMatchUpsRound4New.foodName[evaluate(loopcount)]#:: #getMatchUpsRound4New.scoreRound4[evaluate(loopcount)]#<br />
   <hr />
   </span>
 </cfoutput>
<cfset loopcount = loopcount + 1 />
</cfloop>

<p style="background-color: blue;">Round 5</p>
<!---5--->
<cfset loopcount = 1 />
<cfloop query="getMatchUpsRound5" >
 <cfoutput>
   
   <span <cfif getMatchUpsRound5.totalVotes neq getMatchUpsRound5New.scoreRound5[evaluate(loopcount)] OR getMatchUpsRound5.foodName neq getMatchUpsRound5New.foodName[evaluate(loopcount)]>style="background-color: yellow;"</cfif> >
   #loopcount#))   #getMatchUpsRound5.foodName#:: #getMatchUpsRound5.totalVotes#----------#getMatchUpsRound5New.foodName[evaluate(loopcount)]#:: #getMatchUpsRound5New.scoreRound5[evaluate(loopcount)]#<br />
   <hr />
   </span>
 </cfoutput>
<cfset loopcount = loopcount + 1 />
</cfloop>
<!---<cfdump var="#getMatchUpsRound2New#">
<cfdump var="#getMatchUpsRound2#">--->

</body>
</html>