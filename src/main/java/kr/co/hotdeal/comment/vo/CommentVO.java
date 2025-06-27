package kr.co.hotdeal.comment.vo;

import lombok.Data;

@Data
public class CommentVO {
    private int commentId;
    private int hotdealId;
    private Integer parentId; // 대댓글용
    private String username;
    private String content;
    private String regDate;
}
