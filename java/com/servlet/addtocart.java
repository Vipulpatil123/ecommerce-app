package com.servlet;

import java.io.IOException;
import java.nio.file.Path;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.conn.DBConnect;
import com.dao.DAO3;
import com.entity.cart;

@MultipartConfig
@WebServlet("/addtocart")
public class addtocart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public addtocart() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String N = request.getParameter("N");
        String id = request.getParameter("id");
        String ie = request.getParameter("ie");
        String ig = request.getParameter("ig");
        String ihstr = request.getParameter("ih");
        int ih = Integer.parseInt(ihstr);
        String ij = request.getParameter("ij");

        // ✅ User input quantity
        String qtyStr = request.getParameter("qty");
        int qty = 1;
        try {
            qty = Integer.parseInt(qtyStr);
        } catch (NumberFormatException e) {
            qty = 1; // default fallback
        }

        cart c = new cart();
        c.setName(N);
        c.setBname(id);
        c.setCname(ie);
        c.setPname(ig);
        c.setPprice(ih);
        c.setPimage(ij);
        c.setPquantity(qty);  // ✅ Set user input quantity

        try {
            DAO3 dao = new DAO3(DBConnect.getConn());

            if (dao.checkaddtocartnull(c)) {
                if (dao.updateaddtocartnull(c) > 0) {
                    Cookie cart = new Cookie("cart", "cartt");
                    cart.setMaxAge(15);
                    response.addCookie(cart);
                    response.sendRedirect("cart.jsp");
                } else {
                    response.sendRedirect("selecteditemc.jsp");
                }
            } else {
                if (dao.addtocartnull(c) > 0) {
                    Cookie cart = new Cookie("cart", "cartt");
                    cart.setMaxAge(15);
                    response.addCookie(cart);
                    response.sendRedirect("cart.jsp");
                } else {
                    response.sendRedirect("selecteditemc.jsp");
                }
            }

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Not used
    }
}
