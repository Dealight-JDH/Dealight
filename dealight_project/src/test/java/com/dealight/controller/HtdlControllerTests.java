package com.dealight.controller;


import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultHandler;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class HtdlControllerTests {

	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	
	@Before
	public void setUp() {
		mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testListPaging() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/dealight/hotdeal/main")
				.param("pageNum", "2")
				.param("amount", "9"))
				.andReturn().getModelAndView().getModelMap());
	}
	@Test
	public void testRegisterHtdl() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/dealight/hotdeal/register")
					.param("name", "새로운 핫딜딜")
					.param("storeId", "4")
					.param("menu", "싸이 버거")
					.param("menu", "화이트갈릭 버거")
					.param("dcRate", "20")
					.param("befPrice", "15000")
					.param("startTm", "16:46")
					.param("endTm", "16:48")
					.param("lmtPnum", "20")
					.param("intro", "핫딜 aaaaaaa"))
				.andDo(MockMvcResultHandlers.print())
				.andReturn().getModelAndView().getViewName();
					
		
		log.info(resultPage);
								
	}
	
	@Test
	public void testHtdlList() throws Exception {
		
		 log.info(mockMvc.perform(MockMvcRequestBuilders.get("/dealight/hotdeal")
						.param("stusCd", "A"))
				 	.andExpect(MockMvcResultMatchers.status().isOk())
				 	.andDo(MockMvcResultHandlers.print())
				 	.andReturn()
					.getModelAndView()
					);
	}
}
