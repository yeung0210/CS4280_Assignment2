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
public class usePointsServlet extends HttpServlet {

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
           out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>CS4280 Internet Bookstore - Use Loyalty Point</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<center><h1>CS4280 Internet Bookstore</h1>");
            out.println("<body><br><br><br>");
            
            HttpSession session = request.getSession();
            if (session.getAttribute("loyalttPoint") == null) {
                session.setAttribute("loyalttPoint", 0);
            }
            int currentPoints = (Integer)session.getAttribute("loyalttPoint");
            if (session.getAttribute("usedPoints") == null) {
                session.setAttribute("usedPoints", 0);
            }
            int usedPoints = (Integer)session.getAttribute("usedPoints");
            String total_price_string = request.getParameter("totalPrice");
            Double total_price = Double.parseDouble(total_price_string);

            
            if (currentPoints > 0) {
                out.println("<h3>Points you have: " + currentPoints + "</h3>");
                out.println("<h3>Total in the order: $" + total_price + " </h3>");
                out.println("<form action=\"usePointsServlet\" action=\"POST\">");
                out.println("<input type=\"hidden\" name=\"totalPrice\" "
                            + "value=\"" + total_price + "\">");
                out.println("<h4>How many points do you want to use this time?");
                out.println("<input type=\"text\" name=\"pointsToUse\" size=\"4\" />");
                out.println("<input type=\"submit\" value=\"Use\" /></h4>");
                out.println("</form>");
                
                String points_string = request.getParameter("pointsToUse");
                if (points_string != null) {
                    Double points_double = Double.parseDouble(points_string);
                    if (points_double > currentPoints) {
                        out.println("<p style=\"color:red;\">Please enter a number no larger than the points you have");
                    }
                    else
                    {
                        usedPoints += points_double;
                        session.setAttribute("usedPoints", usedPoints);
                        response.sendRedirect("checkout.jsp");
                    }
                }
            }
            else {
                out.println("<h3>Sorry you have no points now</h3><br><br>");
                out.println("<a href=\"checkout.jsp\"><p>Go Back to checkout page</p></a>");
                out.println("<a href=\"index.jsp\"><p>Go Back to home page</p></a>");
            }
            
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
