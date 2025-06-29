package kr.co.hotdeal.report.dao;

import kr.co.hotdeal.report.vo.ReportVO;

public interface ReportDAO {
    void insertReport(ReportVO report);
    // 추가적으로 필요한 DAO 메서드 (예: getReportById, getReportsByHotdealId, updateReportStatus 등)
}