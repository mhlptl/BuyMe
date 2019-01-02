<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alerts</title>
</head>
<body>
<%
	try {
		String x= request.getParameter("alerts");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		String insert = "INSERT INTO alerts_help (userID, sort) VALUES ('" + session.getAttribute("email") +"','" + x + "')";
		st.execute(insert);
		con.close();
		out.println("<a href='home_buyers.jsp'>Home</a>");
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>