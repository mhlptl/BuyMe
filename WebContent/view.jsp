<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Users</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
<style>
caption {
	font-size: 20px;
	padding: 5px;
	background-color: #2F4F4F;
	color: white;
}
</style>
</head>
<body>
<%
	if(session.getAttribute("adminID") == null) {
		response.sendRedirect("success.jsp");
	}
%>
	<ul>
		<li><a onclick="back();">Back</a></li>
		<li>
			<div style="float:right;">
				<form method="POST">
					<select name="view">
						<option value="custRep">Employees</option>
						<option value="Buyers">Buyers</option>
						<option value="Sellers">Sellers</option>
						<option value="Users">End-Users</option>
					</select><br/><br/>
					<input type="submit" value="View"/>
				</form>
			</div>
		</li>
	</ul>
	<br/>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		if(request.getParameter("view").equals("custRep")) {
			rs = st.executeQuery("SELECT * FROM custRep");
		}
		else if(request.getParameter("view").equals("Buyers")) {
			rs = st.executeQuery("SELECT * FROM buyers b JOIN users u ON u.email = b.buyerID");
		}
		else if(request.getParameter("view").equals("Sellers")) {
			rs = st.executeQuery("SELECT * FROM sellers s JOIN users u ON u.email = s.sellerID");
		}
		else {
			rs = st.executeQuery("SELECT * FROM users");
		}
		//Make an HTML table to show the results in
		if(request.getParameter("view").equals("custRep")) {
			out.print("<table style='width:100%'>");
			out.print("<caption>Employees</caption>");
			out.print("<tr>");
				out.print("<th>First Name</th>");
				out.print("<th>Email</th>");
				out.print("<th>Password</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("firstName"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("email"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("password"));
					out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");	
		}
		else {
			out.print("<table style='width:100%'>");
			out.print("<caption>"+ request.getParameter("view") +"</caption>");
			out.print("<tr>");
				out.print("<th>First Name</th>");
				out.print("<th>Last Name</th>");
				out.print("<th>Email</th>");
				out.print("<th>Password</th>");
			out.print("</tr>");
			//parse out the results
			while (rs.next()) {
				out.print("<tr>");
					out.print("<td>");
						out.print(rs.getString("firstName"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("lastName"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("email"));
					out.print("</td>");
					out.print("<td>");
						out.print(rs.getString("password"));
					out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");	
		}
		//close the connection
		con.close();
	} catch (Exception e) {
		out.println(e);
	}
%>
</body>
</html>