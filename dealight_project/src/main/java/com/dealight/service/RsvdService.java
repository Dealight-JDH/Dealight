package com.dealight.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserWithRsvdDTO;

public interface RsvdService {
	
	final static int timeGap = 30;
	
	// '����' Ȯ��
	// reservation mapper read
	// select
	RsvdVO read(long rsvdId);

	// '���� ��' Ȯ��
	// reservation detail mapper read
	// select
	List<RsvdDtlsVO> readDetail(long rsvdId);
	
	// �߰� mapper method �ʿ� - �߰� �Ϸ�
	// '����'�� '���� ����Ʈ' Ȯ���ϱ�
	// ���� �����丮
	// read list
	List<RsvdVO> readAllRsvdList(long storeId);
	
	// �߰� mapper method �ʿ�
	// '����'�� '���翹��'���� '���ฮ��Ʈ'Ȯ���ϱ�
	// read list
	// rsvd_stus = "c"
	List<RsvdVO> readCurRsvdList(long storeId);
	
	// �߰� mapper method �ʿ�
	// '����'�� '����'�� '���ฮ��Ʈ'Ȯ���ϱ�
	// ���� ������ ���Ͽ��ุ �����Ƿ� ũ�� ��� x
	// time = today
	List<RsvdVO> readTodayCurRsvdList(long storeId);
	
	// read
	List<RsvdVO> readRsvdListByDate(long storeId,String date);

	// read
	RsvdVO findRsvdByRsvdIdWithDtls(long rsvdId);
	
	// ���� ���ɿ��� �Ǵ��ϱ�
	// "�� �ð�"�� "�� ����"���� ������ ��������
	// rsvd_stus = "c", time = this time
	// acm�� �� ������ �� ���� ���� �ο�
	// *******acm�� ������ ���� ���� �ο����� �����ؾ���
	boolean isReserveThisTimeStore(long storeId, Date date, int acm);
	
	// time���� ���� string Ÿ���� second�� ���
	// 00:00 -> 0
	// 12:30 -> 12*60 + 30-> 720 + 30 == 750
	String getTime(Date date);
	
	// time���� ���� string Ÿ���� second�� ���
	// 00:00 -> 0
	// 12:30 -> 12*60 + 30-> 720 + 30 == 750
	int calTimeMinutes(String time);
	
	// ��¥�� ���� ����Ʈ
	// mapper �߰�
	// date �� ������ "yyyyMMdd"
	List<RsvdVO> getListByDate(long storeId,String date);
	
	// �ð��뺰 ���� ����Ʈ
	// map���� �ؾ��ϳ�?
	// 15�� ������ �ֱ�
	// HashMap<String rsvdByTime,int count>.
	HashMap<String,List<Long>> getRsvdByTimeMap(List<RsvdVO> listByDate);
	
	
	// hour = hour
	// if minute < 60 -> 45
	// 		minute < 45 -> 30
	// 		minute < 30 -> 15
	// 		minute < 15 -> 00
	// String rsvdByTime = hour.toString() + ":" + minute.toString()
	String toRsvdByTimeFormat(String time);
	
	
	// �ٷ� ���� ���� Ȯ���ϱ�
	// �ð������� �����ؾ���
	long readNextRsvdId(HashMap<String, List<Long>> getTodayRsvdByTimeMap);
	
	
	// �ֵ����� �ƴ��� Ȯ���ϱ�
	boolean isHtdl(RsvdVO rsvd);
	
	RsvdVO findRsvdByRsvdId(long rsvdId, List<RsvdVO> readTodayCurRsvdList);
	
	
	// ===============���� ��Ȳ�� ����
	
	// ���� ���� ���� �հ�
	int totalTodayRsvd(List<RsvdVO> readTodayCurRsvdList);
	
	// ���� ���� �ο� �հ�
	int totalTodayRsvdPnum(List<RsvdVO> readTodayCurRsvdList);
	
	// ���� ��ȣ �޴�
	HashMap<String,Integer> todayFavMenu(long storeId);
	
	// ���� ���� �� ����Ʈ
	List<UserWithRsvdDTO> userListTodayRsvd(long storeId);
	
	// �� �̿� �ð���
	// �ϴ� ����
	
	// �Ϻ� ���� ����(������)
	//�ϴ� ����
	
	
	List<RsvdVO> findLastWeekRsvd(long storeId);
	
}
