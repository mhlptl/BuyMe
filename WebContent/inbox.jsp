<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inbox</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
<%
	if(session.getAttribute("email") == null) {
		response.sendRedirect("success.jsp");
	}
%>
	<ul>
		<li><a onclick="back();">Back</a></li>
		<li><a href="payment.jsp">Payment</a></li>
		<li><a href="delete_inbox.jsp">Clear Inbox</a></li>
		<li><a href="email.jsp">Email</a></li>
	</ul>
	<br/>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM alerts WHERE userID = '" +session.getAttribute("email") + "' ORDER BY status DESC");
		//Make an HTML table to show the results in
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>Alert ID</th>");
				out.print("<th>Body</th>");
				out.print("<th>Status</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("alertID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("outbid"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("status"));
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