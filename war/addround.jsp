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
ResultSet rsp = conn.createStatement().executeQuery("SELECT ID, Name1, Name2 FROM Player");
ResultSet rsc = conn.createStatement().executeQuery("SELECT ID, Name FROM Course");
%>
<div style="margin: 20px auto; width:100%; max-width:1200px; background:#fff">
<table style="border: 1px solid black">
<tbody>
<tr>
<th style="background-color: #CCFFCC; margin: 5px">ID</th>
<th style="background-color: #CCFFCC; margin: 5px">Player</th>
</tr>

<%
while (rsp.next()) {
    String pname = rsp.getString("name1") + " " + rsp.getString("name2");
    int id = rsp.getInt("ID");
 %>
<tr>
<td><%= id %></td>
<td><%= pname %></td>
</tr>
<%
}
%>

</tbody>
</table>
<br />

<div style="margin: 20px auto; width:100%; max-width:1200px; background:#fff">
<table style="border: 1px solid black">
<tbody>
<tr>
<th style="background-color: #CCFFCC; margin: 5px">ID</th>
<th style="background-color: #CCFFCC; margin: 5px">Course</th>
</tr>

<%
while (rsc.next()) {
    String cname = rsc.getString("name");
    int id = rsc.getInt("ID");
 %>
<tr>
<td><%= id %></td>
<td><%= cname %></td>
</tr>
<%
}
conn.close();
%>

<p><strong>Enter a round</strong></p>
<form action="/addround" method="post">
    <div>Date: <input type="text" name="rounddate"></input></div>
    <div>Notes: <input type="text" name="notes"></input></div>
    <div>Player: <input type="text" name="playerid"></input></div>
    <div>Course: <input type="text" name="courseid"></input></div>
    <div><input type="submit" value="Add Round" /></div>
    <input type="hidden" name="addRound" />
  </form>
  <div>
  </body>
</html>
