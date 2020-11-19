package com.dealight.controller;


import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.dealight.domain.StoreVO;
import com.dealight.service.HtdlService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;
import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Setter(onMethod_ = @Autowired)
	private StoreService storeService;
	
	@Setter(onMethod_ = @Autowired)
	private RsvdService rsvdService;
	
	@Setter(onMethod_ = @Autowired)
	private HtdlService htdlService;
	
	@Setter(onMethod_ = @Autowired)
	private WaitService waitService;
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	private long storeId = 101;

	@Before
	public void setUp() {
		
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
		
	}
	
	@Test
	public void changeSeatStus() throws Exception {
		
		StoreVO store = storeService.getStore(12);
		
		String jsonStore = new Gson().toJson(store);
		
		long storeId = 13;
		String statusColor = "R";
		
		mockMvc.perform(post("/business/manage/test")
				.contentType(MediaType.APPLICATION_JSON)
				.content(jsonStore))
				.andExpect(status().is(200));
	}
	

	
	
//	@Test
//	public void getStore() {
//		
//		long storeId = 101L;
//		
//		mockMvc.perform(get("/board/store/" + storeId)
//				.contentType(MediaType.APPLICATION_JSON)
//				.content(content)
//				.andExpect(status().is(200));
//		
//		
//	}

}
