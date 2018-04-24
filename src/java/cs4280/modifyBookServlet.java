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
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author cyeung234
 */
public class modifyBookServlet extends HttpServlet {

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
        String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
        String dbLoginId = "aiad044";
        String dbPwd = "aiad044";

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        String strSQL = null;
        
        String book_id = request.getParameter("bookID");
        String book_name = request.getParameter("bookName");
        String book_author = request.getParameter("bookAuthor");
        String book_description = request.getParameter("bookDescription");
        Double book_price;
        book_price = Double.parseDouble(request.getParameter("bookPrice"));
        int book_quantity;
        book_quantity = Integer.parseInt(request.getParameter("bookQuantity"));
        
        try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                if (con != null && !con.isClosed()) {
                    strSQL = "UPDATE [Book] SET [Book_Name] = '" + book_name + "', [Book_Author] = '" + book_author + "', [Book_Description] = '" + book_description + 
                            "', [Book_Price] = " + book_price + ", [Book_Quantity] = " + book_quantity + " WHERE [Book_ID] = '" + book_id + "'";
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
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>CS4280 Internet Bookstore - Modify Book Details</title>");            
            out.println("</head>");
            out.println("<body><br><br><br>");
            out.println("<center><h1>Modify Successfully!</h1>");
            out.println("<p>The website will return to index page very soon!</p>");
            out.println("</body>");
            out.println("</html>");
            response.setHeader("Refresh", "2; URL=admin.jsp");
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
