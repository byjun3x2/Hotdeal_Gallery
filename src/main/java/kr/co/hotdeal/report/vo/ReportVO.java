package kr.co.hotdeal.report.vo;

import java.util.Date;
import lombok.Data; // lombok 사용 시

@Data // lombok 사용 시 getter, setter, toString 등 자동 생성
public class ReportVO {
    private int reportId;
    private int hotdealId;
    private int reporterUserId; // 신고한 사용자 ID
    private String reportType; // 신고 유형 (VIRAL_POST, ILLEGAL_HARMFUL, ADULT_CONTENT, ETC)
    private Date reportDate;
    private String status; // 처리 상태 (PENDING, REVIEWED, ACTION_TAKEN, REJECTED)

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