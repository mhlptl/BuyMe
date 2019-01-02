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
		<li><a onclick="back();">Back</a></li>
	</ul>
	<br/>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		float increment = Float.valueOf(request.getParameter("increment"));
		float max = Float.valueOf(request.getParameter("maxBid"));
		ResultSet rs;
		rs = st.executeQuery("SELECT increment, bidPrice FROM auction WHERE auctionID = '" + request.getParameter("auctionID") + "'");
		while(rs.next()) {
			if(increment < rs.getFloat("increment")) {
				con.close();
				out.println("Increment too low");
				return;
			}
			if(rs.getString("bidPrice").isEmpty()) {
				if(rs.getFloat("startPrice") >= max) {
					con.close();
					out.println("Max is too low");
					return;
				}
			}
			else {
				if(rs.getFloat("bidPrice") >= max) {
					con.close();
					out.println("Max is too low");
					return;
				}
			}
		}
		String insert = "INSERT INTO autobid(auctionID, buyerID, maxAmount, increment) VALUES (?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, request.getParameter("auctionID"));
		ps.setString(2, session.getAttribute("email").toString());
		ps.setString(3, request.getParameter("maxBid"));
		ps.setString(4, request.getParameter("increment"));
		ps.executeUpdate();
		con.close();
		out.println("AutoBid Started");
	} catch (Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>