<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>

<html>
  <body>

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
ResultSet rs = conn.createStatement().executeQuery("SELECT ID, Name FROM Course");
%>

<table style="border: 1px solid black">
<tbody>
<tr>
<th style="background-color: #CCFFCC; margin: 5px">ID</th>
<th style="background-color: #CCFFCC; margin: 5px">Course</th>
</tr>

<%
while (rs.next()) {
    String name = rs.getString("name");
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
No more courses!
<p><strong>Enter a course</strong></p>
<form action="/addcourse" method="post">
    <div>Name: <input type="text" name="name"></input></div>
    <div><input type="submit" value="Add Course" /></div>
    <input type="hidden" name="addCourse" />
  </form>
  </body>
</html>
