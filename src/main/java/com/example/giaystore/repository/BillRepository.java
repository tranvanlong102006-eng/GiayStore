package com.example.giaystore.repository;

import com.example.giaystore.entity.Bill;
import com.example.giaystore.utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import java.util.List;

public class BillRepository {

    public List<Bill> findAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()){
            String jpql = "SELECT DISTINCT b FROM Bill b JOIN FETCH b.user JOIN FETCH b.billProducts";
            return em.createQuery(jpql, Bill.class).getResultList();
        }
    }

    public Bill findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            String jpql = "SELECT DISTINCT b FROM Bill b " +
                    "JOIN FETCH b.user " +
                    "LEFT JOIN FETCH b.billProducts bp " +
                    "LEFT JOIN FETCH bp.product " +
                    "WHERE b.id = :id";
            return em.createQuery(jpql, Bill.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    // --- THÊM MỚI ---
    public void add(Bill bill) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(bill); // Nhờ cascade = ALL, BillProduct cũng sẽ tự động lưu
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // --- CẬP NHẬT ---
    public void update(Bill bill) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(bill);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // --- XÓA ---
    public void delete(Integer id) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            Bill bill = em.find(Bill.class, id);
            if (bill != null) {
                em.remove(bill); // Nhờ orphanRemoval = true/Cascade.ALL, BillProduct liên quan sẽ bị xóa theo
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}