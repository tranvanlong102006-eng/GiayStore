package com.example.giaystore.repository;

import com.example.giaystore.entity.Brand;
import com.example.giaystore.utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import javax.swing.text.html.parser.Entity;
import java.util.List;

public class BrandRepository {

    public List<Brand> findAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()){
            return em.createQuery("SELECT b FROM Brand b", Brand.class).getResultList();
        }
    }

    public Brand findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()){
            return em.find(Brand.class, id);
        }
    }

    public void delete(Integer id) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.remove(em.find(Brand.class, id));
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void add(Brand brand) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(brand);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void update(Brand brand) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(brand);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }
}
