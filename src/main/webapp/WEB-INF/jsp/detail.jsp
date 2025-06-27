<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="topMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>핫딜 상세보기</title>
    <style>
        .detail-box {
            width: 500px;
            margin: 40px auto;
            border: 1px solid #ddd;
            padding: 30px;
            border-radius: 8px;
            background: #fafbfc;
        }
        .detail-box h2 {
            margin-bottom: 20px;
        }
        .detail-box img {
            max-width: 100%;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        .detail-box .info {
            margin-bottom: 15px;
            font-size: 15px;
            color: #555;
        }
        .detail-box .label {
            font-weight: bold;
            color: #333;
            margin-right: 8px;
        }
        .detail-box .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        .detail-box .back-link:hover {
            text-decoration: underline;
        }
        .vote-btn { padding:6px 18px; margin-right:10px; border-radius:4px; border:none; font-size:15px; cursor:pointer;}
        .like-btn { background:#007bff; color:#fff;}
        .dislike-btn { background:#ff4444; color:#fff;}
        .vote-msg { color:#d00; font-size:14px; margin-top:10px;}
        .comment-section-wrapper {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            margin-top: 40px;
            margin-bottom: 40px;
        }
        .comment-section {
            width: 100%;
            max-width: 700px;
            background: #fafbfc;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 28px 32px;
            box-sizing: border-box;
            text-align: center;
        }
        .comment-section h3 {
            margin-bottom: 18px;
        }
        #commentForm textarea {
            width: 90%;
            min-width: 250px;
            max-width: 600px;
            margin-bottom: 8px;
        }
        #commentForm button {
            margin-top: 8px;
        }
        .comment-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
            max-width: 600px;
            margin: 0 auto;
            text-align: left;
        }
        .reply-toggle-btn {
            font-size: 13px;
            padding: 2px 8px;
            cursor: pointer;
            margin-top: 5px;
        }
        .replyForm {
            display: none;
            margin-top: 8px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="detail-box">
    <h2>${deal.title}</h2>
    <c:if test="${not empty deal.thumbnail}">
        <img src="${deal.thumbnail}" alt="썸네일">
    </c:if>
    <div class="info">
        <span class="label">작성자:</span> ${deal.author}
    </div>
    <div class="info">
        <span class="label">등록일:</span> ${deal.regDate}
    </div>
    <div class="info">
        <span class="label">조회수:</span> ${deal.views}
    </div>
    <div class="info">
        <span class="label">추천수:</span> <span id="likes-count">${deal.likes}</span>
        <span class="label">비추천수:</span> <span id="dislikes-count">${deal.dislikes}</span>
    </div>
    <div>
        <c:if test="${not empty sessionScope.loginUser}">
            <button class="vote-btn like-btn" onclick="vote('LIKE')">추천</button>
            <button class="vote-btn dislike-btn" onclick="vote('DISLIKE')">비추천</button>
        </c:if>
        <span id="vote-msg" class="vote-msg"></span>
    </div>
    <div class="info">
        <span class="label">내용:</span><br>
        <pre style="font-size:15px; color:#333;">${deal.content}</pre>
    </div>
    <a href="list?page=1" class="back-link">← 목록으로</a>
</div>

<div class="comment-section-wrapper">
    <div class="comment-section">
        <h3>댓글</h3>
        <c:if test="${not empty sessionScope.loginUser}">
            <form id="commentForm" method="post" action="addComment" style="margin-bottom:18px;">
                <input type="hidden" name="hotdealId" value="${deal.id}" />
                <%-- parentId는 보내지 않거나 null로 보냅니다 --%>
                <textarea name="content" rows="3" cols="60" maxlength="1000" required placeholder="댓글을 입력하세요"></textarea>
                <br>
                <button type="submit">등록</button>
            </form>
        </c:if>
        <c:if test="${empty sessionScope.loginUser}">
            <div style="color:#888; margin-bottom:18px;">댓글을 작성하려면 로그인하세요.</div>
        </c:if>
        
        <div id="comment-list">
            <c:if test="${empty commentList}">
                <div style="color:#aaa;">아직 댓글이 없습니다.</div>
            </c:if>
            <c:if test="${not empty commentList}">
                <%-- 최상위 댓글(parentId가 null인 댓글)만 필터링하여 commentTree.jsp를 호출 --%>
                <c:forEach var="comment" items="${commentList}">
                    <c:if test="${comment.parentId == null}">
                        <jsp:include page="commentTree.jsp">
                            <jsp:param name="commentId" value="${comment.commentId}" />
                            <jsp:param name="depth" value="0" />
                        </jsp:include>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>
</div>

<script>
// 추천/비추천 AJAX
function vote(type) {
    $.post("vote", {id: "${deal.id}", type: type}, function(res) {
        if(res.result === "success") {
            $("#likes-count").text(res.likes);
            $("#dislikes-count").text(res.dislikes);
            $("#vote-msg").text("투표가 반영되었습니다!");
        } else {
            $("#vote-msg").text(res.result);
        }
    }, "json");
}

$(function() {
    // 1. 최상위 댓글 AJAX 등록
    $("#commentForm").submit(function(e) {
        e.preventDefault(); // 기본 폼 제출 방지
        $.ajax({
            url: "addComment",
            type: "POST",
            data: $(this).serialize(),
            success: function(res) {
                // 전체 댓글 목록을 다시 로드하여 갱신
                $("#comment-list").load(location.href + " #comment-list>*", "");
                // 입력창 비우기
                $("#commentForm textarea").val("");
            }
        });
    });

    // 2. 답글 버튼 클릭 이벤트 (동적 생성 요소에 이벤트 바인딩)
    $(document).on("click", ".reply-toggle-btn", function() {
        var targetId = $(this).data("target");
        // 모든 답글 폼을 숨기고 클릭된 것만 토글
        $(".replyForm").not("#" + targetId).hide();
        $("#" + targetId).toggle();
    });

    // 3. 답글(대댓글) AJAX 등록
    $(document).on("submit", ".replyForm", function(e) {
        e.preventDefault(); // 기본 폼 제출 방지
        var $form = $(this);
        $.ajax({
            url: "addComment",
            type: "POST",
            data: $form.serialize(),
            success: function(res) {
                // 전체 댓글 목록을 다시 로드하여 갱신
                $("#comment-list").load(location.href + " #comment-list>*", "");
                // 현재 폼의 입력창 비우고 폼 숨기기 (사용성 개선)
                $form.find("textarea").val("");
                $form.hide();
            }
        });
    });
});
</script>
</body>
</html>