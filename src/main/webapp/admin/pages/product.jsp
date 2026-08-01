<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- CSS dành riêng cho trang Product (viết trong scope .product-page) -->
<style>
    .product-page {
        width: 100%;
        box-sizing: border-box;
    }

    /* Header của trang Product */
    .product-page .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .product-page .page-title {
        font-size: 22px;
        font-weight: 700;
        color: #1e293b;
        margin: 0;
    }

    /* Nút Thêm Mới */
    .product-page .btn-add-product {
        background-color: #2563eb;
        color: #ffffff;
        padding: 10px 18px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        border: none;
        cursor: pointer;
        transition: all 0.2s ease;
        box-shadow: 0 2px 4px rgba(37, 99, 235, 0.2);
    }

    .product-page .btn-add-product:hover {
        background-color: #1d4ed8;
        transform: translateY(-1px);
    }

    /* Bảng danh sách sản phẩm */
    .product-page .table-card {
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
        border: 1px solid #e2e8f0;
        overflow-x: auto;
    }

    .product-page .custom-table {
        width: 100%;
        border-collapse: collapse;
        text-align: left;
        font-size: 14px;
    }

    .product-page .custom-table th {
        background-color: #f8fafc;
        color: #64748b;
        font-weight: 600;
        padding: 14px 16px;
        border-bottom: 1px solid #e2e8f0;
        text-transform: uppercase;
        font-size: 12px;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }

    .product-page .custom-table td {
        padding: 14px 16px;
        border-bottom: 1px solid #f1f5f9;
        color: #334155;
        vertical-align: middle;
    }

    .product-page .custom-table tbody tr:hover {
        background-color: #f8fafc;
    }

    .product-page .product-img {
        width: 54px;
        height: 54px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
    }

    /* Badge Trạng thái */
    .product-page .status-badge {
        display: inline-block;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        white-space: nowrap;
    }

    .product-page .status-active {
        background-color: #dcfce7;
        color: #15803d;
    }

    .product-page .status-inactive {
        background-color: #fee2e2;
        color: #b91c1c;
    }

    /* Group Nút Hành động */
    /* Container căn giữa các nút */
    .action-btns {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    /* Base style chung cho tất cả nút bấm */
    .btn-action {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        border-radius: 8px;
        text-decoration: none;
        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        border: 1px solid transparent;
    }

    .btn-action .material-symbols-outlined {
        font-size: 20px;
        line-height: 1;
    }

    /* Khi click (active) tạo phản hồi chạm */
    .btn-action:active {
        transform: scale(0.92);
    }

    /* --- NÚT CHI TIẾT (Blue / Indigo) --- */
    .btn-detail {
        color: #2563eb;
        background-color: #eff6ff;
        border-color: #dbeafe;
    }

    .btn-detail:hover {
        color: #ffffff;
        background-color: #2563eb;
        border-color: #2563eb;
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
        transform: translateY(-2px);
    }

    /* --- NÚT SỬA (Amber / Emerald) --- */
    .btn-edit {
        color: #d97706;
        background-color: #fffbeb;
        border-color: #fef3c7;
    }

    .btn-edit:hover {
        color: #ffffff;
        background-color: #d97706;
        border-color: #d97706;
        box-shadow: 0 4px 12px rgba(217, 119, 6, 0.25);
        transform: translateY(-2px);
    }

    /* --- NÚT XÓA (Rose / Red) --- */
    .btn-delete {
        color: #dc2626;
        background-color: #fef2f2;
        border-color: #fee2e2;
    }

    .btn-delete:hover {
        color: #ffffff;
        background-color: #dc2626;
        border-color: #dc2626;
        box-shadow: 0 4px 12px rgba(220, 38, 38, 0.25);
        transform: translateY(-2px);
    }

    /* Stylings cho Modal Form & Detail Card */
    .product-page .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background-color: rgba(15, 23, 42, 0.5);
        backdrop-filter: blur(2px);
        display: flex;
        gap: 20px;
        justify-content: center;
        align-items: center;
        z-index: 1000;
    }

    .product-page .form-container,
    .product-page .detail-card {
        width: 460px;
        height: 1000px;
        background-color: #ffffff;
        border-radius: 8px;
        padding: 24px;
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
        max-height: 85vh;
        overflow-y: auto;

        -ms-overflow-style: none;
        scrollbar-width: none;
    }

    .product-page .form-container::-webkit-scrollbar{
        display: none;
    }

    .product-page .form-title {
        margin-top: 0;
        margin-bottom: 16px;
        font-size: 18px;
        color: #0f172a;
    }

    .product-page .form-group {
        margin-bottom: 14px;
    }

    .product-page .form-group label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        font-size: 13px;
        color: #334155;
    }

    .product-page .form-group .input-select {
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .product-page .form-group .input-select span{
        width: 20px;
        height: 20px;
        font-size: 20px;
        align-items: center;
        justify-items: center;
        color: white;
        background-color: #299929;
        border-radius: 50%;
    }

    .product-page .form-group input[type="text"],
    .product-page .form-group input[type="number"],
    .product-page .form-group input[type="file"],
    .product-page .form-group select,
    .product-page .form-group textarea {
        width: 90% !important;
        padding: 9px 12px;
        box-sizing: border-box;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
        outline: none;
        transition: border-color 0.2s;
    }

    .product-page .form-group input:focus,
    .product-page .form-group select:focus,
    .product-page .form-group textarea:focus {
        border-color: #2563eb;
    }

    .product-page .btn-submit {
        background-color: #2563eb;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
    }

    .product-page .btn-cancel {
        color: #64748b;
        text-decoration: none;
        margin-left: 12px;
        font-size: 14px;
    }
</style>

<div class="product-page">
    <div class="page-header">
        <h2 class="page-title">Danh sách sản phẩm</h2>
        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn-add-product">
            <i class="fa-solid fa-plus"></i> Thêm mới
        </a>
    </div>

    <div class="table-card">
        <table class="custom-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Hình ảnh</th>
                <th>Tên</th>
                <th>Danh mục</th>
                <th>Màu</th>
                <th>Size</th>
                <th>Hãng</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Ghi chú</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${productList}" var="p">
                <tr>
                    <td><strong>#${p.id}</strong></td>
                    <td>
                        <img src="${pageContext.request.contextPath}/img/${p.img}" alt="${p.name}" class="product-img">
                    </td>
                    <td><strong>${p.name}</strong></td>
                    <td>${p.category.name}</td>
                    <td>${p.color.name}</td>
                    <td>${p.size.name}</td>
                    <td>${p.brand.name}</td>
                    <td>${p.quantity}</td>
                    <td><strong>${p.price} VNĐ</strong></td>
                    <td>${p.node}</td>
                    <td>
                        <span class="status-badge ${p.active ? 'status-active' : 'status-inactive'}">
                                ${p.active ? 'Đang kinh doanh' : 'Ngừng kinh doanh'}
                        </span>
                    </td>
                    <td>
                        <div class="action-btns">
                            <!-- Nút Chi tiết -->
                            <a href="${pageContext.request.contextPath}/admin/product/findById?id=${p.id}"
                               class="btn-action btn-detail" title="Chi tiết">
                                <span class="material-symbols-outlined">info</span>
                            </a>

                            <!-- Nút Sửa -->
                            <a href="${pageContext.request.contextPath}/admin/product/update?id=${p.id}"
                               class="btn-action btn-edit" title="Chỉnh sửa">
                                <span class="material-symbols-outlined">edit</span>
                            </a>

                            <!-- Nút Xóa -->
                            <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.id}"
                               class="btn-action btn-delete" title="Xóa"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm ID = ${p.id} không?');">
                                <span class="material-symbols-outlined">delete</span>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Modal Form Add/Update -->
    <c:if test="${not empty booleanTrue}">
        <div class="modal-overlay">
            <div class="form-container">
                <h3 class="form-title">${productUpdate != null ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm mới'}</h3>
                <form action="${pageContext.request.contextPath}/admin/product/${productUpdate != null ? 'update' : 'add'}"
                      method="post">
                    <input type="hidden" name="id" value="${productUpdate.id}"/>

                    <div class="form-group">
                        <label>Tên sản phẩm:</label>
                        <input type="text" name="name" value="${productUpdate.name}" required/>
                    </div>

                    <div class="form-group">
                        <label>Chọn hình ảnh:</label>
                        <input type="file" name="img" accept="image/*"/>
                        <c:if test="${not empty productUpdate.img}">
                            <small style="color: #64748b; margin-top: 4px; display: block;">
                                Ảnh hiện tại: ${productUpdate.img}
                            </small>
                        </c:if>
                    </div>

                    <div class="form-group">
                        <label>Danh mục:</label>
                        <div class="input-select">
                            <select name="categoryId" required>
                                <c:forEach items="${categoryList}" var="c">
                                    <option value="${c.id}" ${productUpdate.category.id == c.id ? 'selected' : ''}>${c.name}</option>
                                </c:forEach>
                            </select>
                            <a href="${pageContext.request.contextPath}/admin/product/${productUpdate != null ? 'add': 'update'}?modal=category" title="Thêm Category">
                                <span class="material-symbols-outlined light-large-icon">add</span>
                            </a>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Thương hiệu:</label>
                        <div class="input-select">
                            <select name="brandId" required>
                                <c:forEach items="${brandList}" var="b">
                                    <option value="${b.id}" ${productUpdate.brand.id == b.id ? 'selected' : ''}>${b.name}</option>
                                </c:forEach>
                            </select>
                            <a href=""  title="Thêm Brand">
                                <span class="material-symbols-outlined light-large-icon">add</span>
                            </a></div>
                    </div>

                    <div class="form-group">
                        <label>Màu sắc:</label>
                        <div class="input-select">
                            <select name="colorId" required>
                                <c:forEach items="${colorList}" var="cl">
                                    <option value="${cl.id}" ${productUpdate.color.id == cl.id ? 'selected' : ''}>${cl.name}</option>
                                </c:forEach>
                            </select>
                            <a href=""  title="Thêm Color">
                                <span class="material-symbols-outlined light-large-icon">add</span>
                            </a></div>
                    </div>

                    <div class="form-group">
                        <label>Kích cỡ:</label>
                        <div class="input-select">
                            <select name="sizeId" required>
                            <c:forEach items="${sizeList}" var="s">
                                <option value="${s.id}" ${productUpdate.size.id == s.id ? 'selected' : ''}>${s.name}</option>
                            </c:forEach>
                        </select>
                            <a href="${pageContext.request.contextPath}/admin/product/category"  title="Thêm Size">
                                <span class="material-symbols-outlined light-large-icon">add</span>
                            </a></div>
                    </div>

                    <div class="form-group">
                        <label>Số lượng:</label>
                        <input type="number" name="quantity" value="${productUpdate.quantity}" required/>
                    </div>

                    <div class="form-group">
                        <label>Giá (VNĐ):</label>
                        <input type="number" step="0.01" name="price" value="${productUpdate.price}" required/>
                    </div>

                    <div class="form-group">
                        <label>Ghi chú:</label>
                        <textarea name="node" rows="3">${productUpdate.node}</textarea>
                    </div>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                            <input type="checkbox" name="active"
                                   value="true" ${productUpdate == null || productUpdate.active ? 'checked' : ''}/>
                            <span>Đang kinh doanh</span>
                        </label>
                    </div>

                    <div style="margin-top: 20px;">
                        <button type="submit"
                                class="btn-submit">${productUpdate != null ? 'Cập nhật' : 'Lưu sản phẩm'}</button>
                        <a href="${pageContext.request.contextPath}/admin/product" class="btn-cancel">Hủy bỏ</a>
                    </div>
                </form>
            </div>
            <c:if test="${not empty pageProduct}">
                <div class="form-container">
                    <jsp:include page="${productPage}" />
                </div>
            </c:if>
        </div>
    </c:if>

    <!-- Modal Xem Chi Tiết -->
    <c:if test="${not empty productDetail}">
        <div class="modal-overlay">
            <div class="detail-card">
                <h3 class="form-title">Chi tiết sản phẩm #${productDetail.id}</h3>
                <img src="${pageContext.request.contextPath}/img/${productDetail.img}" alt="Ảnh sản phẩm"
                     style="width:100%; height:200px; object-fit:cover; border-radius:8px; margin-bottom:15px;"/>

                <div style="font-size: 14px; line-height: 1.8;">
                    <div><strong>Tên sản phẩm:</strong> ${productDetail.name}</div>
                    <div><strong>Danh mục:</strong> ${productDetail.category.name}</div>
                    <div><strong>Thương hiệu:</strong> ${productDetail.brand.name}</div>
                    <div><strong>Màu sắc:</strong> ${productDetail.color.name}</div>
                    <div><strong>Kích cỡ:</strong> ${productDetail.size.name}</div>
                    <div><strong>Số lượng:</strong> ${productDetail.quantity}</div>
                    <div><strong>Giá:</strong> ${productDetail.price} VNĐ</div>
                    <div><strong>Ghi chú:</strong> ${productDetail.node}</div>
                    <div><strong>Trạng thái:</strong> ${productDetail.active ? 'Đang kinh doanh' : 'Ngừng kinh doanh'}
                    </div>
                </div>

                <div style="margin-top: 20px; text-align: right;">
                    <a href="${pageContext.request.contextPath}/admin/product" class="btn-submit"
                       style="padding: 8px 16px; text-decoration: none">Đóng</a>
                </div>
            </div>
        </div>
    </c:if>
</div>