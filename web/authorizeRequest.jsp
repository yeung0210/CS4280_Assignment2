<%-- 
    Document   : authorizeRequest
    Created on : Apr 23, 2018, 8:34:37 PM
    Author     : cyeung234
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CS4280 Internet Bookstore - Admin (Authorize Refund Request)</title>
        <style>
        table, th, td {
            border: 1px solid black;
            text-align: left;
            padding: 15px;
        }
        </style>
    </head>
    <body>
        <center><h1>CS4280 Internet Bookstore</h1>
            <% 
                NumberFormat formatter = new DecimalFormat("#0.00");
                String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
                String dbLoginId = "aiad044";
                String dbPwd = "aiad044";

                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                ResultSet rsOrder = null;
                ResultSet rsBook = null;
                ResultSetMetaData rsmd = null;
                String strSQLRequest = null;
                String strSQLOrder = null;
                String strSQLBook = null;
                int numberOfRowsRequest = 0;
                int numberOfRowsBook = 0;

                try {
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                    stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    if (con != null && !con.isClosed()) {
                        strSQLRequest = "SELECT * FROM [Request] WHERE [Approved] = 'X'";
                        rs = stmt.executeQuery(strSQLRequest);
                        rsmd = rs.getMetaData();
                        rs.last();
                        numberOfRowsRequest = rs.getRow();
                        for (int j = 1; j <=  numberOfRowsRequest; j++) { 
                            rs.absolute(j);
                            String request_id = rs.getString("Request_ID");
                            String order_id = rs.getString("Order_ID");
                            Double refund_value = rs.getDouble("Request_Values");
                            String request_reason = rs.getString("Request_Reason");
            %>
            <fieldset style="line-height: 2em;
                      border: 1px dotted #000000;
                      text-align: left;
                      border-radius: 15px;
                      padding: 20px;
                      margin: 50px;">

                   
                <p>Order ID: <%=order_id%><br>
                   Refund Value: $<%=refund_value%><br>
                   Reason: <%=request_reason%> 
                </p>
                <table style="border: 1px solid black; border-collapse: collapse; padding: 10px">
                    <tr>
                    <th>Book Name</th>
                    <th>Book author</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    </tr>
                <%
                            strSQLOrder = "SELECT Book.Book_Name, Book.Book_Author, Book_Price, Orders.Book_Quantity, Orders.Order_ID FROM Request inner join Orders on Orders.Order_ID = Request.Order_ID inner join Book on Orders.Book_ID = Book.Book_ID WHERE Orders.Order_ID = '" + order_id + "'";
                            rs = stmt.executeQuery(strSQLOrder);
                            rsmd = rs.getMetaData();
                            rs.last();
                            numberOfRowsBook = rs.getRow();
 
                            for (int k = 1; k <= numberOfRowsBook; k++) { 
                                rs.absolute(k);
                                String name = rs.getString("Book_Name");
                                String author = rs.getString("Book_Author");
                                double price = rs.getDouble("Book_Price");
                                int quantity = rs.getInt("Book_Quantity");
                %>
                                <tr><td><%=name%></td>
                                <td><%=author%></td>
                                <td><%=quantity%></td>
                                <td>$<%=formatter.format(price * quantity) %></td>
                                </tr>
                
            <%
                            }
                        }
                    }
                }catch(ClassNotFoundException cnfe) {
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
            </fieldset>
        </center>
    </body>
</html>
