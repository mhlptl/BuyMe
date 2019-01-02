<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ask a Question</title>
</head>
<body>
<%
	if(session.getAttribute("email") == null){
		response.sendRedirect("success.jsp");
	}
	try {
		String quest = request.getParameter("question");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		quest = request.getParameter("question");
		String insert = "INSERT INTO questions(question) VALUES (?)";
		int x = 0;
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, quest);
		x = ps.executeUpdate();
		if(x > 0) {
			out.println("Success!<br/>");
		}
		else {
			out.println("Failed.<br/>");
		}
		con.close();
	} catch (Exception ex) {
		out.println(ex);
		out.println("<br/>Failed.<br/>");
	}
%>
	<a href="validate.jsp">Home</a>
</body>
</html>