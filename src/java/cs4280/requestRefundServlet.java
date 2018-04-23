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
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author cyeung234
 */
public class requestRefundServlet extends HttpServlet {

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
        
        
        NumberFormat formatter = new DecimalFormat("#0.00");
        HttpSession session = request.getSession();
        String currentMember = (String)session.getAttribute("username");
        
        String url = "jdbc:sqlserver://w2ksa.cs.cityu.edu.hk:1433;databaseName=aiad044_db";
        String dbLoginId = "aiad044";
        String dbPwd = "aiad044";

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        int numberOfRows = 0;
        String strSQL = null;
        String strSQLInsert = null;
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String input_OrderID = request.getParameter("orderID");
        Double input_refund_value;
        input_refund_value = Double.parseDouble(request.getParameter("refundValue"));
        String input_reason = request.getParameter("reason");
        
        try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(url, dbLoginId, dbPwd);
                stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                if (con != null && !con.isClosed() && currentMember != null)
                {
                  strSQL = "SELECT * FROM [Orders]";
                  rs = stmt.executeQuery(strSQL);
                  rsmd = rs.getMetaData();
                  rs.last();
                  numberOfRows = rs.getRow();
                  boolean exist = false;
                  for (int j = 1; j <= numberOfRows; j++) {
                      rs.absolute(j);
                      if ((rs.getString("Order_ID").equals(input_OrderID)) && (rs.getString("Member_Username").equals(currentMember))) {
                          exist = true;
                      }
                  }
                  if(exist) {
                    String requestID = "R";
                    for (int i = 0; i < 5; i++) {
                        Random r = new Random();
                        char c = (char)(r.nextInt(10) + '0');  
                        requestID += c;
                    }
                    strSQLInsert = "INSERT INTO [Request] VALUES('" + requestID + "', '" + input_OrderID + "', " + input_refund_value + 
                          ", '" + input_reason + "', 'X')";
                    stmt.executeUpdate(strSQLInsert);      
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>CS4280 Internet Bookstore - Successful Submission</title>");            
                    out.println("</head>");
                    out.println("<body><br><br><br>");
                    out.println("<center><h1>Successful Submission</h1>");
                    out.println("<h3>Request ID: " + requestID +"</h3>");
                    out.println("<h3>Your Request will be authorized by book manager soon.</h3>");
                    out.println("<a href=\"index.jsp\"><p>Go Back to home page</p></a>");
                    out.println("</body>");
                    out.println("</html>");
                    
                  }
                  else {
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>CS4280 Internet Bookstore - Submission Failed</title>");            
                    out.println("</head>");
                    out.println("<body><br><br><br>");
                    out.println("<center><h1>Request Submission Failed</h1>");
                    out.println("<h3>Invalid Order ID!</h3>");
                    out.println("<a href=\"reqestRefund.jsp\"><p>Submit request again</p></a>");
                    out.println("<a href=\"index.jsp\"><p>Go Back to home page</p></a>");
                    out.println("</body>");
                    out.println("</html>");
                    }
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
