package com.dealight.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;
import com.dealight.mapper.HtdlDtlsMapper;
import com.dealight.mapper.HtdlMapper;
import com.dealight.mapper.HtdlRsltMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class HtdlServiceImpl implements HtdlService {

	@Autowired
	private HtdlMapper htdlMapper;
	
	@Autowired
	private HtdlDtlsMapper htdlDtlsMapper;
	
	@Autowired
	private HtdlRsltMapper htdlRsltMapper;
	
	@Override
	public HtdlVO read(long htdlId) {

		return htdlMapper.findById(htdlId);
	}

	@Override
	public List<HtdlDtlsVO> readDtls(long htdlId) {

		return htdlDtlsMapper.findByHtdlId(htdlId);
	}

	@Override
	public HtdlRsltVO readRslt(long htdlId) {

		return htdlRsltMapper.findById(htdlId);
	}

	@Override
	public int calHtdlEndTm(HtdlVO htdl) {
		
		Date today = new Date();

		String pattern = "HH:mm";
    	
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    	
    	String date = simpleDateFormat.format(today);
    	
    	//log.info("test.....................................date : " + date);
    	
    	String[] times1 = htdl.getEndTm().split(":");
    	int endTm = Integer.valueOf(times1[0])*60 + Integer.valueOf(times1[1]);
		
    	//log.info("test.....................................endTm : " + endTm);
    	
    	String[] times2 = date.split(":");
    	int curTm = Integer.valueOf(times2[0])*60 + Integer.valueOf(times2[1]);
    	
    	//log.info("test.....................................curTm : " + curTm);
    	
    	
		return endTm - curTm;
	}

	@Override
	public List<HtdlVO> readAllStoreHtdlList(long storeId) {
		
		return htdlMapper.findByStoreId(storeId);
	}

	@Override
	public List<HtdlVO> readActStoreHtdlList(long storeId) {
		
		return htdlMapper.findByStoreIdStusCd(storeId, "A");
	}

}
