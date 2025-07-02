<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="topMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${deal.title}</title>
    <style>
        body { background-color: #f4f6f9; margin: 0; padding: 0; }
        .layout-3col { display: flex; justify-content: center; align-items: flex-start; width: 100vw; min-height: 100vh; gap: 32px; box-sizing: border-box; }
        .ad-sidebar-left { width: 220px; min-width: 220px; max-width: 220px; border: 1px solid #e0e0e0; border-radius: 4px; background-color: #fffbe8; display: flex; align-items: center; justify-content: center; padding: 0; box-sizing: border-box; height: fit-content; position: sticky; top: 40px; z-index: 10; overflow: hidden; }
        .main-content { flex: 0 1 800px; min-width: 600px; max-width: 900px; display: flex; flex-direction: column; align-items: stretch; }
        .detail-container { background-color: #fff; border: 1px solid #dee2e6; border-radius: 8px; padding: 30px 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin: 0 auto; width: 100%; box-sizing: border-box; }
        .deal-header { border-bottom: 2px solid #343a40; padding-bottom: 15px; margin-bottom: 25px; }
        .deal-header h1 { font-size: 2em; font-weight: 600; margin: 0; color: #212529; }
        .deal-header .meta-info { margin-top: 10px; color: #6c757d; font-size: 0.9em; }
        .deal-header .meta-info span + span::before { content: "|"; margin: 0 10px; }
        .product-info-box { background-color: #f8f9fa; border: 1px solid #e9ecef; border-radius: 5px; padding: 20px; margin: 25px 0; }
        .product-info-box h3 { margin-top: 0; margin-bottom: 15px; font-size: 1.2em; color: #343a40; }
        .product-info-box p { margin: 8px 0; font-size: 1em; }
        .product-info-box a { color: #007bff; text-decoration: none; word-break: break-all; }
        .product-info-box a:hover { text-decoration: underline; }
        .deal-content { min-height: 150px; line-height: 1.7; font-size: 1.05em; color: #343a40; margin-bottom: 30px; }
        .vote-section { text-align: center; margin: 30px 0 0; }
        .vote-buttons { margin-bottom: 10px; }
        .vote-buttons .vote-btn { padding:8px 22px; margin:0 5px; border-radius:20px; border:1px solid #ccc; font-size:15px; cursor:pointer; background-color: #fff; transition: all 0.2s; }
        .vote-btn.like-btn:hover { background-color:#e7f3ff; border-color:#9ecbff;}
        .vote-btn.dislike-btn:hover { background-color:#ffe3e6; border-color:#ffb3ba;}
        .vote-msg-wrapper { height: 1.2em; }
        .vote-msg { color: #d00; font-size: 14px; visibility: hidden; }
        .comment-section-wrapper { margin-top: 40px; }
        .comment-section { width: 100%; background: #fff; border: 1px solid #dee2e6; border-radius: 8px; padding: 28px 32px; box-sizing: border-box; }
        .comment-section h3 { margin-bottom: 18px; text-align: left; }
        #commentForm textarea, .replyForm textarea { width: 100%; box-sizing:border-box; border: 1px solid #ced4da; border-radius: 4px; padding: 10px; margin-bottom: 10px; resize: none; }
        #commentForm button { float: right; }
        .comment-item { border-top: 1px solid #e9ecef; padding: 15px 0; text-align: left; position: relative; margin-bottom: 16px; min-height: 48px; padding-bottom: 8px; }
        .replyForm { display: none; margin-top: 8px; }
        .best-posts { width: 220px; min-width: 220px; max-width: 220px; border: 1px solid #e0e0e0; border-radius: 8px; padding: 16px; background-color: #fff; height: fit-content; box-shadow: 0 2px 10px rgba(0,0,0,0.05); position: sticky; top: 40px; flex-shrink: 0; }
        .best-posts h3 { margin-top: 0; font-size: 18px; border-bottom: 2px solid #007bff; padding-bottom: 8px; margin-bottom: 12px; }
        .best-posts ul { list-style: none; padding: 0; margin: 0; }
        .best-posts li { margin-bottom: 10px; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .best-posts a { text-decoration: none; color: #333; }
        .best-posts a:hover { text-decoration: underline; }
        .carousel-container { position: relative; width: 220px; height: 600px; overflow: hidden; }
        .carousel-slide { display: none; position: absolute; width: 100%; height: 100%; left: 0; top: 0; transition: opacity 0.7s; }
        .carousel-slide img { width: 100%; height: 100%; object-fit: cover; border-radius: 4px; display: block; }
        .carousel-slide.active { display: block; opacity: 1; z-index: 1; }
        .carousel-slide.inactive { opacity: 0; z-index: 0; }
        .carousel-btn { display: none; }
        .carousel-dots { position: absolute; bottom: 12px; left: 0; width: 100%; text-align: center; z-index: 3; }
        .carousel-dot { display: inline-block; width: 10px; height: 10px; margin: 0 4px; background: #ccc; border-radius: 50%; cursor: pointer; transition: background 0.2s; }
        .carousel-dot.active { background: #007bff; }
        @media (max-width: 1400px) { .layout-3col { gap: 12px; } .main-content { min-width: 400px; } .ad-sidebar-left, .best-posts { display: none; } }
        @media (max-width: 900px) { .main-content { min-width: 100vw; max-width: 100vw; padding: 0 4vw; } .detail-container, .comment-section { padding: 16px 4vw; } }
        .bottom-action-bar { display: flex; justify-content: center; align-items: center; margin-top: 20px; position: relative; }
        .bottom-action-bar .back-link { display: inline-block; color: #007bff; text-decoration: none; font-size: 15px; z-index: 1; }
        .bottom-action-bar .back-link:hover { text-decoration: underline; }
        .edit-delete-btns-bar { position: absolute; right: -30px; top: 1.5px; display: flex; gap: 5px; }
        .edit-delete-btns-bar button, .edit-delete-btns-bar .btn-info { font-size: 15px; padding: 7px 18px 7px 14px; height: 38px; min-width: 70px; box-sizing: border-box; border-radius: 4px; border: 1px solid #ccc; background-color: #fff; cursor: pointer; transition: background 0.2s; }
        .edit-delete-btns-bar button:hover, .edit-delete-btns-bar .btn-info:hover { background-color: #f4f6fa; }
        .ended-deal-msg { color: red; font-weight: bold; text-align: center; padding: 10px; border: 1px solid red; background-color: #ffe3e6; border-radius: 5px; margin-bottom: 15px; }
        .report-popup { display: none; position: absolute; background-color: #fff; border: 1px solid #ddd; border-radius: 5px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); padding: 10px 0; z-index: 1000; min-width: 150px; text-align: left; }
        .report-popup ul { list-style: none; padding: 0; margin: 0; }
        .report-popup ul li { padding: 8px 15px; cursor: pointer; color: #333; font-size: 14px; }
        .report-popup ul li:hover { background-color: #f0f0f0; }
        .comment-actions { margin-top: 5px; }
        .action-btn { font-size: 13px; padding: 2px 8px; cursor: pointer; background: none; border: 1px solid #ccc; border-radius: 4px; }
        .action-btn:hover { background-color: #f0f0f0; }
        .comment-edit-form { display: none; }
        .comment-edit-form button { font-size: 13px; padding: 2px 8px; cursor: pointer; }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
    <div class="layout-3col">
        <%@ include file="adCarousel.jsp" %>
        <div class="main-content">
            <div class="detail-container">
                <div class="deal-header">
                    <h1>
                        <c:choose>
                            <c:when test="${deal.isNotice == 'Y'}">
                                <span style="color: #28a745;">[공지]</span>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${not empty deal.product.category}">
                                    <span style="color: #007bff;">[${deal.product.category}]</span>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                        ${deal.title}
                    </h1>
                    <div class="meta-info">
                        <span>작성자: ${deal.author}</span>
                        <span>등록일: ${deal.regDate}</span>
                        <span>조회: ${deal.views}</span>
                    </div>
                </div>

                <c:if test="${deal.isNotice != 'Y'}">
                    <div class="product-info-box">
                        <div id="ended-deal-msg-box" class="ended-deal-msg" style="${deal.isEnded == 'Y' ? '' : 'display:none;'}">종료가 된 핫딜입니다</div>
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
                </c:if>
                
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
                        <div class="vote-buttons">
                            <button class="vote-btn like-btn" onclick="vote('LIKE')">👍 추천 <span id="likes-count">${deal.likes}</span></button>
                            <button class="vote-btn dislike-btn" onclick="vote('DISLIKE')">👎 비추천 <span id="dislikes-count">${deal.dislikes}</span></button>
                        </div>
                    </c:if>
                    <div class="vote-msg-wrapper">
                        <span id="vote-msg" class="vote-msg"></span>
                    </div>
                </div>
                
                <div class="bottom-action-bar">
                    <a href="list?page=1" class="back-link">← 목록으로</a>
                    <div class="edit-delete-btns-bar">
                        <c:if test="${not empty sessionScope.loginUser}">
                            <c:if test="${sessionScope.loginUser.username == deal.author}">
                                <form action="edit" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="${deal.id}">
                                    <button type="submit">수정</button>
                                </form>
                                <form action="delete" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                    <input type="hidden" name="id" value="${deal.id}">
                                    <button type="submit">삭제</button>
                                </form>
                            </c:if>
                            
                            <c:if test="${deal.isNotice != 'Y'}">
                                <button type="button" id="reportEndBtn" onclick="reportEnd()">
                                    <c:choose>
                                        <c:when test="${deal.isEnded == 'Y'}">종료신고 취소</c:when>
                                        <c:otherwise>종료신고</c:otherwise>
                                    </c:choose>
                                </button>
                                <button class="btn-info" id="reportButton">신고</button>
                                <div class="report-popup" id="reportPopup">
                                    <ul>
                                        <li onclick="selectReportType(${deal.id}, 'VIRAL_POST')">바이럴 게시글</li>
                                        <li onclick="selectReportType(${deal.id}, 'ILLEGAL_HARMFUL')">불법 유해물</li>
                                        <li onclick="selectReportType(${deal.id}, 'ADULT_CONTENT')">성인물</li>
                                        <li onclick="selectReportType(${deal.id}, 'ETC')">기타</li>
                                    </ul>
                                </div>
                            </c:if>
                        </c:if>
                    </div>
                </div>
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
var voteMsgTimer;
function vote(type) {
    $.post("vote", {id: "${deal.id}", type: type}, function(res) {
        const msgSpan = $("#vote-msg");
        let message = "";
        if(res.result === "success") {
            $("#likes-count").text(res.likes);
            $("#dislikes-count").text(res.dislikes);
            message = "투표가 반영되었습니다!";
        } else {
            message = res.result;
        }
        msgSpan.text(message).css('visibility', 'visible');
        if (voteMsgTimer) clearTimeout(voteMsgTimer);
        voteMsgTimer = setTimeout(function() {
            msgSpan.css('visibility', 'hidden');
        }, 1500);
    }, "json");
}

function reloadComments() {
    $("#comment-list").load(location.href + " #comment-list > *");
}

$(function() {
    $("#commentForm").submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: "addComment",
            type: "POST",
            data: $(this).serialize(),
            success: function() {
                reloadComments();
                $("#commentForm textarea").val("");
            },
            error: function() { alert("댓글 등록에 실패했습니다."); }
        });
    });

    $(document).on("click", ".reply-toggle-btn", function() {
        var targetId = $(this).data("target");
        $(".replyForm, .comment-edit-form").not("#" + targetId).hide();
        $("#" + targetId).toggle();
    });

    $(document).on("submit", ".replyForm", function(e) {
        var $form = $(this);
        e.preventDefault();
        $.ajax({
            url: "addComment",
            type: "POST",
            data: $form.serialize(),
            success: function() { reloadComments(); },
            error: function() { alert("답글 등록에 실패했습니다."); }
        });
    });

    $(document).on("click", ".edit-btn", function() {
        var $commentItem = $(this).closest('.comment-item');
        $commentItem.find('.comment-content-area, .comment-actions').hide();
        $commentItem.find('.comment-edit-form').show();
    });

    $(document).on("click", ".edit-cancel-btn", function() {
        var $commentItem = $(this).closest('.comment-item');
        $commentItem.find('.comment-edit-form').hide();
        $commentItem.find('.comment-content-area, .comment-actions').show();
    });
    
    $(document).on("click", ".edit-submit-btn", function() {
        var commentId = $(this).data("comment-id");
        var newContent = $(this).closest('.comment-edit-form').find('.edit-textarea').val();
        $.ajax({
            url: "updateComment",
            type: "POST",
            data: { commentId: commentId, content: newContent },
            success: function(res) {
                if(res.status === 'success') reloadComments();
                else alert(res.message);
            },
            error: function() { alert("댓글 수정 요청에 실패했습니다."); }
        });
    });

    $(document).on("click", ".delete-btn", function() {
        var commentId = $(this).data("comment-id");
        if (confirm("정말 이 댓글을 삭제하시겠습니까?")) {
            $.ajax({
                url: "deleteComment",
                type: "POST",
                data: { commentId: commentId },
                success: function(res) {
                    if(res.status === 'success') reloadComments();
                    else alert(res.message);
                },
                error: function() { alert("댓글 삭제 요청에 실패했습니다."); }
            });
        }
    });
});

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
    if(slides.length > 0) {
        dots.forEach((dot, i) => {
            dot.addEventListener('click', () => {
                showSlide(i);
                startAuto();
            });
        });
        showSlide(0);
        startAuto();
    }
});

function reportEnd() {
    var btn = document.getElementById('reportEndBtn');
    var msg = (btn.innerText.trim() === '종료신고') ? '정말 종료신고 하시겠습니까?' : '정말 종료신고를 취소하시겠습니까?';
    if (!confirm(msg)) return;

    $.post("reportEnd", { id: "${deal.id}" }, function(res) {
        if (res.status === "success") {
            $("#ended-deal-msg-box").toggle(res.isEnded === 'Y');
            $("#reportEndBtn").text(res.isEnded === 'Y' ? "종료신고 취소" : "종료신고");
        } else {
            alert(res.message);
        }
    }, "json").fail(function() {
        alert("요청 처리 중 오류가 발생했습니다.");
    });
}

document.addEventListener('DOMContentLoaded', function() {
    const reportButton = document.getElementById('reportButton');
    const reportPopup = document.getElementById('reportPopup');

    if (reportButton && reportPopup) {
        reportButton.addEventListener('click', function(event) {
            event.stopPropagation();
            if (reportPopup.style.display === 'block') {
                reportPopup.style.display = 'none';
            } else {
                const buttonRect = reportButton.getBoundingClientRect();
                reportPopup.style.left = buttonRect.left + 'px';
                reportPopup.style.top = buttonRect.bottom + 5 + 'px';
                reportPopup.style.display = 'block';
            }
        });
        document.addEventListener('click', function(event) {
            if (!reportPopup.contains(event.target)) {
                reportPopup.style.display = 'none';
            }
        });
    }
});

function selectReportType(hotdealId, reportType) {
    const reportPopup = document.getElementById('reportPopup');
    if(reportPopup) reportPopup.style.display = 'none';

    if (confirm("이 게시글을 '" + reportType + "' 유형으로 신고하시겠습니까?")) {
        $.post("reportPost", {hotdealId: hotdealId, reportType: reportType}, function(res) {
            if (res === "success") {
                alert('게시글 신고가 접수되었습니다. 감사합니다.');
                const reportButton = document.getElementById('reportButton');
                if (reportButton) {
                    reportButton.innerText = '신고됨';
                    reportButton.disabled = true;
                    reportButton.style.backgroundColor = '#e9ecef';
                    reportButton.style.cursor = 'not-allowed';
                }
            } else if (res === "not_logged_in") {
                alert("신고하려면 로그인해야 합니다.");
                window.location.href = "login";
            }
            else {
                alert('게시글 신고에 실패했습니다.');
            }
        }).fail(function() {
            alert("요청 처리 중 오류가 발생했습니다.");
        });
    }
}
</script>
</body>
</html>