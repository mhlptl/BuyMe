<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>

	<header class="header">
		<h1>WELCOME TO BUY ME</h1>
	</header>
	
	<ul>
		<li><a onclick="toggle('user');">User Login</a></li>
		<li><a onclick="toggle('register');">Register</a></li>
		<li><a onclick="toggle('employee');">Employee Login</a></li>
		<li><a onclick="toggle('admin');">Admin Login</a></li>
		<li><a onclick="toggle('search');">Search</a></li>
		<li><a onclick="toggle('userSearch');">User Search</a></li>
		<li><a href="faqs.jsp">FAQs</a></li>
		<li>
			<form style="float:right;">
					<select name="groups">
						<option value="ORDER BY items.auctionID ASC">AuctionID Low-High</option>
						<option value="ORDER BY items.auctionID DESC">AuctionID High-Low</option>
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

	<div id="user" style="display:none;">
		<form action="checkLogin_users.jsp" method="POST">
			<fieldset>
				<legend>User Login</legend>
				<input class="form_fields" type="email" name="email" placeholder="Email" required/><br/>
				<input class="form_fields" type="password" name="password" placeholder="Password" required/><br/>
				<input type="submit" value="Login"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>
	
	<div id="register" style="display:none;">
		<form action="checkRegistration_users.jsp" method="POST">
			<fieldset>
				<legend>Register</legend>
				<input class="form_fields" type="text" name="firstName" placeholder="First Name" required/><br/>
				<input class="form_fields" type="text" name="lastName" placeholder="Last Name" required/><br/>
				<input class="form_fields" type="email" name="email" required placeholder="Email"/><br/>
				<input class="form_fields" type="password" name="password" placeholder="Password"required/><br/>
				<input class="form_fields" type="radio" name="accountType" value="buyer" required/>Buyer
				<input class="form_fields" type="radio" name="accountType" value="seller"/>Seller<br/>
				<input type="submit" value="Register"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>
	
	<div id="employee" style="display:none;">
		<form action="checkLogin_employees.jsp" method="POST">
			<fieldset>
				<legend>Employee Login</legend>
				<input class="form_fields" type="email" name="email" placeholder="Email" required/><br/>
				<input class="form_fields" type="password" name="password" placeholder="Password" required/><br/>
				<input type="submit" value="Login"/>
				<input type="reset"/>
			</fieldset>
		</form>
	</div>

	<div id="admin" style="display:none;">
		<form action="checkLogin_admin.jsp" method="POST">
			<fieldset>
				<legend>Administrator Login</legend>
				<input class="form_fields" type="text" name="adminID" placeholder="Admin" required/><br/>
				<input class="form_fields" type="password" name="password" placeholder="Password" required/><br/>
				<input type="submit" value="Login"/>
				<input type="reset"/>
			</fieldset>
		</form>
	</div>
	
	<div id="search" style="display:none;">
		<form id="search_index" action="search.jsp" method="POST">
			<fieldset>
				<legend>Search</legend>
				<input class="form_fields" type="text" name="auctionID" placeholder="Auction ID"><br/>
				<input class="form_fields" type="text" name="title" placeholder="Title"><br/>
				<input class="form_fields" type="text" name="artist" placeholder="Artist"><br/>
				<input class="form_fields" type="text" name="genre" placeholder="Genre"><br/>
				<input class="form_fields" type="text" name="type" placeholder="Type"><br/>
				<input type="submit" value="Search!">
				<input type="submit" value="Bid History" formaction="bidHistory.jsp">
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
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		String group = "";
		if(request.getParameter("groups") != null) {
			group = request.getParameter("groups");
		}
		Calendar cd = Calendar.getInstance();
		cd.setTimeInMillis(ts.getTime());
		Calendar cal = Calendar.getInstance();
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT items.auctionID, items.title, items.artist, items.genre, items.type, auction.bidPrice, bid.buyerID, " +
			"auction.startingPrice, auction.startDate, auction.expiration FROM items LEFT JOIN bid ON items.auctionID = bid.auctionID " + 
			"LEFT JOIN auction ON items.auctionID = auction.auctionID GROUP BY items.auctionID " + group + "");		
		//Make an HTML table to show the results in
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>Auction ID</th>");
				out.print("<th>Title</th>");
				out.print("<th>Artist</th>");
				out.print("<th>Genre</th>");
				out.print("<th>Type</th>");
				out.print("<th>Bid Status</th>");
				out.print("<th>Current Price</th>");
				out.print("<th>Start Date</th>");
				out.print("<th>Expiration</th>");
				out.print("<th>Auction Status</th>");
			out.print("</tr>");	
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
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
					
					if(rs.getString("buyerID") == null){
						out.print("<td>");
							out.print("NO BIDS");
						out.print("</td>");
					}
					else {
						out.print("<td>");
							out.print("BIDS");
						out.print("</td>");
					}
					if(rs.getString("bidPrice") == null){
						out.print("<td>");
							out.print(rs.getString("startingPrice"));
						out.print("</td>");
					}
					else {
						out.print("<td>");
							out.print(rs.getString("bidPrice"));
						out.print("</td>");
					}
					out.print("<td>");
						out.print(rs.getString("startDate"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("expiration"));
					out.print("</td>");
					Timestamp end = rs.getTimestamp("expiration");
					cal.setTimeInMillis(end.getTime());
					if(end.before(ts)) {
						out.print("<td style='background-color:red; border-left: 2px solid black;'>");
							out.print("<strong>CLOSED</strong>");
						out.print("</td>");
					}
					else if((cal.getTimeInMillis() - cd.getTimeInMillis()) <= 86400000) {
						out.print("<td style='background-color:yellow; border-left: 2px solid black;'>");
							out.print("<strong>OPEN</strong>");
						out.print("</td>");
					}
					else {
						out.print("<td style='background-color:#33cc33; border-left: 2px solid black;'>");
							out.print("<strong>OPEN</strong>");
						out.print("</td>");
					}
				out.print("</tr>");
			}
		out.print("</table>");
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
	//checks to see if there is a winner
	try {
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT auction.auctionID, auction.sellerID, bid.buyerID, auction.bidPrice " +
			" FROM auction JOIN bid ON auction.auctionID = bid.auctionID AND auction.bidPrice = bid.newPrice " + 
			" WHERE expiration < '" + timestamp + "'" + " AND auction.auctionID NOT IN (SELECT auctionID FROM pays)" +
			" AND auction.bidPrice >= (CASE WHEN auction.minSellPrice IS NULL THEN 0 ELSE auction.minSellPrice END)");
		String insert = "INSERT INTO pays(auctionID, buyerID, sellerID, amount) VALUES (?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		if(!rs.next()) { }
		else {
			do {
				ps.setInt(1, rs.getInt("auctionID"));
				ps.setString(2, rs.getString("buyerID"));
				ps.setString(3, rs.getString("sellerID"));
				ps.setFloat(4, rs.getFloat("bidPrice"));
				ps.executeUpdate();
			}while(rs.next());
		}
	} catch(Exception ex) {
		out.println(ex);
	}
%>

</body>
</html>