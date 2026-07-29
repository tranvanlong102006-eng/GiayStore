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
        "/size/findAll",
        "/size/add",
        "/size/update",
        "/size/delete"
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
            case "/size/findAll":
                findAll(req, resp);
                break;
            case "/size/update":
                viewUpdate(req, resp);
                break;
            case "/size/delete":
                delete(req, resp);
                break;
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
        sizeService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/size/findAll");
    }

    private void viewUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String idStr = req.getParameter("id");

        if (idStr != null && !idStr.isEmpty()){
            Integer id = Integer.parseInt(idStr);
            Size size = sizeService.findById(id);
            req.setAttribute("sizeUpdate", size);
        }

        findAll(req, resp);
    }


    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        List<Size> sizeList = sizeService.findAll();
        req.setAttribute("sizeList", sizeList);
        resp.sendRedirect(req.getContextPath() + "/size/findAll");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/size/add":
                add(req, resp);
                break;
            case "/size/update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Size size = showAddUpdate(req);
        sizeService.update(size);
        resp.sendRedirect(req.getContextPath() + "/size/findAll");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Size size = showAddUpdate(req);
        sizeService.add(size);
        resp.sendRedirect(req.getContextPath() + "/size/findAll");
    }

    private Size showAddUpdate(HttpServletRequest req) {

        String idStr = req.getParameter("id");
        Integer id = (idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : null);
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        return new Size(id, code, name);
    }
}
