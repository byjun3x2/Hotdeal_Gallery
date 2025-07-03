package kr.hotdeal;

import kr.co.hotdeal.board.service.HotdealService;
import kr.co.hotdeal.board.vo.HotdealVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/spring/spring-mvc.xml" })
public class BestPostsControllerTest {

	@Autowired
	private HotdealService hotdealService;

	@Test
	public void 베스트_게시글_UI_기본_조회_테스트() {

		List<HotdealVO> bestList = hotdealService.getBestHotdealList(5);

		assertNotNull("bestList는 null이 아니어야 함", bestList);

		System.out.println("bestList:");
		for (HotdealVO h : bestList) {
			System.out.println(h.getTitle() + " / " + h.getLikes() + " / " + h.getDislikes());
		}

		if (!bestList.isEmpty()) {
			HotdealVO first = bestList.get(0);
			assertNotNull(first.getTitle());
			assertNotNull(first.getLikes());
			assertNotNull(first.getDislikes());

		}
	}
}
