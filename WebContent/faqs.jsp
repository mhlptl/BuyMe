<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FAQS</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>

	<header class="header">
		<h1>Frequently Asked Questions</h1>
	</header>
	
	<ul>
		<li><a onclick="back();">Back</a><li>
	</ul>
	
	<div id="search_FAQs" style="margin:auto; width:50%;">
		<form method="POST">
			<fieldset>
				<legend>Search</legend>
				<input class="form_fields" type="text" name="question" placeholder="Question"/>
				<input class="form_fields" type="text" name="answer" placeholder="Answer"/>
				<input type="submit" value="Search!"/>
				<input type="reset"/><br/>
				*Clicking 'Search!' with both fields empty will reset the table back to normal.
			</fieldset>
		</form>
	</div>
	<br/>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM questions JOIN answers ON questions.qID = answers.aID");
		if(request.getParameter("question") == null && request.getParameter("answer") == null) {
			rs = st.executeQuery("SELECT * FROM questions JOIN answers ON questions.qID = answers.aID");
		}
		else if(request.getParameter("question").isEmpty() && request.getParameter("answer").isEmpty()) {
			rs = st.executeQuery("SELECT * FROM questions JOIN answers ON questions.qID = answers.aID");
		}
		else if(request.getParameter("answer").isEmpty()) {
			rs = st.executeQuery("SELECT * FROM questions JOIN answers ON questions.qID = answers.aID WHERE " +
				"question like '%" + request.getParameter("question") + "%'");
		}
		else if(request.getParameter("question").isEmpty()) {
			rs = st.executeQuery("SELECT * FROM questions JOIN answers ON questions.qID = answers.aID WHERE " +
				"answer like '%" + request.getParameter("answer") + "%'");
		}
		else {
			rs = st.executeQuery("SELECT * FROM questions JOIN answers ON questions.qID = answers.aID WHERE " +
				"question like '%" + request.getParameter("question") + "%' OR answer like '%" + request.getParameter("answer") + "%'");
		}
		//Make an HTML table to show the results in
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>Questions</th>");
				out.print("<th>Answers</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("question"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("answer"));
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