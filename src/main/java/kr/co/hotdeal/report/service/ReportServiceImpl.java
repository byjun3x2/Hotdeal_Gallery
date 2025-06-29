package kr.co.hotdeal.report.service;

import kr.co.hotdeal.report.dao.ReportDAO;
import kr.co.hotdeal.report.vo.ReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
}