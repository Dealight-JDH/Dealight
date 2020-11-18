package com.dealight.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class ManageControllerTests {

	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;

	@Before
	public void setUp() {
		
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
		
	}
	
	@Test
	public void testGetDealHistory() throws Exception{
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/business/manage/dealhistory")
				.param("storeId", "13"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		
	}
	
	@Test
	public void testGetReservation() throws Exception {
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/business/manage/reservation")
				.param("rsvdId", "9"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		
	}
	
	@Test
	public void testGetWaiting() throws Exception {
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/business/manage/waiting")
				.param("waitId", "141"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		
	}
	
	@Test
	public void testGetWaitingRegister() throws Exception {
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/business/manage/waiting/register")
				.param("storeId", "13"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	@Test
	public void testGetModifyStoreInfo() throws Exception {
		
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/business/manage/modify")
				.param("storeId", "101"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	//@Transactional
	@Test
	public void testPostModifyStoreInfo() throws Exception {
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/business/manage/modify")
				.param("storeId", "13")
				.param("storeNm", "테스트")
				.param("telno", "031-753-4444")
				.param("buserId", "kjuioq")
				.param("openTm", "09:30")
				.param("closeTm", "21:30")
				.param("breakSttm", "15:00")
				.param("breakEntm", "16:00")
				.param("lastOrdTm", "21:00")
				.param("n1SeatNo", "8")
				.param("n2SeatNo", "10")
				.param("n4SeatNo", "5")
				.param("storeIntro", "수정")
				.param("avgMealTm", "30")
				.param("hldy", "수정")
				.param("acmPnum", "40")
				).andReturn()
				.getModelAndView()
				//.getModelMap());
				.getViewName();
		
		log.info(resultPage);
	}
	
}
