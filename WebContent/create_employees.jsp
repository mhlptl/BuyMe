<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Account</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
<%
	if(session.getAttribute("adminID") == null) {
		response.sendRedirect("success.jsp");
	}
%>
	<ul>
		<li><a onclick="back();">Back</a><li>
	</ul>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		String insert = "INSERT INTO custRep(firstName, email) VALUES (?, ?)";
		if(request.getParameter("firstName").contains(" ")) {
			out.println("Invalid. Please create account again.");
		}
		else {
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, request.getParameter("firstName"));
			ps.setString(2, request.getParameter("email"));
			ps.executeUpdate();
			out.println("Employee Created!");
		}
		con.close();
	} catch (Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>