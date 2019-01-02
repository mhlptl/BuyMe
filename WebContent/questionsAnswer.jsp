<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer a Question</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
<%
	if(session.getAttribute("email") == null){
		response.sendRedirect("success.jsp");
	}
%>

	<ul>
		<li><a onclick="back();">Back</a><li>
	</ul>

	<div style="margin:auto; width:40%;">
		<form action="postAnswers.jsp" method="POST">
			<fieldset class="answers">
				<legend>Answer Question</legend>
				<input class="form_fields" type="text" name="aID" placeholder="Question ID"/><br/>
				<textarea class="form_fields" name="answer" rows="3" cols="60" maxlength="255" placeholder="Your Answer Here."></textarea><br/>
				<input type="submit" value="Submit"/>
				<input type="reset"><br/>
			</fieldset>
		</form>
	</div>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM questions WHERE result <> 'Answered'");
		//Make an HTML table to show the results in
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>QuestionID</th>");
				out.print("<th>Question</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("qID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("question"));
					out.print("</td>");
				out.print("</tr>");
			}
		out.print("</table>");
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
%>
</body>
</html>