<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Login</title>
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
	rs = st.executeQuery("SELECT * FROM custRep WHERE email='" + email + "' and password='" + pwd + "'");
	if (rs.next()) {
		session.setAttribute("email", email); // the username will be stored in the session
		response.sendRedirect("home_employees.jsp");
	}
	else {
		out.println("Invalid password <a href='index.jsp'>try again</a>");
	}
%>
</body>
</html>