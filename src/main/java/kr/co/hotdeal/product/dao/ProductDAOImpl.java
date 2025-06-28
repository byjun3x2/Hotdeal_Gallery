package kr.co.hotdeal.product.dao;

import kr.co.hotdeal.product.vo.ProductVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDAOImpl implements ProductDAO {

    private static final String NAMESPACE = "kr.co.hotdeal.product.dao.ProductDAO.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    // 상품 등록
    @Override
    public void insertProduct(ProductVO product) {
        sqlSessionTemplate.insert(NAMESPACE + "insertProduct", product);
    }

    // 전체 상품 조회
    @Override
    public List<ProductVO> getAllProducts() {
        return sqlSessionTemplate.selectList(NAMESPACE + "getAllProducts");
    }

    // 상품 상세 조회 (필요시)
    @Override
    public ProductVO getProductById(String productId) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getProductById", productId);
    }
    
    // [ADD] 상품 삭제 메소드 구현
    @Override
    public void deleteProduct(String productId) {
        sqlSessionTemplate.delete(NAMESPACE + "deleteProduct", productId);
    }
    
    @Override
    public void deleteAllProducts() {
        sqlSessionTemplate.delete(NAMESPACE + "deleteAllProducts");
    }
    
    /**
     * [ADD] getAllCategories 메소드 구현
     */
    @Override
    public List<String> getAllCategories() {
        return sqlSessionTemplate.selectList(NAMESPACE + "getAllCategories");
    }

    @Override
    public void updateProduct(ProductVO vo) {
        sqlSessionTemplate.update(NAMESPACE + "updateProduct", vo);
    }
}
