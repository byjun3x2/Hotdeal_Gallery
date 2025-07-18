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
	private String productId;
	private int commentCount;
	private String isEnded;
	private ProductVO product;
	private String isNotice;
}
