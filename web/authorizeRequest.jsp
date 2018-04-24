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
        
    </head>
    <body>
        <center><h1>CS4280 Internet Bookstore</h1>
        <a href="handleLogoutServlet"><p style="float: right; padding-right: 50px;">Logout</p></a>
        <a href="authorizeRequest.jsp"><p style="float: right; padding-right: 50px;"> Authorize Refund Request</p></a>
        <a href="addBook.jsp"><p style="float: right; padding-right: 50px;"> Add Book</p></a>
        <a href="admin.jsp"><p style="float: right; padding-right: 50px;"> Home</p></a>
        <p style="float: right; padding-right: 50px;">Welcome Book Manager!</p>
        <br><br>
            <fieldset style="line-height: 2em;
                      width: 500px;
                      border: 1px dotted #000000;
                      text-align: left;
                      border-radius: 15px;
                      padding: 20px;
                      margin: 50px;">
            <% 
                String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
                String dbLoginId = "aiad044";
                String dbPwd = "aiad044";

                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                ResultSetMetaData rsmd = null;
                String strSQLRequest = null;
                int numberOfRowsRequest = 0;
                
                
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
            

                <h3><%=request_id%></h3>
                <p>Order ID: <%=order_id%><br>
                   Refund Value: $<%=refund_value%><br>
                   Reason: <%=request_reason%> 
                </p>
                
                    
                    
                    
                    <p>Approve? 
                        <form action="handleRequestServlet" method="POST" >
                            <input type="hidden" name="requestID" value="<%=request_id%>" />
                            <input type="hidden" name="answer" value="Y" />
                            <input type="submit" value="YES">
                        </form>
                        <form action="handleRequestServlet" method="POST" >
                            <input type="hidden" name="answer" value="N" />
                            <input type="hidden" name="requestID" value="<%=request_id%>" />
                            <input type="submit" value="NO">
                        </form>
                    </p>
                        <span style="float: right;">
                        <form action="viewOrderRequested.jsp" method="POST" id="viewOrder">
                            <input type="hidden" name="orderID" value="<%=order_id%>" />
                            <a href="javascript:;" onclick="document.getElementById('viewOrder').submit();">View Order</a>
                        </form>
                        
                    </span>
                <br><br>
                
            <%
                            
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
            </fieldset>
        </center>
    </body>
</html>
