<%@page import="com.entity.cart"%>
<%@page import="com.dao.DAO2"%>
<%@page import="com.entity.customer"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO"%>
<%@page import="java.sql.*,java.io.*,java.text.*,java.util.*" %> 

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Validate Login</title>
    <link rel="stylesheet" href="images/bootstrap.css">
    <link rel="stylesheet" href="Css/w3.css">
    <link rel="stylesheet" href="Css/font.css">
    <style>
        .w3-sidebar a {font-family: "Roboto", sans-serif;}
        body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
    </style>
</head>
<body>

<%
    String Total3 = request.getParameter("Total");
    String CusName3 = request.getParameter("CusName");

    String Ab = null;
    String N = null;
    boolean loggedIn = false;

    // Check cookies for login status
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("cname".equals(cookie.getName())) {
                loggedIn = true;
                Ab = cookie.getValue();

                DAO dao = new DAO(DBConnect.getConn());
                List<customer> customers = dao.getCustomer(Ab);
                for (customer c : customers) {
                    N = c.getName();
                }
                break;
            }
        }
    }

    if (!loggedIn) {
        response.sendRedirect("customerlogin.jsp?Total=" + Total3 + "&CusName=" + CusName3);
        return;
    }

    int tcqty = 0;
    DAO2 dao2 = new DAO2(DBConnect.getConn());
    List<cart> cartList = dao2.getcart(N);
    for (cart item : cartList) {
        tcqty += item.getPquantity();
    }
%>

<!-- Hidden inputs for form redirection -->
<form method="post">
    <input type="hidden" name="Total" value="<%= Total3 %>">
    <input type="hidden" name="CusName" value="<%= CusName3 %>">
</form>

</body>
</html>
