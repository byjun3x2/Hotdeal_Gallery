package kr.co.hotdeal.comment.vo;

import lombok.Data;

@Data
public class CommentVO {
	private int commentId;
	private int hotdealId;
	private Integer parentId;
	private String username;
	private String content;
	private String regDate;
	private String isEdited;
	private String editDate;
}
