package kr.co.hotdeal.product.dao;

import kr.co.hotdeal.product.vo.ProductVO;
import java.util.List;

public interface ProductDAO {
    // 상품 등록
    void insertProduct(ProductVO product);

    // 전체 상품 조회
    List<ProductVO> getAllProducts();

    // 상품 상세 조회
    ProductVO getProductById(String productId);
    
    void updateProduct(ProductVO vo);
    
    // [ADD] 상품 삭제 메소드 추가
    void deleteProduct(String productId);
    
    void deleteAllProducts(); // 전체 상품 삭제
    
    
    /**
     * [ADD] DB에서 중복을 제외한 모든 카테고리 목록을 가져오는 메소드
     */
    List<String> getAllCategories();
}
