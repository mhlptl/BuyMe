<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Account</title>
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
		String first = request.getParameter("firstName");
		String email = request.getParameter("email");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		String delete;
		if(first.contains(" ")) {
			out.println("Invalid input. Delete Failed.");
		}
		else if(!first.isEmpty() && !email.isEmpty()) {
			delete = "DELETE FROM custRep WHERE firstName = ? AND email = ?";
			PreparedStatement ps = con.prepareStatement(delete);
			ps.setString(1, first);
			ps.setString(2, email);
			int x = ps.executeUpdate();
			con.close();
			if(x > 0) {
				out.println("Customer Representative Deleted.");
			}
			else {
				out.println("Delete Failed.");
			}
		}
		else{
			delete = "DELETE FROM custRep WHERE email = ?";
			PreparedStatement ps = con.prepareStatement(delete);
			ps.setString(1, email);
			int x = ps.executeUpdate();
			con.close();
			if(x > 0) {
				out.println("Customer Representative Deleted.");
			}
			else {
				out.println("Delete Failed.");
			}
		}
	} catch (Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>