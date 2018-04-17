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
                out.println("<a href=\"shoppingCartServlet\"><p style=\"float: right; padding-right: 50px;\">Shopping Cart</p></a>");
                out.println("<p style=\"float: right; padding-right: 50px;\">Hello! You haven't login yet</p>");
            }
            else 
            {
                out.println("<a href=\"handleLogoutServlet\"><p style=\"float: right; padding-right: 50px;\">Logout</p></a>");
                out.println("<a href=\"shoppingCartServlet\"><p style=\"float: right; padding-right: 50px;\">Shopping Cart</p></a>");
                out.println("<p style=\"float: right; padding-right: 50px;\">Welcome " + session_username + "</p>");
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
                    <li>Category 1</li>
                    <li>Category 2</li>
                    <li>Category 3</li>
                    <li>Category 4</li>
                    <li>Category 5</li>
                </ul>          
            </fieldset>
        </div>
        
        <div style="float: left; margin: 50px; padding: 20px;">
            <p>Search Book: <input type="text" size="100" name="search_name" /></p>
            <table style="padding: 20px;
                   margin-top: 50px;
                   border: 1px dotted #000000;
                   border-radius: 15px;">
                <tr>
                    <td style="padding: 20px;">
                        <form action="shoppingCartServlet">
                                <input type="hidden" name="bookID" value="B001">
                            <input type="hidden" name="bookName" 
                                   value="Russian Roulette: The Inside Story of Putin's War on America and the Election of Donald Trump" />
                            <input type="hidden" name="bookAuthor" value="Michael Isikoff and David Corn" />
                            <input type="hidden" name="bookPrice" value="17" />
                            <h4>Russian Roulette: The Inside Story of Putin's War on America and the Election of Donald Trump</h4>
                            <p>Michael Isikoff and David Corn</p>
                            <p>$17</p>
                            <a href="" style="font-size: 10px"><p>View Detail</p></a>
                            <input style="float: right;" type="submit" value="Add to Shopping Cart" />
                        </form>
                    </td>  
                </tr>  
                <tr>
                    <td style="padding: 20px;">
                        <form action="shoppingCartServlet">
                            <input type="hidden" name="bookID" value="B002">
                            <input type="hidden" name="bookName" 
                                   value="A Higher Loyalty: Truth, Lies, and Leadership">
                            <input type="hidden" name="bookAuthor" value="James Comey" />
                            <input type="hidden" name="bookPrice" value="15.99" />
                            <h4>A Higher Loyalty: Truth, Lies, and Leadership</h4>
                            <p>James Comey</p>
                            <p>$15.99</p>
                            <a href="" style="font-size: 10px"><p>View Detail</p></a>
                            <input style="float: right;" type="submit" value="Add to Shopping Cart" />
                        </form>
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
