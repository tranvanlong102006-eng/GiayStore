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

@WebServlet(name = "productController", value = {
        "/product/findAll",
        "/product/findById",
        "/product/add",
        "/product/update",
        "/product/delete"
})
public class ProductController extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;
    private BrandService brandService;
    private ColorService colorService;
    private SizeService sizeService;

    public void init() {

        this.productService = new ProductService(new ProductRepository());
        this.brandService = new BrandService(new BrandRepository());
        this.categoryService = new CategoryService(new CategoryRepository());
        this.colorService = new ColorService(new ColorRepository());
        this.sizeService = new SizeService(new SizeRepository());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/product/findAll":
                findAll(req, resp);
                break;
            case "/product/findById":
                findById(req, resp);
                break;
            case "/product/add":
            case "/product/update":
                viewUpdate(req, resp);
                break;
            case "/product/delete":
                delete(req, resp);
                break;
        }
    }

    private void viewUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idStr = req.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            Integer id = Integer.parseInt(idStr);
            Product product = productService.findById(id);
            req.setAttribute("productUpdate", product);
        }

        boolean i = true;
        req.setAttribute("booleanTrue", i);

        List<Category> categoryList = categoryService.findAll();
        req.setAttribute("categoryList", categoryList);

        List<Brand> brandList = brandService.findAll();
        req.setAttribute("brandList", brandList);

        List<Color> colorList = colorService.findAll();
        req.setAttribute("colorList", colorList);

        List<Size> sizeList = sizeService.findAll();
        req.setAttribute("sizeList", sizeList);

        findAll(req, resp);
    }

    private void findById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.findById(id);
        req.setAttribute("productDetail", product);
        findAll(req, resp);
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
        productService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/product/findAll");
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Product> productList = productService.findAll();
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/admin/compontents/product-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/product/add":
                add(req, resp);
                break;
            case "/product/update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Product product = showAddUpdate(req);
        productService.update(product);
        resp.sendRedirect(req.getContextPath() + "/product/findAll");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Product product = showAddUpdate(req);
        productService.add(product);
        resp.sendRedirect(req.getContextPath() + "/product/findAll");
    }

    private Product showAddUpdate(HttpServletRequest req) {

        String idStr = req.getParameter("id");
        Integer id = (idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : null);
        Integer categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Category category = categoryService.findById(categoryId);
        Integer brandId = Integer.parseInt(req.getParameter("brandId"));
        Brand brand = brandService.findById(brandId);
        Integer colorId = Integer.parseInt(req.getParameter("colorId"));
        Color color = colorService.findById(colorId);
        Integer sizeId = Integer.parseInt(req.getParameter("sizeId"));
        Size size = sizeService.findById(sizeId);
        String img = req.getParameter("img");
        String name = req.getParameter("name");
        Integer quantity = Integer.parseInt(req.getParameter("quantity"));
        BigDecimal price = new BigDecimal(req.getParameter("price"));
        String node = req.getParameter("node");
        Boolean active = Boolean.parseBoolean(req.getParameter("active"));
        return new Product(id, category, color, size, brand, null, img, name, quantity, price, node, active);

    }
}
