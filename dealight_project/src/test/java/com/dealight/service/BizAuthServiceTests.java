package com.dealight.service;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.BUserVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BizAuthServiceTests {

	@Setter(onMethod_ = @Autowired)
	private BizAuthService service;
	
	private long brSeq = 1;
    private String userId = "aaaa";
    private String brno = "1123123";
    private String brPhotoSrc = "/a.jpg";
    private String brJdgStusCd;
    private long storeId = 101;
    private String storeNm = "TestStoreNm";
    private String telno = "010-2112-1232";
    private String storeTelno = "02-123-1234";
	
	@Test
	public void testRegister() {
		
		BUserVO buser = new BUserVO.Builder(brSeq, userId, brno, brPhotoSrc, storeNm, telno, storeTelno)
								   .build();
		
		service.register(buser);
		
		List<BUserVO> buserList = service.getList();
		
		
	}
	
	@Test
	public void testRead() {
		
		List<BUserVO> buserList = service.getList();
		
		BUserVO buser = buserList.get(buserList.size()-1);
		
		log.info(service.read(buser.getBrSeq()));
		
		log.info(service.delete(buser.getBrSeq()));
		
	}
	
	@Test
	public void testModify() {
		BUserVO buser = new BUserVO.Builder(100, "jung", brno, brPhotoSrc, storeNm, telno, storeTelno)
				.build();
		
		service.modify(buser);
		
		log.info(buser);
		log.info(service.read(buser.getBrSeq()));
		
	}

}
