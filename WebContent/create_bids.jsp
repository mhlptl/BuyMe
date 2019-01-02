<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%!
float startPrice = 0;
float increment = 0;
float highPrice = 0;
String price = "0";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bid</title>
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
	//check for date
	try {
		String endDate = "";
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String auctionID = request.getParameter("auctionID");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT startingPrice, increment, expiration FROM auction where auctionID = '" + auctionID + "'");
		while(rs.next()) {
			startPrice = rs.getFloat("startingPrice");
			increment = rs.getFloat("increment");
			endDate = rs.getString("expiration");
		}
		Timestamp end = Timestamp.valueOf(endDate);
		if(end.before(timestamp)) {
			con.close();
			out.println("End Date has passed");
			return;
		}
		rs = st.executeQuery("SELECT max(newPrice) FROM bid where auctionID = '" + auctionID + "'");
		while(rs.next()) {
			highPrice = rs.getFloat("max(newPrice)");
		}
		con.close();
	}
	catch(Exception ex) {
		out.println(ex);
	}
	//insert bid
	try {
		String email = request.getParameter("buyerID");
		String auctionID = request.getParameter("auctionID");
		String amount = request.getParameter("amount");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		String newEmail = request.getParameter("buyerID");
		String newAuctionID = request.getParameter("auctionID");
		String newAmount = request.getParameter("amount");
		String insert = ("INSERT INTO alerts(userID, outbid) VALUES (?, ?)");
		PreparedStatement ps = con.prepareStatement(insert);
		rs = st.executeQuery("SELECT maxAmount, buyerID FROM autobid WHERE auctionID = '" + newAuctionID + "'");
		float floatAmount = Float.valueOf(newAmount);
		if(floatAmount < increment) {
			con.close();
			out.println("Bid is too low");
			return;
		}
		else {
			float floatPrice = Float.valueOf(price);
			if(highPrice > startPrice) {
				floatPrice = highPrice;
			}
			else {
				floatPrice = startPrice;
			}
			floatPrice = floatPrice + floatAmount;
			price = String.valueOf(floatPrice);
			if(!rs.next()) {
				
			}
			else {
				do {
					if(rs.getFloat("maxAmount") <= floatPrice) {
						ps.setString(1, rs.getString("buyerID"));
						ps.setString(2, "You have been outbid on auction " + newAuctionID);
						ps.executeUpdate();
					}
				}while(rs.next());	
			}
			insert = "INSERT INTO bid(buyerID, auctionID, amount, newPrice) VALUES (?,?,?,?)";
			PreparedStatement ps1 = con.prepareStatement(insert);
			ps1.setString(1, newEmail);
			ps1.setString(2, newAuctionID);
			ps1.setString(3, newAmount);
			ps1.setString(4, price);
			ps1.executeUpdate();
			st.executeUpdate("UPDATE auction SET bidPrice = '" + price + "' WHERE auctionID = '" + newAuctionID +"'");
		}	
		con.close();
	} catch (Exception ex) {
		out.println(ex);
	}
	//check for autobid
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		Statement stmt = con.createStatement();
		float floatPrice;
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM autobid WHERE buyerID <> '" + session.getAttribute("email") + "' AND auctionID = '" + request.getParameter("auctionID") + "'");
		String insert = "INSERT INTO bid(buyerID, auctionID, amount, newPrice) VALUES (?,?,?,?)";
		if(!rs.next()) { }
		else {
			do {
				floatPrice = Float.valueOf(price);
				if(floatPrice < startPrice) {
					floatPrice = startPrice;
				}
				if(floatPrice < rs.getFloat("maxAmount")) {	
					floatPrice = floatPrice + rs.getFloat("increment");
					price = String.valueOf(floatPrice);
					PreparedStatement ps = con.prepareStatement(insert);
					ps.setString(1, rs.getString("buyerID"));
					ps.setString(2, rs.getString("auctionID"));
					ps.setString(3, rs.getString("increment"));
					ps.setString(4, price);
					ps.executeUpdate();
					stmt.executeUpdate("UPDATE auction SET bidPrice = '" + price + "' WHERE auctionID = '" + rs.getString("auctionID") +"'");
				}
				else {
					stmt.executeUpdate("DELETE FROM autobid WHERE maxAmount <= '" + price + "' AND auctionID = '" + 
						request.getParameter("auctionID") + "'");
				}
			} while(rs.next());
			//is not working because auctionID turns into null so must run autobid only
			if(rs.first() != rs.isLast()) {
				stmt.executeUpdate("DELETE FROM autobid WHERE maxAmount <= '" + price + "' AND auctionID = '" + 
					request.getParameter("auctionID") + "'");
				session.setAttribute("auctionID", request.getParameter("auctionID"));
				con.close();
				response.sendRedirect("recursive_bid.jsp");
			}
		}
		con.close();
	} catch(Exception ex) {
		out.println(ex);
	}
	//check for outbid
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		String insert = "INSERT INTO alerts (userID, outbid) " +
				"SELECT buyerID, 'You have been outbid by " + session.getAttribute("email") + ".'" 
				+ "FROM bid b WHERE b.buyerID <> '" + session.getAttribute("email") + "' AND b.auctionID = '" + request.getParameter("auctionID")
				+ "' GROUP BY buyerID";
		st.execute(insert);
		con.close();
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>