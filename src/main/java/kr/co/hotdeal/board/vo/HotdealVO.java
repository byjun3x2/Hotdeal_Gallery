 package kr.co.hotdeal.board.vo;

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
}
