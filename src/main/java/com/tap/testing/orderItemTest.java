package com.tap.testing;

import com.tap.DAOImple.OrderItemDAOImple;
import com.tap.model.OrderItem;

public class orderItemTest {
	public static void main(String[] args) {
		OrderItem oi = new OrderItem(1,1,1,1,67.0);
		OrderItemDAOImple odao = new OrderItemDAOImple();
		odao.addItem(oi);
	}

}
