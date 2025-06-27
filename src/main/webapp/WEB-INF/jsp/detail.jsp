<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>핫딜 상세보기</title>
    <style>
        /* [REVISED] 전체적인 레이아웃 및 디자인 개선 */
        body {
            background-color: #f4f6f9; /* 배경색 추가 */
        }
        .page-container {
            display: flex;
            justify-content: center;
            gap: 24px;
            width: 95%;
            max-width: 1200px;
            margin: 40px auto;
            align-items: flex-start;
        }
        .main-content {
            flex: 3;
            min-width: 600px;
        }

        /* 상세 내용 컨테이너 */
        .detail-container {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 30px 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        /* 게시글 헤더 */
        .deal-header {
            border-bottom: 2px solid #343a40;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .deal-header h1 {
            font-size: 2em;
            font-weight: 600;
            margin: 0;
            color: #212529;
        }
        .deal-header .meta-info {
            margin-top: 10px;
            color: #6c757d;
            font-size: 0.9em;
        }
        .deal-header .meta-info span + span::before {
            content: "|";
            margin: 0 10px;
        }
        
        /* 상품 정보 박스 */
        .product-info-box {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 5px;
            padding: 20px;
            margin: 25px 0;
        }
        .product-info-box h3 {
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 1.2em;
            color: #343a40;
        }
        .product-info-box p {
            margin: 8px 0;
            font-size: 1em;
        }
        .product-info-box .product-link a {
            font-weight: bold;
            color: #007bff;
            text-decoration: none;
        }
        .product-info-box .product-link a:hover {
            text-decoration: underline;
        }

        /* 게시글 본문 */
        .deal-content {
            min-height: 150px;
            line-height: 1.7;
            font-size: 1.05em;
            color: #343a40;
            margin-bottom: 30px;
        }

        /* 투표 섹션 */
        .vote-section { text-align: center; margin: 30px 0; }
        .vote-btn { padding:8px 22px; margin:0 10px; border-radius:20px; border:1px solid #ccc; font-size:15px; cursor:pointer; background-color: #fff; transition: all 0.2s; }
        .vote-btn.like-btn:hover { background-color:#e7f3ff; border-color:#9ecbff;}
        .vote-btn.dislike-btn:hover { background-color:#ffe3e6; border-color:#ffb3ba;}
        .vote-msg { color:#d00; font-size:14px; margin-top:10px; display: block; height: 1em;}

        /* 댓글 섹션 */
        .comment-section-wrapper { margin-top: 40px; }
        .comment-section {
            width: 100%;
            background: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 28px 32px;
            box-sizing: border-box;
        }
        .comment-section h3 { margin-bottom: 18px; text-align: left; }
        #commentForm textarea { width: 100%; box-sizing:border-box; border: 1px solid #ced4da; border-radius: 4px; padding: 10px; margin-bottom: 10px; }
        #commentForm button { float: right; }

        .comment-item { border-top: 1px solid #e9ecef; padding: 15px 0; text-align: left; }
        .reply-toggle-btn { font-size: 13px; padding: 2px 8px; cursor: pointer; margin-top: 5px; }
        .replyForm { display: none; margin-top: 8px; }

        /* 베스트 게시글 사이드바 스타일 */
        .best-posts { flex: 1; min-width: 220px; border: 1px solid #e0e0e0; border-radius: 8px; padding: 16px; background-color: #fff; height: fit-content; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .best-posts h3 { margin-top: 0; font-size: 18px; border-bottom: 2px solid #007bff; padding-bottom: 8px; margin-bottom: 12px; }
        .best-posts ul { list-style: none; padding: 0; margin: 0; }
        .best-posts li { margin-bottom: 10px; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .best-posts a { text-decoration: none; color: #333; }
        .best-posts a:hover { text-decoration: underline; }
        
        .back-link { display: inline-block; margin-top: 20px; color: #007bff; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
    <%@ include file="topMenu.jsp" %>
    
    <div class="page-container">
        <div class="main-content">
            <div class="detail-container">
                <div class="deal-header">
                    <h1>
                        <c:if test="${not empty deal.product.category}">
                            <span style="color: #007bff;">[${deal.product.category}]</span>
                        </c:if>
                        ${deal.title}
                    </h1>
                    <div class="meta-info">
                        <span>작성자: ${deal.author}</span>
                        <span>등록일: ${deal.regDate}</span>
                        <span>조회: ${deal.views}</span>
                    </div>
                </div>

                <div class="product-info-box">
                    <h3>상품 정보</h3>
                    <p><strong>상품명:</strong> ${deal.product.productName}</p>
                    <p><strong>쇼핑몰:</strong> ${deal.product.shopName}</p>
                    <p><strong>가격:</strong> <fmt:formatNumber value="${deal.product.price}" pattern="#,###" />원</p>
                    <p><strong>배송료:</strong> 
                        <c:choose>
                            <c:when test="${deal.product.deliveryFee == '0'}">무료</c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${deal.product.deliveryFee}" pattern="#,###" />원
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${not empty deal.product.relatedUrl}">
                        <p class="product-link">
                            <a href="${deal.product.relatedUrl}" target="_blank">상품 페이지로 이동 &raquo;</a>
                        </p>
                    </c:if>
                </div>
                
                <c:if test="${not empty deal.thumbnail}">
                    <div style="text-align:center; margin-bottom: 25px;">
                        <img src="${deal.thumbnail}" alt="썸네일" style="max-width:100%; border-radius:6px;">
                    </div>
                </c:if>
                
                <div class="deal-content">
                    <pre style="font-family: inherit; font-size: inherit; white-space: pre-wrap; word-wrap: break-word;">${deal.content}</pre>
                </div>

                <div class="vote-section">
                    <c:if test="${not empty sessionScope.loginUser}">
                        <button class="vote-btn like-btn" onclick="vote('LIKE')">👍 추천 <span id="likes-count">${deal.likes}</span></button>
                        <button class="vote-btn dislike-btn" onclick="vote('DISLIKE')">👎 비추천 <span id="dislikes-count">${deal.dislikes}</span></button>
                    </c:if>
                    <span id="vote-msg" class="vote-msg"></span>
                </div>

                <a href="list?page=1" class="back-link">← 목록으로</a>
            </div>

            <div class="comment-section-wrapper">
                <div class="comment-section">
                    <h3>댓글</h3>
                    <c:if test="${not empty sessionScope.loginUser}">
                        <form id="commentForm" method="post" action="addComment">
                            <input type="hidden" name="hotdealId" value="${deal.id}" />
                            <textarea name="content" rows="3" required placeholder="댓글을 입력하세요"></textarea>
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
        </div>

        <%@ include file="bestPosts.jsp" %>
    </div>

<script>
function vote(type) {
    $.post("vote", {id: "${deal.id}", type: type}, function(res) {
        if(res.result === "success") {
            $("#likes-count").text(res.likes);
            $("#dislikes-count").text(res.dislikes);
            $("#vote-msg").text("투표가 반영되었습니다!").show().delay(2000).fadeOut();
        } else {
            $("#vote-msg").text(res.result).show().delay(2000).fadeOut();
        }
    }, "json");
}

$(function() {
    $("#commentForm").submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: "addComment",
            type: "POST",
            data: $(this).serialize(),
            success: function(res) {
                $("#comment-list").load(location.href + " #comment-list>*");
                $("#commentForm textarea").val("");
            },
            error: function() {
                alert("댓글 등록에 실패했습니다.");
            }
        });
    });

    $(document).on("click", ".reply-toggle-btn", function() {
        var targetId = $(this).data("target");
        $(".replyForm").not("#" + targetId).hide();
        $("#" + targetId).toggle();
    });

    $(document).on("submit", ".replyForm", function(e) {
        e.preventDefault();
        var $form = $(this);
        $.ajax({
            url: "addComment",
            type: "POST",
            data: $form.serialize(),
            success: function(res) {
                $("#comment-list").load(location.href + " #comment-list>*");
                $form.find("textarea").val("");
                $form.hide();
            },
            error: function() {
                alert("답글 등록에 실패했습니다.");
            }
        });
    });
});
</script>
</body>
</html>
