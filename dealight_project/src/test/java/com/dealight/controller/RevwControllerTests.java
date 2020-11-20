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
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // test for controller
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class RevwControllerTests {

	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;

	private MockMvc mockMvc;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	@Test
	public void test() {
		log.info(mockMvc);
	}

	@Test
	public void testGetWrittenList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders
						.get("/dealight/mypage/review/written-list")
						.param("userId", "user1id"))
				.andReturn() 	
				.getModelAndView().getModelMap());
	}

	@Test
	public void testRegisterRevwByRsvd() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/dealight/mypage/review/register/rsvd")
				.param("storeId", "12345")
				.param("storeNm", "식당테스트")
				.param("rsvdId", "1234")
				.param("userId", "user1id")
				.param("cnts", "테스트라고시발")
				.param("rating", "4.5")
				.param("revwId", "10")
				.param("imgUrl", "asfefwa.jpg")
				).andReturn().getModelAndView().getViewName();

		log.info(resultPage);
	}
	
	@Test
	public void testRegisterRevwByWait() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/dealight/mypage/review/register/wait")
				.param("storeId", "12345")
				.param("storeNm", "식당테스트")
				.param("waitId", "1234")
				.param("userId", "user1id")
				.param("cnts", "테스트라고시발")
				.param("rating", "4.5")
				.param("revwId", "10")
				.param("imgUrl", "test.jpg")
				).andReturn().getModelAndView().getViewName();

		log.info(resultPage);
	}

	@Test
	public void testGetWritableItemByRsvd() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders
						.get("/dealight/mypage/review/register/rsvd")
						.param("userId", "user1id")
						.param("rsvdId", "1"))
				.andReturn()
				.getModelAndView().getModelMap());
	}

	@Test
	public void testGetWritableItemByWait() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders
						.get("/dealight/mypage/review/register/wait")
						.param("userId", "user1id")
						.param("waitId", "4"))
				.andReturn()
				.getModelAndView().getModelMap());
	}

	@Test
	public void testUpdateRevwReply() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/dealight/mypage/review/written-list")
				.param("userId", "user1id")
				.param("revwId", "90")
				.param("replyCnts", "내용테스트"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
}
