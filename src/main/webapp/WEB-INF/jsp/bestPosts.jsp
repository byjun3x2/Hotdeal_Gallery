<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--
  베스트 게시글 목록을 표시하는 사이드바 UI입니다.
  이 파일을 include하는 페이지의 Controller는 반드시
  "bestList"라는 이름으로 베스트 게시글 목록 데이터를 Model에 추가해야 합니다.
--%>
<aside class="best-posts">
    <h3>베스트 게시글</h3>
    <ul>
        <c:forEach var="item" items="${bestList}" varStatus="status">
            <li>
                <a href="detail?id=${item.id}" title="${item.title}">
                    ${status.index + 1}. 
                    <c:if test="${not empty item.category}">[${item.category}]</c:if> 
                    ${item.title} 
                    <span style="color: #007bff; font-weight: bold;">[+${item.likes - item.dislikes}]</span>
                </a>
            </li>
        </c:forEach>
        <c:if test="${empty bestList}">
            <li style="color: #aaa;">베스트 게시글이 없습니다.</li>
        </c:if>
    </ul>
</aside>