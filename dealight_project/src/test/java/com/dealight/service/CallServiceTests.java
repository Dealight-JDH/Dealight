package com.dealight.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CallServiceTests {

	
	@Test
	public void test() {
		
		int idx = (int) (Math.random() * 10);
		
		System.out.println("idx...................."+idx);
			
		for(int i = 0; i< 100; i++) {
			
			idx = (int) (Math.random() * 10);
			System.out.println("idx...................."+idx);
		}
				
	}
	
}
