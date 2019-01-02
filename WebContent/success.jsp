<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error</title>
</head>
<body>
<%
	if((session.getAttribute("email") == null)) {
%>
	You are not logged in<br/>
	<a href="index.jsp">Please Login</a>
<%
	} else {
%>
	<%response.sendRedirect("underConstruction.jsp");%>
<%
	}
%>
</body>
</html>