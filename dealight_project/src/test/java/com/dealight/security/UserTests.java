package com.dealight.security;

import static org.junit.Assert.assertTrue;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.UserVO;
import com.dealight.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class UserTests {
	
	@Setter(onMethod_ = @Autowired)
	 private PasswordEncoder pwencoder;
	  
	 @Setter(onMethod_ = @Autowired)
	 private DataSource ds;
	 
	 @Setter(onMethod_ = @Autowired)
	 private UserService userSerivce;
	
			  
		  @Test
		  public void testInsertMember() {

		    String sql = "insert into tbl_user(user_id, name, pwd, email, telno, brdt, sex) values (?,?,?,?,?,?,?)";
		    
		    for(int i = 0; i < 7; i++) {
		      
		      Connection con = null;

		      PreparedStatement pstmt = null;
		      
		      try {
		        con = ds.getConnection();
		        pstmt = con.prepareStatement(sql);
		        
		        pstmt.setString(3, pwencoder.encode("pw" + i));
		        
		        if(i < 2) {
		          
		          pstmt.setString(1,"user"+i);
		          pstmt.setString(2,"일반사용자"+i);
		          pstmt.setString(4,"aa@aa.com"+i);
		          pstmt.setString(5,"010-1234-234"+i);
		          pstmt.setString(6,"96052"+i);
		          pstmt.setString(7,"M");
		          
		        }else if (i < 4) {
		          
		          pstmt.setString(1, "manager"+i);
		          pstmt.setString(2,"운영자"+i);
		          pstmt.setString(4,"aa@aa.com"+i);
		          pstmt.setString(5,"010-1234-234"+i);
		          pstmt.setString(6,"96052"+i);
		          pstmt.setString(7,"M");
		          
		        }else {
		          
		          pstmt.setString(1, "admin"+i);
		          pstmt.setString(2,"관리자"+i);
		          pstmt.setString(4,"aa@aa.com"+i);
		          pstmt.setString(5,"010-1234-234"+i);
		          pstmt.setString(6,"96052"+i);
		          pstmt.setString(7,"M");
		        }
		        
		        pstmt.executeUpdate();
		        
		      }catch(Exception e) {
		        e.printStackTrace();
		      }finally {
		        if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
		        if(con != null) { try { con.close();  } catch(Exception e) {} }
		        
		      }
		    }
		  }
		  
		  @Test
		  public void testInsertAuth() {
				
			String sql = "insert into tbl_user_auth(user_id, auth)values(?,?)";
			
			for(int i = 0; i < 7; i++) {
				  Connection con = null;
			      PreparedStatement pstmt = null;
			      
			      try {
			    	  con = ds.getConnection();
			    	  pstmt = con.prepareStatement(sql);
			    	  
			    	  
			    	  if(i < 2) {
			    		  pstmt.setString(1, "user" + i);
			    		  pstmt.setString(2, "ROLE_USER");
			    	  }else if (i < 4) {
			              pstmt.setString(1, "manager"+i);
			              pstmt.setString(2, "ROLE_MEMBER");
			    	  }else {
			    		  pstmt.setString(1, "admin"+i);
				          pstmt.setString(2, "ROLE_ADMIN");
			    	  }
			    	  
			    	  pstmt.executeUpdate();
			    	  
			      }catch (Exception e) {
			    	  e.printStackTrace();
				  }finally {
					 if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
				     if(con != null) { try { con.close();  } catch(Exception e) {} }
				  }
			}
		}
		  
		  
		 

		 @Test
		 public void pwdUpdate() {
			 
			  List<UserVO> beforeList = userSerivce.getList();
			  
			 List<UserVO> list = userSerivce.getList();
			 
			 list.stream().forEach(user -> {
				 
				 if(user.getPwd().length() < 10) {
					 user.setPwd(pwencoder.encode(user.getPwd()));
					 assertTrue(userSerivce.changePwd(user));
				 }
				 
			 });
			 
			 log.info("=============================before list=============================");
			 beforeList.stream().forEach(user -> {
				 
				 log.info("user pwd : "+user.getPwd());
			 });
			 list = userSerivce.getList();
			 log.info("=============================after list=============================");
			 list.stream().forEach(user -> {
				 log.info("user pwd : "+user.getPwd());
			 });
		 }

}
