package kr.co.hotdeal.product.service;

import kr.co.hotdeal.product.dao.ProductDAO;
import kr.co.hotdeal.product.vo.ProductVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductDAO productDAO;

    // 상품 등록
    public void insertProduct(ProductVO product) {
        productDAO.insertProduct(product);
    }

    // 전체 상품 조회
    public List<ProductVO> getAllProducts() {
        return productDAO.getAllProducts();
    }

    // 상품 상세 조회 (필요시)
    public ProductVO getProductById(String productId) {
        return productDAO.getProductById(productId);
    }
    
    /**
     * [ADD] 컨트롤러가 사용할 카테고리 조회 서비스 메소드
     */
    public List<String> getAllCategories() {
        return productDAO.getAllCategories();
    }
}
