<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
	String etunimi = request.getParameter("etunimi");
	out.print("Nimi on " + etunimi + "<br>");
	String ikaStr = request.getParameter("ika");
	out.print("Ikä on " + ikaStr + "<br>");
	int vuosiPois = Integer.parseInt(ikaStr)-1;
	out.print("Ikä miinus yksi vuosi on " + vuosiPois);
%>
<br>
<span id="etunimi"></span><br>
<span id="ika"></span>
<script>
$(document).ready(function(){
	var etunimi = requestURLParam("etunimi");
	$("#etunimi").text("Nimi on " + etunimi);
	$("#ika").text("Ikä on " + requestURLParam("ika"));
});
</script>
</body>
</html>