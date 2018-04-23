<%-- 
    Document   : checkout
    Created on : 2018年4月17日, 下午12:12:14
    Author     : yu
--%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="cs4280.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" import= "java.util.*"%>
<!DOCTYPE html>
<html>
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CS4280 Internet Bookstore - Checkout</title>
        <style>
            table, th, td {
            border: 1px solid black;
            text-align: left;
            padding: 15px;
            }
        </style>
    </head>
    <body>
        <center>   
             <h1>CS4280 Internet Bookstore</h1>
        </center>
        <br><br>
        <%
            NumberFormat formatter = new DecimalFormat("#0.00");
            shoppingCart cart;
            cart = (shoppingCart)session.getAttribute("shoppingCart");
            String session_username = (String)session.getAttribute("username");
            if(session_username == null) {
        %>
                <a href="shoppingCartServlet"><p style="float: right; padding-right: 50px;">Shopping Cart</p></a>
                <a href="index.jsp"><p style="float: right; padding-right: 50px;">Home</p></a>
                <p style="float: right; padding-right: 50px;">Hello! You haven't login yet</p>
        <%
            }
            else 
            {
        %>
                <a href="handleLogoutServlet"><p style="float: right; padding-right: 50px;">Logout</p></a>
                <a href="shoppingCartServlet"><p style="float: right; padding-right: 50px;">Shopping Cart</p></a>
                <a href="index.jsp"><p style="float: right; padding-right: 50px;">Home</p></a>
                <p style="float: right; padding-right: 50px;">Welcome <%=session_username%></p>
        <%
            }
        %>
        <center>
        <br>
        <br>
        <br>
        <br>
        <%

            double totalPrice = 0;
            synchronized(session) {
                
        %>

            <table style="border: 1px solid black; border-collapse: collapse; padding: 10px">
                <tr>
                <th>Book Name</th>
                <th>Book author</th>
                <th>Quantity</th>
                <th>Price</th>
                <%
                    for (int i = 0; i < cart.getItemsOrdered().size(); i++) {
                        Item currentItem = (Item)cart.getItemsOrdered().get(i);
                %>
                        <tr><td><%=currentItem.getBookName()%></td>
                        <td><%=currentItem.getBookAuthor()%></td>
                        <td><%=currentItem.getBookQuantity()%></td>
                        <td>$<%=formatter.format(currentItem.getBookPrice() * currentItem.getBookQuantity()) %></td></tr>
                <%
                    }
                    int usedPoints = 0;
                    if (session.getAttribute("usedPoints") != null) {
                        usedPoints = (Integer)session.getAttribute("usedPoints");
                %>
                        <tr><td colspan=2>Loyalty point</td>
                        <td><%=usedPoints %></td>
                        <td>-$<%=usedPoints %></td></tr>
                <%
                    }
                %>
            </table>
            <h4>Total: $
            <%
                for (int i = 0; i < cart.getItemsOrdered().size(); i++) {
                    Item currentItem = (Item)cart.getItemsOrdered().get(i);
                    totalPrice += currentItem.getBookPrice() * currentItem.getBookQuantity();
                }
                if (session.getAttribute("usedPoints") != null) {
                    totalPrice -= usedPoints;
                }
                out.println(formatter.format(totalPrice));
            %>
                
             </h4>
            <%
                }
            if(session_username != null && session.getAttribute("usedPoints") == null) {
            %>
                <h3>Special reward for members: 1 loyalty point = $1</h3>
                <form action="usePointsServlet" method="post">
                <input type="hidden" name="totalPrice" value="<%=totalPrice%>" />
                <input type="submit" value="Use Loyalty Points to pay" />
                </form>
                <br>
            <%
            }
            %>
        
            <fieldset style="line-height: 2em;
                      width: 600px;
                      text-align: left;
                      padding: 20px;
                      margin: 50px;">
                <form action="confirmCheckoutServlet" onsubmit="return checkPaymentField()" method="POST" name="paymentForm">
                    <h3>Order Information</h3>
                    <%
                        if(session_username == null) {
                    %>
                            User: Guest
                            <br>
                    <%
                        }
                        else 
                        {
                    %>
                            User: <%=session_username%>
                            <br>
                    <%
                        }
                    %>
                    <input type="hidden" name="totalPrice" value="<%=totalPrice%>" />
                    Credit Card number: 
                    <input type="text" name="creditCardNumber" size='16'/><br>
                    Expire Date: 
                    <input type="text" name="creditCardExpireMonth" size='2'/> / <input type="text" name="creditCardExpireYear" size='4'/><br>
                    CVV:
                    <input type="text" name="creditCardCVV" size='2'/><br>
                    <a href="javascript:checkPaymentField()"><input type="submit" value="Confirm"></a>
                </form>
            </fieldset>
            <script>
                function checkPaymentField() {
                     if((paymentForm.creditCardNumber.value == "") || (paymentForm.creditCardExpireMonth.value == "") || (paymentForm.creditCardExpireYear.value == "") || (paymentForm.creditCardCVV.value == ""))
                     {
                             window.alert("Please fill in all required infomation."); 
                             return false;
                     } 
                 }
            </script>
        </center>

        
    </body>
</html>
