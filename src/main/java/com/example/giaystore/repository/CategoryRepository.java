package com.example.giaystore.repository;

import com.example.giaystore.entity.Category;
import com.example.giaystore.utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class CategoryRepository {

    public List<Category> findAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()){
            return em.createQuery("SELECT  c FROM Category c", Category.class).getResultList();
        }
    }

    public Category findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()){
            return em.find(Category.class, id);
        }
    }

    public void deleteById(Integer id) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try{
            trans.begin();
            em.remove(em.find(Category.class, id));
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void add(Category category) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try{
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }

    public void update(Category category) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try{
            trans.begin();
            em.merge(category);
            trans.commit();
        } catch (Exception e){
            trans.rollback();
        }
    }
}
