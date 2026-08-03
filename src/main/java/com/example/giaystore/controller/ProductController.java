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
        "/admin/product",
        "/admin/product/findById",
        "/admin/product/add",
        "/admin/product/update",
        "/admin/product/delete"
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
            case "/admin/product":
                findAll(req, resp);
                break;
            case "/admin/product/findById":
                findById(req, resp);
                break;
            case "/admin/product/add":
            case "/admin/product/update":
                viewUpdate(req, resp);
                break;
            case "/admin/product/delete":
                delete(req, resp);
                break;

        }
    }





    private void viewUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String modal = req.getParameter("modal");
        String idStr = req.getParameter("id");

        if (modal != null && !modal.isEmpty()) {
            req.setAttribute("pageProduct", true);

            switch (modal) {
                case "category":
                    req.setAttribute("productPage", "/admin/compontents/category-list.jsp");
                    if (idStr != null && !idStr.isEmpty()) {
                        req.setAttribute("categoryUpdate", categoryService.findById(Integer.parseInt(idStr)));
                    }
                    break;
                case "brand":
                    req.setAttribute("productPage", "/admin/compontents/brand-list.jsp");
                    if (idStr != null && !idStr.isEmpty()) {
                        req.setAttribute("brandUpdate", brandService.findById(Integer.parseInt(idStr)));
                    }
                    break;
                case "color":
                    req.setAttribute("productPage", "/admin/compontents/color-list.jsp");
                    if (idStr != null && !idStr.isEmpty()) {
                        req.setAttribute("colorUpdate", colorService.findById(Integer.parseInt(idStr)));
                    }
                    break;
                case "size":
                    req.setAttribute("productPage", "/admin/compontents/size-list.jsp");
                    if (idStr != null && !idStr.isEmpty()) {
                        req.setAttribute("sizeUpdate", sizeService.findById(Integer.parseInt(idStr)));
                    }
                    break;
            }
        } else if (idStr != null && !idStr.isEmpty()) {
            Integer productId = Integer.parseInt(idStr);
            Product product = productService.findById(productId);
            req.setAttribute("productUpdate", product);
        }

        req.setAttribute("booleanTrue", true);

        // Lấy danh sách cho các combobox
        req.setAttribute("categoryList", categoryService.findAll());
        req.setAttribute("brandList", brandService.findAll());
        req.setAttribute("colorList", colorService.findAll());
        req.setAttribute("sizeList", sizeService.findAll());

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
        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Product> productList = productService.findAll();
        req.setAttribute("productList", productList);

        req.setAttribute("currentPage", "product");
        // Gán product.jsp làm trang nội dung con được nhúng vào admin.jsp
        req.setAttribute("contentPage", "/admin/pages/product.jsp");

        // Trả về khung tổng quản trị
        req.getRequestDispatcher("/admin/pages/admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/admin/product/add":
                add(req, resp);
                break;
            case "/admin/product/update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
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
        Product product = new Product(id, category, color, size, brand, img, name, quantity, price, node, active);
        productService.update(product);
        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {


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

        Product product = new Product(null, category, color, size, brand, img, name, quantity, price, node, active);
        productService.add(product);
        resp.sendRedirect(req.getContextPath() + "/admin/product");
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
        return new Product(id, category, color, size, brand, img, name, quantity, price, node, active);

    }
}
