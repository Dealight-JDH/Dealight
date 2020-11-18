package com.dealight.domain;

import static org.junit.Assert.*;

import org.junit.Test;

public class MenuVOTests {
	
	// �ʼ� �Է°�
    private long storeId = 1;
    private long menuSeq = 1;
    private int price = 5000;
    private String name = "���"; 
    private String recoMenu;

    //���� �Է°�
    private String imgUrl = "/a.jpg";

	// 1. �ʼ� �Է°��� �Է��ϰ� ���尴ü�� ������ �� �ִ���.
	// not null ���� �Է�
	// �ʼ��� : storeId, menuSeq, price, name
	// �⺻�� : recoMenu
	@Test
	public void menuGenerateTest1() {
		MenuVO menu = new MenuVO.MenuVOBuilder()
				.storeId(storeId)
				.menuSeq(menuSeq)
				.price(price)
				.name(name)
				.build();
		
		assertTrue(menu.getStoreId() == storeId);
		assertTrue(menu.getMenuSeq() == menuSeq);
		assertTrue(menu.getPrice() == price);
		assertTrue(menu.getName().equals(name));
		
		assertNull(menu.getImgUrl());
		assertNotNull(menu);
	}
	
	// 2. ��� �Է°�
	@Test
	public void menuGenerateTest2() {
		MenuVO menu = new MenuVO.MenuVOBuilder()
				.storeId(storeId)
				.menuSeq(menuSeq)
				.price(price)
				.name(name)
				.imgUrl(imgUrl)
				.build();
		
		assertTrue(menu.getStoreId() == storeId);
		assertTrue(menu.getMenuSeq() == menuSeq);
		assertTrue(menu.getPrice() == price);
		assertTrue(menu.getName().equals(name));
		assertTrue(menu.getImgUrl().equals(imgUrl));
		
		assertNotNull(menu);
	}

}
