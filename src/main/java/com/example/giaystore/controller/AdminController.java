package com.example.giaystore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminController", urlPatterns = {
        "/admin",
        "/admin/invoice"
})
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/invoice".equals(path)) {
            req.setAttribute("currentPage", "invoice");
            req.setAttribute("contentPage", "/admin/pages/invoice.jsp");
        } else if ("/admin/product".equals(path)) {
            resp.sendRedirect(req.getContextPath() + "/admin/product");
            return;
        }

        req.getRequestDispatcher("/admin/pages/admin.jsp").forward(req, resp);
    }

}
