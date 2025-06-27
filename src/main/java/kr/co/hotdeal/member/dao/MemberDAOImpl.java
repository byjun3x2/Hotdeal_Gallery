package kr.co.hotdeal.member.dao;

import kr.co.hotdeal.member.vo.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class MemberDAOImpl implements MemberDAO {

    private static final String NAMESPACE = "kr.co.hotdeal.member.dao.MemberDAO.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public void insertMember(MemberVO member) {
        sqlSessionTemplate.insert(NAMESPACE + "insertMember", member);
    }

    @Override
    public MemberVO selectMemberByUsername(String username) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "selectMemberByUsername", username);
    }

    @Override
    public MemberVO selectMemberById(int memberId) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "selectMemberById", memberId);
    }

    @Override
    public MemberVO login(String username, String password) {
        Map<String, Object> param = new HashMap<>();
        param.put("username", username);
        param.put("password", password);
        return sqlSessionTemplate.selectOne(NAMESPACE + "login", param);
    }
    
    @Override
    public void deleteMemberByUsername(String username) {
        sqlSessionTemplate.delete(NAMESPACE + "deleteMemberByUsername", username);
    }
    
    @Override
    public void deleteAllMembers() {
        sqlSessionTemplate.delete(NAMESPACE + "deleteAllMembers");
    }
}
