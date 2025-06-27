package kr.co.hotdeal.vote.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class VoteDAOImpl implements VoteDAO {

    private static final String NAMESPACE = "kr.co.hotdeal.vote.dao.VoteDAO.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public int countVote(int hotdealId, String username, String voteType) {
        java.util.Map<String, Object> param = new java.util.HashMap<>();
        param.put("hotdealId", hotdealId);
        param.put("username", username);
        param.put("voteType", voteType);
        return sqlSessionTemplate.selectOne(NAMESPACE + "countVote", param);
    }

    @Override
    public void insertVote(int hotdealId, String username, String voteType) {
        java.util.Map<String, Object> param = new java.util.HashMap<>();
        param.put("hotdealId", hotdealId);
        param.put("username", username);
        param.put("voteType", voteType);
        sqlSessionTemplate.insert(NAMESPACE + "insertVote", param);
    }

    @Override
    public void deleteVoteForTest(int hotdealId, String username, String voteType) {
        java.util.Map<String, Object> param = new java.util.HashMap<>();
        param.put("hotdealId", hotdealId);
        param.put("username", username);
        param.put("voteType", voteType);
        sqlSessionTemplate.delete(NAMESPACE + "deleteVoteForTest", param);
    }
    
    @Override
    public void deleteVote(int hotdealId, String username, String voteType) {
        Map<String, Object> param = new HashMap<>();
        param.put("hotdealId", hotdealId);
        param.put("username", username);
        param.put("voteType", voteType);
        sqlSessionTemplate.delete(NAMESPACE + "deleteVote", param);
    }
}
