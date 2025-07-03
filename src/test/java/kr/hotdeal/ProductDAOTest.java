package kr.hotdeal;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.util.List;
import java.util.UUID;
import kr.co.hotdeal.product.dao.ProductDAO;
import kr.co.hotdeal.product.vo.ProductVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/spring/spring-mvc.xml" })
public class ProductDAOTest {

	@Autowired
	private ProductDAO productDAO;

	private ProductVO createTestProduct(String productName) {
		ProductVO product = new ProductVO();
		product.setProductId(UUID.randomUUID().toString());
		product.setCategory("테스트카테고리");
		product.setShopName("테스트쇼핑몰");
		product.setProductName(productName);
		product.setRelatedUrl("http://test.com");
		product.setPrice(10000);
		product.setDeliveryFee("3000원");
		product.setProductImage("test_image.jpg");
		return product;
	}

	@Test
	public void 상품_등록_및_ID조회_테스트() {

		ProductVO product = createTestProduct("테스트 상품 1");
		String productId = product.getProductId();

		try {

			productDAO.insertProduct(product);

			ProductVO result = productDAO.getProductById(productId);
			assertNotNull("ID로 상품이 조회되어야 합니다.", result);
			assertEquals("테스트 상품 1", result.getProductName());
		} finally {

			productDAO.deleteProduct(productId);
		}
	}

	@Test
	public void 전체상품_조회_테스트() {

		ProductVO product1 = createTestProduct("전체 조회 테스트 1");
		ProductVO product2 = createTestProduct("전체 조회 테스트 2");

		try {
			productDAO.insertProduct(product1);
			productDAO.insertProduct(product2);

			List<ProductVO> productList = productDAO.getAllProducts();

			assertNotNull(productList);

			long foundCount = productList.stream().filter(p -> p.getProductId().equals(product1.getProductId())
					|| p.getProductId().equals(product2.getProductId())).count();
			assertEquals("테스트에서 생성한 2개의 상품이 모두 조회되어야 합니다.", 2, foundCount);

		} finally {

			productDAO.deleteProduct(product1.getProductId());
			productDAO.deleteProduct(product2.getProductId());
		}
	}

	@Test
	public void 상품_삭제_테스트() {

		ProductVO product = createTestProduct("삭제될 상품");
		productDAO.insertProduct(product);
		String productId = product.getProductId();

		productDAO.deleteProduct(productId);

		ProductVO result = productDAO.getProductById(productId);
		assertNull("삭제된 상품은 조회되지 않아야 합니다.", result);
	}
}
