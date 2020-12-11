package com.dealight.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.client.match.JsonPathRequestMatchers;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;

import com.dealight.domain.RsvdVO;
import com.dealight.service.RsvdService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@WebAppConfiguration
public class RsvdControllerTests {

	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Autowired
	private RsvdService rsvdService;
	
	
	@Before
	public void setUp() {
		mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void rsvdRegister() throws Exception {
		
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/dealight/reservation/kakaoPay")
											.param("storeId", "4")
											.param("menu[0].name","불고기 버거")
											.param("menu[0].price","4000")
											.param("menu[0].qty","2")
											.param("menu[1].name","새우 버거")
											.param("menu[1].price","5000")
											.param("menu[1].qty","1")
											.param("pnum","3")
											.param("time", "13:00")
											.param("totAmt", "13000")
											.param("totQty", "3"))
									.andReturn()
									.getModelAndView().getViewName();
		
		RsvdVO vo = rsvdService.read(4);
		
		log.info("예약 vo...: " + vo);
		log.info("rsvd.... resultPage: " + resultPage);
		
	}
}
