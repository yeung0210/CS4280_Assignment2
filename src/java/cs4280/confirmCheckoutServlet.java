/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs4280;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
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
            throws ServletException, IOException, SQLException {
        
        
        NumberFormat formatter = new DecimalFormat("#0.00");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String currentMember = (String)session.getAttribute("username");
        
        String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
        String dbLoginId = "aiad044";
        String dbPwd = "aiad044";

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        String strSQLUpdate = null;
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            Double totalPriceConfirmed;
            totalPriceConfirmed = Double.parseDouble(request.getParameter("totalPrice"));
            String orderID = "";
            
            shoppingCart cart;
            cart = (shoppingCart)session.getAttribute("shoppingCart");
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>CS4280 Internet Bookstore - Confirm Order</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<body><br><br><br>");
            out.println("<center><h1>Successful Payment!</h1>");
            if (currentMember != null) {
                
                for (int i = 0; i < 6; i++) {
                    Random r = new Random();
                    char c = (char)(r.nextInt(26) + 'a');  
                    orderID += c;
                }

                out.println("<h4>Order ID: " + orderID +"</h4>");
            }
            out.println("<h4>Total: " + formatter.format(totalPriceConfirmed) + "</h4>");
            
            int loyaltyPoint = 0;
            if (session.getAttribute("loyaltyPoint") != null) {
                loyaltyPoint = (Integer)session.getAttribute("loyaltyPoint");
            }
            int usedPoint = 0;
            if (session.getAttribute("usedPoints") != null) {
                usedPoint = (Integer)session.getAttribute("usedPoints");
            }
               
            int currentPoints = loyaltyPoint - usedPoint;
            session.setAttribute("loyaltyPoint", currentPoints);
            
            
            
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                if (con != null && !con.isClosed() && currentMember != null)
                {
                    strSQLUpdate = "UPDATE [Member] SET [Member_Points] = " + currentPoints + " WHERE [Member_Username] = '" + currentMember +"'";
                    stmt.executeUpdate(strSQLUpdate);
                    PreparedStatement statementInsert = con.prepareStatement("INSERT INTO [Orders] VALUES('" + orderID + "', '" + currentMember + "', ?, ?," + totalPriceConfirmed + ", " + usedPoint + ")");
                    
                    for (int i = 0; i < cart.itemNum(); i++) {
                        Item currentItem = (Item)cart.getItemsOrdered().get(i);
                        statementInsert.setString(1, currentItem.getBookID());
                        statementInsert.setInt(2, currentItem.getBookQuantity());
                        statementInsert.executeUpdate();
                        
                    }
                }
                PreparedStatement statementUpdate = con.prepareStatement("UPDATE [Book] SET [Book_Quantity] = ([Book_Quantity] -1) WHERE [Book_ID] = ?");
                for (int i = 0; i < cart.itemNum(); i++) {
                    Item currentItem = (Item)cart.getItemsOrdered().get(i);
                    statementUpdate.setString(1, currentItem.getBookID());
                    statementUpdate.executeUpdate();
                }
                
            } catch(ClassNotFoundException cnfe) {
                cnfe.printStackTrace();
            } catch(SQLException sqlex) { 
                sqlex.printStackTrace();
                throw sqlex;
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
            
            session.setAttribute("shoppingCart", null);
            session.setAttribute("usedPoints", null);
            
            if (totalPriceConfirmed >= 50 && session.getAttribute("username") != null) {
                out.println("<h3>Special reward for members: Every $50 in the purchase can earn 1 loyalty point</h3>");
                         out.println("<form action=\"enquiryPointServlet\" method=\"post\">");
                         out.println("<input type=\"hidden\" name=\"totalPrice\" "
                                + "value=\"" + formatter.format(totalPriceConfirmed) + "\">");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(confirmCheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(confirmCheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
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
