package kr.co.hotdeal.report.dao;

import java.util.List;

import kr.co.hotdeal.report.vo.ReportVO;

public interface ReportDAO {
    void insertReport(ReportVO report);
    // 추가적으로 필요한 DAO 메서드 (예: getReportById, getReportsByHotdealId, updateReportStatus 등)
    
    // [ADD] 관리자용 전체 신고 목록 조회 메서드
    List<ReportVO> selectAllReports();
}