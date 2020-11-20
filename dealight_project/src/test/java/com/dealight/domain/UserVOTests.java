package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;

import org.junit.Test;

public class UserVOTests {
	
	// �ʼ� �Է°�
	String userId = "kjuioq";
	String name = "�赿��";
	String pwd = "123123";
	String email = "kjuioq@naver.com";
	String telno = "010-2737-5157";
	String sex = "M";

	// ���� �Է°�
	String brdt = "931211";
	String photoSrc = "/a.jpg";
	Date pmExpi = new Date();
	
	// 1. �ʼ� �Է°��� �Է��ϰ� ������ü�� ������ �� �ִ���.
	// not null ���� �Է�
	// �ʼ��� : id,name,pw,email,telno,sex
	// ���ð� : snsLginYn, clsCd, pmStus, pmCnt
	// �ʼ� �Է°��� �Է����� �ʾ����� �����Ͽ���
	@Test
	public void userGenerateTest1() {
		UserVO user = new UserVO().builder()
				.userId(userId)
				.brdt(brdt)
				.name(name)
				.pwd(pwd)
				.email(email)
				.telno(telno)
				.sex(sex)
				.build();
		
		assertTrue(user.getUserId().equals(userId));
		assertTrue(user.getName().equals(name));
		assertTrue(user.getPwd().equals(pwd));
		assertTrue(user.getEmail().equals(email));
		assertTrue(user.getTelno().equals(telno));
		assertTrue(user.getSex().equals(sex));
		assertNotNull(user);
		
	}
	
	
	// 2. ��� �Է°��� �Է��ؼ� ���� ��ü�� �����Ѵ�.
	// �߰� : brdt, photoSrc, pmExpi
	@Test
	public void userGenerateTest2() {
		UserVO user = new UserVO().builder()
				.userId(userId)
				.brdt(brdt)
				.name(name)
				.telno(telno)
				.pwd(pwd)
				.email(email)
				.photoSrc(photoSrc)
				.sex(sex)
				.pmExpi(pmExpi)
				.build();
		
		assertTrue(user.getUserId().equals(userId));
		assertTrue(user.getName().equals(name));
		assertTrue(user.getPwd().equals(pwd));
		assertTrue(user.getEmail().equals(email));
		assertTrue(user.getTelno().equals(telno));
		assertTrue(user.getSex().equals(sex));
		assertTrue(user.getBrdt().equals(brdt));
		assertTrue(user.getPhotoSrc().equals(photoSrc));
		assertTrue(user.getPmExpi().equals(pmExpi));
		
		
		assertNotNull(user);
	}
	
//	
//	// 3. �Է��� ���� ���Ŀ� ���� ������ ���ܸ� �߻���Ų��.
//	// 3-1. ���̵� 20�� �̻��� ��
//	@Test(expected=IllegalArgumentException.class)
//	public void userGenerateExceptionTest1() {
//			UserVO user = new UserVO.Builder("dddddddddddddddddddddddddddddd", "�赿��", "123123", "kjuioq@naver.com", "010-2737-5157",
//														"M")
//					.setBrbt("931211")
//					.setPhotoSrc("/a.jpg")
//					.setPmExpi(new Date())
//					.build();
//			
//			System.out.println(user);
//			assertNotNull(user);
//	}
//	
//	// 3. �Է��� ���� ���Ŀ� ���� ������ ���ܸ� �߻���Ų��.
//	// 3-2. �̸��� ���ڼ��� 5�ڸ� �ʰ����� ��
//	@Test(expected=IllegalArgumentException.class)
//	public void userGenerateExceptionTest2() {
//			UserVO user = new UserVO.Builder("ddd", "�赿��������", "123123", "kjuioq@naver.com", "010-2737-5157",
//														"M")
//					.setBrbt("931211")
//					.setPhotoSrc("/a.jpg")
//					.setPmExpi(new Date())
//					.build();
//			
//			System.out.println(user);
//			assertNotNull(user);
//	}
//	
//	// 3. �Է��� ���� ���Ŀ� ���� ������ ���ܸ� �߻���Ų��.
//	// 3-3. ��й�ȣ�� ���ڼ��� 20�ڸ� �ʰ����� ��
//	@Test(expected=IllegalArgumentException.class)
//	public void userGenerateExceptionTest3() {
//			UserVO user = new UserVO.Builder("ddd", "�赿��", "1231233333333333333333", "kjuioq@naver.com", "010-2737-5157",
//														"M")
//					.setBrbt("931211")
//					.setPhotoSrc("/a.jpg")
//					.setPmExpi(new Date())
//					.build();
//			
//			System.out.println(user);
//			assertNotNull(user);
//	}
//	
//	// 3. �Է��� ���� ���Ŀ� ���� ������ ���ܸ� �߻���Ų��.
//	// 3-4. email�� ���ڼ��� 30�ڸ� �ʰ����� ��
//	@Test(expected=IllegalArgumentException.class)
//	public void userGenerateExceptionTest4() {
//			UserVO user = new UserVO.Builder("dddddddd", "�赿��", "123123", "kjuioq@naver.cdsandjsandjasdasjndasjndjasndjn dasjom", "010-2737-5157",
//														"M")
//					.setBrbt("931211")
//					.setPhotoSrc("/a.jpg")
//					.setPmExpi(new Date())
//					.build();
//			
//			System.out.println(user);
//			assertNotNull(user);
//	}
//	
//	// 3. �Է��� ���� ���Ŀ� ���� ������ ���ܸ� �߻���Ų��.
//	// 3-5. ��ȭ��ȣ�� ���ڼ��� 13�ڸ� �ʰ����� ��
//	@Test(expected=IllegalArgumentException.class)
//	public void userGenerateExceptionTest5() {
//			UserVO user = new UserVO.Builder("dddddddd", "�赿��", "123123", "kjuioq@naver.com", "00000000000010-2737-5157",
//														"M")
//					.setBrbt("931211")
//					.setPhotoSrc("/a.jpg")
//					.setPmExpi(new Date())
//					.build();
//			
//			System.out.println(user);
//			assertNotNull(user);
//	}
//	
//	// 3. �Է��� ���� ���Ŀ� ���� ������ ���ܸ� �߻���Ų��.
//	// 3-6. �����Է��ڵ尡 M Ȥ�� F�� �ƴҶ�
//	@Test(expected=IllegalArgumentException.class)
//	public void userGenerateExceptionTest6() {
//			UserVO user = new UserVO.Builder("dddddddd", "�赿��", "123123", "kjuioq@naver.com", "010-2737-5157",
//														"G")
//					.setBrbt("931211")
//					.setPhotoSrc("/a.jpg")
//					.setPmExpi(new Date())
//					.build();
//			
//			System.out.println(user);
//			assertNotNull(user);
//	}
	
}
