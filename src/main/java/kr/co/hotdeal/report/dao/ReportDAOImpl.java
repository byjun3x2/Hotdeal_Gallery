package kr.co.hotdeal.report.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.hotdeal.report.vo.ReportVO;

@Repository
public class ReportDAOImpl implements ReportDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "reportMapper."; // 매퍼 XML의 namespace

    @Override
    public void insertReport(ReportVO report) {
        sqlSession.insert(NAMESPACE + "insertReport", report);
    }
    
    // [ADD] 관리자용 전체 신고 목록 조회 메서드 구현
    @Override
    public List<ReportVO> selectAllReports() {
        return sqlSession.selectList(NAMESPACE + "selectAllReports");
    }
}