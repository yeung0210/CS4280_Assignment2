<%-- 
    Document   : addBook
    Created on : Apr 24, 2018, 9:42:34 PM
    Author     : cyeung234
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CS4280 Internet Bookstore - Add Book Form</title>
    </head>
    <body>
        <center><h1>CS4280 Internet Bookstore</h1>
        <a href="handleLogoutServlet"><p style="float: right; padding-right: 50px;">Logout</p></a>
        <a href="authorizeRequest.jsp"><p style="float: right; padding-right: 50px;"> Authorize Refund Request</p></a>
        <a href="addBook.jsp"><p style="float: right; padding-right: 50px;"> Add Book</p></a>
        <a href="admin.jsp"><p style="float: right; padding-right: 50px;"> Home</p></a>
        <p style="float: right; padding-right: 50px;">Welcome Book Manager!</p>
        <br><br>
            <fieldset style="width: 500px; line-height: 2em;
                      border: 1px dotted #000000;
                      text-align: left;
                      border-radius: 15px;
                      padding: 20px;
                      margin: 50px;">

                <form action="modifyBookServlet" method="POST" id="modifyBookForm">
                    <h4>Modify Book Form</h4>
                    <input type="hidden" name="bookID" value="<%=request.getParameter("bookID")%>">
                    Book Name: <input type="text" name="bookName" value="<%=request.getParameter("bookName") %>" /><br>
                    Book Author: <input type="text" name="bookAuthor" value="<%=request.getParameter("bookAuthor") %>" /><br>
                    Description: <br>
                    <textarea rows="4" cols="50" name="bookDescription" form="modifyBookForm"><%=request.getParameter("bookDescription") %></textarea><br>
                    Book Price: <input type="text" name="bookPrice" value="<%=request.getParameter("bookPrice") %>"/><br>
                    Available Quantity: <input type="text" name="bookQuantity" value="<%=request.getParameter("bookQuantity") %>"/><br>
                    <input type="submit" value="Modify">
                </form>
            </fieldset>
        </center>
    </body>
</html>
