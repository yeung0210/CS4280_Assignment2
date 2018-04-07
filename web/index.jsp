<%-- 
    Document   : index
    Created on : 2018/4/3, 上午 12:27:36
    Author     : yeung0210
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" import= "java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CS4280 Internet Bookstore</title>
    </head>
    <body>
        <center>   
             <h1>CS4280 Internet Bookstore</h1>
        </center>
        <br><br>
        <%
            String session_username = (String)session.getAttribute("username");
            if(session_username == null) {
                out.println("<a href=\"\"><p style=\"float: right; padding-right: 50px;\">Shopping Cart</p></a>");
                out.println("<p style=\"float: right; padding-right: 50px;\">Hello! You haven't login yet</p>");
            }
            else 
            {
                out.println("<a href=\"handleLogoutServlet\"><p style=\"float: right; padding-right: 50px;\">Logout</p></a>");
                out.println("<a href=\"\"><p style=\"float: right; padding-right: 50px;\">Shopping Cart</p></a>");
                out.println("<p style=\"float: right; padding-right: 50px;\">Welcome " + session_username + " !</p>");
            }
        %>
        <br><br><br><br>
        <div style="float: left;">
            <fieldset style="width: 150px; line-height: 2em;
                      border: 1px dotted #000000;
                      border-radius: 15px;
                      padding: 20px;
                      margin: 50px;">
                <%
                    if(session_username == null) {
                        out.println("<form action=\"handleLoginServlet\" onsubmit=\"return checkField()\" name=\"loginForm\" method=\"POST\">");
                        out.println("Username:");
                        out.println("<input type=\"text\" name=\"username\" />");
                        out.println("Password:");
                        out.println("<input type=\"password\" name=\"password\" />");
                        out.println("<a href=\"javascript:checkField()\"><input type=\"submit\" value=\"Login\" /></a>");
                        out.println("</form>");
                    }
                    else 
                    {
                        out.println("<h3>Test</h3>");
                        out.println("<a href=\"\"><p>Profile</p></a>");
                        out.println("<a href=\"\"><p>Setting</p></a>");
                        out.println("<a href=\"\"><p>Refund Request</p></a>");
                    }
                %>
                
                <script>
                    function checkField() {
                        if(loginForm.username.value == "" && loginForm.password.value == "")
                        {
                                window.alert("Please input the username and password"); 
                                document.loginForm.username.focus();
                                return false;
                        } else if(loginForm.username.value == "")
                                {
                                        window.alert("Please input the username");
                                        document.loginForm.username.focus();
                                        return false;
                                }
                          else if(loginForm.password.value == "") 
                                {
                                        window.alert("Please input the password");
                                        document.loginForm.password.focus();
                                        return false;
                                }
                    }
                </script>
            </fieldset>
            <fieldset style="width: 150px; line-height: 2em;
                      border: 1px dotted #000000;
                      border-radius: 15px;
                      padding: 20px;
                      margin: 50px;">
                <h3>Book Categories</h3>
                <ul>
                    <li>ahiofwelk</li>
                    <li>ahiofwelk</li>
                    <li>ahiofwelk</li>
                    <li>ahiofwelk</li>
                    <li>ahiofwelk</li>
                </ul>          
            </fieldset>
        </div>
        
        <div style="float: left">
            <table style="margin: 50px; 
                   padding: 20px; 
                   border: 1px dotted #000000;
                   border-radius: 15px;">
                <tr>
                    <td style="padding: 30px;">
                        <h3>Book name</h3>
                        <p>Book author</p>
                        <p>Book price</p>
                    </td>
                    <td style="padding: 30px;">
                        <h3>Book name</h3>
                        <p>Book author</p>
                        <p>Book price</p>
                    </td>
                    <td style="padding: 30px;">
                        <h3>Book name</h3>
                        <p>Book author</p>
                        <p>Book price</p>
                    </td>
                    <td style="padding: 30px;">
                        <h3>Book name</h3>
                        <p>Book author</p>
                        <p>Book price</p>
                    </td>
                    <td style="padding: 30px;">
                        <h3>Book name</h3>
                        <p>Book author</p>
                        <p>Book price</p>
                    </td>
                </tr>    
                    <% 
                          // connect to database and get the book information
//                        String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
//                        String dbLoginId = "aiad044";
//                        String dbPwd = "aiad044";
//    
//                        Connection con = null;
//                        Statement stmt = null;
//                        ResultSet rs = null;
//                        String strSQL = null;
//                        String result = null;
//    
//    //                    try {
//    //                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//    //                        con = DriverManager.getConnection(url, dbLoginId, dbPwd);
//    //                        stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
//    //                        out.println("Connected");
//    //                    } catch(ClassNotFoundException cnfe) {
//    //                        cnfe.printStackTrace();
//    //                    } catch(SQLException sqlex) { 
//    //                        sqlex.printStackTrace();
//    //                        throw sqlex;
//    //                    } 
//    //                    
//    //                    try {
//    //                        strSQL = "SELECT [Book_name] FROM [Book]";
//    //                        rs = stmt.executeQuery(strSQL);
//    //                        while (rs.next()) {
//    //                           out.println("<td>");
//    //                           result = rs.getString("Book_name");
//    //                           out.println(result);
//    //                           out.println("</td>");
//    //                        }
//    //                    } catch(SQLException sqlex) { 
//    //                        sqlex.printStackTrace();
//    //                        throw sqlex;
//    //                    } catch (NullPointerException ne) {
//    //                        out.println("Error!");
//    //                    }
//                        
//                        try {
//                            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//                            con = DriverManager.getConnection(url, dbLoginId, dbPwd);
//                            stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
//                            if (con != null && !con.isClosed())
//                            {
//                                out.println("Connected");
//                                strSQL = "SELECT [Book_name] FROM [Book]";
//                                rs = stmt.executeQuery(strSQL);
//                                while (rs.next()) {
//                                   out.println("<td>");
//                                   result = rs.getString("Book_name");
//                                   out.println(result);
//                                   out.println("</td>");
//                                } 
//                            } 
//                        } catch(ClassNotFoundException cnfe) {
//                            cnfe.printStackTrace();
//                        } catch(SQLException sqlex) { 
//                            sqlex.printStackTrace();
//                            throw sqlex;
//                        } catch (NullPointerException ne) {
//                            out.println("Error!");
//                        } finally {
//                            try {
//                                if(rs!=null)
//                                    rs.close();
//                                if(stmt!=null)
//                                    stmt.close();
//                                if(con!=null)
//                                    con.close();
//                            }
//                            catch(Exception ex) {
//                                System.out.println(ex.toString());
//                            }
//    
//                        }
                    %>
                </tr>
        </table>
        </div>
</html>
