package com.dealight.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	private String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private String id = "dealight";
	private String pwd = "1234";
	
	@Test
	public void testConnection() {
		
		try (Connection con = DriverManager.getConnection(url, id, pwd)){
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
}
