<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: tranv
  Date: 7/29/2026
  Time: 10:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .brand-page .brand-form {
        margin-bottom: 45px;
    }

    .brand-page .brand-form input {
        width: 100% !important;
    }

    /* Đảm bảo Font Icon hiển thị đúng, không bị gạch chân */
    .brand-page .material-symbols-outlined {
        font-family: 'Material Symbols Outlined' !important;
        font-weight: normal;
        font-style: normal;
        font-size: 20px;
        line-height: 1;
        letter-spacing: normal;
        text-transform: none;
        display: inline-block;
        -webkit-font-smoothing: antialiased;
        text-decoration: none !important;

    }

    /* Thùng chứa các nút hành động */
    .brand-page .action-btns {
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        gap: 8px !important;
    }

    /* Style cơ bản cho Nút Icon */
    .brand-page .btn-action {
        display: inline-flex !important;
        align-items: center !important;
        justify-content: center !important;
        width: 36px !important;
        height: 36px !important;
        border-radius: 8px !important;
        text-decoration: none !important; /* Bắt buộc xóa gạch chân của thẻ a */
        transition: all 0.2s ease-in-out !important;
        cursor: pointer !important;
        border: 1px solid transparent !important;
        box-sizing: border-box !important;
    }

    /* Màu sắc mặc định */
    .brand-page .btn-edit {
        color: #d97706 !important;
        background-color: #fffbeb !important;
        border-color: #fef3c7 !important;
    }

    .brand-page .btn-delete {
        color: #dc2626 !important;
        background-color: #fef2f2 !important;
        border-color: #fee2e2 !important;
    }

    /* HIỆU ỨNG HOVER */
    .brand-page .btn-edit:hover {
        background-color: #d97706 !important;
        color: #ffffff !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 6px -1px rgba(217, 119, 6, 0.3);
    }

    .brand-page .btn-delete:hover {
        background-color: #dc2626 !important;
        color: #ffffff !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 6px -1px rgba(220, 38, 38, 0.3);
    }
</style>

<div class="brand-page">
    <div class="brand-form">
        <h3 class="form-title">${brandUpdate != null ? 'Cập nhật Brand' : 'Thêm Brand'}</h3>
        <form action="${pageContext.request.contextPath}/admin/product/brand/${brandUpdate != null ? "update" : "add"}" method="post">
            <div class="form-group">
                <c:if test="${not empty brandUpdate}">
                    <label>Id</label>
                    <input type="text" name="id" value="${brandUpdate.id}" readonly>
                </c:if>
            </div>
            <div class="form-group">
                <label>Mã</label>
                <input type="text" name="code" value="${brandUpdate.code}" required
                       placeholder="Nhập mã danh mục...">
            </div>
            <div class="form-group">
                <label>Tên</label>
                <input type="text" name="name" value="${brandUpdate.name}" required
                       placeholder="Nhập tên danh mục...">
            </div>
            <button type="submit" class="btn-submit">${brandUpdate != null ? 'Update' : 'Add'}</button>
            <c:if test="${brandUpdate != null}">
                <a href="${pageContext.request.contextPath}/admin/product/add?modal=brand">Hủy sửa</a>
            </c:if>
        </form>
    </div>
    <h3 class="form-title">Danh sách Brand</h3>
    <div class="table-card">
        <table class="custom-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Mã</th>
                <th>Tên</th>
                <th style="text-align: center">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${brandList}" var="b">
                <tr>
                    <td>${b.id}</td>
                    <td>${b.code}</td>
                    <td>${b.name}</td>
                    <td>
                        <div class="action-btns">
                            <a class="btn-action btn-edit" title="Sửa"
                               href="${pageContext.request.contextPath}/admin/product/brand/update?id=${b.id}&modal=brand">
                                <span class="material-symbols-outlined">edit</span>
                            </a>
                            <a class="btn-action btn-delete" title="Xóa"
                               href="${pageContext.request.contextPath}/admin/product/brand/delete?id=${b.id}"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                                <span class="material-symbols-outlined">delete</span>
                            </a></div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

