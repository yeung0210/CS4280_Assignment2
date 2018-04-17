<%-- 
    Document   : checkout
    Created on : 2018年4月17日, 下午12:12:14
    Author     : yu
--%>
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
            shoppingCart cart;
            cart = (shoppingCart)session.getAttribute("shoppingCart");
            String session_username = (String)session.getAttribute("username");
            if(session_username == null) {
                out.println("<a href=\"shoppingCartServlet\"><p style=\"float: right; padding-right: 50px;\">Shopping Cart</p></a>");
                out.println("<a href=\"index.jsp\"><p style=\"float: right; padding-right: 50px;\">Home</p></a>");
                out.println("<p style=\"float: right; padding-right: 50px;\">Hello! You haven't login yet</p>");
            }
            else 
            {
                out.println("<a href=\"handleLogoutServlet\"><p style=\"float: right; padding-right: 50px;\">Logout</p></a>");
                out.println("<a href=\"shoppingCartServlet\"><p style=\"float: right; padding-right: 50px;\">Shopping Cart</p></a>");
                out.println("<a href=\"index.jsp\"><p style=\"float: right; padding-right: 50px;\">Home</p></a>");
                out.println("<p style=\"float: right; padding-right: 50px;\">Welcome " + session_username + "</p>");
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

                    out.println("<table style=\"border: 1px solid black; border-collapse: collapse; padding: 10px\">");
                    out.println("<tr>");
                    out.println("<th>Book Name</th>"
                            + "<th>Book author</th>"
                            + "<th>Quantity</th>"
                            + "<th>Price</th>");
                    for (int i = 0; i < cart.getItemsOrdered().size(); i++) {
                        Item currentItem = (Item)cart.getItemsOrdered().get(i);
                        out.println("<tr><td>" + currentItem.getBookName() + "</td>");
                        out.println("<td>" + currentItem.getBookAuthor() + "</td>");
                        out.println("<td>" + currentItem.getBookQuantity() + "</td>");
                        out.println("<td>" + currentItem.getBookPrice() * currentItem.getBookQuantity() + "</td></tr>");
                    }
                    Double usedPoints = (Double)session.getAttribute("usedPoints");
                    if (usedPoints != null) {
                        out.println("<tr><td colspan=2>Loyalty point</td>");
                        out.println("<td>" + usedPoints.intValue() +"</td>");
                        out.println("<td> -" + usedPoints +"</td></tr>");
                    }
                    out.println("</table>");
                    out.println("<h4>Total: $");
                    for (int i = 0; i < cart.getItemsOrdered().size(); i++) {
                        Item currentItem = (Item)cart.getItemsOrdered().get(i);
                        totalPrice += currentItem.getBookPrice() * currentItem.getBookQuantity();
                    }
                    if (session.getAttribute("usedPoints") != null) {
                        totalPrice -= usedPoints;
                    }
                    out.println(totalPrice);
                    out.println("</h4>");
                    
                }
                
                if(session_username != null) {
                     out.println("<h3>Special reward for members: Every $50 purchase can earn 1 loyalty point!!!!!</h3>");
                     out.println("<form action=\"usePointsServlet\" method=\"post\">");
                     out.println("<input type=\"hidden\" name=\"totalPrice\" "
                            + "value=\"" + totalPrice + "\">");
                     out.println("<input type=\"submit\" value=\"Use Loyalty Points to pay\" />");
                     out.println("</form>");
                     out.println("<br>");
                     out.println("<form action=\"\">");
                     out.println("<input type=\"submit\" value=\"Enquiry Loyalty Points in this purchase\" />");
                     out.println("</form>");
                }
            %>
        
            <fieldset style="line-height: 2em;
                      width: 600px;
                      text-align: left;
                      padding: 20px;
                      margin: 50px;">
                <form onsunmit="return checkPaymentField()" action="confirmCheckoutServlet" method="post" name="paymentForm">
                    <h3>Order Information</h3>
                    <%
                        if(session_username == null) {
                            out.println("User: Guest");
                            out.println("<br>");
                        }
                        else 
                        {
                            out.println("User: " + session_username);
                            out.println("<br>");
                        }
                    %>
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
                if(paymentForm.creditCardNumber.value === "" && paymentForm.creditCardExpireMonth.value == "" && paymentForm.creditCardExpireYear.value == "" && paymentForm.creditCardCVV.value == "")
                {
                        window.alert("Please fill in all required infomation."); 
                        return false;
                } 
            }
        </script>
        </center>

        
    </body>
</html>
