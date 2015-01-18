<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>

<html>
  <body style="background:pink">

<%
String url = null;
if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
  // Load the class that provides the new "jdbc:google:mysql://" prefix.
  Class.forName("com.mysql.jdbc.GoogleDriver");
  url = "jdbc:google:mysql://173.194.82.75/strokes-gained?user=root&password=carlowithdip";
} else {
  // Local MySQL instance to use during development.
  Class.forName("com.mysql.jdbc.Driver");
  url = "jdbc:mysql://127.0.0.1:3306/strokes-gained?user=c00175471&password=carlowithdip";
}

Connection conn = DriverManager.getConnection(url);
ResultSet rs = conn.createStatement().executeQuery("SELECT ID, Name1, Name2 FROM Player");
%>
<div style="margin: 20px auto; width:100%; max-width:1200px; background:#fff">
<table style="border: 1px solid black">
<tbody>
<tr>
<th style="background-color: #CCFFCC; margin: 5px">ID</th>
<th style="background-color: #CCFFCC; margin: 5px">Player</th>
</tr>

<%
while (rs.next()) {
    String name = rs.getString("name1") + " " + rs.getString("name2");
    int id = rs.getInt("ID");
 %>
<tr>
<td><%= id %></td>
<td><%= name %></td>
</tr>
<%
}
conn.close();
%>

</tbody>
</table>
<br />
<p><strong>Enter a player</strong></p>
<form action="/addplayer" method="post">
    <div>First Name: <input type="text" name="fname"></input></div>
    <div>Surname: <input type="text" name="sname"></input></div>
    <div><input type="submit" value="Add Player" /></div>
    <input type="hidden" name="addPlayer" />
  </form>
  <div>
  </body>
</html>
