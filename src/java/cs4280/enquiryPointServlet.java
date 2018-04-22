/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs4280;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author cyeung234
 */
public class enquiryPointServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        
        String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
        String dbLoginId = "aiad044";
        String dbPwd = "aiad044";

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        String strSQL = null;
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>CS4280 Internet Bookstore - Enquiry Points</title>");            
            out.println("</head>");
            out.println("<body><br><br><br><center>");
            
            int pointsGained = 0;
            Double totalPriceConfirmed; 
            totalPriceConfirmed = Double.parseDouble(request.getParameter("totalPrice"));
            pointsGained = totalPriceConfirmed.intValue() / 50;
            out.println("<h1>Congratulations! You earned " + pointsGained +" loyalty points.</h1>");
            HttpSession session = request.getSession();
            int loyaltyPoint = (Integer)session.getAttribute("loyaltyPoint");
            loyaltyPoint += pointsGained;
            session.setAttribute("loyaltyPoint", loyaltyPoint);
            String currentMember = (String)session.getAttribute("username");
            
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                if (con != null && !con.isClosed())
                {
                    strSQL = "UPDATE [Member] SET [Member_Points] = " + loyaltyPoint + " WHERE [Member_Username] = '" + currentMember +"'";
                    stmt.executeUpdate(strSQL);
                }
            } catch(ClassNotFoundException cnfe) {
                cnfe.printStackTrace();
            } catch(SQLException sqlex) { 
                sqlex.printStackTrace();
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
            
            out.println("<h3>Current Loyalty points: " + loyaltyPoint +" points.</h3>");
            out.println("<a href=\"index.jsp\"><p>Go Back to home page</p></a>");
            out.println("</center>");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(enquiryPointServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(enquiryPointServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
