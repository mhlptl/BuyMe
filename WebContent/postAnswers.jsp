<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer a Question</title>
</head>
<body>
<%
	if(session.getAttribute("email") == null){
		response.sendRedirect("success.jsp");
	}
	try {
		String aID = request.getParameter("aID");
		String ans = request.getParameter("answer");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		aID = request.getParameter("aID");
		ans = request.getParameter("answer");
		String insert = "INSERT INTO answers(aID, answer) VALUES (?, ?)";
		int x = 0;
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, aID);
		ps.setString(2, ans);
		x = ps.executeUpdate();
		if(x > 0) {
			insert = "UPDATE questions SET result = 'Answered' WHERE qID = ?";
			ps = con.prepareStatement(insert);
			ps.setString(1, aID);
			x = ps.executeUpdate();
			if(x > 0) {
				out.println("Success!<br/>");
			}
			else {
				out.println("Failed.<br/>");
			}
		}
		else {
			out.println("Failed.<br/>");
		}
		con.close();
		out.println("<a href='questionsAnswer.jsp'>Answer More Questions</a><br/>");
	} catch (Exception ex) {
		out.println(ex);
		out.println("<br/>Failed.<br/>");
	}
%>
	<a href="home_employees.jsp">Home</a>
</body>
</html>