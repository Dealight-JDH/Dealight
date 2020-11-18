package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.StoreImgVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreImgMapperTests {

	
	private long storeId = 101;
	private long imgSeq = 1;
	private String uuid = "dsaf-dsaf-qwdw-ewes";
	private String uploadPath = "C:\\upload";
	private boolean image = true;
	private String fileName = "mat.jpg";
	
	@Setter(onMethod_ = @Autowired)
	private StoreImgMapper mapper;
	
	@Test
	public void DITest() {
		
		assertNotNull(mapper);
		
	}
	
	@Test
	public void insertTest1() {
		
		StoreImgVO storeImg = new StoreImgVO().builder()
				.storeId(storeId)
				.uuid(uuid)
				.uploadPath(uploadPath)
				.image(image)
				.fileName(fileName)
				.build();
		
		mapper.insert(storeImg);
		
		
	}
	
	@Test
	public void readTest1() {
		
		List<StoreImgVO> list = mapper.findByStoreId(storeId);
		
		assertNotNull(list);
		
		log.info(list);
	}
	
	//@Transactional
	@Test
	public void insertAllTest1() {
		
		List<StoreImgVO> list = new ArrayList<>();
		
		StoreImgVO storeImg1 = new StoreImgVO().builder()
				.storeId(storeId)
				.uuid(uuid)
				.uploadPath(uploadPath)
				.image(image)
				.fileName(fileName)
				.build();
		StoreImgVO storeImg2 = new StoreImgVO().builder()
				.storeId(storeId)
				.uuid(uuid)
				.uploadPath(uploadPath)
				.image(image)
				.fileName(fileName)
				.build();
		StoreImgVO storeImg3 = new StoreImgVO().builder()
				.storeId(storeId)
				.uuid(uuid)
				.uploadPath(uploadPath)
				.image(image)
				.fileName(fileName)
				.build();
		
		list.add(storeImg1);
		list.add(storeImg2);
		list.add(storeImg3);
		
		log.info(mapper.findByStoreId(storeId));
		
		mapper.insertAll(list);
		
		log.info(mapper.findByStoreId(storeId));
	}
	
	@Test
	public void deleteTest1() {
		
		log.info(mapper.findByStoreId(storeId));
		
		int result = mapper.delete(uuid);
		
		log.info(mapper.findByStoreId(storeId));
		
		assertTrue(result == 1);
		
	}
	
	@Transactional
	@Rollback(true)
	@Test
	public void deleteAllTest1() {
		
		storeId = 101;
		
		log.info(mapper.findByStoreId(storeId));
		
		mapper.deleteAll(storeId);
		
		log.info(mapper.findByStoreId(storeId));
	}
	
}
