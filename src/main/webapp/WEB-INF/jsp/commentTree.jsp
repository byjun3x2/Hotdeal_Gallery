<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach var="comment" items="${commentList}">
	<c:if test="${comment.commentId == param.commentId}">
		<c:set var="currentDepth"
			value="${empty param.depth ? 0 : param.depth}" />

		<div class="comment-item" style="margin-left: ${currentDepth * 40}px;">
			<div class="comment-main">
				<b>${comment.username}</b> <span style="color: #aaa;">${comment.regDate}</span><br>
				<span>${comment.content}</span>
			</div>
			<c:if test="${not empty sessionScope.loginUser}">
				<button type="button" class="reply-toggle-btn"
					data-target="replyForm-${comment.commentId}">답글</button>
			</c:if>
		</div>

		<c:if test="${not empty sessionScope.loginUser}">
			<form class="replyForm" id="replyForm-${comment.commentId}"
				method="post" action="addComment"
				style="margin-left: ${(currentDepth + 1) * 40}px;">
				<input type="hidden" name="hotdealId" value="${deal.id}" /> <input
					type="hidden" name="parentId" value="${comment.commentId}" />
				<textarea name="content" rows="2" cols="45" maxlength="1000"
					required placeholder="답글을 입력하세요"></textarea>
				<button type="submit" style="margin-left: 6px;">답글 등록</button>
			</form>
		</c:if>

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
