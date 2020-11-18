package com.dealight.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserVO;

public interface UserService {
	
	// read
	// user mapper - select
	UserVO read(String userId);
	
	// read
	// user mapper - select
	// ���°� 'y'�� �г�Ƽ ȸ��
	boolean isCurPanalty(String userId); 
	
	// �߰� mapper method �ʿ�
	// ���� ������ ����������
	// wait mapper - userId�� �˻�
	boolean isCurWaiting(String userId);
	
	// ȸ���� �������� ��������
	List<RsvdVO> getRsvdListThisUser(String userId);
	
	// mapper method �ʿ�
	// �ش� ������ ȸ���� �������� �������� 
	// 'ȸ��'�� '�� ����' ���� �����丮
	List<RsvdVO> getRsvdListStoreUser(@Param("storeId") long storeId,@Param("userId") String userId);

}
