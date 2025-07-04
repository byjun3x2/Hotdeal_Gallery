package kr.hotdeal;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.util.UUID;
import kr.co.hotdeal.board.dao.HotdealDAO;
import kr.co.hotdeal.board.vo.HotdealVO;
import kr.co.hotdeal.product.dao.ProductDAO;
import kr.co.hotdeal.product.vo.ProductVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/spring/spring-mvc.xml" })
public class HotdealDAOTest {

	@Autowired
	private HotdealDAO hotdealDAO;

	@Autowired
	private ProductDAO productDAO;

	private ProductVO createAndInsertTestProduct(String productName) {
		ProductVO product = new ProductVO();
		product.setProductId(UUID.randomUUID().toString());
		product.setCategory("테스트카테고리");
		product.setShopName("테스트쇼핑몰");
		product.setProductName(productName);
		product.setPrice(10000);
		product.setDeliveryFee("3000원");
		productDAO.insertProduct(product);
		return product;
	}

	private HotdealVO createTestHotdeal(String title, String productId) {
		HotdealVO vo = new HotdealVO();
		vo.setTitle(title);
		vo.setAuthor("테스터");
		vo.setThumbnail("test_thumbnail.jpg");
		vo.setContent("테스트 내용입니다.");
		vo.setProductId(productId);
		vo.setViews(0);
		vo.setLikes(0);
		vo.setDislikes(0);
		vo.setIsNotice("0");
		return vo;
	}

	@Test
	public void 게시글_등록_및_조회_테스트() {
		ProductVO product = createAndInsertTestProduct("등록용 상품");
		HotdealVO vo = createTestHotdeal("등록 및 조회 테스트", product.getProductId());
		hotdealDAO.insertHotdeal(vo);
		Integer insertedId = vo.getId();

		try {
			assertNotNull("ID가 생성되어야 합니다.", insertedId);
			HotdealVO result = hotdealDAO.getHotdealById(insertedId);
			assertNotNull("ID로 게시글이 조회되어야 합니다.", result);
			assertEquals("등록 및 조회 테스트", result.getTitle());
			assertEquals(product.getProductId(), result.getProductId());
		} finally {
			if (insertedId != null) {
				hotdealDAO.deleteHotdeal(insertedId);
			}

			productDAO.deleteProduct(product.getProductId());
		}
	}

	@Test
	public void 게시글_수정_테스트() {
		ProductVO product = createAndInsertTestProduct("수정용 상품");
		HotdealVO vo = createTestHotdeal("수정 전 제목", product.getProductId());
		hotdealDAO.insertHotdeal(vo);
		Integer testId = vo.getId();

		try {
			HotdealVO forUpdate = new HotdealVO();
			forUpdate.setId(testId);
			forUpdate.setTitle("수정된 제목");
			forUpdate.setContent("수정된 내용입니다.");
			forUpdate.setThumbnail("updated.jpg");
			forUpdate.setProductId(product.getProductId());
			forUpdate.setIsNotice("0"); // isNotice 필드 설정
			hotdealDAO.updateHotdeal(forUpdate);

			HotdealVO updated = hotdealDAO.getHotdealById(testId);
			assertNotNull(updated);
			assertEquals("수정된 제목", updated.getTitle());
		} finally {
			if (testId != null) {
				hotdealDAO.deleteHotdeal(testId);
			}
			productDAO.deleteProduct(product.getProductId());
		}
	}

	@Test
	public void 게시글_삭제_테스트() {
		ProductVO product = createAndInsertTestProduct("삭제용 상품");
		HotdealVO vo = createTestHotdeal("삭제 테스트", product.getProductId());
		hotdealDAO.insertHotdeal(vo);
		Integer testId = vo.getId();

		hotdealDAO.deleteHotdeal(testId);

		HotdealVO deleted = hotdealDAO.getHotdealById(testId);
		assertNull("삭제된 게시글은 조회되지 않아야 합니다.", deleted);

		productDAO.deleteProduct(product.getProductId());
	}

	@Test
	public void 조회수_증가_테스트() {
		ProductVO product = createAndInsertTestProduct("조회수 증가용 상품");
		HotdealVO vo = createTestHotdeal("조회수 테스트", product.getProductId());
		hotdealDAO.insertHotdeal(vo);
		int testId = vo.getId();

		try {
			HotdealVO before = hotdealDAO.getHotdealById(testId);
			assertNotNull("게시글이 조회되어야 합니다.", before);
			int beforeViews = before.getViews();

			hotdealDAO.increaseViews(testId);

			HotdealVO after = hotdealDAO.getHotdealById(testId);
			assertNotNull(after);
			assertEquals("조회수가 1 증가해야 합니다.", beforeViews + 1, after.getViews());
		} finally {
			hotdealDAO.deleteHotdeal(testId);
			productDAO.deleteProduct(product.getProductId());
		}
	}

}
