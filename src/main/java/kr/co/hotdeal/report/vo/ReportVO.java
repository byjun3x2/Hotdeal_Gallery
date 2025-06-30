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

    // 추가된 필드
    private String hotdealTitle;     // 신고된 게시글 제목
    private String reporterUsername; // 신고자 아이디

    // 기본 생성자
    public ReportVO() {}

    // 모든 필드를 포함하는 생성자 (필요시)
    public ReportVO(int reportId, int hotdealId, int reporterUserId, String reportType, Date reportDate, String status) {
        this.reportId = reportId;
        this.hotdealId = hotdealId;
        this.reporterUserId = reporterUserId;
        this.reportType = reportType;
        this.reportDate = reportDate;
        this.status = status;
    }
}