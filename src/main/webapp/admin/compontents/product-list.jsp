<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        /* Modal Overlay phủ toàn màn hình */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        /* Thẻ chi tiết dạng Popup */
        .detail-card {
            width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            max-height: 90vh;
            overflow-y: auto;
        }

        .detail-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .info-item {
            margin: 10px 0;
            font-size: 14px;
        }

        .btn-close {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn-close:hover {
            background-color: #5a6268;
        }

        .form-container {
            width: 450px;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-family: Arial, sans-serif;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .form-group {
            margin-bottom: 12px;
        }

        .form-group label {
            display: block;
            margin-bottom: 4px;
            font-weight: bold;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn-submit {
            background-color: #ffc107;
            color: black;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
    </style>
</head>
<body>

<c:if test="${not empty booleanTrue}">
    <div class="modal-overlay">
        <div class="form-container">
                <%-- SỬA LỖI DÒNG 111: Kiểm tra productUpdate != null --%>
            <form action="${pageContext.request.contextPath}/product/${productUpdate != null ? 'update' : 'add'}"
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
                        <p style="margin-top: 5px; font-size: 13px;">
                            Ảnh hiện tại: <strong>${productUpdate.img}</strong>
                        </p>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>Danh mục:</label>
                    <select name="categoryId" required>
                        <c:forEach items="${categoryList}" var="c">
                            <option value="${c.id}" ${productUpdate.category.id == c.id ? 'selected' : ''}>${c.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Thương hiệu:</label>
                    <select name="brandId" required>
                        <c:forEach items="${brandList}" var="b">
                            <option value="${b.id}" ${productUpdate.brand.id == b.id ? 'selected' : ''}>${b.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Màu sắc:</label>
                    <select name="colorId" required>
                        <c:forEach items="${colorList}" var="cl">
                            <option value="${cl.id}" ${productUpdate.color.id == cl.id ? 'selected' : ''}>${cl.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Kích cỡ:</label>
                    <select name="sizeId" required>
                        <c:forEach items="${sizeList}" var="s">
                            <option value="${s.id}" ${productUpdate.size.id == s.id ? 'selected' : ''}>${s.name}</option>
                        </c:forEach>
                    </select>
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
                        <%-- SỬA LỖI TẠI DÒNG CHECKBOX: Dùng 1 checkbox gọn gàng và chuẩn xác --%>
                    <label class="kinh-doanh">
                        <input type="checkbox" name="active" style="width: 50px"
                               value="true" ${productUpdate == null || productUpdate.active ? 'checked' : ''}/>
                        <span>Đang kinh doanh</span>
                    </label>
                </div>

                <button type="submit" class="btn-submit">${productUpdate != null ? 'Update' : 'Add'}</button>
                <a href="${pageContext.request.contextPath}/product/findAll" style="margin-left: 10px;">Hủy / Làm
                    mới</a>
            </form>
        </div>
    </div>
</c:if>

<a href="${pageContext.request.contextPath}/product/add" methods="get">
    <button>Them moi</button>
</a>
<h2>Danh sách sản phẩm</h2>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Hình ảnh</th>
        <th>Tên</th>
        <th>Category</th>
        <th>Color</th>
        <th>Size</th>
        <th>Brand</th>
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
            <td>${p.id}</td>
            <td>
                <img src="${pageContext.request.contextPath}/img/${p.img}" alt="${p.name}" width="80px"
                     style="border-radius: 8px">
            </td>
            <td>${p.name}</td>
            <td>${p.category.name}</td>
            <td>${p.color.name}</td>
            <td>${p.size.name}</td>
            <td>${p.brand.name}</td>
            <td>${p.quantity}</td>
            <td>${p.price} VNĐ</td>
            <td>${p.node}</td>
            <td>${p.active ? 'Còn hàng' : 'Hết hàng'}</td>
            <td>
                <a href="${pageContext.request.contextPath}/product/findById?id=${p.id}">
                    <button style="cursor: pointer;">Detail</button>
                </a>
                <a href="${pageContext.request.contextPath}/product/update?id=${p.id}">
                    <button style="cursor: pointer;">Update</button>
                </a>
                <a href="${pageContext.request.contextPath}/product/delete?id=${p.id}"
                   onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm ID = ${p.id} không?');">
                    <button style="color: red; cursor: pointer;">Delete</button>
                </a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${not empty productDetail}">
    <div class="modal-overlay">
        <div class="detail-card">
            <h2>Chi tiết sản phẩm #${productDetail.id}</h2>
            <img src="${pageContext.request.contextPath}/img/${productDetail.img}" alt="Ảnh sản phẩm"/>

            <div class="info-item"><strong>Tên sản phẩm:</strong> ${productDetail.name}</div>
            <div class="info-item"><strong>Danh mục:</strong> ${productDetail.category.name}</div>
            <div class="info-item"><strong>Thương hiệu:</strong> ${productDetail.brand.name}</div>
            <div class="info-item"><strong>Màu sắc:</strong> ${productDetail.color.name}</div>
            <div class="info-item"><strong>Kích cỡ:</strong> ${productDetail.size.name}</div>
            <div class="info-item"><strong>Số lượng:</strong> ${productDetail.quantity}</div>
            <div class="info-item"><strong>Giá:</strong> ${productDetail.price} VNĐ</div>
            <div class="info-item"><strong>Ghi chú:</strong> ${productDetail.node}</div>
            <div class="info-item"><strong>Trạng
                thái:</strong> ${productDetail.active ? 'Đang kinh doanh' : 'Không kinh doanh'}</div>

            <a href="${pageContext.request.contextPath}/product/findAll">
                <button class="btn-close">Đóng / Quay lại</button>
            </a>
        </div>
    </div>
</c:if>

</body>
</html>