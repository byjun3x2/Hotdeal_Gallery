package kr.co.hotdeal.product.vo;

import lombok.Data;

@Data
public class ProductVO {
    private String productId;
    private String category;
    private String shopName;
    private String productName;
    private String relatedUrl;
    private int price;
    private String deliveryFee;
    private String productImage;  
}