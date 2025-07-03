package kr.hotdeal;

import static org.junit.Assert.assertEquals;

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

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/spring/spring-mvc.xml" })
public class VoteDAOTest {

	@Autowired
	private VoteDAO voteDAO;
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private HotdealDAO hotdealDAO;
	@Autowired
	private ProductDAO productDAO;

	private MemberVO createAndInsertTestMember(String username) {
		MemberVO member = new MemberVO();
		member.setUsername(username);
		member.setPassword("test1234");
		member.setName(username);
		memberDAO.insertMember(member);
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

	@Test
	public void 추천_투표_등록_및_조회_삭제_테스트() {

		ProductVO product = createAndInsertTestProduct("투표 테스트용 상품");
		MemberVO member = createAndInsertTestMember("voteUser123");
		HotdealVO hotdeal = createAndInsertTestHotdeal("투표 테스트 게시글", product.getProductId(), member.getUsername());

		Integer hotdealId = hotdeal.getId();
		String username = member.getUsername();
		String productId = product.getProductId();
		String voteType = "LIKE";

		try {

			int countBefore = voteDAO.countVote(hotdealId, username, voteType);
			assertEquals("투표 전에는 count가 0이어야 합니다.", 0, countBefore);

			voteDAO.insertVote(hotdealId, username, voteType);

			int countAfter = voteDAO.countVote(hotdealId, username, voteType);
			assertEquals("투표 후에는 count가 1이어야 합니다.", 1, countAfter);

			voteDAO.deleteVote(hotdealId, username, voteType);

			int countAfterDelete = voteDAO.countVote(hotdealId, username, voteType);
			assertEquals("삭제 후에는 count가 0이어야 합니다.", 0, countAfterDelete);

		} finally {

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
