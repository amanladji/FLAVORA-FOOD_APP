package com.tap.model;

import com.tap.model.CartItems;

import java.util.Map;
import java.util.HashMap;

public class Cart {
	static Map<Integer, CartItems> item;
	
	public Cart() {
		item = new HashMap<Integer, CartItems>();
	}
	
	public Map<Integer, CartItems> getItems() {
		return item;
	}

	public static void addItem(CartItems cartItem) {
		int menuId = cartItem.getMenuId();
		
		if(item.containsKey(menuId)) {
									//map.get(menuId);
			CartItems existingItem = item.get(menuId);
			existingItem.setQuantity(existingItem.getQuantity() + 1);
			
		}else {
			item.put(menuId, cartItem);
		}
	}

	public static void updateItem(int menuId, int quantity) {
		if(item.containsKey(menuId)) {
			
			if(quantity <= 0) 
			{
				item.remove(menuId);
			}
			else 
			{
				CartItems cartItem = item.get(menuId);
				cartItem.setQuantity(quantity);
			}
		}
	}

	public static void removeItem(int menuId) {
		item.remove(menuId);
		
	}

}
