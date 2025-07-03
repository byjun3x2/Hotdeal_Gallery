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
	}

	@Override
	public List<ReportVO> getAllReports() {
		return reportDAO.selectAllReports();
	}
}