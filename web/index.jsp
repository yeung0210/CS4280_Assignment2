<%-- 
    Document   : index
    Created on : 2018/4/3, 上午 12:27:36
    Author     : yeung0210
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CS4280 Internet Bookstore</title>
    </head>
    <body>
        <center>   
            <font face="Times new Roman" size="7" color="Orange">CS4280 Internet Bookstore
        </center>
        <br><br>
        <table>
            <tr>
                <% 
                    
                    String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
                    String dbLoginId = "aiad044";
                    String dbPwd = "aiad044";

                    Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    String strSQL = null;
                    String result = null;

                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                        stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    } catch(ClassNotFoundException cnfe) {
                        cnfe.printStackTrace();
                    } catch(SQLException sqlex) {
                        sqlex.printStackTrace();
                    }

                    try {
                        strSQL = "SELECT [Book_name] FROM [aiad044_db].[dbo].[Book]";
                        rs = stmt.executeQuery(strSQL);
                        while (rs.next()) {
                           out.println("<td>");
                           out.println(rs.getString("Book_name"));
                           out.println("</td>");
                        }
                    } catch (SQLException sqlex) {
                        sqlex.printStackTrace();
                        throw sqlex;
                    } catch (NullPointerException ne) {
                        out.println("Error!");
                    }

                %>
            </tr>
        </table>
                
</html>
