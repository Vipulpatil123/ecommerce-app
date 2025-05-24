<%@page import="com.entity.cart"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO2"%>
<%@page import="java.sql.*,java.io.*,java.text.*,java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">
<link rel="stylesheet" href="Css/cart.css">
<link rel="stylesheet" href="Css/whitespace.css">
<script>
    function show() {
        alert("Add something to the cart first.");
    }
</script>

<style>
    .w3-sidebar a { font-family: "Roboto", sans-serif; }
    body,h1,h2,h3,h4,h5,h6,.w3-wide { font-family: "Montserrat", sans-serif; }
</style>
</head>
<body>

<%@ include file = "customer_navbar.jsp" %>
<center>
<div style="background-color: #ebe9eb">
    <br>
    <h1>Cart</h1>
    <br>
</div>
<br>

<%
    String customerName = null;
    String msgg = null;

    // Fetch cookies and get customer name
    Cookie[] cookiess = request.getCookies();
    if (cookiess != null) {
        for (Cookie c : cookiess) {
            if ("cname".equals(c.getName()) && c.getValue() != null && !c.getValue().trim().isEmpty()) {
                customerName = c.getValue().trim();
                break;
            }
        }
    }
    
    // If user is not logged in, show error and stop processing
    if (customerName == null) {
%>
        <div class="alert alert-warning text-center">
            <h3 style="color:red">You must be logged in to view your cart.</h3>
            <a href="login.jsp" class="btn btn-primary">Login Here</a>
        </div>
        </center>
        </body>
        </html>
<%
        return; // Stop processing the rest of the page
    }

    // Check for cart cookie and remove it (for success message)
    if (cookiess != null) {
        for (int i = 0; i < cookiess.length; i++) {
            if ("cart".equals(cookiess[i].getName())) {
                cookiess[i].setMaxAge(0);  // Expire the cart cookie
                response.addCookie(cookiess[i]);
                msgg = "Product added to cart successfully....";
            }
        }
    }

    // Display success message
    if (msgg != null) {
        out.println("<div class='alert alert-success text-center'><b>" + msgg + "</b></div>");
    }
%>

<div class="table-responsive">
    <div class="mbd">
        <div class="container border">
            <br>
            <%
                int Total = 0;  // Initialize total amount
                DAO2 dao = null;
                List<cart> listv = null;
                
                try {
                    dao = new DAO2(DBConnect.getConn());
                    listv = dao.getcart(customerName);  // Get cart items for the customer
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Error loading cart: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }

                if (listv != null && !listv.isEmpty()) {
                    for (cart v : listv) {
            %>
                        <div class="container bd">
                            <div class="row justify-content-center align-items-center">
                                <div class="col-xxl-2 col-xl-2 col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                    <img src="images/<%= (v.getPimage() != null && !v.getPimage().isEmpty()) ? v.getPimage() : "default.jpg" %>" 
                                         height="100px" width="90px" alt="Product Image">
                                </div>
                                &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
                                <div class="col-xxl-2 col-xl-2 col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                    <b><%= v.getBname() != null ? v.getBname() : "" %> &ensp;<%= v.getPname() != null ? v.getPname() : "" %></b><br>
                                    <b><%= v.getCname() != null ? v.getCname() : "" %></b>
                                </div>
                                <div class="col-xxl-2 col-xl-2 col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                    <b><%= v.getPquantity() %></b>
                                </div>
                                <div class="col-xxl-2 col-xl-2 col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                    <b>Rs. <%= v.getPprice() %></b>
                                </div>
                                <div class="col-xxl-2 col-xl-2 col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                    <a href="removecart?ie=<%= v.getPimage() != null ? v.getPimage() : "" %>&id=<%= customerName %>">
                                        <img src="images/delete.jpg" alt="Remove" height="25px">
                                    </a>
                                </div>
                                <%
                                    // Calculate total price (assuming getPprice() and getPquantity() return primitive types)
                                    try {
                                        Total = Total + (v.getPprice() * v.getPquantity());  // Update total price
                                    } catch (Exception e) {
                                        // Handle any calculation errors silently or log them
                                        System.out.println("Error calculating price for item: " + e.getMessage());
                                    }
                                %>
                            </div>
                        </div>
                        <br>
            <%      }
                } %>

            <div class="tp">
                <h5><b>Total Price: Rs. <%= Total %></b> </h5>
            </div>
            <br>
            <% if (Total > 0) { %>
                <a href="ShippingAddress.jsp?Total=<%= Total %>">
                    <button class="pd"><h5 class="ws"><b>Proceed To Checkout</b></h5></button>
                </a>
            <% } else { %>
                <button onclick="show()" class="pd"><h5 class="ws"><b>Proceed To Checkout</b></h5></button>
            <% } %>
        </div>
    </div>
</div>

<% if (Total == 0) { %>
    <center>
        <img src="images/emptycart.png" height="200px" alt="Empty Cart">
        <h2 style="color:firebrick">YOUR CART IS EMPTY</h2>
    </center>
<% } %>

</center>

<br>
<footer style="text-align: center; padding: 3px; background-color: DarkSalmon; color: white;">
    <%@ include file="footer.jsp" %>
</footer>

</body>
</html>
