package kr.co.hotdeal.vote.vo;

import lombok.Data;

@Data
public class VoteVO {
    private int voteId;
    private int hotdealId;
    private String username;
    private String voteType; // "LIKE" 또는 "DISLIKE"
}
