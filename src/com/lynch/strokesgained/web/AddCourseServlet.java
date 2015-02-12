package com.lynch.strokesgained.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.utils.SystemProperty;

@SuppressWarnings("serial")
public class AddCourseServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String url = null;
	    try {
	    	if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
		        // Load the class that provides the new "jdbc:google:mysql://" prefix.
		        Class.forName("com.mysql.jdbc.GoogleDriver");
		        url = "jdbc:google:mysql://173.194.82.75/strokes-gained?user=root&password=carlowithdip";
	    	}
	    	else {
		        // Local MySQL instance to use during development.
		        Class.forName("com.mysql.jdbc.Driver");
		        url = "jdbc:mysql://127.0.0.1:3306/strokes-gained?user=c00175471&password=carlowithdip";
	    	}
	    } 
	    catch (Exception e) {
	    	e.printStackTrace();
	    	return;
	    }

	    PrintWriter out = resp.getWriter();
	    try {
	    	Connection conn = DriverManager.getConnection(url);
	    	try {
	    		String name = req.getParameter("name");
	    		if (name == "") {
	    			out.println("<html><head></head><body>You did not enter a course name! Try again! Redirecting in 2 seconds...</body></html>");
	    		} 
	    		else {
	    			String statement = "INSERT INTO Course (Name) VALUES( ? )";
	    			PreparedStatement stmt = conn.prepareStatement(statement);
	    			stmt.setString(1, name);
	    			int success = 2;
	    			success = stmt.executeUpdate();
	    			if (success == 1) {
	    				out.println("<html><head></head><body>Success! Redirecting in 2 seconds...</body></html>");
	    			} 
	    			else if (success == 0) {
	    				out.println("<html><head></head><body>Failure! Please try again! Redirecting in 2 seconds...</body></html>");
	    			}
	    		}
	    	} 
	    	finally {
	    		conn.close();
	    	}
	    } 
	    catch (SQLException e) {
	    	e.printStackTrace();
	    }
	    
	    resp.setHeader("Refresh", "2; url=/addcourse.jsp");
	}
}
