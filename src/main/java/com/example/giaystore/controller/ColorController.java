package com.example.giaystore.controller;

import com.example.giaystore.entity.Color;
import com.example.giaystore.repository.ColorRepository;
import com.example.giaystore.service.ColorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "colorController", value = {
        "/admin/product/color",
        "/admin/product/color/add",
        "/admin/product/color/update",
        "/admin/product/color/delete"
})
public class ColorController extends HttpServlet {

    private ColorService colorService;

    public void init(){
        this.colorService = new ColorService(new ColorRepository());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/admin/product/color":
                findAll(req, resp);
                break;
            case "/admin/product/color/update":
                viewUpdate(req, resp);
                break;
            case "/admin/product/color/delete":
                delete(req, resp);
                break;
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
        colorService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=color");
    }

    private void viewUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idStr = req.getParameter("id");

        if (idStr != null && !idStr.isEmpty()){
            Integer id = Integer.parseInt(idStr);
            Color color = colorService.findById(id);
            req.setAttribute("colorUpdate", color);
        }

        findAll(req, resp);
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Color> colorList = colorService.findAll();
        req.setAttribute("colorList", colorList);
        req.setAttribute("booleanTrue", true);
        req.setAttribute("productPage", "/admin/compontents/color-list.jsp");

        // Forward về Servlet hoặc trang giao diện Product chính
        req.getRequestDispatcher("/admin/product/add").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/admin/product/color/add":
                add(req, resp);
                break;
            case "/admin/product/color/update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Color color = showAddUpdate(req);
        colorService.update(color);
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=color");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Color color = showAddUpdate(req);
        colorService.add(color);
        resp.sendRedirect(req.getContextPath() + "/admin/product/add?modal=color");
    }

    private Color showAddUpdate(HttpServletRequest req) {

        String idStr = req.getParameter("id");
        Integer id = (idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : null);
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        return new Color(id, code, name);
    }
}
