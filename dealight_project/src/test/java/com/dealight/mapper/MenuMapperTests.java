package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.BUserVO;
import com.dealight.domain.MenuVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MenuMapperTests {
	
	// �ʼ� �Է°�
    private long storeId = 13;
    private long menuSeq = 3;
    private int price = 5000;
    private String name = "���"; 
    private String recoMenu = "Y";

    //���� �Է°�
    private String imgUrl = "/a.jpg";
    
    @Autowired
    private MenuMapper mapper;
    
    // create
    @Test
    public void insertTest1() {
    	MenuVO menu = new MenuVO().builder()
				.storeId(storeId)
				.menuSeq(menuSeq)
				.price(price)
				.name(name)
				.recoMenu(recoMenu)
				.build();
    	
    	List<MenuVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insert(menu);
    	
    	list = mapper.findAll();
    	
    	assertTrue(bf + 1 == list.size());

    	
    }
    
    // create
    @Test
    public void insertSelectKeyTest1() {
    	MenuVO menu = new MenuVO().builder()
				.storeId(storeId)
				.menuSeq(menuSeq)
				.price(price)
				.name(name)
				.recoMenu(recoMenu)
				.build();
    	
    	List<MenuVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insertSelectKey(menu);
    	
    	list = mapper.findAll();
    	
    	assertTrue(bf + 1 == list.size());
    	
    	assertTrue(list.get(list.size()-1).getMenuSeq() == menu.getMenuSeq());
    	
    	log.info(menu);

    	
    }
    
    // read
    @Test
    public void findTest1() {
    	
    	MenuVO menu = mapper.findBySeq(3);
    	
    	assertNotNull(menu);
    	
    }
    
    
    // read list
    @Test
    public void findAllTest1() {
    	List<MenuVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);

    	
    }
    
    
    // update
    @Test
    public void updateTest1() {
    	MenuVO menu = new MenuVO().builder()
				.storeId(storeId)
				.menuSeq(menuSeq)
				.price(price)
				.name("����")
				.build();

    	String bf = mapper.findBySeq(1).getName();
    	
    	int result = mapper.update(menu);
    	
    	assertTrue(result == 1);
    	
    	menu = mapper.findBySeq(menuSeq);
    	
    	assertTrue(!menu.getName().equals(bf));
    	
    	menu.setName(bf);
    	
    	result = mapper.update(menu);
    	
    	assertTrue(result == 1);
    	
    	
    }
    
    // delete
    @Test
    public void deleteTest1() {
    	
    	int bf = mapper.findAll().size();
    	
    	int result = mapper.delete(menuSeq);
    	
    	assertTrue(result == 1);
    	
    	assertTrue(mapper.findAll().size() == bf - 1);
    	
    }
    
    @Test
    public void findByStoreIdTests() {
    	
    	List<MenuVO> list = mapper.findByStoreId(storeId);
    	
    	assertNotNull(list);
    	
    	log.info(list);
    	
    }

}
