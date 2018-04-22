<%-- 
    Document   : reqestRefund
    Created on : 2018年4月17日, 下午12:02:30
    Author     : yu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CS4280 Internet Bookstore - Request for Refund</title>
    </head>
    <body>
        <center>   
             <h1>CS4280 Internet Bookstore</h1>
        </center>
        <br><br>
        <%
            String session_username = (String)session.getAttribute("username");
        %>
            <a href="handleLogoutServlet"><p style="float: right; padding-right: 50px;">Logout</p></a>
            <a href="shoppingCartServlet"><p style="float: right; padding-right: 50px;">Shopping Cart</p></a>
            <p style="float: right; padding-right: 50px;">Welcome<%=session_username %></p>

        
        <center>
            <fieldset style="width: 500px; line-height: 2em;
                      border: 1px dotted #000000;
                      text-align: left;
                      border-radius: 15px;
                      padding: 20px;
                      margin: 50px;">
                <form action="requestRefundServlet" method="POST" id="refundForm">
                    <h4>Refund Form</h4>
                    Order ID: <input type="text" name="orderID" /><br>
                    How much do you want to refund: <input type="text" name="refundValue" /><br>
                    Reason: <br>
                    <textarea rows="4" cols="50" name="reason" form="refundForm"></textarea><br>
                    <input type="submit" value="Submit" />
                </form>
            </fieldset>
        </center>
    </body>
</html>
