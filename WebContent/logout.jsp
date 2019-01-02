<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logout</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
<%
	session.invalidate();
%>
	<a href="index.jsp">Please login again</a>
</body>
</html>