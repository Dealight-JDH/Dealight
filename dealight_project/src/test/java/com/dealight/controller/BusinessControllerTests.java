package com.dealight.controller;

import static org.junit.Assert.fail;
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
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	"file:src/main/webapp/WEB-INF/spring/root-context.xml"
})
@Log4j
public class BusinessControllerTests {

	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testRegister() throws Exception {

		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/business/register")
				.param("storeNm", "우육명관")
				.param("telno", "02-134-1234")
				.param("clsCd", "B")
				.param("addr", "종로구")
				.param("lt", "2.5")
				.param("lo", "4.12")
				.param("buserId", "aaaa")
				.param("openTm", "12:00")
				.param("closeTm", "22:00")
				.param("lastOrdTm", "21:30")
				.param("seatStusCd", "B")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
		
	}

	@Test
	public void testList() throws Exception{
		
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/business/"))
				.andReturn().getModelAndView().getModelMap()
				);
	}
	
	@Test
	public void testManage() throws Exception{
		
		long storeId = 101;
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/business/manage/?storeId=" + storeId))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		
	}
	
	@Test
	public void testGetRegister() throws Exception{
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/business/register"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	@Test
	public void testPostRegister() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/business/register")
				.param("storeId", "244")
				.param("storeNm", "���õ��")
				.param("telno", "000-0000-0000")
				.param("clsCd", "C")
				.param("buserId", "aaa")
				.param("openTm", "09:30")
				.param("closeTm", "22:00"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	@Test
	public void testGetDealHistory() throws Exception{
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/business/manage/dealhistory")
				.param("storeId", "13"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		
	}
}
