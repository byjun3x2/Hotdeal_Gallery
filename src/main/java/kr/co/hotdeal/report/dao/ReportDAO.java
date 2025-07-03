package kr.co.hotdeal.report.dao;

import java.util.List;

import kr.co.hotdeal.report.vo.ReportVO;

public interface ReportDAO {
    void insertReport(ReportVO report);

    List<ReportVO> selectAllReports();
}