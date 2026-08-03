package com.example.giaystore.service;

import com.example.giaystore.entity.Bill;
import com.example.giaystore.entity.BillStatus;
import com.example.giaystore.repository.BillRepository;
import lombok.RequiredArgsConstructor;
import java.util.List;

@RequiredArgsConstructor
public class BillService {

    private final BillRepository billRepository;

    public List<Bill> findAll() {
        return billRepository.findAll();
    }

    public Bill findById(Integer id) {
        return billRepository.findById(id);
    }

    public void create(Bill bill) {
        billRepository.add(bill);
    }

    public void updateStatus(Integer id, BillStatus status) {
        Bill bill = billRepository.findById(id);
        if (bill != null) {
            bill.setStatus(status);
            billRepository.update(bill);
        }
    }

    public void delete(Integer id) {
        billRepository.delete(id);
    }
}