package kr.co.hotdeal.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.hotdeal.report.dao.ReportDAO;
import kr.co.hotdeal.report.vo.ReportVO;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportDAO reportDAO;

    @Override
    @Transactional
    public void addReport(ReportVO report) {
        reportDAO.insertReport(report);
        // 필요시 핫딜 게시글의 신고 카운트 업데이트 등의 추가 로직
    }
    
    // [ADD] 관리자용 전체 신고 목록 조회 서비스 구현
    @Override
    public List<ReportVO> getAllReports() {
        return reportDAO.selectAllReports();
    }
}