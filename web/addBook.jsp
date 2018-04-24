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
            <fieldset style="width: 500px; line-height: 2em;
                      border: 1px dotted #000000;
                      text-align: left;
                      border-radius: 15px;
                      padding: 20px;
                      margin: 50px;">
                <form action="addBookServlet" method="POST" id="addBookForm">
                    <h4>Add Book Form</h4>
                    Book Name: <input type="text" name="bookName" /><br>
                    Book Author: <input type="text" name="bookAuthor" /><br>
                    Description: <br>
                    <textarea rows="4" cols="50" name="bookDescription" form="addBookForm"></textarea><br>
                    Book Price: <input type="text" name="bookPrice" /><br>
                    Available Quantity: <input type="text" name="bookQuantity" /><br>
                    <input type="submit" value="Add">
                </form>
            </fieldset>
        </center>
    </body>
</html>
