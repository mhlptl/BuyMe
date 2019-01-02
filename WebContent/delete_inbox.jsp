<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Inbox</title>
</head>
<body>
<%
	if(session.getAttribute("email") == null) {
		response.sendRedirect("success.jsp");
	}
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();;
		PreparedStatement ps = con.prepareStatement("DELETE FROM alerts WHERE userID = ?");
		ps.setString(1, session.getAttribute("email").toString());
		int x = ps.executeUpdate();
		response.sendRedirect("inbox.jsp");
		con.close();
	} catch (Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>