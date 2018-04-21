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
        %>
                <a href="shoppingCartServlet"><p style="float: right; padding-right: 50px;">Shopping Cart</p></a>
                <p style="float: right; padding-right: 50px;">Hello! You haven't login yet</p>
        <%
            }
            else 
            {
        %>
                <a href="handleLogoutServlet"><p style="float: right; padding-right: 50px;">Logout</p></a>
                <a href="shoppingCartServlet"><p style="float: right; padding-right: 50px;">Shopping Cart</p></a>
                <p style="float: right; padding-right: 50px;">Welcome <%=session_username%></p>
        <%
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
                %>
                        <form action="handleLoginServlet" onsubmit="return checkField()" name="loginForm" method="POST">
                        Username:
                        <input type="text" name="username" />
                        Password:
                        <input type="password" name="password" />
                        <a href="javascript:checkField()"><input type="submit" value="Login" /></a>
                        </form>
                <%
                    }
                    else 
                    {
                %>
                        <h3>Test</h3>");
                        <a href=""><p>Profile</p></a>
                        <a href=""><p>Setting</p></a>
                        <a href="reqestRefund.jsp"><p>Request for Refund</p></a>
                <%
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
                   width: 800px;
                   margin-top: 50px;
                   border: 1px dotted #000000;
                   border-radius: 15px;">
                
                    <% 
                        String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
                        String dbLoginId = "aiad044";
                        String dbPwd = "aiad044";
    
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        String strSQL = null;
    

                        
                        try {
                            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                            con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                            stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            if (con != null && !con.isClosed())
                            {
                                strSQL = "SELECT * FROM [Book]";
                                rs = stmt.executeQuery(strSQL);
                                while (rs.next()) {
                                   String id = rs.getString("Book_ID");
                                   String name = rs.getString("Book_name");
                                   String author = rs.getString("Book_Author");
                                   Double price = rs.getDouble("Book_Price");
                    %>
                    <tr>
                        <td style="padding: 20px;">
                            <form action="shoppingCartServlet">
                                <input type="hidden" name="bookID" value="<%=id%>">
                                <input type="hidden" name="bookName" 
                                       value="<%=name%>" />
                                <input type="hidden" name="bookAuthor" value="<%=author%>" />
                                <input type="hidden" name="bookPrice" value="<%=price%>" />
                                <h4><%=name%></h4>
                                <p><%=author%></p>
                                <p>$<%=price%></p>
                                <a href="" style="font-size: 10px"><p>View Detail</p></a>
                                <span style="float: right;"><h5>Number of Items: <input type="text" size="4" name="bookQuantity" value="1" /></h5>
                                <input type="submit" value="Add to Shopping Cart" />
                                </span>
                            </form>
                        </td>  
                    </tr>  
                    
                    <%
                                } 
                            } 
                        } catch(ClassNotFoundException cnfe) {
                            cnfe.printStackTrace();
                        } catch(SQLException sqlex) { 
                            sqlex.printStackTrace();
                            throw sqlex;
                        } catch (NullPointerException ne) {
                            out.println("Error!");
                        } finally {
                            try {
                                if(rs!=null)
                                    rs.close();
                                if(stmt!=null)
                                    stmt.close();
                                if(con!=null)
                                    con.close();
                            }
                            catch(Exception ex) {
                                System.out.println(ex.toString());
                            }
    
                        }
                    %>
                    
                    
                
        </table>
        </div>
</html>
