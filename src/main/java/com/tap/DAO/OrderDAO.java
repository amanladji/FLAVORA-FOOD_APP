package com.tap.DAO;

import java.util.List;

import com.tap.model.Order;

public interface OrderDAO {
	int addOrder(Order o);
	void updateOrder(Order u);
	void removeOrder(int OrderId);
	Order getOrder(int OrderId);
	List<Order> getAll();

}
