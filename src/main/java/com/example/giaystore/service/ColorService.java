package com.example.giaystore.service;

import com.example.giaystore.entity.Color;
import com.example.giaystore.repository.ColorRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class ColorService {

    private final ColorRepository colorRepository;

    public List<Color> findAll() {
        return colorRepository.findAll();
    }

    public Color findById(Integer id) {
        return colorRepository.findById(id);
    }

    public void delete(Integer id) {
        colorRepository.delete(id);
    }

    public void add(Color color) {
        colorRepository.add(color);
    }

    public void update(Color color) {
        colorRepository.update(color);
    }
}
