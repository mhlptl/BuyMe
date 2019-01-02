<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Login</title>
</head>
<body>
<%
	if(request.getParameter("email") == null) {
		response.sendRedirect("success.jsp");
	}
	String email = request.getParameter("email");
	String pwd = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("SELECT * FROM users WHERE email='" + email + "' and password='" + pwd + "'");
	if(rs.next()) {
		session.setAttribute("email", email);
		rs=st.executeQuery("SELECT * FROM buyers WHERE buyerID='" + email + "'");
		if(rs.next()) {
			response.sendRedirect("home_buyers.jsp");
		}
		else {
			response.sendRedirect("home_sellers.jsp");
		}
	}
	else {
		out.println("Invalid password <a href='index.jsp'>try again</a>");
	}
%>
</body>
</html>