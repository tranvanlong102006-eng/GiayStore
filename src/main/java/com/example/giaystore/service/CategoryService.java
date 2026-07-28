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

    public Category finById(Integer id) {
        return categoryRepository.findById(id);
    }

    public void deleteById(Integer id) {
        categoryRepository.deleteById(id);
    }

    public void add(Category category) {
        categoryRepository.add(category);
    }

    public void update(Category category) {
        categoryRepository.update(category);
    }
}
