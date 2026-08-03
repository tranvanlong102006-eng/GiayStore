<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- CSS dành riêng cho trang Bill (đồng bộ 100% theo scope và style của product.jsp) -->
<style>
    .bill-page {
        width: 100%;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        gap: 24px;
        font-family: inherit;
    }

    /* Header của trang Bill */
    .bill-page .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 8px;
    }

    .bill-page .page-title {
        font-size: 22px;
        font-weight: 700;
        color: #1e293b;
        margin: 0;
    }

    /* Nút Thêm Mới (Đồng bộ chuẩn từ product.jsp) */
    .bill-page .btn-add-product {
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

    .bill-page .btn-add-product:hover {
        background-color: #1d4ed8;
        transform: translateY(-1px);
    }

    /* Bảng danh sách hóa đơn & sản phẩm */
    .bill-page .table-card {
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
        border: 1px solid #e2e8f0;
        overflow-x: auto;
        padding: 20px;
    }

    .bill-page .card-subtitle {
        font-size: 16px;
        font-weight: 700;
        color: #0f172a;
        margin: 0 0 16px 0;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .bill-page .card-subtitle::before {
        content: '';
        display: inline-block;
        width: 4px;
        height: 16px;
        background-color: #2563eb;
        border-radius: 2px;
    }

    .bill-page .custom-table {
        width: 100%;
        border-collapse: collapse;
        text-align: left;
        font-size: 14px;
    }

    .bill-page .custom-table th {
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

    .bill-page .custom-table td {
        padding: 14px 16px;
        border-bottom: 1px solid #f1f5f9;
        color: #334155;
        vertical-align: middle;
    }

    .bill-page .custom-table tbody tr:hover {
        background-color: #f8fafc;
    }

    .bill-page .product-img {
        width: 48px;
        height: 48px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
    }

    /* Status Badges */
    .bill-page .status-badge {
        display: inline-block;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        white-space: nowrap;
        background-color: #eff6ff;
        color: #2563eb;
    }

    /* Action Buttons (Copy chuẩn từ product.jsp) */
    .bill-page .action-btns {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .bill-page .btn-action {
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

    .bill-page .btn-action .material-symbols-outlined {
        font-size: 20px;
        line-height: 1;
    }

    .bill-page .btn-action:active {
        transform: scale(0.92);
    }

    .bill-page .btn-detail {
        color: #2563eb;
        background-color: #eff6ff;
        border-color: #dbeafe;
    }

    .bill-page .btn-detail:hover {
        color: #ffffff;
        background-color: #2563eb;
        border-color: #2563eb;
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
        transform: translateY(-2px);
    }

    .bill-page .btn-delete {
        color: #dc2626;
        background-color: #fef2f2;
        border-color: #fee2e2;
    }

    .bill-page .btn-delete:hover {
        color: #ffffff;
        background-color: #dc2626;
        border-color: #dc2626;
        box-shadow: 0 4px 12px rgba(220, 38, 38, 0.25);
        transform: translateY(-2px);
    }

    .bill-page .btn-add-sm {
        background-color: #16a34a;
        color: #ffffff;
        padding: 6px 12px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        font-weight: 600;
        font-size: 12px;
        transition: all 0.2s ease;
    }

    .bill-page .btn-add-sm:hover {
        background-color: #15803d;
    }

    /* Modal Styling */
    .bill-page .modal-overlay {
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

    .bill-page .detail-card,
    .bill-page .form-modal-card {
        background-color: #ffffff;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
        max-height: 90vh;
        overflow-y: auto;
        -ms-overflow-style: none;
        scrollbar-width: none;
    }

    .bill-page .detail-card {
        width: 520px;
    }

    .bill-page .form-modal-card {
        width: 1200px;
        height: 80%;
    }

    .bill-page .detail-card::-webkit-scrollbar,
    .bill-page .form-modal-card::-webkit-scrollbar {
        display: none;
    }

    .bill-page .form-title {
        margin-top: 0;
        margin-bottom: 16px;
        font-size: 18px;
        color: #0f172a;
        font-weight: 700;
    }

    /* Form Controls */
    .bill-page .form-row {
        display: flex;
        gap: 16px;
        margin-bottom: 16px;
    }

    .bill-page .form-group {
        flex: 1;
        display: flex;
        flex-direction: column;
    }

    .bill-page .form-group label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        font-size: 13px;
        color: #334155;
    }

    .bill-page .form-group input[type="text"],
    .bill-page .form-group input[type="number"] {
        width: 100%;
        padding: 9px 12px;
        box-sizing: border-box;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
        outline: none;
        transition: border-color 0.2s;
    }

    .bill-page .form-group input:focus {
        border-color: #2563eb;
    }

    /* Layout Panel Tạo Hóa Đơn Đôi */
    .bill-page .flex-container {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
    }

    .bill-page .col-panel {
        flex: 1;
        min-width: 320px;
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        padding: 16px;
        height: 500px;
    }

    .bill-page .btn-submit {
        background-color: #2563eb;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        font-size: 14px;
        transition: background-color 0.2s;
    }

    .bill-page .btn-submit:hover {
        background-color: #1d4ed8;
    }

    .bill-page .btn-cancel {
        color: #64748b;
        text-decoration: none;
        margin-left: 12px;
        font-size: 14px;
        font-weight: 600;
    }

    .bill-page .btn-cancel:hover {
        color: #0f172a;
    }

    .bill-page .total-box {
        margin-top: 16px;
        padding: 12px 16px;
        background: #ffffff;
        border-radius: 6px;
        border: 1px solid #e2e8f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>

<div class="bill-page">

    <!-- Header Trang: Đã thêm nút Thêm mới giống product.jsp -->
    <div class="page-header">
        <h2 class="page-title">Quản lý hóa đơn</h2>
        <a href="${pageContext.request.contextPath}/admin/bill/add" class="btn-add-product">
            <i class="fa-solid fa-plus"></i> Thêm mới
        </a>
    </div>

    <!-- ==================== PART 1: DANH SÁCH HÓA ĐƠN ==================== -->
    <div class="table-card">
        <h3 class="card-subtitle">Danh sách hóa đơn hiện có</h3>
        <table class="custom-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Mã HD</th>
                <th>Khách hàng</th>
                <th>Tổng tiền</th>
                <th>Ngày tạo</th>
                <th>Trạng thái</th>
                <th style="text-align: center;">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${billList}" var="b">
                <tr>
                    <td><strong>#${b.id}</strong></td>
                    <td><strong style="color: #2563eb;">${b.code}</strong></td>
                    <td><strong>${b.user.username}</strong></td>
                    <td><strong style="color: #0f172a;">${b.total} VNĐ</strong></td>
                    <td>${b.createDay}</td>
                    <td>
                        <span class="status-badge">${b.status}</span>
                    </td>
                    <td>
                        <div class="action-btns">
                            <!-- Nút Chi tiết -->
                            <a href="${pageContext.request.contextPath}/admin/bill/findById?id=${b.id}"
                               class="btn-action btn-detail" title="Chi tiết">
                                <span class="material-symbols-outlined">info</span>
                            </a>

                            <!-- Nút Xóa -->
                            <a href="${pageContext.request.contextPath}/admin/bill/delete?id=${b.id}"
                               class="btn-action btn-delete" title="Xóa"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa hóa đơn này không?');">
                                <span class="material-symbols-outlined">delete</span>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- ==================== PART 2: MODAL CHI TIẾT HÓA ĐƠN ==================== -->
    <c:if test="${not empty billDetail}">
        <div class="modal-overlay">
            <div class="detail-card">
                <h3 class="form-title">Chi tiết hóa đơn #${billDetail.id}</h3>

                <div style="font-size: 14px; line-height: 1.8; margin-bottom: 20px; background: #f8fafc; padding: 14px; border-radius: 8px; border: 1px solid #e2e8f0;">
                    <div><strong>Mã Hóa Đơn:</strong> <span
                            style="color: #2563eb; font-weight: 700;">${billDetail.code}</span></div>
                    <div><strong>Khách Hàng:</strong> ${billDetail.user.username}</div>
                    <div><strong>Email:</strong> ${billDetail.user.email}</div>
                    <div><strong>Ngày Tạo:</strong> ${billDetail.createDay}</div>
                    <div><strong>Trạng Thái:</strong> <span class="status-badge">${billDetail.status}</span></div>
                </div>

                <h4 style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 10px;">SẢN PHẨM TRONG HÓA
                    ĐƠN</h4>

                <table class="custom-table" style="margin-bottom: 20px;">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Ảnh</th>
                        <th>Tên SP</th>
                        <th>Đơn Giá</th>
                        <th>SL</th>
                        <th>Thành Tiền</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${billDetail.billProducts}" var="bp" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>
                                <img src="${pageContext.request.contextPath}/img/${bp.product.img}"
                                     alt="${bp.product.name}" class="product-img"
                                     onerror="this.src='https://via.placeholder.com/48';"/>
                            </td>
                            <td><strong>${bp.product.name}</strong></td>
                            <td>${bp.price}</td>
                            <td><strong>x${bp.quantity}</strong></td>
                            <td style="font-weight: 700; color: #dc2626;">${bp.quantity * bp.price} VNĐ</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/admin/bill" class="btn-submit"
                       style="padding: 8px 18px; text-decoration: none; display: inline-block;">Đóng</a>
                </div>
            </div>
        </div>
    </c:if>

    <!-- ==================== PART 3: MODAL THÊM HÓA ĐƠN MỚI (CHỈ HIỆN KHI ẤN THÊM MỚI) ==================== -->
    <c:if test="${not empty showAddForm or not empty booleanTrue}">
        <div class="modal-overlay">
            <div class="form-modal-card">
                <h3 class="form-title">Tạo hóa đơn mới</h3>

                <form action="${pageContext.request.contextPath}/admin/bill/add" method="post" id="billForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Mã Hóa Đơn:</label>
                            <input type="text" name="code" placeholder="VD: HD-001" required>
                        </div>
                        <div class="form-group">
                            <label>ID Người Dùng:</label>
                            select
                            <input type="number" name="userId" placeholder="VD: 1" required>
                        </div>
                    </div>

                    <div class="flex-container">
                        <!-- KHO SẢN PHẨM -->
                        <div class="col-panel">
                            <h4 style="font-size: 14px; font-weight: 700; margin-top: 0; margin-bottom: 12px;">1. Chọn
                                Sản Phẩm Từ Kho</h4>
                            <div style="max-height: 450px; overflow-y: auto;">
                                <table class="custom-table">
                                    <thead>
                                    <tr>
                                        <th>Ảnh</th>
                                        <th>Tên SP</th>
                                        <th>Giá</th>
                                        <th>SL</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${productList}" var="p">
                                        <tr>
                                            <td>
                                                <img src="${pageContext.request.contextPath}/img/${p.img}"
                                                     alt="${p.name}" class="product-img"
                                                     onerror="this.src='https://via.placeholder.com/48';"/>
                                            </td>
                                            <td><strong>${p.name}</strong></td>
                                            <td>${p.price}</td>
                                            <td>
                                                <input type="number" id="qty_${p.id}" value="1" min="1"
                                                       style="width: 50px; padding: 4px; border: 1px solid #cbd5e1; border-radius: 4px;">
                                            </td>
                                            <td>
                                                <button type="button" class="btn-add-sm"
                                                        onclick="addProductToBill('${p.id}', '${p.name}', '${p.price}', '${p.img}')">
                                                    + Thêm
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- SẢN PHẨM ĐÃ CHỌN -->
                        <div class="col-panel" style="background: #ffffff;">
                            <h4 style="font-size: 14px; font-weight: 700; margin-top: 0; margin-bottom: 12px;">2. Sản
                                Phẩm Đã Chọn</h4>
                            <div style="min-height: 180px; height: 300px; overflow-y: auto;">
                                <table class="custom-table">
                                    <thead>
                                    <tr>
                                        <th>Ảnh</th>
                                        <th>Tên SP</th>
                                        <th>Đơn Giá</th>
                                        <th>SL</th>
                                        <th>Thành Tiền</th>
                                        <th>Xóa</th>
                                    </tr>
                                    </thead>
                                    <tbody id="selectedProductBody">
                                    </tbody>
                                </table>
                            </div>

                            <div class="total-box">
                                <span style="font-size: 14px; font-weight: 600; color: #64748b;">Tổng tiền hóa đơn:</span>
                                <div>
                                    <span id="displayTotal"
                                          style="color: #dc2626; font-weight: 800; font-size: 18px;">0</span>
                                    <span style="font-weight: 700; color: #dc2626;">VNĐ</span>
                                </div>
                            </div>

                            <div style="margin-top: 20px; display: flex; align-items: center; justify-content: flex-end;">
                                <button type="submit" class="btn-submit">
                                    XÁC NHẬN TẠO HÓA ĐƠN
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/bill" class="btn-cancel">Hủy bỏ</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

</div>

<!-- JAVASCRIPT XỬ LÝ DYNAMIC FORM -->
<script>
    var contextPath = "${pageContext.request.contextPath}";

    function addProductToBill(id, name, price, img) {
        var qtyInput = document.getElementById('qty_' + id);
        var quantity = parseInt(qtyInput.value);

        if (isNaN(quantity) || quantity <= 0) {
            alert('Vui lòng nhập số lượng hợp lệ!');
            return;
        }

        var tbody = document.getElementById('selectedProductBody');
        var existingRow = document.getElementById('selected_row_' + id);

        if (existingRow) {
            // Nếu sản phẩm đã có trong danh sách -> Tăng số lượng
            var qtyField = existingRow.querySelector('input[name="quantity"]');
            var newQty = parseInt(qtyField.value) + quantity;
            qtyField.value = newQty;

            var itemTotalCell = existingRow.querySelector('.item-total');
            var totalAmount = newQty * parseFloat(price);
            itemTotalCell.innerText = totalAmount.toLocaleString('vi-VN');
        } else {
            // Nếu sản phẩm chưa có -> Thêm dòng mới
            var newRow = document.createElement('tr');
            newRow.id = 'selected_row_' + id;

            var itemTotal = (quantity * parseFloat(price)).toLocaleString('vi-VN');

            newRow.innerHTML =
                '<td><img src="' + contextPath + '/img/' + img + '" alt="' + name + '" class="product-img" onerror="this.src=\'https://via.placeholder.com/48\';"></td>' +
                '<td><strong>' + name + '</strong><input type="hidden" name="productId" value="' + id + '"></td>' +
                '<td>' + price + '<input type="hidden" name="price" value="' + price + '"></td>' +
                '<td><input type="number" name="quantity" value="' + quantity + '" min="1" style="width: 50px; padding: 4px; border: 1px solid #cbd5e1; border-radius: 4px;" onchange="updateItemTotal(this, ' + price + ')"></td>' +
                '<td class="item-total" style="font-weight: 700; color: #0f172a;">' + itemTotal + '</td>' +
                '<td><button type="button" class="btn-action btn-delete" style="width: 28px; height: 28px;" onclick="removeProductRow(\'' + id + '\')"><span class="material-symbols-outlined" style="font-size: 16px;">delete</span></button></td>';

            tbody.appendChild(newRow);
        }

        qtyInput.value = 1;
        calculateGrandTotal();
    }

    function updateItemTotal(inputElement, price) {
        var row = inputElement.closest('tr');
        var qty = parseInt(inputElement.value);

        if (isNaN(qty) || qty <= 0) {
            qty = 1;
            inputElement.value = 1;
        }

        var itemTotalCell = row.querySelector('.item-total');
        var totalAmount = qty * parseFloat(price);
        itemTotalCell.innerText = totalAmount.toLocaleString('vi-VN');
        calculateGrandTotal();
    }

    function removeProductRow(id) {
        var row = document.getElementById('selected_row_' + id);
        if (row) {
            row.remove();
            calculateGrandTotal();
        }
    }

    // Hàm tính tổng tiền chính xác dựa trên input
    function calculateGrandTotal() {
        var rows = document.querySelectorAll('#selectedProductBody tr');
        var grandTotal = 0;

        rows.forEach(function (row) {
            var qtyInput = row.querySelector('input[name="quantity"]');
            var priceInput = row.querySelector('input[name="price"]');

            if (qtyInput && priceInput) {
                var qty = parseInt(qtyInput.value) || 0;
                var price = parseFloat(priceInput.value) || 0;
                grandTotal += qty * price;
            }
        });

        document.getElementById('displayTotal').innerText = Math.round(grandTotal).toLocaleString('vi-VN');
    }

    var billForm = document.getElementById('billForm');
    if (billForm) {
        billForm.addEventListener('submit', function (e) {
            var rows = document.querySelectorAll('#selectedProductBody tr');
            if (rows.length === 0) {
                e.preventDefault();
                alert('Vui lòng chọn ít nhất 1 sản phẩm trước khi tạo hóa đơn!');
            }
        });
    }
</script>