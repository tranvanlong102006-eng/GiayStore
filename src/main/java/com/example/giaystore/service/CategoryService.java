package com.example.giaystore.service;

import com.example.giaystore.entity.Category;
import com.example.giaystore.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository categoryRepository;

    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    public Category findById(Integer id) {
        return categoryRepository.findById(id);
    }

    public void delete(Integer id) {
        categoryRepository.delete(id);
    }

    public void add(Category category) {
        categoryRepository.add(category);
    }

    public void update(Category category) {
        categoryRepository.update(category);
    }
}
