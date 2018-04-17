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
 * @author yu
 */
public class confirmCheckoutServlet extends HttpServlet {

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
        
        
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            Double totalPriceConfirmed;
            totalPriceConfirmed = Double.parseDouble(request.getParameter("totalPrice"));
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>CS4280 Internet Bookstore - Confirm Ordert</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<body><br><br><br>");
            out.println("<center><h1>Successful Payment!</h1>");
            out.println("<h4>Order ID: xxxxx</h4>");
            out.println("<h4>Total: " + totalPriceConfirmed + "</h4>");
            
            HttpSession session = request.getSession();
            int loyalttPoint = (Integer)session.getAttribute("loyalttPoint");
            int usedPoint = 0;
            if (session.getAttribute("usedPoints") != null) {
                usedPoint = (Integer)session.getAttribute("usedPoints");
            }
               
            int currentPoints = loyalttPoint - usedPoint;
            session.setAttribute("loyalttPoint", currentPoints);
            session.setAttribute("shoppingCart", null);
            session.setAttribute("usedPoints", null);
            
            if (totalPriceConfirmed >= 50) {
                out.println("<h3>Special reward for members: Every $50 in the purchase can earn 1 loyalty point</h3>");
                         out.println("<form action=\"enquiryPointServlet\" method=\"post\">");
                         out.println("<input type=\"hidden\" name=\"totalPrice\" "
                                + "value=\"" + totalPriceConfirmed + "\">");
                         out.println("<input type=\"submit\" value=\"Enquiry Loyalty Points\" />");
                         out.println("</form>");
            }
                out.println("<a href=\"index.jsp\"><p>Go Back to home page</p></a>");
                out.println("</body>");
                out.println("</html>");
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
