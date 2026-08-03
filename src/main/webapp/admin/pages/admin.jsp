<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: tranv
  Date: 7/29/2026
  Time: 7:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Trị Hệ Thống - Giày Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/manager.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
</head>
<body>
<div class="container">
    <!-- Sidebar Navigation -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <div class="brand-icon-wrapper">
                <img src="/icon/boot.png" alt="logo" class="brand-icon">
            </div>
            <h2>GIÀY STORE</h2>
        </div>

        <nav class="sidebar-menu">
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/product"
                       class="${currentPage == 'product' ? 'active' : ''}">
                        <img src="/icon/box.png" alt="box">
                        <span>Quản lý sản phẩm</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/bill"
                       class="${currentPage == 'bill' ? 'active' : ''}">
                        <img src="/icon/invoice.png" alt="invoice">
                        <span>Quản lý hóa đơn</span>
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content Area -->
    <main class="main-content">
        <header class="header">
            <div class="header-left">
                <span class="welcome-text">Xin chào, <strong>Admin</strong> 👋</span>
            </div>
            <div class="header-right">
                <div class="header-icon" title="Thông báo">
                    <img src="/icon/bell.png" alt="bell">
                    <span class="badge">3</span>
                </div>
                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=0D8ABC&color=fff" alt="Avatar">
                    <span class="user-name">Quản Trị Viên</span>
                </div>
            </div>
        </header>

        <section class="body-content">
            <c:if test="${not empty contentPage}">
                <jsp:include page="${contentPage}"/>
            </c:if>
        </section>
    </main>
</div>
</body>
</html>
