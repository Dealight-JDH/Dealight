package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class NStoreVOTests {

	// nstore ��ü
	private long storeId = 1;
	private String bizTm = "21:00";
	private String menu = "���";
	
	// store ��ü
    private String storeNm = "��������";
    private String telno = "010-2737-5157";
    private String clsCd = "I";


	// 1. �ʼ� �Է°��� �Է��ϰ� ���尴ü�� ������ �� �ִ���.
	// not null ���� �Է�
	// �ʼ��� : storeId, breakEntm
	// ���ð� : menu
	@Test
	public void nstoreGenerateTest1() {
		NStoreVO nstore = new NStoreVO.NStoreVOBuilder()
				.storeId(storeId)
				.bizTm(bizTm)
				.build();

		assertTrue(nstore.getStoreId() == storeId);
		assertTrue(nstore.getBizTm().equals(bizTm));
		assertNull(nstore.getMenu());
		assertNotNull(nstore);

	}

	// 2. ����Է°�
	@Test
	public void nstoreGenerateTest2() {
		NStoreVO nstore = new NStoreVO.NStoreVOBuilder()
				.storeId(storeId)
				.bizTm(bizTm)
				.menu(menu)
				.build();

		assertTrue(nstore.getStoreId() == storeId);
		assertTrue(nstore.getBizTm().equals(bizTm));
		assertTrue(nstore.getMenu().equals(menu));
		assertNotNull(nstore);

	}

}
