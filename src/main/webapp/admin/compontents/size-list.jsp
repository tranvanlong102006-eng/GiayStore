<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: tranv
  Date: 7/29/2026
  Time: 12:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<style>
    .size-page .size-form {
        margin-bottom: 45px;
    }

    .size-page .size-form input {
        width: 100% !important;
    }

    /* Đảm bảo Font Icon hiển thị đúng, không bị gạch chân */
    .size-page .material-symbols-outlined {
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
    .size-page .action-btns {
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        gap: 8px !important;
    }

    /* Style cơ bản cho Nút Icon */
    .size-page .btn-action {
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
    .size-page .btn-edit {
        color: #d97706 !important;
        background-color: #fffbeb !important;
        border-color: #fef3c7 !important;
    }

    .size-page .btn-delete {
        color: #dc2626 !important;
        background-color: #fef2f2 !important;
        border-color: #fee2e2 !important;
    }

    /* HIỆU ỨNG HOVER */
    .size-page .btn-edit:hover {
        background-color: #d97706 !important;
        color: #ffffff !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 6px -1px rgba(217, 119, 6, 0.3);
    }

    .size-page .btn-delete:hover {
        background-color: #dc2626 !important;
        color: #ffffff !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 6px -1px rgba(220, 38, 38, 0.3);
    }

</style>
<div class="size-page">
    <div class="size-form">
        <h3 class="form-title">${sizeUpdate != null ? 'Cập nhật Sizen' : 'Thêm Size'}</h3>
        <form action="${pageContext.request.contextPath}/admin/product/size/${sizeUpdate != null ? "update" : "add"}" method="post">
            <div class="form-group">
                <c:if test="${not empty sizeUpdate}"><label>Id</label>
                    <input type="text" name="id" value="${sizeUpdate.id}" readonly></c:if>
            </div>
            <div class="form-group">
                <label>Mã</label>
                <input type="text" name="code" value="${sizeUpdate.code}" required placeholder="Nhập mã danh mục...">
            </div>
            <div class="form-group">
                <label>Tên</label>
                <input type="text" name="name" value="${sizeUpdate.name}" required placeholder="Nhập tên danh mục...">
            </div>
            <button class="btn-submit" type="submit">${sizeUpdate != null ? 'Update' : 'Add'}</button>
        </form>
    </div>
    <h3 class="form-title">Danh sách Size</h3>
    <div class="table-card">
        <table class="custom-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Mã</th>
                <th>Tên</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${sizeList}" var="s">
                <tr>
                    <td>${s.id}</td>
                    <td>${s.code}</td>
                    <td>${s.name}</td>
                    <td>
                        <div class="action-btns">
                            <a class="btn-action btn-edit"
                               href="${pageContext.request.contextPath}/admin/product/size/update?id=${s.id}&modal=size">
                                <span class="material-symbols-outlined">edit</span>
                            </a>
                            <a class="btn-action btn-delete"
                               href="${pageContext.request.contextPath}/admin/product/size/delete?id=${s.id}"
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


