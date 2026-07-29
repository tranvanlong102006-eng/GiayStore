package com.example.giaystore.service;

import com.example.giaystore.entity.Size;
import com.example.giaystore.repository.SizeRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class SizeService {

    private final SizeRepository sizeRepository;

    public List<Size> findAll() {
        return sizeRepository.findAll();
    }

    public Size findById(Integer id) {
        return sizeRepository.findById(id);
    }

    public void delete(Integer id) {
        sizeRepository.delete(id);
    }

    public void add(Size size) {
        sizeRepository.add(size);
    }

    public void update(Size size) {
        sizeRepository.update(size);
    }
}
