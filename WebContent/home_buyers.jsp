<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buyer HomePage</title>
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
		<li><a onclick="toggle('bids');">Place Bid</a></li>
		<li><a href="viewBids_buyers.jsp">View Bids</a></li>
		<li><a href="payment.jsp">Payments</a></li>
		<li><a onclick="toggle('alert_set');">Set Alerts</a></li>
		<li><a onclick="toggle('questions');">Ask Questions</a></li>
		<li><a href="inbox.jsp">Inbox</a></li>
		<li><a onclick="toggle('search');">Search</a></li>
		<li><a href="faqs.jsp">FAQs</a></li>
		<li><a href="logout.jsp">Logout</a></li>
		<li>
			<form style="float:right;">
				<select name="groups">
					<option value="ORDER BY auction.auctionID ASC">AuctionID Low-High</option>
					<option value="ORDER BY auction.auctionID DESC">AuctionID High-Low</option>
					<option value="ORDER BY items.title ASC">Title A-Z</option>
					<option value="ORDER BY items.title DESC">Title Z-A</option>
					<option value="ORDER BY auction.bidPrice ASC">Bid Price Low-High</option>
					<option value="ORDER BY auction.bidPrice DESC">Bid Price High-Low</option>
					<option value="ORDER BY auction.startDate ASC">Start Date Old-New</option>
					<option value="ORDER BY auction.startDate DESC">Start Date New-Old</option>
					<option value="ORDER BY auction.expiration ASC">Expiration Old-New</option>
					<option value="ORDER BY auction.expiration DESC">Expiration New-Old</option>
				</select><br/><br/>
				<input type="submit" value="Sort"/>
			</form>
		</li>
	</ul>
	
	<div id="bids" style="display:none;">
		<form action="create_bids.jsp" method="POST">
			<fieldset>
				<legend>Enter Bid Here</legend>
				<input class="form_fields" type="text" name="auctionID" placeholder="Auction ID" required/><br/>
				<input class="form_fields" type="text" name="amount" placeholder= "$" required/><br/>
				<input type="hidden" value=<%=session.getAttribute("email")%> name="buyerID"/><br/>
				<input type="submit" value="Submit"/>
				<input type="reset">
			</fieldset>
		</form>
		<form action="autobid.jsp" method="POST">
			<fieldset>
				<legend>Set AutoBid</legend>
				<input class="form_fields" type="text" name="auctionID" placeholder="Auction ID" required/><br/>
				<input class="form_fields" type="text" name="increment" placeholder="Increment" required/><br/>
				<input class="form_fields" type="text" name="maxBid" placeholder= "Max Bid Price" required/><br/><br/>
				<input type="submit" value="Set"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>
	
	<div id="questions" style="display:none;">
		<form action="postQuestions.jsp" method="POST">
			<fieldset>
				<legend>Ask Question</legend>
				<textarea name="question" rows="3" cols="90" maxlength="255" placeholder="Your Question Here."></textarea><br/>
				<input type="submit" value="Ask"/>
				<input type="reset"><br/>
			</fieldset>
		</form>
	</div>	

	<div id="alert_set" style="display:none;">
		<form action="buyAlerts.jsp" method="POST">
			<fieldset>
				<legend>Set Alerts</legend>
				<input class="form_fields" list="alerts" name="alerts"><br/>
					<datalist id="alerts">
						<option value="Pop">
						<option value="Rock">
						<option value="hip-hop/rap">
						<option value="Country">
						<option value="CD">
						<option value="Record">
						<option value="Digital">
					</datalist>
				<input type="submit" value="Set">
				<input type="reset"><br/>
			</fieldset>
		</form>
	</div>

	<div id="search" style="display:none;">
		<form action="search.jsp" method="POST">
			<fieldset>
				<legend>Search</legend>
				<input class="form_fields" type="text" name="auctionID" placeholder="Auction ID"><br/>
				<input class="form_fields" type="text" name="title" placeholder="Title"><br/>
				<input class="form_fields" type="text" name="artist" placeholder="Artist"><br/>
				<input class="form_fields" type="text" name="genre" placeholder="Genre"><br/>
				<input class="form_fields" type="text" name="type" placeholder="Type"><br/>
				<input type="submit" value="Search!">
				<input type="reset">
			</fieldset>
		</form>
	</div>
	
	<br/>
<%
	try {
		String group = "";
		if(request.getParameter("groups") != null) {
			group = request.getParameter("groups");
		}
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM auction JOIN items ON items.auctionID = auction.auctionID "
			+ "GROUP BY auction.auctionID " + group + "");
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		Calendar cd = Calendar.getInstance();
		cd.setTimeInMillis(ts.getTime());
		Calendar cal = Calendar.getInstance();
		//Make an HTML table to show the results in
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>Seller</th>");
				out.print("<th>AuctionID</th>");
				out.print("<th>Title</th>");
				out.print("<th>Artist</th>");
				out.print("<th>Genre</th>");
				out.print("<th>Type</th>");
				out.print("<th>Start Price</th>");
				out.print("<th>Bid Price</th>");
				out.print("<th>Increment</th>");
				out.print("<th>Start Date</th>");
				out.print("<th>Expiration</th>");
				out.print("<th>Status</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("sellerID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("auctionID"));
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
					out.print("<td>");
						out.print(rs.getString("startingPrice"));
					out.print("</td>");
					if(rs.getString("bidPrice") == null) {
						out.print("<td>");
							out.print("No Bids");
						out.print("</td>");
					}
					else {
						out.print("<td>");
							out.print(rs.getString("bidPrice"));
						out.print("</td>");	
					}
					out.print("<td>");
						out.print(rs.getString("increment"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getTimestamp("startDate"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getTimestamp("expiration"));
					out.print("</td>");
					Timestamp end = rs.getTimestamp("expiration");
					cal.setTimeInMillis(end.getTime());
					if(cal.getTimeInMillis() < cd.getTimeInMillis()) {
						out.print("<td style='background-color:red; border-left: 2px solid black;'>");
							out.print("Expired");
						out.print("</td>");
					}					
					else if(cal.getTimeInMillis() - cd.getTimeInMillis() < 7200000) {
						out.print("<td style='background-color:yellow; border-left: 2px solid black;'>");
							out.print("2 Hours");
						out.print("</td>");
					}
					else {
						out.print("<td style='background-color:#33cc33; border-left: 2px solid black;'>");
							out.print("2+ Hours");
						out.print("</td>");
					}
				out.print("</tr>");
			}
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
	//alerts_win
	try {
		String concat = "";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT auctionID, buyerID, amount FROM pays WHERE status = 'Unpaid' AND buyerID = '"
			+ session.getAttribute("email") + "'");
		String insert = "INSERT INTO alerts (userID, outbid) VALUES (?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		if(!rs.next()) { }
		else {
			do {
				ps.setString(1, rs.getString("buyerID"));
				concat = "You have won auction " + rs.getInt("auctionID") + " with the pricetag of $" + rs.getString("amount") + "."; 
				ps.setString(2, concat);
				ps.executeUpdate();
			} while(rs.next());
		}
		con.close();
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>