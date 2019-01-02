<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earning Reports</title>
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
		<li>
			<div style="float:right">
				<form method="POST">
					<select name="view_earnings">
						<option value="total">Total</option>
						<option value="item">By Item</option>
						<option value="type">By Type</option>
						<option value="user">By User</option>
					</select><br/><br/>
					<input type="submit" value="View"/>
				</form>
			</div>
		</li>
	</ul>
	<br/>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		if(request.getParameter("view_earnings").equals("total")) {
			rs = st.executeQuery("SELECT COUNT(*), SUM(amount) FROM pays WHERE status = 'Paid'");
		}
		else if(request.getParameter("view_earnings").equals("item")) {
			rs = st.executeQuery("SELECT title, COUNT(*), SUM(amount) FROM pays JOIN items on pays.auctionID = items.auctionID " +
				"WHERE status = 'Paid' GROUP BY items.title");
		}
		else if(request.getParameter("view_earnings").equals("type")) {
			rs = st.executeQuery("SELECT type, COUNT(*), SUM(amount) FROM pays JOIN items on pays.auctionID = items.auctionID " +
				"WHERE status = 'Paid' GROUP BY items.type");
		}
		else {
			rs = st.executeQuery("SELECT sellerID, COUNT(*), SUM(amount) FROM pays WHERE status = 'Paid' GROUP BY sellerID");
		}
		//Make an HTML table to show the results in
		if(request.getParameter("view_earnings").equals("total")) {
			out.print("<table style='width:100%'>");
			out.print("<caption>Total Earnings</caption>");
			out.print("<tr>");
				out.print("<th>Number of Items</th>");
				out.print("<th>Total</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("COUNT(*)"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("SUM(amount)"));
					out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
		}
		else if(request.getParameter("view_earnings").equals("item")) {
			out.print("<table style='width:100%'>");
			out.print("<caption>Earnings by Item</caption>");
			out.print("<tr>");
				out.print("<th>Item</th>");
				out.print("<th>Number of Items</th>");
				out.print("<th>Total</th>");
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
					out.print("<td>");
						out.print(rs.getString("SUM(amount)"));
					out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
		}
		else if(request.getParameter("view_earnings").equals("type")){
			out.print("<table style='width:100%'>");
			out.print("<caption>Earnings by Type</caption>");
			out.print("<tr>");
				out.print("<th>Type</th>");
				out.print("<th>Number of Items</th>");
				out.print("<th>Total</th>");
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
					out.print("<td>");
						out.print(rs.getString("SUM(amount)"));
					out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
		}
		else {
			out.print("<table style='width:100%'>");
			out.print("<caption>Earnings by User</caption>");
			out.print("<tr>");
				out.print("<th>Seller</th>");
				out.print("<th>Number of Items</th>");
				out.print("<th>Total</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("sellerID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("COUNT(*)"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("SUM(amount)"));
					out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
		}
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
%>
</body>
</html>