package kr.co.hotdeal.report.vo;

import java.util.Date;
import lombok.Data;

@Data
public class ReportVO {
	private int reportId;
	private int hotdealId;
	private int reporterUserId;
	private String reportType;
	private Date reportDate;
	private String status;

	private String hotdealTitle;
	private String reporterUsername;

	public ReportVO() {
	}

	public ReportVO(int reportId, int hotdealId, int reporterUserId, String reportType, Date reportDate,
			String status) {
		this.reportId = reportId;
		this.hotdealId = hotdealId;
		this.reporterUserId = reporterUserId;
		this.reportType = reportType;
		this.reportDate = reportDate;
		this.status = status;
	}
}