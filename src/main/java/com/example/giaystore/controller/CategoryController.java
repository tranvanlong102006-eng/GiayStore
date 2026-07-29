package com.example.giaystore.controller;

import com.example.giaystore.entity.Category;
import com.example.giaystore.repository.CategoryRepository;
import com.example.giaystore.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "categoryController", value = {
        "/category/findAll",
        "/category/add",
        "/category/update",
        "/category/delete"
})
public class CategoryController extends HttpServlet {

    private CategoryService categoryService;

    public void init(){
        this.categoryService = new CategoryService(new CategoryRepository());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/category/findAll":
                findAll(req, resp);
                break;
            case "/category/update":
                viewUpdate(req, resp);
                break;
            case "/category/delete":
                delete(req, resp);
                break;
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
        categoryService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/category/findAll");
    }

    private void viewUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idStr = req.getParameter("id");

        if (idStr != null && !idStr.isEmpty()){

            Integer id = Integer.parseInt(idStr);
            Category category = categoryService.findById(id);
            req.setAttribute("categoryUpdate", category);
        }

        findAll(req, resp);
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Category> categoryList = categoryService.findAll();
        req.setAttribute("categoryList", categoryList);
        req.getRequestDispatcher("/admin/compontents/category-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/category/add":
                add(req, resp);
                break;
            case "/category/update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Category category = showAddUpdate(req);
        categoryService.update(category);
        resp.sendRedirect(req.getContextPath() + "/category/findAll");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Category category = showAddUpdate(req);
        categoryService.add(category);
        resp.sendRedirect(req.getContextPath() + "/category/findAll");
    }

    private Category showAddUpdate(HttpServletRequest req) {

        String idStr = req.getParameter("id");
        Integer id = (idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : null);
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        return new Category(id, code, name);
    }
}
