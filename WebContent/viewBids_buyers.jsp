<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bids</title>
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
	</ul>
	<br/>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM bid WHERE buyerID = '" + session.getAttribute("email") + "'");
		//Make an HTML table to show the results in
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>AuctionID</th>");
				out.print("<th>bidID</th>");
				out.print("<th>Bid</th>");
				out.print("<th>New Price</th>");
				out.print("<th>Time Placed</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("auctionID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("bidID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("amount"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("newPrice"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("timePlaced"));
					out.print("</td>");
				out.print("</tr>");
			}
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
%>
</body>
</html>