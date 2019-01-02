<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
<style>
caption {
	font-size: 20px;
	padding: 5px;
	background-color: #2F4F4F;
	color: white;
}
</style>
</head>
<body>
<%
	if(session.getAttribute("adminID") == null) {
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
		
		//best selling by title
		rs = st.executeQuery("SELECT title, COUNT(*) FROM pays JOIN items on pays.auctionID = items.auctionID " + 
			"GROUP BY title HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC");
		//create table
		out.print("<table style='width:100%'>");
		out.print("<caption>Best Selling Items</caption>");
		out.print("<tr>");
			out.print("<th>Title</th>");
			out.print("<th>Number Sold</th>");
		out.print("</tr>");
		//parse out the results
		while (rs.next()) {
			out.print("<tr>");
				out.print("<td>");
					out.print(rs.getString("title"));
				out.print("</td>");
				out.print("<td>");
					out.print(rs.getString("COUNT(*)"));
				out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		out.println("<br/>");
		
		//best selling by type
		rs = st.executeQuery("SELECT type, COUNT(*) FROM pays JOIN items on pays.auctionID = items.auctionID " +
			"GROUP BY type HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC");
		//create table
		out.print("<table style='width:100%'>");
		out.print("<caption>Best Selling Type</caption>");
		out.print("<tr>");
			out.print("<th>Type</th>");
			out.print("<th>Number Sold</th>");
		out.print("</tr>");
		//parse out the results
		while (rs.next()) {
			out.print("<tr>");
				out.print("<td>");
					out.print(rs.getString("type"));
				out.print("</td>");
				out.print("<td>");
					out.print(rs.getString("COUNT(*)"));
				out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		out.println("<br/>");
		
		//best buyers
		rs = st.executeQuery("SELECT buyerID, COUNT(*) FROM pays WHERE status = 'Paid' GROUP BY buyerID HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC ");
		//create table
		out.print("<table style='width:100%'>");
		out.print("<caption>Best Buyer</caption>");
		out.print("<tr>");
			out.print("<th>BuyerID</th>");
			out.print("<th>Number Bought</th>");
		out.print("</tr>");
		//parse out the results
		while (rs.next()) {
			out.print("<tr>");
				out.print("<td>");
					out.print(rs.getString("buyerID"));
				out.print("</td>");
				out.print("<td>");
					out.print(rs.getString("COUNT(*)"));
				out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		out.println("<br/>");
		
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
%>
</body>
</html>