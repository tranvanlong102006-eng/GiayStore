package com.example.giaystore.repository;

import com.example.giaystore.entity.Color;
import com.example.giaystore.entity.Size;
import com.example.giaystore.utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class SizeRepository {
    public List<Size> findAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.createQuery("SELECT s FROM Size s", Size.class).getResultList();
        }
    }

    public Size findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.find(Size.class, id);
        }
    }

    public void delete(Integer id) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.remove(em.find(Size.class, id));
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void add(Size size) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(size);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void update(Size size) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(size);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }
}
