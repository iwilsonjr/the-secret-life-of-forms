<cfparam name="userIP" default="">
<cfset userIP = cgi.remote_addr />
<cfset todaysDate = createODBCDateTime(now()) />
<cfset noVoteFoodIDList = "" />
<cfset voteLimit = 1000 />
<!---<cfif FindNoCase("rollcalltasteofamerica.com", cgi.HTTP_REFERER) EQ 0 OR userIP EQ "143.231.249.141" OR userIP EQ "156.33.241.4" >
  <cflocation url="machineVote.cfm" addtoken="no" /> 
</cfif>--->
<cflock type="exclusive" scope="session" timeout="30" >
 <cfif isDefined('form.ukey') ><!--- in case validation fails and empty form is submitted or page hit directly --->
  <cfif StructKeyExists(session, "ukey")>  
	<cfif session.ukey eq #form.ukey#&"#request.keySuffix#"> 
        <cftry><!---first insert records in db as an audit trail, then increment score below--->
         <cftransaction>
          <cfloop list="#form.fieldnames#" index="i">
           <cfif Isnumeric(#evaluate('form.' & i)#) AND i neq "ukey" > <!--- remove unneeded text fields & prevent ukey from being inserted as score result --->
            <cfset currentLoopFormValue = evaluate('form.' & i) />
            <cfquery name="checkVoteLimit" datasource="#application.DSN#">
             SELECT count(id) as totalVotes
             FROM custom_foodfight_score_link_R#trim(request.currentRound)#
             WHERE foodID = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentLoopFormValue#">
             AND ipAddress= <cfqueryparam cfsqltype="cf_sql_varchar" value="#userIP#">            
             AND DateDiff(dd, dateStamp, #parseDateTime(todaysDate)#) = 0
            </cfquery>
            <cfif checkVoteLimit.totalVotes GTE voteLimit>
             <cfset noVoteFoodIDList = listAppend(noVoteFoodIDList,currentLoopFormValue) />
            </cfif>
           </cfif>
          </cfloop>         
         
          <cfquery name="insertScoreTallies" datasource="#application.DSN#" >
           <cfloop list="#form.fieldnames#" index="i">
            <cfif Isnumeric(#evaluate('form.' & i)#) AND i neq "ukey" > <!--- remove unneeded text fields & prevent ukey from being inserted as score result --->
            <cfset currentLoopFormValue = evaluate('form.' & i) />
            <cfif listFind(noVoteFoodIDList,currentLoopFormValue) EQ 0> <!--- if the user has not reached the voting limit for that food item --->
            INSERT INTO custom_foodfight_score_link_R#trim(request.currentRound)# (foodID, Round, ukey, ipAddress)
            VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#currentLoopFormValue#">, <cfqueryparam cfsqltype="cf_sql_integer" value="#request.currentRound#">, <cfqueryparam cfsqltype="cf_sql_integer" value="#form.ukey#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#userIP#">)
            
            <!---increment round score for each contestant--->
            UPDATE custom_foodfight_contestants
            SET scoreRound#request.currentRound# = (scoreRound#request.currentRound# + 1)
            WHERE ID = #currentLoopFormValue#
            </cfif>
            </cfif>
           </cfloop>
           <!--- added this to ensure no errors if all foodIDs had reached limit --->
           select top 1 id
           from custom_foodfight_contestants
           where id = <cfqueryparam cfsqltype="cf_sql_integer" value="-1">
         </cfquery>
        </cftransaction>
        
        <!---kill the security session--->
		<cfif StructKeyExists(session, "ukey")>  
        <cfset rc = StructDelete(session, "ukey", "True")>  
        </cfif>
        <!---wipe out any session cookies just to be sure--->
        <!---<cfcookie name="CFID" value="" expires="NOW" /> 
        <cfcookie name="CFTOKEN" value="" expires="NOW" />--->
    
        <cfcatch type="any">An error occurred.</cfcatch>
        </cftry>
    <cfelse>Your vote did not come through the form and therefore will be disallowed.
    </cfif>
  </cfif>
</cfif>
</cflock>
success