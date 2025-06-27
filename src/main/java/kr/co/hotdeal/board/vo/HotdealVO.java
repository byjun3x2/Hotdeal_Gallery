 package kr.co.hotdeal.board.vo;

import kr.co.hotdeal.product.vo.ProductVO;
import lombok.Data;

@Data
public class HotdealVO {
    private int id;
    private String thumbnail;
    private String title;
    private String author;
    private String regDate;
    private int views;
    private int likes;
    private int dislikes;
    private String content;
    private String category; 
    private String productId; // 상품 참조용 FK
 // [ADD] 댓글 수를 담기 위한 필드 추가
    private int commentCount;

 // [ADD] 상품 정보를 담기 위한 ProductVO 필드 추가
    private ProductVO product;
    

 
}
