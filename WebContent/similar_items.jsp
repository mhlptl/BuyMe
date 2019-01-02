<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Similar Items</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
	
	<header>
		<h1>Similar Items</h1>
	</header>
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
		PreparedStatement ps = con.prepareStatement("SELECT * FROM items LEFT JOIN bid ON items.auctionID = bid.auctionID " + 
			"LEFT JOIN auction ON items.auctionID = auction.auctionID WHERE " + 
		"(items.auctionID = ? OR items.title = ? OR items.artist like ? OR items.genre = ? OR items.type = ?) AND auction.startDate >= NOW() - INTERVAL 4 WEEK GROUP BY items.auctionID");
		ps.setString(1, request.getParameter("auctionID"));
		ps.setString(2, request.getParameter("title"));
		ps.setString(3, request.getParameter("artist"));
		ps.setString(4, request.getParameter("genre"));
		ps.setString(5, request.getParameter("type"));
		rs = ps.executeQuery();
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>Auction ID</th>");
				out.print("<th>Title</th>");
				out.print("<th>Artist</th>");
				out.print("<th>Genre</th>");
				out.print("<th>Type</th>");
				out.print("<th>Bids</th>");
				out.print("<th>Price</th>");
				out.print("<th>Start Date</th>");
				out.print("<th>Expiration</th>");
			out.print("</tr>");
			while(rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getInt("auctionID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("title"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("artist"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("genre"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("type"));
					out.print("</td>");
					
					if(rs.getString("buyerID") == null) {
						out.print("<td>");
							out.print("NO BIDS");
						out.print("</td>");
					}
					else {
						out.print("<td>");
							out.print("BIDS");
						out.print("</td>");
					}
					if(rs.getString("newPrice") == null){
						out.print("<td>");
							out.print(rs.getString("startingPrice"));
						out.print("</td>");
					}
					else {
						out.print("<td>");
							out.print(rs.getString("newPrice"));
						out.print("</td>");
					}
					
						out.print("<td>");
							out.print(rs.getString("startDate"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(rs.getString("expiration"));
					out.print("</td>");
				out.print("</tr>");
	        }
		out.print("</table>");
		con.close();
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>