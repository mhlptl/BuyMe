<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrator Login</title>
</head>
<body>
<%
	if(request.getParameter("adminID") == null) {
		response.sendRedirect("success.jsp");
	}
	String admin = request.getParameter("adminID");
	String pwd = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("SELECT * FROM admin WHERE adminID='" + admin + "' and password='" + pwd + "'");
	if (rs.next()) {
		session.setAttribute("adminID", admin); // the username will be stored in the session
		response.sendRedirect("home_admin.jsp");
	}
	else {
		out.println("Invalid password <a href='index.jsp'>try again</a>");
	}
%>
</body>
</html>