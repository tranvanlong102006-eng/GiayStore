package com.example.giaystore.service;

import com.example.giaystore.entity.Product;
import com.example.giaystore.repository.ProductRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public void delete(Integer id) {
        productRepository.delete(id);
    }

    public Product findById(Integer id) {
        return productRepository.findById(id);
    }

    public void add(Product product){
        productRepository.add(product);
    }

    public void update(Product product){
        productRepository.update(product);
    }
}
