<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search</title>
<link rel="stylesheet" href="styles.css">
<script src="scripts.js"></script>
</head>
<body>

	<header>
		<h1>Search Auctions</h1>
	</header>
	
	<ul>
		<li><a onclick="back();">Back</a></li>
	</ul>
	
	<div style="margin:auto; width:90%;">
		<form id="search_index" method="POST">
			<fieldset>
				<legend>Search</legend>
				<input class="form_fields" type="text" name="auctionID" placeholder="Auction ID"/>
				<input class="form_fields" type="text" name="title" placeholder="Title"/>
				<input class="form_fields" type="text" name="artist" placeholder="Artist"/>
				<input class="form_fields" type="text" name="genre" placeholder="Genre"/>
				<input class="form_fields" type="text" name="type" placeholder="Type"/>
				<input type="submit" value="Search!"/>
				<input type="submit" value="Bid History" formaction="bidHistory.jsp"/>
				<input type="submit" value="Similar Items" formaction="similar_items.jsp">
				<input type="reset"/>
			</fieldset>
		</form>
	</div>
	<br/>
	
<%
	boolean one = request.getParameter("auctionID").isEmpty();
	boolean two = request.getParameter("title").isEmpty();
	boolean three = request.getParameter("artist").isEmpty();
	boolean four = request.getParameter("genre").isEmpty();
	boolean five = request.getParameter("type").isEmpty();
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://Link to Database","username", "password");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR title like '%" + 
			request.getParameter("title") + "%' OR artist like '%" + request.getParameter("artist") + "%' OR genre like '%" + 
			request.getParameter("genre") + "%' OR type like '%" + request.getParameter("type") + "%'");
		// 5 empty
		if(one && two && three && four && five) {
			out.println("Search Failed.");
			return;
		}
		//4 empty
		else if(two && three && four && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "%'");
		}
		//4 empty
		else if(one && three && four && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE title like '%" + request.getParameter("title") + "%'");
		}
		//4 empty
		else if(one && two && four && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE artist like '%" + request.getParameter("artist") + "%'");
		}
		//4 empty
		else if(one && two && three && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE genre like '%" + request.getParameter("genre") + "%'");
		}
		//4 empty
		else if(one && two && three && four) {
			rs = st.executeQuery("SELECT * FROM items WHERE type like '%" + request.getParameter("type") + "%'");
		}
		//3 empty
		else if(one && two && three) {
			rs = st.executeQuery("SELECT * FROM items WHERE genre like '%" + 
				request.getParameter("genre") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//3 empty
		else if(one && two && four) {
			rs = st.executeQuery("SELECT * FROM items WHERE artist like '%" + 
				request.getParameter("artist") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//3 empty
		else if(one && two && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE artist like '%" + 
				request.getParameter("artist") + "%' OR genre like '%" + request.getParameter("genre") + "%'");
		}
		//3 empty
		else if(one && three && four) {
			rs = st.executeQuery("SELECT * FROM items WHERE title like '%" + 
				request.getParameter("title") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//3 empty
		else if(one && three && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE title like '%" + 
				request.getParameter("title") + "%' OR genre like '%" + request.getParameter("genre") + "%'");
		}
		//3 empty
		else if(one && four && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE title like '%" + 
				request.getParameter("title") + "%' OR artist like '%" + request.getParameter("artist") + "%'");
		}
		//3 empty
		else if(two && three && four) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" +
				request.getParameter("auctionID") + "' OR type like '%" + request.getParameter("type") + "%'");
		}
		//3 empty
		else if(two && three && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + 
				request.getParameter("auctionID") + "%' OR genre like '%" + request.getParameter("genre") + "%'");
		}
		//3 empty
		else if(two && four && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" +
				request.getParameter("auctionID") + "' OR artist like '%" + request.getParameter("artist") + "%'");
		}
		//3 empty
		else if(three && four && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + 
				request.getParameter("auctionID") + "' OR title like '%" + request.getParameter("title") + "%'");
		}
		//2 empty
		else if(one && two) {
			rs = st.executeQuery("SELECT * FROM items WHERE artist like '%" + request.getParameter("artist") + "%' OR genre like '%" + 
				request.getParameter("genre") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//2 empty
		else if(one && three) {
			rs = st.executeQuery("SELECT * FROM items WHERE title like '%" + request.getParameter("title") + "%' OR genre like '%" + 
				request.getParameter("genre") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//2 empty
		else if(one && four) {
			rs = st.executeQuery("SELECT * FROM items WHERE title like '%" + request.getParameter("title") + "%' OR artist like '%" + 
				request.getParameter("artist") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//2 empty
		else if(one && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE title like '%" + request.getParameter("title") + "%' OR artist like '%" + 
				request.getParameter("artist") + "%' OR genre like '%" + request.getParameter("genre") + "%'");
		}
		//2 empty
		else if(two && three) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR genre like '%" + 
				request.getParameter("genre") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//2 empty
		else if(two && four) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR artist like '%" + 
				request.getParameter("artist") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//2 empty
		else if(two && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR artist like '%" + 
				request.getParameter("artist") + "%' OR genre like '%" + request.getParameter("genre") + "%'");
		}
		//2 empty
		else if(three && four) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR title like '%" + 
				request.getParameter("title") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		//2 empty
		else if(three && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR title like '%" + 
				request.getParameter("title") + "%' OR genre like '%" + request.getParameter("genre") + "%'");
		}
		//2 empty
		else if(four && five) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR title like '%" + 
				request.getParameter("title") + "%' OR artist like '%" + request.getParameter("artist") + "%'");
		}
		//1 empty
		else if(one) {
			rs = st.executeQuery("SELECT * FROM items WHERE title like '%" + request.getParameter("title") + "%' OR artist like '%" 
				+ request.getParameter("artist") + "%' OR genre like '%" + request.getParameter("genre") + "%' OR type like '%" 
				+ request.getParameter("type") + "%'");
		}
		//1 empty
		else if(two) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "%' OR artist like '%" 
				+ request.getParameter("artist") + "%' OR genre like '%" + request.getParameter("genre") + "%' OR type like '%" 
				+ request.getParameter("type") + "%'");
		}
		//1 empty
		else if(three) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR title like '%" 
				+ request.getParameter("title") + "%' OR genre like '%" + request.getParameter("genre") + "%' OR type like '%" 
				+ request.getParameter("type") + "%'");
		}
		//1 empty
		else if(four) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR title like '%" 
				+ request.getParameter("title") + "%' OR artist like '%" + request.getParameter("artist") + "%' OR type like '%" 
				+ request.getParameter("type") + "%'");
		}
		//1 empty
		else if(five) {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR title like '%" 
				+ request.getParameter("title") + "%' OR artist like '%" + request.getParameter("artist") + "%' OR genre like '%" 
				+ request.getParameter("genre") + "%'");
		}
		//0 empty
		else {
			rs = st.executeQuery("SELECT * FROM items WHERE auctionID ='" + request.getParameter("auctionID") + "' OR title like '%" + 
				request.getParameter("title") + "%' OR artist like '%" + request.getParameter("artist") + "%' OR genre like '%" + 
				request.getParameter("genre") + "%' OR type like '%" + request.getParameter("type") + "%'");
		}
		out.print("<table style='width:100%'>");
			out.print("<tr>");
				out.print("<th>Auction ID</th>");
				out.print("<th>Title</th>");
				out.print("<th>Artist</th>");
				out.print("<th>Genre</th>");
				out.print("<th>Type</th>");
			out.print("</tr>");
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
			out.print("</tr>");
			}
		out.print("</table>");
	} catch(Exception ex) {
		out.println(ex);
	}
%>
</body>
</html>