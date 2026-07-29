package com.example.giaystore.repository;

import com.example.giaystore.entity.Product;
import com.example.giaystore.utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class ProductRepository {
    public List<Product> findAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            String jpql = "SELECT p FROM Product p " +
                    "JOIN FETCH p.category " +
                    "JOIN FETCH p.size " +
                    "JOIN FETCH p.brand " +
                    "JOIN FETCH p.color";

            return em.createQuery(jpql, Product.class).getResultList();
        }
    }

    public void delete(Integer id) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product product = em.find(Product.class, id);
            em.remove(product);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public Product findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            String jpql = "SELECT p FROM Product p " +
                    "JOIN FETCH p.category " +
                    "JOIN FETCH p.size " +
                    "JOIN FETCH p.brand " +
                    "JOIN FETCH p.color " +
                    "WHERE p.id = :id";

            return em.createQuery(jpql, Product.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void add(Product product) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void update(Product product) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }


}
