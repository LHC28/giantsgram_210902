package com.giantsgram;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

// 단위 테스트 (Unit test)
// JUnit이라는 라이브러리가 있기 때문에 사용가능
@SpringBootTest
class GiantsgramApplicationTests {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	//@Test 주석 처리시 수행 안 됨.
	void contextLoads() {
		logger.debug("### hellow world ###");
		
		//assertNotNull(객체); 를 활용하면 null인지 아닌지 확인 가능하다고 한다.
	}
	
	@Test
	void 더하기테스트() {
		logger.debug("$$$$ 더하기 테스트 시작");
		int a = 10;
		int b = 20;
		
		assertEquals(30,sum(a,b));
	}
	
	int sum(int x, int y) {
		return x+y;
	}
	/*
	@Test
	@Transactional
	void addYserTest() {
		userBO.add~
	}
	*/

}
