package kr.co.hotdeal.product.dao;

import kr.co.hotdeal.product.vo.ProductVO;
import java.util.List;

public interface ProductDAO {

	void insertProduct(ProductVO product);

	List<ProductVO> getAllProducts();

	ProductVO getProductById(String productId);

	void updateProduct(ProductVO vo);

	void deleteProduct(String productId);

	void deleteAllProducts(); // 전체 상품 삭제

	List<String> getAllCategories();
}
