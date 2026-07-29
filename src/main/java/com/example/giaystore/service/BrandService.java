package com.example.giaystore.service;

import com.example.giaystore.entity.Brand;
import com.example.giaystore.repository.BrandRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class BrandService {

    private final BrandRepository brandRepository;

    public List<Brand> findAll() {
        return brandRepository.findAll();
    }

    public Brand findById(Integer id) {
        return brandRepository.findById(id);
    }

    public void delete(Integer id) {
        brandRepository.delete(id);
    }

    public void add(Brand brand) {
        brandRepository.add(brand);
    }

    public void update(Brand brand) {
        brandRepository.update(brand);
    }
}
