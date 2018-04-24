<%-- 
    Document   : viewOrderRequested
    Created on : Apr 24, 2018, 8:24:58 PM
    Author     : cyeung234
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CS4280 Internet Bookstore - Admin (View Refund Order)</title>
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
        <table style="border: 1px solid black; border-collapse: collapse; padding: 10px">
            <tr>
            <th>Book Name</th>
            <th>Book author</th>
            <th>Quantity</th>
            <th>Price</th>
        <% 
            NumberFormat formatter = new DecimalFormat("#0.00");
            String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
            String dbLoginId = "aiad044";
            String dbPwd = "aiad044";

            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            ResultSetMetaData rsmd = null;
            String strSQL = null;
            int numberOfRows = 0;
            String input_order_id = request.getParameter("orderID");


            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                if (con != null && !con.isClosed()) {
                    strSQL = "SELECT Book.Book_Name, Book.Book_Author, Book.Book_Price, Orders.Book_Quantity, Orders.Total_Price "
                            + "FROM Orders inner join Book on Orders.Book_ID = Book.Book_ID WHERE Orders.Order_ID = '" + input_order_id +"'";
                    rs = stmt.executeQuery(strSQL);
                    rsmd = rs.getMetaData();
                    rs.last();
                    numberOfRows = rs.getRow();
                    for (int j = 1; j <=  numberOfRows; j++) { 
                        rs.absolute(j);
                        String name = rs.getString("Book_Name");
                        String author = rs.getString("Book_Author");
                        int quantity = rs.getInt("Book_Quantity");
                        Double price = rs.getDouble("Book_Price");
                        
            %>
            
                 <tr><td><%=name%></td>
                        <td><%=author%></td>
                        <td><%=quantity%></td>
                        <td>$<%=formatter.format(price * quantity) %></td></tr>
                 <% 
                    }
                    Double total_price = rs.getDouble("Total_Price");
                 %>
                  </table>
            <h4>Total: $ <%=total_price %></h4>
            <%
                            
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
    </body>
</html>
