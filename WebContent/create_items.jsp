<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Post Items</title>
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
		<li><a onclick="back();">Back</a></li>
	</ul>
	<br/>
<%
	Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	try {
		String sellerID = request.getParameter("sellerID");
		String startingPrice = request.getParameter("startingPrice");
		String minSellPrice = request.getParameter("minSellPrice");
		String increment = request.getParameter("increment");
		String expiration = request.getParameter("expiration");
		String title = request.getParameter("title");
		String artist = request.getParameter("artist");
		String genre = request.getParameter("genre");
		String type = request.getParameter("type");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		String newSellerID = request.getParameter("sellerID");
		String newStartingPrice = request.getParameter("startingPrice");
		String newMinSellPrice = request.getParameter("minSellPrice");
		String newIncrement = request.getParameter("increment");
		String newExpiration = request.getParameter("expiration");
		String newTitle = request.getParameter("title");
		String newArtist = request.getParameter("artist");
		String newGenre = request.getParameter("genre");
		String newType = request.getParameter("type");
		String insert = "INSERT INTO auction(sellerID, startingPrice, increment, startDate, expiration) VALUES (?, ?, ?, ?, ?)";
		int x = 0;
		Timestamp exp = Timestamp.valueOf(newExpiration.replace('T', ' ').concat(":00"));
		if(exp.before(timestamp)) {
			con.close();
			out.println("Invalid Expiration");
			return;
		}
		if(newType.contains(" ") || newStartingPrice.equals("0.00") || newIncrement.equals("0.00") ||newTitle.contains("  ") ||
				newArtist.contains("  ") || newMinSellPrice.contains(" ") || newMinSellPrice.equals("0.00")) {
			con.close();
			out.println("Invalid Type");
			return;
		}
		if(!newMinSellPrice.isEmpty()) {
			float startPrice = Float.valueOf(newStartingPrice);
			float minSell = Float.valueOf(newMinSellPrice);
			if(startPrice > minSell) {
				con.close();
				out.println("Min Price is lower than Start Price");
				return;
			}
			insert = "INSERT INTO auction(sellerID, startingPrice, minSellPrice, increment, startDate, expiration) VALUES (?, ?, ?, ?, ?, ?)";
		}
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, newSellerID);
		ps.setString(2, newStartingPrice);
		if(!newMinSellPrice.isEmpty()) {
			ps.setString(3, newMinSellPrice);
			ps.setString(4, newIncrement);
			//just added 8/5
			ps.setTimestamp(5, timestamp);
			ps.setString(6, newExpiration);
		}
		else {
			ps.setString(3, newIncrement);
			//just added 8/5
			ps.setTimestamp(4, timestamp);
			ps.setString(5, newExpiration);
		}
		x = ps.executeUpdate();
		if(x > 0) {
			x = 0;
			insert = "INSERT INTO items(title, artist, genre, type) VALUES (?, ?, ?, ?)";
			ps = con.prepareStatement(insert);
			ps.setString(1, newTitle);
			ps.setString(2, newArtist);
			ps.setString(3, newGenre);
			ps.setString(4, newType);
			x = ps.executeUpdate();
			if(x > 0) {
				out.println("Auction Created");
			}
		}
		else {
			con.close();
			out.println("Creating Auction Failed");
			return;
		}
		con.close();
	} catch (Exception ex) {
		out.println(ex);
		out.println("Failed");
	}
	//set alerts
	try {
		String insert = "";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		Statement stmt = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT ah.sort FROM alerts_help ah, auction AS a WHERE UNIX_TIMESTAMP(a.startDate) > UNIX_TIMESTAMP(ah.alertTime)");
		if(!rs.next()) { }
		else {
			do {
				if(rs.getString("sort").equals("pop") || rs.getString("sort").equals("rock") || rs.getString("sort").equals("hip-hop/rap") ||
						rs.getString("sort").equals("country") || rs.getString("sort").equals("other")) {
					insert = "INSERT INTO alerts(userID, outbid) " +
							" SELECT ah.userID, 'Item with " + rs.getString("sort") + " keyword uploaded.' " + 
							" FROM alerts_help ah, items i, auction a WHERE a.auctionID = i.auctionID AND i.genre = '" + rs.getString("sort") + 
							"' AND ah.sort = '" + rs.getString("sort") + "' AND UNIX_TIMESTAMP(a.startDate) > UNIX_TIMESTAMP(ah.alertTime)";
					stmt.executeUpdate(insert);
				}
				else if(rs.getString("sort").equals("CD") || rs.getString("sort").equals("Digital") || rs.getString("sort").equals("Record")) {
					insert = "INSERT INTO alerts(userID, outbid) " +
							" SELECT ah.userID, 'Item with " + rs.getString("sort") + " keyword uploaded.' " + 
							" FROM alerts_help ah, items i, auction a WHERE a.auctionID = i.auctionID AND i.type = '" + rs.getString("sort") + 
							"' AND ah.sort = '" + rs.getString("sort") + "' AND UNIX_TIMESTAMP(a.startDate) > UNIX_TIMESTAMP(ah.alertTime)";
					stmt.execute(insert);
				}
				else {
					insert = "INSERT INTO alerts(userID, outbid) " +
							" SELECT ah.userID, 'Item with " + rs.getString("sort") + " keyword uploaded.' " + 
							" FROM alerts_help ah, items i, auction a WHERE a.auctionID = i.auctionID AND i.artist like '%" + rs.getString("sort") + 
							"%' AND ah.sort like '%" + rs.getString("sort") + "%' AND UNIX_TIMESTAMP(a.startDate) > UNIX_TIMESTAMP(ah.alertTime)";
					stmt.execute(insert);
				}
			} while (rs.next());
			insert = "UPDATE alerts_help SET alertTime = CURRENT_TIMESTAMP";
			stmt.execute(insert);
		}
		con.close();
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>