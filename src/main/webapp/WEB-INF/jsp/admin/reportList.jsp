<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지 - 신고 관리</title>
    <style>
        body { font-family: sans-serif; }
        .admin-container { width: 90%; max-width: 1200px; margin: 40px auto; }
        .admin-container h1, .admin-container h2 { margin-bottom: 20px; }
        .member-table { width: 100%; border-collapse: collapse; }
        .member-table th, .member-table td { border: 1px solid #ddd; padding: 12px; text-align: center; }
        .member-table th { background-color: #f2f2f2; }
        .member-table tbody tr:hover { background-color: #f9f9f9; }
        .admin-tabs { border-bottom: 2px solid #ddd; margin-bottom: 20px; padding-bottom: 0; }
        .admin-tabs a { display: inline-block; padding: 10px 20px; text-decoration: none; color: #333; border: 1px solid transparent; border-bottom: none; font-size: 16px; margin-bottom: -2px; }
        .admin-tabs a.active { border-color: #ddd; border-bottom: 2px solid #fff; background: #fff; font-weight: bold; border-radius: 4px 4px 0 0; }
        .member-table a { color: #007bff; text-decoration: none; }
        .member-table a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <%@ include file="../topMenu.jsp" %>
    <div class="admin-container">
        <h1>관리자 페이지</h1>
        
        <div class="admin-tabs">
            <a href="<c:url value='/admin/members'/>">회원 관리</a>
            <a href="<c:url value='/admin/reports'/>" class="active">신고 관리</a>
        </div>
        
        <h2>신고된 게시글 목록</h2>
        <table class="member-table">
            <thead>
                <tr>
                    <th style="width: 8%;">신고ID</th>
                    <th>게시글 제목</th>
                    <th style="width: 15%;">신고 유형</th>
                    <th style="width: 12%;">신고자</th>
                    <th style="width: 15%;">신고일</th>
                    <th style="width: 10%;">상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty reportList}">
                        <c:forEach var="report" items="${reportList}">
                            <tr>
                                <td>${report.reportId}</td>
                                <td style="text-align: left; padding-left: 15px;">
                                    <a href="<c:url value='/detail?id=${report.hotdealId}'/>" target="_blank">
                                        ${report.hotdealTitle}
                                    </a>
                                </td>
                                <td>${report.reportType}</td>
                                <td>${report.reporterUsername}</td>
                                <td>${report.reportDate}</td>
                                <td>${report.status}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6">접수된 신고가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>