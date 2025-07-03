package kr.co.hotdeal.report.service;

import java.util.List;

import kr.co.hotdeal.report.vo.ReportVO;

public interface ReportService {
    void addReport(ReportVO report);

    List<ReportVO> getAllReports();
}