<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Seller HomePage</title>
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
		<li><a onclick="toggle('auctions');">Sell an item</a></li>
		<li><a onclick="toggle('questions');">Ask Questions</a></li>
		<li><a onclick="toggle('search');">Search</a>
		<li><a href="email.jsp">Email</a></li>
		<li><a href="faqs.jsp">FAQs</a></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	<br/>
	
	<div id="auctions" style="display:none;">
		<form action="create_items.jsp" method="POST">
			<fieldset>
				<input class="form_fields" type="hidden" value=<%=session.getAttribute("email")%> name="sellerID"/><br/>
				<input class="form_fields" type="text" name="title" placeholder="Album Title" maxlength="30" required/><br/>
				<input class="form_fields" type="text" name="artist" placeholder="Artist Name" maxlength="30" required/><br/>
				Select Genre<br/>
				<select class="form_fields" name="genre" required>
					<option value="pop">Pop</option>
					<option value="rock">Rock</option>
					<option value="country">Country</option>
					<option value="hip-hop/rap">Hip-Hop/Rap</option>
					<option value="other">Other</option>
				</select><br/>
				Format Type<br/>
				<select class="form_fields" name="type" required>
					<option value="CD">CD</option>
					<option value="Record">Record</option>
					<option value="Digital">Digital</option>
				</select><br/>
				<input class="form_fields" type="text" name="startingPrice" placeholder="Starting Price" required/><br/>
				<input class="form_fields" type="text" name="minSellPrice" placeholder="Minimum Sell Price (Not Required)"/><br/>
				<input class="form_fields" type="text" name="increment" min="0.01" placeholder="Set Increment" required/><br/>
				<input class="form_fields" type="datetime-local" name="expiration" required/><br/>
				<input type="submit" value="Create Auction"/>
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

<%
	//seller can see his auctions
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM auction JOIN items WHERE items.auctionID = auction.auctionID AND sellerID = '" 
			+ session.getAttribute("email") + "' GROUP BY auction.auctionID");
		//Make an HTML table to show the results in
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>AuctionID</th>");
				out.print("<th>Title</th>");
				out.print("<th>Artist</th>");
				out.print("<th>Genre</th>");
				out.print("<th>Type</th>");
				out.print("<th>Start Price</th>");
				out.print("<th>Min Sell Price</th>");
				out.print("<th>Increment</th>");
				out.print("<th>Start Date</th>");
				out.print("<th>Expiration</th>");
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
					out.print("<td>");
						out.print(rs.getString("startingPrice"));
					out.print("</td>");
					out.print("<td>");
						if(rs.getString("minSellPrice") == null) {
							out.print("None Set");
						}
						else {
							out.print(rs.getString("minSellPrice"));
						}
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("increment"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("startDate"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("expiration"));
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