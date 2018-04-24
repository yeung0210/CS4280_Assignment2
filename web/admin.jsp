<%-- 
    Document   : admin
    Created on : Apr 22, 2018, 6:44:32 PM
    Author     : cyeung234
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" import= "java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CS4280 Internet Bookstore - Admin</title>
    </head>
    <body>
    <center><h1>CS4280 Internet Bookstore</h1>
    
        <a href="handleLogoutServlet"><p style="float: right; padding-right: 50px;">Logout</p></a>
        <a href="authorizeRequest.jsp"><p style="float: right; padding-right: 50px;"> Authorize Refund Request</p></a>
        <a href=""><p style="float: right; padding-right: 50px;"> Add Book</p></a>
        <p style="float: right; padding-right: 50px;">Welcome Book Manager!</p>
        
        <div style="margin: 50px; padding: 20px;">
            <table style="padding: 20px;
                   width: 500px;
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
                                   int quantity = rs.getInt("Book_Quantity");
                    %>
                    <tr>
                        <td style="padding: 20px;">
                            <h4><%=name%></h4>
                            <p><%=author%></p>
                            <p>$<%=price%></p>
                            <p>Quantity: <%=quantity%></p>
                            <form action="" method="POST">
                                <input type="hidden" name="bookID" value="<%=id%>">
                                <input type="hidden" name="bookName" value="<%=name%>" />
                                <input type="hidden" name="bookAuthor" value="<%=author%>" />
                                <input type="hidden" name="bookPrice" value="<%=price%>" />
                                <input type="submit" value="Modify Book Details" />
                            </form>
                            <br>
                            <form action="deleteBookServlet" method="POST" onsubmit="return confirmDelete()">
                                <input type="hidden" name="bookID" value="<%=id%>">
                                <input type="submit" value="Delete Book" />
                            </form>
                                <script>
                                    function confirmDelete() {
                                        var r = confirm("Are you sure to delete the book?");
                                        if (r) {
                                            return true;
                                        }
                                        else {
                                            return false;
                                        }
                                    }
                                </script>
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
                    
                    
            </center>
        </table>
        </div>
    </body>
</html>
