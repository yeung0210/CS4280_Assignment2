/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs4280;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yeung0210
 */
public class shoppingCartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        shoppingCart cart;
        String input_ID = request.getParameter("bookID");
        String input_name = request.getParameter("bookName");
        String input_author = request.getParameter("bookAuthor");
        String input_price_string = request.getParameter("bookPrice");
        String input_quantity_string = request.getParameter("bookQuantity");
        
        
        cart = (shoppingCart)session.getAttribute("shoppingCart");
        
        if (input_quantity_string == null) {
            int input_quantity = 0;
        }
       
        if (input_name != null && input_author != null && input_price_string != null && input_quantity_string != null) {
            double input_price = Double.parseDouble(input_price_string);
            int input_quantity = Integer.parseInt(input_quantity_string);
            synchronized(session) {
                
                if (cart == null) {
                  cart = new shoppingCart();
                  session.setAttribute("shoppingCart", cart);
                }
                
                boolean bookExist = false;
                int index = -1;
                 for (int i = 0; i < cart.getItemsOrdered().size(); i++) {
                    Item currentItem = (Item)cart.getItemsOrdered().get(i);
                    if (currentItem.getBookID().equals(input_ID)) {
                        bookExist = true;
                        index = i;
                    }
                }
                
                if (bookExist) {
                    Item foundItem = (Item)cart.getItemsOrdered().get(index);
                    foundItem.increaseQuantity(input_quantity);
                }
                else {
                   Item orderedItem = new Item(input_ID, input_name, input_author, input_price, input_quantity);
                   cart.addItem(orderedItem);
                }
                
            }
        }
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>CS4280 Internet Bookstore - Sucessful Login</title>");
        out.println("<style>");
        out.println("table, th, td {\n" +
            "border: 1px solid black;"
            + "text-align: left;"
            + "padding: 15px;" +
            "}");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<center>");  
        out.println("<h1>CS4280 Internet Bookstore</h1>");
        
        if (cart == null) {
            out.println("<br><br><br>");
            out.println("<h3>No Item is selected!</h3>");
            out.println("<br><br>");
            out.println("<a href=\"index.jsp\"><p>Go Back to home page</p></a>");
        } 
        else {
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
                out.println("</table>");
                out.println("<h4>Total Price: $");
                double totalPrice = 0;
                for (int i = 0; i < cart.getItemsOrdered().size(); i++) {
                    Item currentItem = (Item)cart.getItemsOrdered().get(i);
                    totalPrice += currentItem.getBookPrice() * currentItem.getBookQuantity();
                }
                out.println(totalPrice);
                out.println("</h4>");
                out.println("<br><br>");
                out.println("<form action=\"checkout.jsp\" method=\"post\"><br>");
                out.println("<input type=\"submit\" value=\"Checkout\">");
                out.println("</form>");
                out.println("<br><br>");
                out.println("<a href=\"index.jsp\"><p>Go Back to home page</p></a>");
            }
        }
    }
        
        
    
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
