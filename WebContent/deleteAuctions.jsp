<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Auction</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
<%
	if(session.getAttribute("email") == null) {
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
		Statement st = con.createStatement();;
		PreparedStatement ps = con.prepareStatement("DELETE FROM auction WHERE auctionID = ?");
		ps.setString(1, request.getParameter("auctionID"));
		int x = ps.executeUpdate();
		if(x > 0) {
			out.println("Auction Deleted.");	
		}
		else {
			out.println("Delete Failed.");
		}
		con.close();
	} catch (Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>