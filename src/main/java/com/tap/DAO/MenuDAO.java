package com.tap.DAO;

import java.util.List;

import com.tap.model.Menu;

public interface MenuDAO {
	void addMenu(Menu m);
	void updateMenu(Menu m);
	void removeMenu(int menuId);
	List<Menu> getMenusByRestaurantId(int menuId);
	Menu getMenu(int menuId);
	List<Menu> getAll();

}
