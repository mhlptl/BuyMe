<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bid History</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
<style>
</style>
</head>
<body>
	
	<header>
		<h1>Bid History</h1>
	</header>

	<ul>
		<li><a onclick="back();">Back</a><li>
		<li><a onclick="toggle('userSearch');">User Search</a></li>
	</ul>
	
	<div style="margin:auto; width:90%;">
		<form id="search_index" method="POST">
			<fieldset>
				<legend>Bid History</legend>
				<input class="form_fields" type="text" name="auctionID" placeholder="Auction ID">
				<input class="form_fields" type="text" name="title" placeholder="Title">
				<input class="form_fields" type="text" name="artist" placeholder="Artist">
				<input class="form_fields" type="text" name="genre" placeholder="Genre">
				<input class="form_fields" type="text" name="type" placeholder="Type">
				<input type="submit" value="Bid History">
				<input type="submit" value="Search" formaction="search.jsp">
				<input type="submit" value="Similar Items" formaction="similar_items.jsp">
				<input type="reset">
			</fieldset>
		</form>
	</div>
	
	<div id="userSearch" style="display:none;">
		<form id="user_search" action="auctionHistory.jsp" method="POST">
			<fieldset>
				<legend>User History</legend>
				<select class="form_fields" name="user">
					<option value="buyerID">Buyer</option>
					<option value="sellerID">Seller</option>
				</select>
				<input class="form_fields" type="email" name="email" placeholder="Email">
				<input type="submit" value="Search!">
				<input type="reset">
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
		PreparedStatement ps = con.prepareStatement("SELECT * FROM items LEFT JOIN bid ON items.auctionID = bid.auctionID " + 
			"LEFT JOIN auction ON items.auctionID = auction.auctionID WHERE " + 
		"items.auctionID = ? OR items.title = ? OR items.artist like ? OR items.genre = ? OR items.type = ?");
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
				out.print("<th>Bidders</th>");
				out.print("<th>Price</th>");
				out.print("<th>Time Bids Were Placed</th>");
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
							out.print("NO BID YET");
						out.print("</td>");
					}
					else {
						out.print("<td>");
							out.print(rs.getString("buyerID"));
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
					if(rs.getString("timePlaced") == null){
						out.print("<td>");
							out.print("-");
						out.print("</td>");
					}
					else {
						out.print("<td>");
							out.print(rs.getString("timePlaced"));
						out.print("</td>");
					}
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