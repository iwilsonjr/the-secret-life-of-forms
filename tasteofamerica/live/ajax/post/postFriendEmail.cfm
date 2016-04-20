<cfif isDefined('form') >
 <cftry>
  <cfquery name="insertSendToFriend" datasource="#application.DSN#" >
  	INSERT INTO custom_foodfight_send_to_friend (senderEmail, friendsEmail)  
    VALUES (<cfqueryparam value="#trim(form['yourEmail'])#" cfsqltype="CF_SQL_VARCHAR" />, <cfqueryparam value="#trim(form['friendsEmail'])#" cfsqltype="CF_SQL_VARCHAR" />) 
  </cfquery>
 
     <cfmail from="#form.yourEmail#" to="#form.friendsEmail#" subject="Your Friend Wants You to Vote at CQ Roll Call's Taste of America" type="html" >
    
    <p>Your Friend, #form.yourEmail#, wants you to vote with your taste buds!</p>
     
    <p>Support your state by joining CQ Roll Call in choosing your favorite regional cuisine.  <a href="http://www.rollcalltasteofamerica.com">Click here</a> to vote NOW in CQ Roll Call's A Taste of America.</p>  
     
    <p>Thank you for participating in Roll Call's Taste of America. Share with your friends for a chance to win two tickets to the Elite Eight Reception at Nationals Park immediately prior to Congressional Baseball Game.</p>
     
    <p>Thanks!</p>
     
    <p>The CQ Roll Call Team</p>
    </cfmail>
 <cfcatch type="any">An error occoured.</cfcatch>
</cftry>
<cfelse>success
</cfif>