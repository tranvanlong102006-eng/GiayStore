package com.example.giaystore.controller;

import com.example.giaystore.entity.Size;
import com.example.giaystore.repository.SizeRepository;
import com.example.giaystore.service.SizeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "sizeController", value = {
        "/admin/product/size/findAll",
        "/admin/product/size/add",
        "/admin/product/size/update",
        "/admin/product/size/delete"
})
public class SizeController extends HttpServlet {

    private SizeService sizeService;

    public void init(){
        this.sizeService = new SizeService(new SizeRepository());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/admin/product/size/findAll":
                findAll(req, resp);
                break;
            case "/admin/product/size/update":
                viewUpdate(req, resp);
                break;
            case "/admin/product/size/delete":
                delete(req, resp);
                break;
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
        sizeService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=size");
    }

    private void viewUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        String idStr = req.getParameter("id");

        if (idStr != null && !idStr.isEmpty()){
            Integer id = Integer.parseInt(idStr);
            Size size = sizeService.findById(id);
            req.setAttribute("sizeUpdate", size);
        }

        findAll(req, resp);
    }


    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        List<Size> sizeList = sizeService.findAll();
        req.setAttribute("sizeList", sizeList);
        req.setAttribute("booleanTrue", true);
        req.setAttribute("productPage", "/admin/compontents/size-list.jsp");

        // Forward về Servlet hoặc trang giao diện Product chính
        req.getRequestDispatcher("/admin/product/add").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/admin/product/size/add":
                add(req, resp);
                break;
            case "/admin/product/size/update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Size size = showAddUpdate(req);
        sizeService.update(size);
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=size");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Size size = showAddUpdate(req);
        sizeService.add(size);
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=size");
    }

    private Size showAddUpdate(HttpServletRequest req) {

        String idStr = req.getParameter("id");
        Integer id = (idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : null);
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        return new Size(id, code, name);
    }
}
