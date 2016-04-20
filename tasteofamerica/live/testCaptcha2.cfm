<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
</head>

<body>
<cfdump var="#FORM#" />


 <cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="POST" charset="utf-8">   
   <cfhttpparam type="HEADER" name="Cache-Control" value="no-cache">
   <cfhttpparam type="HEADER" name="Pragma" value="no-cache">      
   <!---<cfhttpparam type="HEADER" name="Content-Type" value="application/json">   --->
   <cfhttpparam type="formfield" name="secret" value="6LcEAQYTAAAAAD3Ldg-iRmve2iyE60DwgJRqAm6l" />
   <cfhttpparam type="formfield" name="response" value="#form['G-RECAPTCHA-RESPONSE']#" />
   <cfhttpparam type="formfield" name="remoteip" value="#cgi.REMOTE_ADDR#" />
   
   
       
  </cfhttp> 
  
  
  <cfdump var="#cfhttp#" />


</body>
</html>
