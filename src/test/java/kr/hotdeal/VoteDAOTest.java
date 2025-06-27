package kr.hotdeal;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.UUID;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.hotdeal.board.dao.HotdealDAO;
import kr.co.hotdeal.board.vo.HotdealVO;
import kr.co.hotdeal.member.dao.MemberDAO;
import kr.co.hotdeal.member.vo.MemberVO;
import kr.co.hotdeal.product.dao.ProductDAO;
import kr.co.hotdeal.product.vo.ProductVO;
import kr.co.hotdeal.vote.dao.VoteDAO;

/**
 * VoteDAO 테스트 클래스
 * 각 테스트는 독립적으로 실행되며, 생성된 테스트 데이터를 직접 정리합니다.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class VoteDAOTest {

    @Autowired private VoteDAO voteDAO;
    @Autowired private MemberDAO memberDAO;
    @Autowired private HotdealDAO hotdealDAO;
    @Autowired private ProductDAO productDAO;

    // ================== 테스트 헬퍼 메소드 (데이터 생성) ==================

    private MemberVO createAndInsertTestMember(String username) {
        MemberVO member = new MemberVO();
        member.setUsername(username);
        member.setPassword("test1234");
        member.setName(username);
        memberDAO.insertMember(member); // MemberDAO에 해당 메소드가 있다고 가정
        return member;
    }

    private ProductVO createAndInsertTestProduct(String productName) {
        ProductVO product = new ProductVO();
        product.setProductId(UUID.randomUUID().toString());
        product.setCategory("테스트");
        product.setShopName("테스트샵");
        product.setProductName(productName);
        product.setPrice(1000);
        product.setDeliveryFee("무료");
        productDAO.insertProduct(product);
        return product;
    }
    
    private HotdealVO createAndInsertTestHotdeal(String title, String productId, String author) {
        HotdealVO hotdeal = new HotdealVO();
        hotdeal.setTitle(title);
        hotdeal.setAuthor(author);
        hotdeal.setContent("내용");
        hotdeal.setProductId(productId);
        // 테스트의 일관성을 위해 초기값을 0으로 설정
        hotdeal.setViews(0);
        hotdeal.setLikes(0);
        hotdeal.setDislikes(0);
        hotdealDAO.insertHotdeal(hotdeal);
        return hotdeal;
    }

    // ================== 테스트 메소드 ==================

    @Test
    public void 추천_투표_등록_및_조회_삭제_테스트() {
        // given: 투표에 필요한 모든 부모 데이터 생성
        ProductVO product = createAndInsertTestProduct("투표 테스트용 상품");
        MemberVO member = createAndInsertTestMember("voteUser123");
        HotdealVO hotdeal = createAndInsertTestHotdeal("투표 테스트 게시글", product.getProductId(), member.getUsername());
        
        // 테스트에 사용할 키 값들
        Integer hotdealId = hotdeal.getId();
        String username = member.getUsername();
        String productId = product.getProductId();
        String voteType = "LIKE";

        try {
            // [1] 투표 전 상태 확인
            int countBefore = voteDAO.countVote(hotdealId, username, voteType);
            assertEquals("투표 전에는 count가 0이어야 합니다.", 0, countBefore);
            
            // [2] 투표 기록 삽입
            voteDAO.insertVote(hotdealId, username, voteType);
            
            // [3] 투표 후 상태 확인
            int countAfter = voteDAO.countVote(hotdealId, username, voteType);
            assertEquals("투표 후에는 count가 1이어야 합니다.", 1, countAfter);

            // [4] 투표 기록 삭제
            voteDAO.deleteVote(hotdealId, username, voteType);
            
            // [5] 삭제 후 상태 확인
            int countAfterDelete = voteDAO.countVote(hotdealId, username, voteType);
            assertEquals("삭제 후에는 count가 0이어야 합니다.", 0, countAfterDelete);

        } finally {
            // cleanup: 생성된 테스트 데이터들을 외래키 역순으로 삭제
            // (hotdeal, product, member 순으로 삭제)
            if (hotdealId != null) {
                hotdealDAO.deleteHotdeal(hotdealId);
            }
            if (productId != null) {
                productDAO.deleteProduct(productId);
            }
            if (username != null) {
                memberDAO.deleteMemberByUsername(username); // MemberDAO에 해당 메소드가 있다고 가정
            }
        }
    }
}
