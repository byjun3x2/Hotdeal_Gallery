<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
.top-menu-bar {
    width: 100%;
    background: #fff;
    border-bottom: 1px solid #eee;
    padding: 8px 0;
    font-size: 13px;
    color: #666;
    box-sizing: border-box;
}
.top-menu-bar .menu-container {
    width: 90%;
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.top-menu-bar .menu-links a, .top-menu-bar .menu-links button {
    margin-right: 8px;
    color: #666;
    text-decoration: none;
    background: none;
    border: none;
    font: inherit;
    cursor: pointer;
    outline: none;
    padding: 0 8px;
    transition: color 0.2s;
}
.top-menu-bar .menu-links a:hover, .top-menu-bar .menu-links button:hover {
    text-decoration: underline;
    color: #0056b3;
}
.top-menu-bar .user-actions {
    display: flex;
    align-items: center;
    gap: 15px;
}
.top-menu-bar .user-info a {
    color: #007bff;
    font-weight: bold;
    text-decoration: none;
}
.top-menu-bar .user-info a:hover {
    text-decoration: underline;
}
.admin-link {
    color: red !important;
    font-weight: bold;
}
</style>
<div class="top-menu-bar">
    <div class="menu-container">
        <div class="menu-links">
            <a href="<c:url value='/' />"><b>커스텀 핫딜</b></a>
        </div>
        <div class="user-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <div class="user-info">
                        <%-- [ADD] 관리자일 경우에만 '관리자 페이지' 링크를 표시 --%>
                        <c:if test="${sessionScope.loginUser.role == 'ROLE_ADMIN'}">
                            <a href="<c:url value='/admin/members' />" class="admin-link">관리자 페이지</a> |
                        </c:if>
                        
                        <span><b>${sessionScope.loginUser.name}</b>님 환영합니다!</span> |
                        <a href="<c:url value='/logout' />">로그아웃</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="guest-info">
                        <a href="<c:url value='/login' />">로그인</a> |
                        <a href="<c:url value='/join' />">회원가입</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>