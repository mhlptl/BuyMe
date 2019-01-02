<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Send Email</title>
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
		ResultSet rs;
		String insert = "INSERT INTO EMAIL(to_, subject, content) VALUES(?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		rs = st.executeQuery("SELECT * FROM " + request.getParameter("to"));
		//Make an HTML table to show the results in
		if(!rs.next()){
			out.println("Email not sent");
		}
		do {
			if(request.getParameter("to").equals("buyers")) {
				ps.setString(1, rs.getString("buyerID"));
			}
			else if(request.getParameter("to").equals("sellers")) {
				ps.setString(1, rs.getString("sellerID"));
			}
			else {
				ps.setString(1, rs.getString("email"));	
			}
			ps.setString(2, request.getParameter("subject"));
			ps.setString(3, request.getParameter("content"));
			ps.executeUpdate();
		}while (rs.next());
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
%>
</body>
</html>