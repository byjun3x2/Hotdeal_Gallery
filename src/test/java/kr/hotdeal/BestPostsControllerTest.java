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
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class BestPostsControllerTest {

    @Autowired
    private HotdealService hotdealService;

    @Test
    public void 베스트_게시글_UI_기본_조회_테스트() {
        // 1. 현재 DB에 등록된 베스트 게시글 최대 5개 조회
        List<HotdealVO> bestList = hotdealService.getBestHotdealList(5);

        // 2. bestList가 null이 아니고, 0개 이상이면 통과
        assertNotNull("bestList는 null이 아니어야 함", bestList);

        // 3. bestList 실제 내용 출력 (디버깅)
        System.out.println("bestList:");
        for (HotdealVO h : bestList) {
            System.out.println(h.getTitle() + " / " + h.getLikes() + " / " + h.getDislikes());
        }

        // 4. UI에서 사용할 수 있도록 각 필드가 정상적으로 들어있는지 체크 (첫 게시글 기준)
        if (!bestList.isEmpty()) {
            HotdealVO first = bestList.get(0);
            assertNotNull(first.getTitle());
            assertNotNull(first.getLikes());
            assertNotNull(first.getDislikes());
            // 필요시 추가 필드 검증
        }
    }
}
