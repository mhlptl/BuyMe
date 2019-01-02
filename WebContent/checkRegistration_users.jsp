<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Registration</title>
</head>
<body>
<%
	if(request.getParameter("email") == null) {
		response.sendRedirect("success.jsp");
	}
	try {
		String first = request.getParameter("firstName");
		String last = request.getParameter("lastName");
		String email = request.getParameter("email");
		String pwd = request.getParameter("password");
		String type = request.getParameter("accountType");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		String newFirst = request.getParameter("firstName");
		String newLast = request.getParameter("lastName");
		String newEmail = request.getParameter("email");
		String newPwd = request.getParameter("password");
		String newType = request.getParameter("accountType");
		String insert = "INSERT INTO users(firstName, lastName, email, password) VALUES (?, ?, ?, ?)";
		String insertType = "INSERT INTO " + newType +"s("+ newType +"ID) VALUES(?)";
		if(newFirst.contains(" ") || newLast.contains(" ") || newPwd.contains(" ")) {
			out.print("You are missing fields. Please register again.<br/>");
			out.print("<a href='index.jsp'>Click here to register</a>");
			return;
		}
		else {
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, newFirst);
			ps.setString(2, newLast);
			ps.setString(3, newEmail);
			ps.setString(4, newPwd);
			ps.executeUpdate();
			ps = con.prepareStatement(insertType);
			ps.setString(1, newEmail);
			ps.executeUpdate();
			con.close();
			out.println("Thank you for registering with BuyMe!");
		}
		out.println("<a href='index.jsp'>Please Login</a>");
	}
	catch (Exception ex) {
		out.println(ex);
		out.println("<br/>Registration Failed<br/>");
	}
%>
</body>
</html>