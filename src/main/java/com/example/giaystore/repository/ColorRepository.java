package com.example.giaystore.repository;

import com.example.giaystore.entity.Category;
import com.example.giaystore.entity.Color;
import com.example.giaystore.utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class ColorRepository {
    public List<Color> findAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()){
            return em.createQuery("SELECT c FROM Color c", Color.class).getResultList();
        }
    }

    public Color findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()){
            return em.find(Color.class, id);
        }
    }

    public void delete(Integer id) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.remove(em.find(Color.class, id));
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void add(Color color) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(color);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void update(Color color) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(color);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }
}
