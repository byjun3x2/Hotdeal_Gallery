<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지 - 회원 관리</title>
    <style>
        body { font-family: sans-serif; }
        .admin-container { width: 90%; max-width: 1200px; margin: 40px auto; }
        .admin-container h1 { margin-bottom: 20px; }
        .member-table { width: 100%; border-collapse: collapse; }
        .member-table th, .member-table td { border: 1px solid #ddd; padding: 12px; text-align: center; }
        .member-table th { background-color: #f2f2f2; }
        .member-table tbody tr:hover { background-color: #f9f9f9; }
        .role-admin { color: red; font-weight: bold; }
    </style>
</head>
<body>
    <%@ include file="../topMenu.jsp" %>
    <div class="admin-container">
        <h1>회원 관리</h1>
        <table class="member-table">
            <thead>
                <tr>
                    <th>회원번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>가입일</th>
                    <th>역할</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty memberList}">
                        <c:forEach var="member" items="${memberList}">
                            <tr>
                                <td>${member.memberId}</td>
                                <td>${member.username}</td>
                                <td>${member.name}</td>
                                <td>${member.email}</td>
                                <td>${fn:substring(member.regDate, 0, 10)}</td>
                                <td class="${member.role == 'ROLE_ADMIN' ? 'role-admin' : ''}">${member.role}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6">등록된 회원이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>