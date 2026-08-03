package com.example.giaystore.controller;

import com.example.giaystore.entity.Brand;
import com.example.giaystore.repository.BrandRepository;
import com.example.giaystore.service.BrandService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "brandController", value = {
        "/admin/product/brand",
        "/admin/product/brand/add",
        "/admin/product/brand/update",
        "/admin/product/brand/delete"
})
public class BrandController extends HttpServlet {

    private BrandService brandService;

    @Override
    public void init(){
        this.brandService = new BrandService(new BrandRepository());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/admin/product/brand":
                findAll(req, resp);
                break;
            case "/admin/product/brand/update":
                viewUpdate(req, resp);
                break;
            case "/admin/product/brand/delete":
                delete(req, resp);
                break;
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Integer id = Integer.parseInt(idStr);
            brandService.delete(id);
        }
        // Redirect về trang cha chứa Modal Brand
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=brand");
    }

    private void viewUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()){
            Integer id = Integer.parseInt(idStr);
            Brand brand = brandService.findById(id);
            req.setAttribute("brandUpdate", brand);
        }

        // Nếu dùng tham số modal=brand để mở lại popup ở trang cha
        String modal = req.getParameter("modal");
        if ("brand".equals(modal)) {
            // Forward tới Controller của trang Add Product để giữ nguyên Layout cha
            req.getRequestDispatcher("/admin/product/add?modal=brand").forward(req, resp);
            return;
        }

        findAll(req, resp);
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Brand> brandList = brandService.findAll();
        req.setAttribute("brandList", brandList);
        req.setAttribute("booleanTrue", true);
        req.setAttribute("productPage", "/admin/compontents/brand-list.jsp");

        // Forward về Servlet hoặc trang giao diện Product chính
        req.getRequestDispatcher("/admin/product/add").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/admin/product/brand/add":
                add(req, resp);
                break;
            case "/admin/product/brand/update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Brand brand = showAddUpdate(req);
        brandService.update(brand);
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=brand");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Brand brand = showAddUpdate(req);
        brandService.add(brand);
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=brand");
    }

    private Brand showAddUpdate(HttpServletRequest req) {
        String idStr = req.getParameter("id");
        Integer id = (idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : null);
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        return new Brand(id, code, name);
    }
}