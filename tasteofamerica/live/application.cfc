<cfcomponent displayname="Application" output="true" hint="The Application.cfc">
 <cfset this.name = "foodFightstaging" />
 <cfset this.sessionmanagement = true />
 <cfset this.sessiontimeout = CreateTimeSpan(0,0,10,0) />   
  
 <cffunction name="onApplicationStart" returnType="void" output="false" hint="Executes code once when the start application request is triggered.">
  <cfset application.DSN = 'FoodFightStaging' />
  <cfset application.urlSQLKeywords="declare,set,exec,select,grant,delete,insert,drop,alter,replace,truncate,update,create,rename,describe,from,into,table,view,union,cast,char" />		
  <cfset application.formSQLKeywords="declare,set,exec,grant,cast" />
  
 </cffunction>

 <cffunction name="onApplicationEnd" access="public" returntype="void" output="false" hint="fires when the application is terminated.">
  <cfargument name="applicationScope" type="struct" required="false" default="#structNew()#" />  
 </cffunction>
 
 <cffunction name="onSessionStart" access="public" returntype="void" output="false" hint="Executes when the session is first created.">	
  <cfreturn />
 </cffunction>
 
 <cffunction name="onSessionEnd" access="public" returntype="void" output="false" hint="fires when the session is terminated.">
  <cfargument name="sessionScope" type="struct" required="true" />
  <cfargument name="applicationScope" type="struct" required="false" default="#structNew()#" />
  <cfreturn />
 </cffunction>
 
 <cffunction name="onRequest" returnType="void">
  <cfargument name="targetPage" type="string" required="true">      
  <cfinclude template="#arguments.targetPage#">
 </cffunction>
 
 <cffunction name="onRequestStart" returnType="any" output="true" hint="Executes at first part of page processing.">   
  <cfargument name="TargetPage" type="string" required="true" />
  <cfargument name="queryString" type="string" required="false" default="#cgi.query_string#" />  
  <cfargument name="pageReferer" type="string" required="false" default="#cgi.http_referer#" />     
  <cfset var keywordMatch = 0 />  
  <cfset var result = "true" />
  <cfset initRequestVariables() /> 
  
   <!--- Application Form XSS/SQL Injection protection---> 
 <!--- <cfif IsStruct(FORM)>  
   <cfset FORM = sanitizeData(dataCollection=FORM,dataCollectionType='form') />  
  </cfif>--->
  
  <!--- Application URL XSS/SQL Injection protection--->
 <!--- <cfif IsStruct(URL)>   
   <cfset URL = sanitizeData(dataCollection=URL,dataCollectionType='url') />      
  </cfif> --->
  
  
  <!--- URL SQL INJECTION Protection --->
  <!---<cfif arguments.queryString NEQ "">
   <cfloop list="#application.urlSQLKeywords#" index="sqlKeyword">
    <cfif findNoCase(sqlKeyword, arguments.queryString, 1) NEQ 0>
	 <cfset keywordMatch = incrementValue(keywordMatch) />
	 <cfif keywordMatch GT 3>
	  <cfthrow type="request_denied" message="URL (GET) Request Denied" detail="Request:  #cgi.script_name#?#arguments.queryString#" extendedinfo="Client Address: #cgi.REMOTE_ADDR#" errorCode = "1">	  
	 </cfif>
	</cfif>
   </cfloop>  
  </cfif> --->
  <!--- URL SQL INJECTION Protection --->
  
  <!--- FORM SQL INJECTION Protection --->
 <!--- <cfif IsStruct(FORM)>
   <cfloop list="#structKeyList(FORM)#" index="formField">
	<cfif ListFind(application.formSQLKeywords, evaluate("form.#formField#")) NEQ 0>
	 <cfset keywordMatch = incrementValue(keywordMatch) />
	 <cfif keywordMatch GT 3>
	  <cfthrow type="request_denied" message="URL (POST) Request Denied" detail="Request:  #cgi.script_name#?#arguments.queryString#" extendedinfo="Client Address: #cgi.REMOTE_ADDR#" errorCode = "1"> 
	 </cfif>
	</cfif>
   </cfloop>     
  </cfif>--->
  <!--- FORM SQL INJECTION Protection ---> 
  
  <cfreturn result />
 </cffunction>
 
 <cffunction name="onRequestEnd" returnType="void" output="false" hint="Executes after the page processing is complete.">  
 </cffunction>


 <!---request vars--->
 
 <cffunction name="initRequestVariables" returnType="void" output="false" hint="Initializes all request variables">  

  <cfset request.keySuffix = "_iencl22saidillse" />    <!---additional security suffix added to ukey 5-30-12 jn--->

  <!---set round dates--->   
  <cfset currentMoment = now() />  <!---use for calculations below--->
  <cfset request.currentMoment = currentMoment />   <!---set for brackets.cfm page--->
  
  <!---Early Voting (64) - Added 4/23/14--->
  <cfset roundZeroStart = createdatetime(2014,5,7,9,0,0) />
  <cfset request.roundZeroEnd = createdatetime(2014,5,9,17,0,0) /> <!---put in request scope for use on brackets page--->

  <!---Round 1 (64) CreateDateTime(year, month, day, hour, minute, second) --->
  <cfset roundOneStart = createdatetime(2015,5,4,9,0,0) />
  <cfset request.roundOneEnd = createdatetime(2015,5,8,17,0,0) /> <!---put in request scope for use on brackets page--->
    
  <!---Round 2 (32)--->    
  <cfset roundTwoStart = createdatetime(2015,5,11,9,0,0) />
  <cfset request.roundTwoEnd = createdatetime(2015,5,15,17,0,0) /> <!---put in request scope for use on brackets page--->
  
  <!---Round 3 (16)--->  
  <cfset roundThreeStart = createdatetime(2015,5,18,9,0,0) />
  <cfset request.roundThreeEnd = createdatetime(2015,5,29,5,0,0) /> <!---put in request scope for use on brackets page--->
    
  <!---Round 4 - Final Round (8)--->    
  <cfset roundFourStart = createdatetime(2015,6,1,9,0,0) />
  <cfset gameEndDate = createdatetime(2015,6,5,17,0,0) /> <!---put in request scope for use on brackets page--->
  
  
  <!---set round triggers--->
  <cfset request.currentRound = 0 />
  <cfif currentMoment gt roundZeroStart><cfset request.currentRound = 1 /> </cfif> <!---Added 4/23/14---> 
  <cfif currentMoment gt roundOneStart><cfset request.currentRound = 1 /> </cfif>
  <cfif currentMoment gt roundTwoStart><cfset request.currentRound = 2 /> </cfif>
  <cfif currentMoment gt roundThreeStart><cfset request.currentRound = 3 /> </cfif>
  <cfif currentMoment gt roundFourStart><cfset request.currentRound = 4 /> </cfif>
  <cfif currentMoment gt gameEndDate><cfset request.currentRound = 5 /> </cfif>
 
  
  
  <!---tell if voting is currently live in order to show/hide vote button--->  
  <cfset request.isLive = 0 > 
  <cfif currentMoment gt roundZeroStart AND currentMoment lt request.roundZeroEnd > <cfset request.isLive = 1 > </cfif> <!---Added 4/23/14--->  
  <cfif currentMoment gt roundOneStart AND currentMoment lt request.roundOneEnd > <cfset request.isLive = 1 > </cfif>
  <cfif currentMoment gt roundTwoStart AND currentMoment lt request.roundTwoEnd > <cfset request.isLive = 1 > </cfif>
  <cfif currentMoment gt roundThreeStart AND currentMoment lt request.roundThreeEnd > <cfset request.isLive = 1 > </cfif>
  <cfif currentMoment gt roundFourStart AND currentMoment lt gameEndDate > <cfset request.isLive = 1 > </cfif>
  
 </cffunction>  

 
 <cffunction name="onError" returnType="void" output="true" hint="Handles uncaught exceptions that occur in the application.">
  <cfargument name="Exception" required="true" />
  <cfargument name="EventName" type="String" required="true" />
  <cfset var logFileRoot = "c:\inetpub\wwwroot\rollcalltasteofamerica_staging\logs\" />
  <cfset var logFile = logFileRoot&"errorLog.html" />
  <cfset var logFileArchive = logFileRoot&"log_archive_"&dateFormat(now(),"mmddyyyy")&timeFormat(now(),"hhmmss")&".html" />    
  <cfsavecontent variable="errorContent">
   #dateFormat(now(),"mm-dd-yyyy")# #timeFormat(now(),"h:mm:ss tt")#<hr /> 
   <cfdump var="#Arguments.Exception#" />
   <hr />
  </cfsavecontent> 
  <cfif fileExists(logFile)> 
   <cfset logFileSize = ((getFileInfo(logFile).size/1000)/1000) />  
   <cfif logFileSize GTE 3>
    <cffile action="rename" source="#logFile#" destination="#logFileArchive#" />
    <cffile action="write" file="#logFile#" addnewline="no" output="#errorContent#" />
   <cfelse> 
    <cffile action="append" file="#logFile#" addnewline="no" output="#errorContent#" />
   </cfif>   
  <cfelse>
   <cffile action="write" file="#logFile#" addnewline="no" output="#errorContent#" />
  </cfif> 
  <cflocation url="/error/error.html" addtoken="no" />
 </cffunction>
 
 <cffunction name="sanitizeData" returnType="struct" output="false" hint="" access="private"> 
  <cfargument name="dataCollection" type="struct" required="no" />
  <cfargument name="dataCollectionType" type="string" required="no" default="form" />      
  <cfset var badTags = "SCRIPT,OBJECT,APPLET,EMBED,FORM,LAYER,ILAYER,FRAME,IFRAME,FRAMESET,PARAM,META,HTML,BODY,HEAD" />
  <cfset var badEvents = "onLoad,onClick,onDblClick,onKeyDown,onKeyPress,onKeyUp,onMouseDown,onMouseOut,onMouseUp,onMouseOver,onBlur,onChange,onFocus,onSelect,javascript:" />
  <cfset var formBadChars = '|,&amp;,;,$,%,",\'',\",&gt;,&lt;,(,),+,\,<,>,=,&,--' />
  <cfset var urlBadChars = '|,&amp;,;,%,",\'',\",&gt;,&lt;,(,),+,\,<,>,=,&,'',@,--' />
  <cfset var badChars = "" />
  <cfset var stripperRE = "" />
  <cfset var theText = "" />
  <cfset var badTag = "" />
  <cfset var nextStart = "" />
  <cfif arguments.dataCollectionType EQ "url">
   <cfset badChars = urlBadChars />
  <cfelse>
   <cfset badChars = formBadChars /> 
  </cfif>
  <cfloop collection="#arguments.dataCollection#" item="fieldname">   
   <cfset theText = trim(arguments.dataCollection[fieldname]) /> 
   <cfset stripperRE = "</?(" & listChangeDelims(badTags,"|") & ")[^>]*>" />
   <cfset theText = replaceList(theText,chr(8216) & "," & chr(8217) & "," & chr(8220) & "," & chr(8221) & "," & chr(8212) & "," & chr(8213) & "," & chr(8230),"',',"","",--,--,...") />
   <cfset theText = REReplaceNoCase(theText,stripperRE,"","ALL") />		
   <cfset theText = REReplaceNoCase(theText,'(#ListChangeDelims(badEvents,"|")#)[^ >]*',"","ALL") />
   <cfset theText = replaceList(theText,badChars,"") />
   <cfset arguments.dataCollection[fieldname] = theText />          
  </cfloop>
  <cfreturn arguments.dataCollection />  
 </cffunction>
 
</cfcomponent>	
