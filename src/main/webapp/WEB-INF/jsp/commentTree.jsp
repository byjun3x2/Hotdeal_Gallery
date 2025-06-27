<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 
    이 파일은 재귀적으로 호출됩니다.
    파라미터로 commentId와 depth를 받습니다.
--%>

<%-- JSTL의 <c:forEach>를 사용하여 파라미터로 받은 commentId에 해당하는 댓글을 찾습니다. --%>
<c:forEach var="comment" items="${commentList}">
    <c:if test="${comment.commentId == param.commentId}">
        
        <%-- 현재 깊이(depth)를 변수로 설정합니다. --%>
        <c:set var="currentDepth" value="${empty param.depth ? 0 : param.depth}" />

        <%-- 댓글 아이템 표시, depth에 따라 들여쓰기 적용 --%>
        <div class="comment-item" style="margin-left: ${currentDepth * 40}px;">
            <b>${comment.username}</b> <span style="color:#aaa;">${comment.regDate}</span><br>
            <span>${comment.content}</span>

            <%-- 로그인한 경우에만 답글 버튼과 폼을 표시 --%>
            <c:if test="${not empty sessionScope.loginUser}">
                <button type="button" class="reply-toggle-btn" data-target="replyForm-${comment.commentId}">답글</button>
                
                <%-- 답글 폼: detail.jsp의 jQuery가 인식할 수 있도록 class와 id를 부여 --%>
                <form class="replyForm" id="replyForm-${comment.commentId}" method="post" action="addComment">
                    <input type="hidden" name="hotdealId" value="${deal.id}" />
                    <input type="hidden" name="parentId" value="${comment.commentId}" />
                    <textarea name="content" rows="2" cols="45" maxlength="1000" required placeholder="답글을 입력하세요"></textarea>
                    <button type="submit" style="margin-left:6px;">답글 등록</button>
                </form>
            </c:if>
        </div>

        <%-- 자식 댓글(대댓글)을 찾아서 재귀적으로 자기 자신을 include --%>
        <c:forEach var="child" items="${commentList}">
            <c:if test="${child.parentId == comment.commentId}">
                <jsp:include page="commentTree.jsp">
                    <jsp:param name="commentId" value="${child.commentId}" />
                    <jsp:param name="depth" value="${currentDepth + 1}" />
                </jsp:include>
            </c:if>
        </c:forEach>
    </c:if>
</c:forEach>