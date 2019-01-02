<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrative Page</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>
<%
	if(session.getAttribute("adminID") == null) {
		response.sendRedirect("success.jsp");
	}
%>
	<ul>
		<li><a onclick="toggle('employee');">Create Employees</a></li>
		<li><a onclick="toggle('delete')">Delete an Employee</a></li>
		<li><a onclick="toggle('view_users')">View Users</a></li>
		<li><a onclick="toggle('view_earnings')">View Earnings</a></li>
		<li><a href="view_best.jsp">View Best</a></li>
		<li><a onclick="toggle('email')">Send Email</a></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>

	<div id="employee" style="display:none;">
		<form action="create_employees.jsp" method="POST">
			<fieldset>
				<legend>Create Customer Representatives</legend>
				<input class="form_fields" type="text" name="firstName" placeholder="First Name" required/><br/>
				<input class="form_fields" type="email" name="email" placeholder="Email" required/><br/>
				<input type="submit" value="Create!"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>
	
	<div id="delete" style="display:none;">
		<form action="deleteSingular.jsp" method="POST">
			<fieldset>
				<legend>Delete Employees</legend>
				<input class="form_fields" type="text" name="firstName" placeholder="First Name"/><br/>
				<input class="form_fields" type="email" name="email" placeholder="Email" required/><br/>
				<input type="submit" value="Delete"/>
				<input type="reset">
			</fieldset>
		</form>
		
		<form action="deleteMultiple.jsp" method="POST">
			<fieldset>
				<legend>Delete Multiple Employees</legend>
				<input class="form_fields" type="text" name="firstName" placeholder="First Name"/><br/>
				<input class="form_fields" type="email" name="email" placeholder="Email"/><br/>
				<input type="submit" value="Delete"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>
	
	<div id="view_users" style="display:none;">
		<form action="view.jsp" method="POST">
			<fieldset>
				<legend>User Type</legend>
				<select class="form_fields" name="view">
					<option value="custRep">Employees</option>
					<option value="Buyers">Buyers</option>
					<option value="Sellers">Sellers</option>
					<option value="Users">End-Users</option>
				</select><br/>
				<input type="submit" value="View"/>
			</fieldset>
		</form>
	</div>
	
	<div id="view_earnings" style="display:none;">
		<form action="view_earnings.jsp" method="POST">
			<fieldset>
				<legend>View Earnings</legend>
				<select class="form_fields" name="view_earnings">
					<option value="total">Total</option>
					<option value="item">By Item</option>
					<option value="type">By Type</option>
					<option value="user">By User</option>
				</select><br/>
				<input type="submit" value="View"/>
			</fieldset>
		</form>
	</div>
	
	<div id="email" style="display:none;">
		<form action="sendEmail.jsp" method="POST">
			<fieldset>
				<legend>Send Email to:</legend>
				<select class="form_fields" name="to">
					<option value="custRep">Employees</option>
					<option value="buyers">Buyers</option>
					<option value="sellers">Sellers</option>
					<option value="users">End-Users</option>
				</select><br/>
				<input class="form_fields" type="text" name="subject" placeholder="Subject" required/><br/>
				<input class="form_fields" type="text" name="content" maxlength="255" placeholder="Content" required/><br/>
				<input type="submit" value="Send!"/>
				<input type="reset">
			</fieldset>
		</form>
	</div>

</body>
</html>