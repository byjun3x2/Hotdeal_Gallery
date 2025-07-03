<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach var="comment" items="${commentList}">
	<c:if test="${comment.commentId == param.commentId}">
		<c:set var="currentDepth"
			value="${empty param.depth ? 0 : param.depth}" />

		<div class="comment-item" style="margin-left: ${currentDepth * 40}px;">
			<div class="comment-main">
				<b>${comment.username}</b> <span style="color: #aaa;">${comment.regDate}</span>
				<c:if test="${comment.isEdited == 'Y'}">
					<span style="color: #888; font-size: 12px;"> (수정됨<c:if test='${not empty comment.editDate}'>, ${comment.editDate}</c:if>)</span>
				</c:if><br>
				<span>${comment.content}</span>
			</div>
			<c:if test="${not empty sessionScope.loginUser && sessionScope.loginUser.username == comment.username}">
				<button type="button" class="edit-comment-btn" onclick="showEditForm(${comment.commentId})">수정</button>
				
				<%-- [수정] onsubmit 속성 제거 --%>
				<form method="post" action="deleteComment" style="display:inline;">
					<input type="hidden" name="commentId" value="${comment.commentId}" />
					<input type="hidden" name="hotdealId" value="${comment.hotdealId}" />
					<button type="submit">삭제</button>
				</form>
			</c:if>
			<c:if test="${not empty sessionScope.loginUser}">
				<button type="button" class="reply-toggle-btn"
					data-target="replyForm-${comment.commentId}">답글</button>
			</c:if>
		</div>

		<div id="editForm-${comment.commentId}" style="display:none; margin-left:${currentDepth * 40 + 40}px;">
			<form method="post" action="updateComment">
				<input type="hidden" name="commentId" value="${comment.commentId}" />
				<input type="hidden" name="hotdealId" value="${comment.hotdealId}" />
				<textarea name="content" rows="2" cols="45" maxlength="1000" required>${comment.content}</textarea>
				<button type="submit">수정 완료</button>
				<button type="button" onclick="hideEditForm(${comment.commentId})">취소</button>
			</form>
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

<%--
    [수정] 이 파일에 있던 <script>...</script> 블록을 완전히 삭제합니다.
--%>