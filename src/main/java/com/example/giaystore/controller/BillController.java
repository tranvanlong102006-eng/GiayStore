package com.example.giaystore.controller;

import com.example.giaystore.entity.*;
import com.example.giaystore.repository.*;
import com.example.giaystore.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "billController", value = {
        "/admin/bill",
        "/admin/bill/findById",
        "/admin/bill/add",
        "/admin/bill/update-status",
        "/admin/bill/delete"
})
public class BillController extends HttpServlet {

    private BillService billService;
    private ProductService productService;

    @Override
    public void init() {
        this.billService = new BillService(new BillRepository());
        this.productService = new ProductService(new ProductRepository());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/admin/bill":
                findAll(req, resp);
                break;
            case "/admin/bill/findById":
                viewDetail(req, resp);
                break;
            case "/admin/bill/add":
                showAddForm(req, resp);
                break;
            case "/admin/bill/delete":
                deleteBill(req, resp);
                break;
        }
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Bill> billList = billService.findAll();
        List<Product> productList = productService.findAll();

        req.setAttribute("billList", billList);
        req.setAttribute("productList", productList);
        req.setAttribute("showAddForm", true); // Bật cờ để hiển thị Modal thêm mới trong JSP

        req.setAttribute("currentPage", "bill");
        req.setAttribute("contentPage", "/admin/pages/bill.jsp");

        req.getRequestDispatcher("/admin/pages/admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/admin/bill/add":
                addBill(req, resp);
                break;
            case "/admin/bill/update-status":
                updateStatus(req, resp);
                break;
        }
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Bill> billList = billService.findAll();
        List<Product> productList = productService.findAll();

        // Đẩy đủ dữ liệu ra JSP
        req.setAttribute("billList", billList);
        req.setAttribute("productList", productList);

        req.setAttribute("currentPage", "bill");
        req.setAttribute("contentPage", "/admin/pages/bill.jsp");

        req.getRequestDispatcher("/admin/pages/admin.jsp").forward(req, resp);
    }

    private void viewDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));
        Bill bill = billService.findById(id);
        List<Bill> billList = billService.findAll();
        List<Product> productList = productService.findAll();

        req.setAttribute("billDetail", bill);
        req.setAttribute("billList", billList);
        req.setAttribute("productList", productList);

        req.setAttribute("currentPage", "bill");
        // Nhúng bill.jsp vào trang tổng admin.jsp để giữ nguyên Layout Sidebar & Header
        req.setAttribute("contentPage", "/admin/pages/bill.jsp");

        req.getRequestDispatcher("/admin/pages/admin.jsp").forward(req, resp);
    }

    private void addBill(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String code = req.getParameter("code");
        Integer userId = Integer.parseInt(req.getParameter("userId"));

        User user = new User();
        user.setId(userId);

        Bill bill = new Bill();
        bill.setCode(code);
        bill.setUser(user);
        bill.setStatus(BillStatus.PENDING);

        String[] productIds = req.getParameterValues("productId");
        String[] quantities = req.getParameterValues("quantity");
        String[] prices = req.getParameterValues("price");

        BigDecimal totalBill = BigDecimal.ZERO;

        if (productIds != null) {
            for (int i = 0; i < productIds.length; i++) {
                Product product = new Product();
                product.setId(Integer.parseInt(productIds[i]));

                int qty = Integer.parseInt(quantities[i]);
                BigDecimal unitPrice = new BigDecimal(prices[i]);
                BigDecimal itemTotal = unitPrice.multiply(BigDecimal.valueOf(qty));

                BillProduct billProduct = new BillProduct();
                billProduct.setProduct(product);
                billProduct.setQuantity(qty);
                billProduct.setPrice(unitPrice);
                billProduct.setBill(bill);

                bill.getBillProducts().add(billProduct);
                totalBill = totalBill.add(itemTotal);
            }
        }

        bill.setTotal(totalBill);
        billService.create(bill);

        resp.sendRedirect(req.getContextPath() + "/admin/bill");
    }

    private void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));
        BillStatus status = BillStatus.valueOf(req.getParameter("status"));

        billService.updateStatus(id, status);
        resp.sendRedirect(req.getContextPath() + "/admin/bill");
    }

    private void deleteBill(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));
        billService.delete(id);

        resp.sendRedirect(req.getContextPath() + "/admin/bill");
    }
}