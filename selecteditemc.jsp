<%@page import="com.entity.viewlist"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO2"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*,java.io.*,java.text.*,java.util.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product</title>
    <link rel="stylesheet" href="images/bootstrap.css">
    <link rel="stylesheet" href="Css/w3.css">
    <link rel="stylesheet" href="Css/font.css">

    <style>
        .w3-sidebar a { font-family: "Roboto", sans-serif }
        body, h1, h2, h3, h4, h5, h6, .w3-wide { font-family: "Montserrat", sans-serif; }
    </style>
</head>

<body>
<%@ include file="customer_navbar.jsp" %>

<center>
    <div style="background-color: #ebe9eb">
        <br>
        <h1>Product</h1>
        <br>
    </div>
    <br>

    <div class="container border">
        <center>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">

                    <%
                        String st = request.getParameter("Pn");
                        DAO2 dao = new DAO2(DBConnect.getConn());		
                        List<viewlist> list = dao.getSelecteditem(st);

                        for(viewlist l : list) {
                    %>	

                    <table>
                        <tr>
                            <th colspan='2' align='center'>
                                <img src='images/<%=l.getPimage() %>' height="250px">
                            </th>
                        </tr>
                    </table>

                    <table border='1' cellspacing='5' cellpadding='5' align='center'>
                        <tr>
                            <th>Brand: </th>
                            <th><%=l.getBname() %></th>
                        </tr>

                        <tr>
                            <th>Category: </th>
                            <th><%=l.getCname() %></th>
                        </tr>

                        <tr>
                            <th>Product Name: </th>
                            <th><%=l.getPname() %></th>
                        </tr>

                        <tr>
                            <th>Price: </th>
                            <th>₹ <%=l.getPprice() %></th>
                        </tr>

                        <tr>
                            <th>Available Quantity: </th>
                            <th><%=l.getPquantity() %></th>
                        </tr>

                        <tr>
                            <th style='text-align: center' colspan='2' align='center' bgcolor='#D6EEEE'>
                                <form action="addtocart" method="get">
                                    <input type="hidden" name="id" value="<%=l.getBname()%>">
                                    <input type="hidden" name="ie" value="<%=l.getCname()%>">
                                    <input type="hidden" name="ig" value="<%=l.getPname()%>">
                                    <input type="hidden" name="ih" value="<%=l.getPprice()%>">
                                    <input type="hidden" name="ij" value="<%=l.getPimage()%>">
                                    <input type="hidden" name="N" value="<%=session.getAttribute("username")%>">

                                    Quantity:
                                    <input type="number" name="qty" value="1" min="1" max="<%=l.getPquantity()%>" style="width: 60px;" required>

                                    <input type="submit" value="Add to Cart" class="btn btn-success">
                                </form>
                            </th>
                        </tr>
                    </table>

                </div>

                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                    <h2><%= l.getPname() %></h2><br>
                    <h3>₹ <%= l.getPprice() %></h3><br>
                    <p>
                        Lorem ipsum dolor sit amet, consecte adipisicing elit, 
                        sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                    </p>
                    <br>
                    <h3>Description</h3><br>
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit,
                        sed do eius tempor incididunt ut labore et dolore magna aliqua.
                        Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
                        nisi ut aliquip ex ea commodo consequat.
                    </p>
                </div>
            <% } %>
            </div>
        </center>
    </div>

    <br>

    <footer style="text-align: center; padding: 3px; background-color: DarkSalmon; color: white;">
        <%@ include file="footer.jsp" %>
    </footer>
</center>
</body>
</html>
