<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Representative HomePage</title>
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
		<li><a href="questionsAnswer.jsp">Answer Questions</a></li>
		<li><a onclick="toggle('modify');">Modify User Account</a></li>
		<li><a onclick="toggle('bids')">Remove Bids</a></li>
		<li><a onclick="toggle('auctions')">Remove Auction</a></li>
		<li><a href="email.jsp">Email</a></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	
	<div id="modify" style="display:none;">
		<form action="modify_users.jsp" method="POST">
			<fieldset>
				<legend>Modify User Account</legend>
				<input class="form_fields" type="email" name="email" placeholder="Email" required/><br/>
				<input class="form_fields" type="text" name="newPwd" placeholder="New Password" required/><br/>
				<input type="submit" value="Modify"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>
		
	<div id="bids" style="display:none;">
		<form action="deleteBids.jsp" method="POST">
			<fieldset>
				<legend>Remove Bids</legend>
				<input class="form_fields" type="text" name="bidID" placeholder="Bid ID"/><br/>
				<input class="form_fields" type="email" name="buyerID" placeholder="Buyer Email"/><br/>
				<input type="submit" value="Delete"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>
	
	<div id="auctions" style="display:none;">
		<form action="deleteAuctions.jsp" method="POST">
			<fieldset>
				<legend>Remove Auction</legend>
				<input class="form_fields" type="text" name="auctionID" placeholder="Auction ID" required/><br/>
				<input type="submit" value="Delete"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>

</body>
</html>