package com.dealight.service;

import java.util.List;

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;

public interface HtdlService {
	
	// �ֵ� Ȯ��
	// htdl mapper read
	// select
	HtdlVO read(long htdlId);
	
	// �ֵ� �� Ȯ��
	// htdlDtls mapper read
	// select
	List<HtdlDtlsVO> readDtls(long htdlId);
	
	// �ֵ� ��� Ȯ��
	// htdlRslt mapper read
	// select
	HtdlRsltVO readRslt(long htdlId);
	
	// �ֵ� ���� �ð� ī��Ʈ �ٿ�
	// �ֵ� ���� �ð� - ����ð�
	// ���� ��
	int calHtdlEndTm(HtdlVO htdl);
	
	// mapper method �ʿ�
	// ���� '�� ����'�� ��ϵ� '�ֵ�' ����Ʈ '����' ����
	List<HtdlVO> readAllStoreHtdlList(long storeId);
	
	// mapper method �ʿ�
	// ���� '�� ����'�� ��ϵ� '�ֵ�' �� 'Ȱ��ȭ'������ ����Ʈ ����
	// htdl_stus_cd = 'A'
	List<HtdlVO> readActStoreHtdlList(long storeId);

}
