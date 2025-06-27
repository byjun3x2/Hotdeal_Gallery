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
        body {
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }
        .layout-3col {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            width: 100vw;
            min-height: 100vh;
            gap: 32px;
            margin-top: 32px; /* 원하는 만큼 조정 */
            box-sizing: border-box;
        }
        .ad-sidebar-left {
            width: 220px;
            min-width: 220px;
            max-width: 220px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            background-color: #fffbe8;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0;
            box-sizing: border-box;
            height: fit-content;
            position: sticky;
            top: 40px;
            z-index: 10;
            overflow: hidden;
        }
        .main-content {
            flex: 0 1 800px;
            min-width: 600px;
            max-width: 900px;
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
        .detail-container {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 30px 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin: 0 auto;
        }
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
        .product-info-box a {
            color: #007bff;
            text-decoration: none;
            word-break: break-all;
        }
        .product-info-box a:hover {
            text-decoration: underline;
        }
        .deal-content {
            min-height: 150px;
            line-height: 1.7;
            font-size: 1.05em;
            color: #343a40;
            margin-bottom: 30px;
        }
        .vote-section { text-align: center; margin: 30px 0; }
        .vote-btn { padding:8px 22px; margin:0 10px; border-radius:20px; border:1px solid #ccc; font-size:15px; cursor:pointer; background-color: #fff; transition: all 0.2s; }
        .vote-btn.like-btn:hover { background-color:#e7f3ff; border-color:#9ecbff;}
        .vote-btn.dislike-btn:hover { background-color:#ffe3e6; border-color:#ffb3ba;}
        .vote-msg { color:#d00; font-size:14px; margin-top:10px; display: block; height: 1em;}
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
        .best-posts {
            width: 220px;
            min-width: 220px;
            max-width: 220px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 16px;
            background-color: #fff;
            height: fit-content;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 40px;
            flex-shrink: 0;
        }
        .best-posts h3 { margin-top: 0; font-size: 18px; border-bottom: 2px solid #007bff; padding-bottom: 8px; margin-bottom: 12px; }
        .best-posts ul { list-style: none; padding: 0; margin: 0; }
        .best-posts li { margin-bottom: 10px; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .best-posts a { text-decoration: none; color: #333; }
        .best-posts a:hover { text-decoration: underline; }
        .back-link { display: inline-block; margin-top: 20px; color: #007bff; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
        /* 광고 캐러셀 스타일 */
        .carousel-container {
            position: relative;
            width: 220px;
            height: 600px;
            overflow: hidden;
        }
        .carousel-slide {
            display: none;
            position: absolute;
            width: 100%;
            height: 100%;
            left: 0;
            top: 0;
            transition: opacity 0.7s;
        }
        .carousel-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 4px;
            display: block;
        }
        .carousel-slide.active {
            display: block;
            opacity: 1;
            z-index: 1;
        }
        .carousel-slide.inactive {
            opacity: 0;
            z-index: 0;
        }
        .carousel-btn { display: none; }
        .carousel-dots {
            position: absolute;
            bottom: 12px;
            left: 0;
            width: 100%;
            text-align: center;
            z-index: 3;
        }
        .carousel-dot {
            display: inline-block;
            width: 10px;
            height: 10px;
            margin: 0 4px;
            background: #ccc;
            border-radius: 50%;
            cursor: pointer;
            transition: background 0.2s;
        }
        .carousel-dot.active {
            background: #007bff;
        }
        @media (max-width: 1400px) {
            .layout-3col { gap: 12px; }
            .main-content { min-width: 400px; }
            .ad-sidebar-left, .best-posts { display: none; }
        }
        @media (max-width: 900px) {
            .main-content { min-width: 100vw; max-width: 100vw; padding: 0 4vw; }
            .detail-container, .comment-section { padding: 16px 4vw; }
        }
        
        #commentForm textarea {
    		resize: none;
		}
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
    <%@ include file="topMenu.jsp" %>
    <div class="layout-3col">
        <%@ include file="adCarousel.jsp" %>
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
                    <p>
                        <strong>상품페이지 링크 :</strong>
                        <c:choose>
                            <c:when test="${not empty deal.product.relatedUrl}">
                                <a href="${deal.product.relatedUrl}" target="_blank">${deal.product.relatedUrl}</a>
                            </c:when>
                            <c:otherwise>
                                <span>없음</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
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
/* 광고 캐러셀 */
window.addEventListener("DOMContentLoaded", function() {
    const slides = document.querySelectorAll('.carousel-slide');
    const dots = document.querySelectorAll('.carousel-dot');
    let current = 0;
    let timer = null;
    function showSlide(idx) {
        slides.forEach((slide, i) => {
            slide.classList.remove('active', 'inactive');
            if (i === idx) slide.classList.add('active');
            else slide.classList.add('inactive');
        });
        dots.forEach((dot, i) => {
            dot.classList.toggle('active', i === idx);
        });
        current = idx;
    }
    function nextSlide() {
        let next = (current + 1) % slides.length;
        showSlide(next);
    }
    function startAuto() {
        if (timer) clearInterval(timer);
        timer = setInterval(nextSlide, 10000);
    }
    dots.forEach((dot, i) => {
        dot.addEventListener('click', () => {
            showSlide(i);
            startAuto();
        });
    });
    showSlide(0);
    startAuto();
});
</script>
</body>
</html>
