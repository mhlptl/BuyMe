<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
	
	<header>
		<h1>User History</h1>
	</header>

	<ul>
		<li><a onclick="back();">Back</a><li>
	</ul>
	
	<div style="margin:auto; width:90%;">
		<form method="POST">
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
		//need to work on
		if(request.getParameter("user").equals("buyerID")) {
			rs = st.executeQuery("SELECT * FROM items JOIN bid ON items.auctionID = bid.auctionID " + 
				"WHERE buyerID = '" + request.getParameter("email") + "' GROUP BY items.auctionID");
		}
		else {
			rs = st.executeQuery("SELECT * FROM items JOIN auction a ON items.auctionID = a.auctionID " + 
				"WHERE sellerID = '" + request.getParameter("email") + "'");	
		}
			if(!rs.next()) {
				out.println("Table Empty");
			}
			else {
				out.print("<table style='width:100%'>");
					out.print("<tr>");
						out.print("<th>Auction ID</th>");
						out.print("<th>Title</th>");
						out.print("<th>Artist</th>");
						out.print("<th>Genre</th>");
						out.print("<th>Type</th>");
					out.print("</tr>");				
				do {
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
					out.print("</tr>");
		        } while(rs.next());
				out.print("</table>");				
			}
		con.close();
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>