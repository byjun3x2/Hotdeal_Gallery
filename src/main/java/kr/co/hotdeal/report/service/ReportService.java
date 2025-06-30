package kr.co.hotdeal.report.service;

import java.util.List;

import kr.co.hotdeal.report.vo.ReportVO;

public interface ReportService {
    void addReport(ReportVO report);
    // 추가적으로 필요한 서비스 메서드
 // [ADD] 관리자용 전체 신고 목록 조회 서비스
    List<ReportVO> getAllReports();
}