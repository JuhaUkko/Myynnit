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
	String sukunimi = request.getParameter("sukunimi");
	String sposti = request.getParameter("sposti");
	String puhelin = request.getParameter("puhelin");
	String vuosiStr = request.getParameter("vuosi");
	int year = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
	int ikaTarkastus = year - Integer.parseInt(vuosiStr);
	if(ikaTarkastus <= 17){
		out.print("Alaikäinen");
		response.sendRedirect("kysy.jsp");		
	}else{
	out.print("Etunimi on " + etunimi + "<br>" + "Sukunimi on " + sukunimi + "<br>" + "Sähköposti on " + sposti + "<br>" + "Puhelin on " + puhelin + "<br>" + "Syntymävuosi on " + vuosiStr);
	}
%>
</body>
</html>