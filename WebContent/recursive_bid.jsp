<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bid</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
	<ul>
		<li><a href="home_buyers.jsp">Back</a></li>
	</ul>
	<br/>
<%
	//check for autobid
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		Statement stmt = con.createStatement();
		Statement sts = con.createStatement();
		String price = "";
		float floatPrice = 0;
		ResultSet rs;
		ResultSet rst;
		rs = st.executeQuery("SELECT bidPrice FROM auction WHERE auctionID = '" + session.getAttribute("auctionID") + "'");
		while(rs.next()) {
			floatPrice = rs.getFloat("bidPrice");
		}
		rs.close();
		rs = st.executeQuery("SELECT * FROM autobid WHERE buyerID <> '" + session.getAttribute("email") + "' AND auctionID = '" + session.getAttribute("auctionID") + "'");
		String insert = "INSERT INTO bid(buyerID, auctionID, amount, newPrice) VALUES (?,?,?,?)";
		if(!rs.next()) { }
		else {
			do {
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
					session.getAttribute("auctionID") + "'");
				}
			} while(rs.next());
			rs.first();
			
			while(rs.getFloat("maxAmount") > floatPrice) {
				//rs.isFirst();
				//rs.afterLast();
				if(rs.isFirst() && rs.isLast()) {
					stmt.executeUpdate("DELETE FROM autobid WHERE maxAmount <= '" + price + "' AND auctionID = '" + 
							session.getAttribute("auctionID") + "'");
					con.close();
					return;
				}
				rst = sts.executeQuery("SELECT bidPrice FROM auction WHERE auctionID = '" + session.getAttribute("auctionID") + "'");
				while(rst.next()) {
					floatPrice = rst.getFloat("bidPrice");
				}
				//rst.close();
				rst = sts.executeQuery("SELECT * FROM autobid WHERE buyerID <> '" + session.getAttribute("email") + "' AND auctionID = '" + session.getAttribute("auctionID") + "'");
				insert = "INSERT INTO bid(buyerID, auctionID, amount, newPrice) VALUES (?,?,?,?)";
				if(!rst.next()) { }
				else {
					do {
						if(rst.isFirst() && rst.isLast()) {
							con.close();
							return;
						}
						if(floatPrice < rst.getFloat("maxAmount")) {	
							floatPrice = floatPrice + rst.getFloat("increment");
							price = String.valueOf(floatPrice);
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setString(1, rst.getString("buyerID"));
							ps.setString(2, rst.getString("auctionID"));
							ps.setString(3, rst.getString("increment"));
							ps.setString(4, price);
							ps.executeUpdate();
							stmt.executeUpdate("UPDATE auction SET bidPrice = '" + price + "' WHERE auctionID = '" + rst.getString("auctionID") +"'");
						}
						else {
							stmt.executeUpdate("DELETE FROM autobid WHERE maxAmount <= '" + price + "' AND auctionID = '" + 
							session.getAttribute("auctionID") + "'");
						}
						if(rst.isFirst() && rst.isLast()) {
							con.close();
							return;
						}
					} while(rst.next());
					rst.close();
				}
				if(rs.isFirst() && !rs.isLast()) {
					rs.first();
				}
				else if(rs.isFirst() && rs.isLast()) {
					stmt.executeUpdate("DELETE FROM autobid WHERE maxAmount <= '" + price + "' AND auctionID = '" + 
							session.getAttribute("auctionID") + "'");
					con.close();
					return;
				}
				else {
					rs.next();
				}
			}
			stmt.executeUpdate("DELETE FROM autobid WHERE maxAmount <= '" + price + "' AND auctionID = '" + 
					session.getAttribute("auctionID") + "'");
		}
		con.close();
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>