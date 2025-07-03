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

	public void insertProduct(ProductVO product) {
		productDAO.insertProduct(product);
	}

	public List<ProductVO> getAllProducts() {
		return productDAO.getAllProducts();
	}

	public ProductVO getProductById(String productId) {
		return productDAO.getProductById(productId);
	}

	public List<String> getAllCategories() {
		return productDAO.getAllCategories();
	}

	public void updateProduct(ProductVO vo) {
		productDAO.updateProduct(vo);
	}

}
