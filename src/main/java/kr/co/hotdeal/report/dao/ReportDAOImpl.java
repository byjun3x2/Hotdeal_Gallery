package kr.co.hotdeal.report.dao;

import kr.co.hotdeal.report.vo.ReportVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDAOImpl implements ReportDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "reportMapper."; // 매퍼 XML의 namespace

    @Override
    public void insertReport(ReportVO report) {
        sqlSession.insert(NAMESPACE + "insertReport", report);
    }
}