<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validate</title>
</head>
<body>
<%
	if(session.getAttribute("email") == null){
		response.sendRedirect("success.jsp");
	}
	else {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs=st.executeQuery("SELECT * FROM buyers WHERE buyerID='" + session.getAttribute("email") + "'");
		if(rs.next()) {
			response.sendRedirect("home_buyers.jsp");
		}
		else {
			response.sendRedirect("home_sellers.jsp");
		}
	}
%>
</body>
</html>