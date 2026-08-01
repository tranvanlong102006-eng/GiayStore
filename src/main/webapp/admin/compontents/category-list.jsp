<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="category-page">

        <h3 class="form-title">${categoryUpdate != null ? 'Cập nhật Category' : 'Thêm Category'}</h3>
        <form action="${pageContext.request.contextPath}/admin/product/category/${categoryUpdate != null ? 'update' : 'add'}"
              method="post">

            <div class="form-group"><c:if test="${categoryUpdate != null}">
                <div>
                    <label>ID:</label>
                    <input type="text" name="id" value="${categoryUpdate.id}" readonly>
                </div>
            </c:if>
            </div>

            <div class="form-group">
                <label>Mã:</label>
                <input type="text" name="code" value="${categoryUpdate.code}" required
                       placeholder="Nhập mã danh mục...">
            </div>
            <div class="form-group">
                <label>Tên:</label>
                <input type="text" name="name" value="${categoryUpdate.name}" required
                       placeholder="Nhập tên danh mục...">
            </div>

            <button type="submit" class="btn-submit">${categoryUpdate != null ? 'Update' : 'Add'}</button>

            <c:if test="${categoryUpdate != null}">
                <a href="${pageContext.request.contextPath}/admin/product/add?modal=category">Hủy sửa</a>
            </c:if>
        </form>


    <h3 class="form-title">Danh sách Category</h3>
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
            <c:forEach items="${categoryList}" var="c">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.code}</td>
                    <td>${c.name}</td>
                    <td>
                        <div class="active-btns">
                            <a href="${pageContext.request.contextPath}/admin/product/category/update?id=${c.id}&modal=category"
                            class="btn-active btn-edit">
                                <span class="material-symbols-outlined">edit</span>
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/product/category/delete?id=${c.id}"
                               class="btn-active btn-delete"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                                <span class="material-symbols-outlined">delete</span>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>