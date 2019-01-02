<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Email</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
	<ul>
		<li><a onclick="back();">Back</a></li>
	</ul>
	<br/>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM EMAIL WHERE to_ = '" +session.getAttribute("email") + "'");
		//Make an HTML table to show the results in
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>From</th>");
				out.print("<th>Date</th>");
				out.print("<th>Subject</th>");
				out.print("<th>Content</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("from_"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("date_time"));
					out.print("</td>");
					out.print("<td>");
					out.print(rs.getString("subject"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("content"));
					out.print("</td>");
				out.print("</tr>");
			}
		out.print("</table>");
		st.execute("UPDATE alerts SET status = 'read' WHERE status = 'unread' AND userID = '" + session.getAttribute("email") + "'");
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
%>
</body>
</html>