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
        "/brand/findAll",
        "/brand/add",
        "/brand/update",
        "/brand/delete"
})
public class BrandController extends HttpServlet {

    private BrandService brandService;

    public void init(){
        this.brandService = new BrandService(new BrandRepository());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/brand/findAll":
                findAll(req, resp);
                break;
            case "/brand/update":
                viewUpdate(req, resp);
                break;
            case "/brand/delete":
                delete(req, resp);
                break;
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
        brandService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/brand/findAll");
    }

    private void viewUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idStr = req.getParameter("id");

        if (idStr != null && !idStr.isEmpty()){

             Integer id = Integer.parseInt(idStr);
             Brand brand = brandService.findById(id);
             req.setAttribute("brandUpdate", brand);
        }

        findAll(req, resp);
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Brand> brandList = brandService.findAll();
        req.setAttribute("brandList", brandList);
        req.getRequestDispatcher("/admin/compontents/brand-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/brand/add":
                add(req, resp);
                break;
            case "/brand/update":
                update(req, resp);
                break;
        }

    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Brand brand = showAddUpdate(req);
        brandService.update(brand);
        resp.sendRedirect(req.getContextPath() + "/brand/findAll");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Brand brand = showAddUpdate(req);
        brandService.add(brand);
        resp.sendRedirect(req.getContextPath() + "/brand/findAll");
    }

    private Brand showAddUpdate(HttpServletRequest req) {

        String idStr = req.getParameter("id");
        Integer id = (idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : null);
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        return new Brand(id, code, name);
    }
}
