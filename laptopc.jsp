<%@page import="com.entity.laptop"%>
<%@page import="com.dao.DAO3"%>
<%@page import="com.entity.tv"%>
<%@page import="java.util.List"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="java.sql.*,java.io.*,java.text.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laptops - Premium Electronics Store</title>
    
    <!-- CSS Dependencies -->
    <link rel="stylesheet" href="images/bootstrap.css">
    <link rel="stylesheet" href="Css/w3.css">
    <link rel="stylesheet" href="Css/font.css">
    
    <style>
        .w3-sidebar a {
            font-family: "Roboto", sans-serif;
        }
        
        body, h1, h2, h3, h4, h5, h6, .w3-wide {
            font-family: "Montserrat", sans-serif;
        }
        
        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .page-header h1 {
            margin: 0;
            font-size: 2.5em;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .page-header p {
            margin: 10px 0 0 0;
            font-size: 1.2em;
            opacity: 0.9;
        }
        
        .products-container {
            min-height: 500px;
        }
        
        .product-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .product-image-container {
            position: relative;
            background: #f8f9fa;
            padding: 20px;
            text-align: center;
            flex-shrink: 0;
        }
        
        .product-image {
            max-width: 100%;
            height: 180px;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        
        .product-card:hover .product-image {
            transform: scale(1.05);
        }
        
        .product-info {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .product-title {
            color: #2c3e50;
            font-size: 1.1em;
            font-weight: 600;
            text-decoration: none;
            line-height: 1.4;
            margin-bottom: 10px;
            flex-grow: 1;
        }
        
        .product-title:hover {
            color: #3498db;
            text-decoration: none;
        }
        
        .product-brand {
            color: #7f8c8d;
            font-size: 0.9em;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }
        
        .view-details-btn {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.9em;
            text-align: center;
            transition: all 0.3s ease;
            margin-top: auto;
        }
        
        .view-details-btn:hover {
            background: linear-gradient(135deg, #2980b9, #1f639a);
            color: white;
            text-decoration: none;
            transform: translateY(-1px);
        }
        
        .no-products {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .no-products i {
            font-size: 4em;
            margin-bottom: 20px;
            display: block;
        }
        
        .loading-spinner {
            text-align: center;
            padding: 60px 20px;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 20px;
            border-radius: 8px;
            margin: 20px;
            text-align: center;
        }
        
        .products-count {
            background: #e8f4fd;
            color: #2c3e50;
            padding: 15px 20px;
            margin-bottom: 30px;
            border-radius: 8px;
            font-weight: 500;
        }
        
        footer {
            text-align: center;
            padding: 30px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            margin-top: 60px;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 2em;
            }
            
            .product-card {
                margin-bottom: 20px;
            }
            
            .product-info {
                padding: 15px;
            }
        }
        
        @media (max-width: 576px) {
            .page-header {
                padding: 30px 15px;
            }
            
            .page-header h1 {
                font-size: 1.8em;
            }
        }
    </style>
</head>

<body>
    <%@ include file="customer_navbar.jsp" %>
    
    <div class="page-header">
        <div class="container">
            <h1>Premium Laptops</h1>
            <p>Discover our collection of high-performance laptops</p>
        </div>
    </div>

    <div class="container products-container">
        <%
        try {
            DAO3 dao = new DAO3(DBConnect.getConn());
            List<laptop> laptopList = dao.getAlllaptop();
            
            if (laptopList != null && !laptopList.isEmpty()) {
        %>
                <div class="products-count">
                    <i class="fas fa-laptop"></i> 
                    Showing <%= laptopList.size() %> laptop<%= laptopList.size() != 1 ? "s" : "" %> available
                </div>
                
                <div class="row">
        <%
                for (laptop laptop : laptopList) {
                    // Validate required fields
                    if (laptop.getPimage() == null || laptop.getPimage().trim().isEmpty()) {
                        continue; // Skip products without images
                    }
        %>
                    <div class="col-xxl-3 col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12">
                        <div class="product-card">
                            <div class="product-image-container">
                                <a href="selecteditemc.jsp?Pn=<%= laptop.getPimage() %>">
                                    <img src="images/<%= laptop.getPimage() %>" 
                                         alt="<%= laptop.getBname() %> <%= laptop.getPname() %>" 
                                         class="product-image"
                                         onerror="this.src='images/placeholder-laptop.jpg'; this.onerror=null;">
                                </a>
                            </div>
                            
                            <div class="product-info">
                                <div class="product-brand">
                                    <%= laptop.getBname() != null ? laptop.getBname() : "Unknown Brand" %>
                                </div>
                                
                                <a href="selecteditemc.jsp?Pn=<%= laptop.getPimage() %>" class="product-title">
                                    <%= laptop.getPname() != null ? laptop.getPname() : "Laptop" %>
                                </a>
                                
                                <a href="selecteditemc.jsp?Pn=<%= laptop.getPimage() %>" class="view-details-btn">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </div>
        <%
                }
        %>
                </div>
        <%
            } else {
        %>
                <div class="no-products">
                    <i class="fas fa-laptop"></i>
                    <h3>No Laptops Available</h3>
                    <p>We're currently updating our laptop inventory. Please check back soon!</p>
                </div>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        %>
            <div class="error-message">
                <h4><i class="fas fa-exclamation-triangle"></i> System Error</h4>
                <p>We're experiencing technical difficulties loading our laptop catalog.</p>
                <p>Please try refreshing the page or contact our support team if the problem persists.</p>
            </div>
        <%
        }
        %>
    </div>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

    <!-- Add Font Awesome for icons if not already included -->
    <script>
        // Add loading animation for images
        document.addEventListener('DOMContentLoaded', function() {
            const images = document.querySelectorAll('.product-image');
            images.forEach(img => {
                img.addEventListener('load', function() {
                    this.style.opacity = '1';
                });
            });
        });
        
        // Add smooth scroll behavior
        document.documentElement.style.scrollBehavior = 'smooth';
    </script>
</body>
</html>