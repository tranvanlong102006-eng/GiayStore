package com.example.giaystore.utils;

import jakarta.persistence.EntityManager;

public class JdbcMain {

    public static void main(String[] args) {

        // 1. Khởi tạo kết nối JDBC thông thường (Nếu bạn thực sự cần dùng dcm)
        DataBaseConnectionManager dcm = new DataBaseConnectionManager("GIAYSTORE", "sa", "123");

        // 2. Sử dụng JPA/Hibernate để kết nối và tự động tạo bảng
        EntityManager em = null;
        try {
            em = EntityManagerUtils.getEntityManager();
            System.out.println("Created tables... Kết nối thành công!");
        } catch (Exception e) {
            System.out.println("Failed to create Entity Manager");
            e.printStackTrace();
        }
    }
}