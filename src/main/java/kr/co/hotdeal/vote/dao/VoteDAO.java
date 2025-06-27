package kr.co.hotdeal.vote.dao;

import org.apache.ibatis.annotations.Param;

public interface VoteDAO {
    int countVote(@Param("hotdealId") int hotdealId, @Param("username") String username, @Param("voteType") String voteType);
    void insertVote(@Param("hotdealId") int hotdealId, @Param("username") String username, @Param("voteType") String voteType);
    void deleteVoteForTest(@Param("hotdealId") int hotdealId, @Param("username") String username, @Param("voteType") String voteType);
    void deleteVote(@Param("hotdealId") int hotdealId, @Param("username") String username, @Param("voteType") String voteType); // 새로 추가
}
