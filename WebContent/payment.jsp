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
	<ul>
		<li><a onclick="back();">Back</a><li>
	</ul>
	<div style="float:right;">
		<form method="POST">
			<fieldset>
				<legend>Payment</legend>
				<input class="form_fields" type="text" name="auctionID" placeholder="Auction ID">
				<input type="submit" value="Pay">
			</fieldset>
		</form>
	</div>
	<br/>
<%
	try {
		int x = 0;
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM pays WHERE buyerID = '" + session.getAttribute("email") + "' ORDER BY status DESC");
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>Auction ID</th>");
				out.print("<th>Seller</th>");
				out.print("<th>Amount</th>");
				out.print("<th>Status</th>");
			out.print("</tr>");
			while(rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("auctionID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("sellerID"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("amount"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("status"));
					out.print("</td>");
				out.print("</tr>");
			}
			PreparedStatement ps = con.prepareStatement("UPDATE pays SET status = 'Paid' WHERE auctionID = ? AND buyerID = ?");
			ps.setString(1, request.getParameter("auctionID"));
			ps.setString(2, session.getAttribute("email").toString());
			x = ps.executeUpdate();
		con.close();
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>