<cfif isDefined('form') >
 <cftry>
  <cfquery name="insertSendToFriend" datasource="#application.DSN#" >
  	INSERT INTO custom_foodfight_send_to_friend (senderEmail, friendsEmail)  
    VALUES (<cfqueryparam value="#trim(form['yourEmail'])#" cfsqltype="CF_SQL_VARCHAR" />, <cfqueryparam value="#trim(form['friendsEmail'])#" cfsqltype="CF_SQL_VARCHAR" />) 
  </cfquery>
 
     <cfmail from="#form.yourEmail#" to="#form.friendsEmail#" subject="Your Friend Wants You to Vote at Roll Call’s A Taste of America!" type="html" >
    
    <p>Vote with Your Taste Buds!</p>
     
    <p>Support your State by joining Roll Call and Chef Spike Mendelsohn in choosing your favorite regional cuisine. 
    <a href="http://www.rollcalltasteofamerica.com">Click here</a> to vote NOW in Roll Call’s A Taste of America.</p>
     
    <p>Forward to your friends for a chance to win two tickets for the final four reception on 6/21 at We, The Pizza.</p>
     
    <p>Thanks!</p>
     
    <p>The CQ Roll Call Team and Chef Spike Mendelsohn</p>
    </cfmail>
 <cfcatch type="any">An error occoured.</cfcatch>
</cftry>
<cfelse>success
</cfif>