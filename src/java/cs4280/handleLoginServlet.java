/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs4280;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yeung0210
 */
public class handleLoginServlet extends HttpServlet {

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
        
        String username_admin = "admin";
        String password_admin = "admin";
        
        String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
        String dbLoginId = "aiad044";
        String dbPwd = "aiad044";

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        String strSQL = null;
        
        String input_username = request.getParameter("username");
        String input_password = request.getParameter("password");
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        if (input_username.equals(username_admin) && input_password.equals(password_admin)) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>CS4280 Internet Bookstore - Sucessful Login</title>");            
            out.println("</head>");
            out.println("<body><br><br><br>");
            out.println("<center><h1>Sucessful Login</h1>");
            out.println("<h3>Welcome book manager!</h3>");
            out.println("<p>The website will return to index page very soon!</p>");
            out.println("</body>");
            out.println("</html>");
            response.setHeader("Refresh", "2; URL=admin.jsp");
        } 
        else {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                if (con != null && !con.isClosed())
                {
                    strSQL = "SELECT * FROM [Member] WHERE [Member_Username] = '" + input_username + "'";
                    rs = stmt.executeQuery(strSQL);
                    if(!rs.next()) {
                        out.println("<!DOCTYPE html>");
                        out.println("<html>");
                        out.println("<head>");
                        out.println("<title>CS4280 Internet Bookstore - Login Failed</title>");            
                        out.println("</head>");
                        out.println("<body><br><br><br>");
                        out.println("<center><h1>Login Failed</h1>");
                        out.println("<h3>Account does not exist!</h3>");
                        out.println("<a href=\"index.jsp\"><p>Click here to login again</p></a>");
                        out.println("</body>");
                        out.println("</html>");
                    } 
                    else if(!rs.getString("Member_Password").equals(input_password)) {
                        out.println("<!DOCTYPE html>");
                        out.println("<html>");
                        out.println("<head>");
                        out.println("<title>CS4280 Internet Bookstore - Login Failed</title>");            
                        out.println("</head>");
                        out.println("<body><br><br><br>");
                        out.println("<center><h1>Login Failed</h1>");
                        out.println("<h3>Invalid username or password!</h3>");
                        out.println("<a href=\"index.jsp\"><p>Click here to login again</p></a>");
                        out.println("</body>");
                        out.println("</html>");
                    }
                    else {
                        HttpSession session = request.getSession();
                        session.setAttribute("username", input_username);
                        session.setAttribute("shoppingCart", null);

                        int points = rs.getInt("Member_Points");
                        session.setAttribute("loyaltyPoint", points);

                        out.println("<!DOCTYPE html>");
                        out.println("<html>");
                        out.println("<head>");
                        out.println("<title>CS4280 Internet Bookstore - Sucessful Login</title>");            
                        out.println("</head>");
                        out.println("<body><br><br><br>");
                        out.println("<center><h1>Sucessful Login</h1>");
                        out.println("<h3>Welcome " + input_username + " !</h3>");
                        out.println("<p>The website will return to index page very soon!</p>");
                        out.println("</body>");
                        out.println("</html>");
                        response.setHeader("Refresh", "2; URL=index.jsp");
                    }
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
        }
    }
            
        
        
//        if (input_username.equals(username_test) && input_password.equals(password_test)) {
//            HttpSession session = request.getSession();
//            session.setAttribute("username", input_username);
//            session.setAttribute("shoppingCart", null);
//            int points = 30;
//            session.setAttribute("loyalttPoint", points);
//            
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>CS4280 Internet Bookstore - Sucessful Login</title>");            
//            out.println("</head>");
//            out.println("<body><br><br><br>");
//            out.println("<center><h1>Sucessful Login</h1>");
//            out.println("<h3>Welcome " + input_username + " !</h3>");
//            out.println("<p>The website will return to index page very soon!</p>");
//            out.println("</body>");
//            out.println("</html>");
//            response.setHeader("Refresh", "2; URL=index.jsp");
//        } 
//        else 
//        {
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>CS4280 Internet Bookstore - Login Failed</title>");            
//            out.println("</head>");
//            out.println("<body><br><br><br>");
//            out.println("<center><h1>Login Failed</h1>");
//            out.println("<h3>Invalid username or password!</h3>");
//            out.println("<a href=\"index.jsp\"><p>Click here to login again</p></a>");
//            out.println("</body>");
//            out.println("</html>");
//        }
           

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
            Logger.getLogger(handleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(handleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
