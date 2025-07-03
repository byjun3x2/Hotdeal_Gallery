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


    @Override
    public void insertProduct(ProductVO product) {
        sqlSessionTemplate.insert(NAMESPACE + "insertProduct", product);
    }

    @Override
    public List<ProductVO> getAllProducts() {
        return sqlSessionTemplate.selectList(NAMESPACE + "getAllProducts");
    }


    @Override
    public ProductVO getProductById(String productId) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getProductById", productId);
    }
    

    @Override
    public void deleteProduct(String productId) {
        sqlSessionTemplate.delete(NAMESPACE + "deleteProduct", productId);
    }
    
    @Override
    public void deleteAllProducts() {
        sqlSessionTemplate.delete(NAMESPACE + "deleteAllProducts");
    }
    

    @Override
    public List<String> getAllCategories() {
        return sqlSessionTemplate.selectList(NAMESPACE + "getAllCategories");
    }

    @Override
    public void updateProduct(ProductVO vo) {
        sqlSessionTemplate.update(NAMESPACE + "updateProduct", vo);
    }
}
