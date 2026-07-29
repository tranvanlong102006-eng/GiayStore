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
        "/color/findAll",
        "/color/add",
        "/color/update",
        "/color/delete"
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
            case "/color/findAll":
                findAll(req, resp);
                break;
            case "/color/update":
                viewUpdate(req, resp);
                break;
            case "/color/delete":
                delete(req, resp);
                break;
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Integer id = Integer.parseInt(req.getParameter("id"));
        colorService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/color/findAll");
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
        req.getRequestDispatcher("/admin/compontents/color-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path){
            case "/color/add":
                add(req, resp);
                break;
            case "/color/update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Color color = showAddUpdate(req);
        colorService.update(color);
        resp.sendRedirect(req.getContextPath() + "/color/findAll");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Color color = showAddUpdate(req);
        colorService.add(color);
        resp.sendRedirect(req.getContextPath() + "/color/findAll");
    }

    private Color showAddUpdate(HttpServletRequest req) {

        String idStr = req.getParameter("id");
        Integer id = (idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : null);
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        return new Color(id, code, name);
    }
}
