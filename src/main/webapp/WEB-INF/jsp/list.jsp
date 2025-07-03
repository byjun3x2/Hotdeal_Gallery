<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>핫딜 갤러리</title>
<link rel="shortcut icon" href="<c:url value='/resources/favicon.ico'/>"
	type="image/x-icon" />
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	background-color: #f4f6f9;
}

.wrapper {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

main {
	flex: 1 0 auto;
	padding-top: 40px;
}

.layout-anchor {
	position: relative;
	width: 1000px;
	margin: 0 auto;
}

.ad-sidebar-left {
	position: absolute;
	left: -244px;
	width: 220px;
	min-height: 600px;
	border: 1px solid #e0e0e0;
	border-radius: 4px;
	background-color: #fffbe8;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0;
	box-sizing: border-box;
	z-index: 10;
	transition: top 0.25s;
	overflow: hidden;
}

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

.carousel-btn {
	display: none;
}

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

@media ( max-width : 1650px) {
	.ad-sidebar-left {
		display: none;
	}
}

@media ( max-width : 1350px) {
	.best-posts {
		display: none;
	}
	.layout-anchor {
		width: 90%;
	}
}

.best-posts {
	position: absolute;
	top: 66px;
	left: 100%;
	margin-left: 24px;
	width: 240px;
	border: 1px solid #e0e0e0;
	border-radius: 4px;
	padding: 16px;
	background-color: #fdfdfd;
	height: fit-content;
}

.hotdeal-board {
	width: 100%;
	display: flex;
	flex-direction: column;
}

.hotdeal-board table {
	width: 100%;
	border-collapse: collapse;
}

.hotdeal-board th, .hotdeal-board td {
	border: 1px solid #e0e0e0;
	padding: 8px;
	text-align: left;
	height: 70px;
	vertical-align: middle;
}

.hotdeal-board tbody tr:hover {
	background-color: #f8f9fa;
	cursor: pointer;
}

.hotdeal-board th {
	background-color: #f8f8f8;
	font-weight: bold;
	text-align: center;
}

.hotdeal-board img {
	width: 60px;
	height: 60px;
	object-fit: cover;
	border-radius: 4px;
	display: block;
	margin: 0 auto;
}

.hotdeal-board a {
	text-decoration: none;
}

.hotdeal-board a:hover {
	text-decoration: underline;
}

.write-btn-container {
	text-align: right;
	margin-top: 15px;
	min-height: 33px;
}

.search-container {
	text-align: center;
	margin: 15px 0;
}

.search-box {
	display: inline-block;
}

.search-box input[type="text"] {
	padding: 5px;
	width: 200px;
}

.search-box button {
	padding: 5px 10px;
}

.pagination-container {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 10px;
}

.pagination {
	display: flex;
	align-items: center;
}

.pagination a, .pagination span {
	display: inline-block;
	padding: 6px 12px;
	margin: 0 2px;
	border: 1px solid #ddd;
	color: #333;
	text-decoration: none;
}

.pagination .current {
	background: #007bff;
	color: #fff;
	font-weight: bold;
	border: 1px solid #007bff;
}

.write-btn {
	padding: 8px 18px;
	background: #007bff;
	color: #fff;
	border-radius: 4px;
	text-decoration: none;
	font-weight: bold;
	font-size: 15px;
}

.write-btn:hover {
	background: #0056b3;
}

.best-posts h3 {
	margin-top: 0;
	font-size: 18px;
	border-bottom: 2px solid #007bff;
	padding-bottom: 8px;
	margin-bottom: 12px;
}

.best-posts ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.best-posts li {
	margin-bottom: 10px;
	font-size: 14px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.best-posts a {
	text-decoration: none;
	color: #333;
}

.best-posts a:hover {
	text-decoration: underline;
}

.deal-title-cell {
	text-align: left;
	padding-left: 15px !important;
}

.deal-title-link {
	font-weight: bold;
	font-size: 1.1em;
	color: #333;
	text-decoration: none;
}

.deal-title-link:hover {
	text-decoration: underline;
}

.deal-title-link .category {
	color: #0056b3;
}

.deal-meta-info {
	font-size: 0.9em;
	color: #666;
	margin-top: 6px;
}

.deal-meta-info .price {
	font-weight: bold;
	color: #d9534f;
}

.category-filter {
	margin-bottom: 16px;
	padding: 10px;
	background-color: #fff;
	border: 1px solid #e0e0e0;
	border-radius: 4px;
	display: flex;
	gap: 12px;
	flex-wrap: wrap;
	align-items: center;
}

.category-filter a {
	padding: 5px 10px;
	text-decoration: none;
	color: #333;
	border-radius: 15px;
	background-color: #f1f1f1;
	font-size: 14px;
	transition: all 0.2s;
}

.category-filter a:hover {
	background-color: #e0e0e0;
}

.category-filter a.active {
	background-color: #007bff;
	color: #fff;
	font-weight: bold;
}

.deal-title-link.deal-ended {
	color: #888;
	text-decoration: line-through;
	text-decoration-color: black;
	text-decoration-thickness: 2px;
}

.comment-count {
	display: inline-block;
	margin-left: 8px;
	font-size: 0.95em;
	color: #007bff;
	font-weight: normal;
}

.table-header-row th {
	height: 28px !important;
	padding-top: 4px !important;
	padding-bottom: 4px !important;
}

.hotdeal-board th {
	position: relative;
}

.sort-arrows {
	position: absolute;
	right: 8px;
	top: 50%;
	transform: translateY(-50%);
	display: flex;
	flex-direction: column;
}

.sort-arrows a {
	line-height: 0.8;
	padding: 2px 0;
	font-size: 10px;
}

.sort-arrow {
	text-decoration: none;
	color: #aaa;
}

.sort-arrow.active {
	color: #007bff;
	font-weight: bold;
}

.notice-board {
	background-color: #fff;
	border: 1px solid #e0e0e0;
	border-radius: 4px;
	margin-bottom: 16px;
	padding: 0 15px;
	overflow: hidden;
	height: 43px
}

.notice-carousel-wrapper {
	position: relative;
	height: 180px;
	overflow: hidden;
}

.notice-carousel-track {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
}

.notice-item {
	display: flex;
	align-items: center;
	height: 45px;
	color: #333;
}

.notice-item:hover {
	background-color: #f8f9fa;
}

.notice-tag {
	background-color: #28a745;
	color: white;
	padding: 3px 8px;
	border-radius: 4px;
	font-size: 0.8em;
	font-weight: bold;
	margin-right: 10px;
}

.notice-title {
	font-size: 15px;
	font-weight: 500;
}
</style>
</head>
<body>
	<div class="wrapper">
		<%@ include file="topMenu.jsp"%>
		<main>
			<div class="layout-anchor">
				<%@ include file="adCarousel.jsp"%>
				<div class="hotdeal-board" id="hotdealBoard">
					<div class="category-filter">
						<a
							href="list?page=1&keyword=${keyword}&sortColumn=${sortColumn}&sortOrder=${sortOrder}"
							class="${empty selectedCategory ? 'active' : ''}">전체</a>
						<c:forEach var="cat" items="${categoryList}">
							<a
								href="list?category=${cat}&page=1&keyword=${keyword}&sortColumn=${sortColumn}&sortOrder=${sortOrder}"
								class="${cat == selectedCategory ? 'active' : ''}">${cat}</a>
						</c:forEach>
					</div>

					<c:if test="${not empty noticeList}">
						<div class="notice-board">
							<div class="notice-carousel-wrapper">
								<div class="notice-carousel-track">
									<c:forEach var="notice" items="${noticeList}">
										<a href="detail?id=${notice.id}" class="notice-item">
											<div class="notice-tag">공지</div>
											<div class="notice-title">${notice.title}</div>
										</a>
									</c:forEach>
								</div>
							</div>
						</div>
					</c:if>

					<table id="hotdealTable">
						<thead>
							<tr class="table-header-row">
								<th style="width: 9%;">글번호 <span class="sort-arrows">
										<a
										href="list?page=1&keyword=${keyword}&category=${selectedCategory}&sortColumn=regDate&sortOrder=asc"
										class="sort-arrow ${sortColumn == 'regDate' && sortOrder == 'asc' ? 'active' : ''}">▲</a>
										<a
										href="list?page=1&keyword=${keyword}&category=${selectedCategory}&sortColumn=regDate&sortOrder=desc"
										class="sort-arrow ${sortColumn == 'regDate' && sortOrder == 'desc' ? 'active' : ''}">▼</a>
								</span>
								</th>
								<th style="width: 9%;">이미지</th>
								<th>글제목</th>
								<th style="width: 9%;">작성자</th>
								<th style="width: 9%;">등록일</th>
								<th style="width: 9%;">조회수 <span class="sort-arrows">
										<a
										href="list?page=1&keyword=${keyword}&category=${selectedCategory}&sortColumn=views&sortOrder=asc"
										class="sort-arrow ${sortColumn == 'views' && sortOrder == 'asc' ? 'active' : ''}">▲</a>
										<a
										href="list?page=1&keyword=${keyword}&category=${selectedCategory}&sortColumn=views&sortOrder=desc"
										class="sort-arrow ${sortColumn == 'views' && sortOrder == 'desc' ? 'active' : ''}">▼</a>
								</span>
								</th>
								<th style="width: 9%;">추천 <span class="sort-arrows">
										<a
										href="list?page=1&keyword=${keyword}&category=${selectedCategory}&sortColumn=likes&sortOrder=asc"
										class="sort-arrow ${sortColumn == 'likes' && sortOrder == 'asc' ? 'active' : ''}">▲</a>
										<a
										href="list?page=1&keyword=${keyword}&category=${selectedCategory}&sortColumn=likes&sortOrder=desc"
										class="sort-arrow ${sortColumn == 'likes' && sortOrder == 'desc' ? 'active' : ''}">▼</a>
								</span>
								</th>
								<th style="width: 9%;">비추천</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty hotdealList}">
									<c:forEach var="deal" items="${hotdealList}">
										<tr onclick="location.href='detail?id=${deal.id}'">
											<td style="text-align: center;">${deal.id}</td>
											<td><c:if test="${not empty deal.thumbnail}">
													<img src="${deal.thumbnail}" alt="썸네일">
												</c:if></td>
											<td class="deal-title-cell">
												<div>
													<a href="detail?id=${deal.id}"
														class="deal-title-link ${deal.isEnded == 'Y' ? 'deal-ended' : ''}">
														<span class="category">[${deal.product.category}]</span>
														${deal.title}
													</a>
													<c:if test="${deal.commentCount > 0}">
														<span class="comment-count">💬 ${deal.commentCount}</span>
													</c:if>
												</div>
												<div class="deal-meta-info">
													가격 <span class="price"><fmt:formatNumber
															value="${deal.product.price}" pattern="#,###" />원</span> <span>
														| 배송료 <c:choose>
															<c:when
																test="${deal.product.deliveryFee == '0' || empty deal.product.deliveryFee}">무료</c:when>
															<c:otherwise>
																<fmt:formatNumber value="${deal.product.deliveryFee}"
																	pattern="#,###" />원</c:otherwise>
														</c:choose>
													</span> <span> | ${deal.product.shopName}</span>
												</div>
											</td>
											<td style="text-align: center;">${deal.author}</td>
											<td style="text-align: center;"><fmt:parseDate
													value="${deal.regDate}" var="regDateObj"
													pattern="yyyy-MM-dd HH:mm:ss" />
												<fmt:formatDate value="${regDateObj}" pattern="yyyy.MM.dd" /></td>
											<td style="text-align: center;">${deal.views}</td>
											<td style="text-align: center;">${deal.likes}</td>
											<td style="text-align: center;">${deal.dislikes}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="8" style="text-align: center;">등록된 핫딜이 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="write-btn-container">
						<c:if test="${not empty sessionScope.loginUser}">
							<a href="write" class="write-btn">새글등록</a>
						</c:if>
					</div>
					<div class="search-container">
						<form method="get" action="list" class="search-box">
							<input type="text" name="keyword" value="${keyword}"
								placeholder="제목 검색">
							<button type="submit">검색</button>
							<input type="hidden" name="page" value="1" /> <input
								type="hidden" name="category" value="${selectedCategory}" /> <input
								type="hidden" name="sortColumn" value="${sortColumn}" /> <input
								type="hidden" name="sortOrder" value="${sortOrder}" />
						</form>
					</div>
					<div class="pagination-container">
						<div class="pagination">
							<c:set var="lastPage"
								value="${(totalCount + criteria.perPageNum - 1) / criteria.perPageNum}" />
							<c:if test="${criteria.page > 1}">
								<a
									href="list?page=${criteria.page-1}&keyword=${keyword}&category=${selectedCategory}&sortColumn=${sortColumn}&sortOrder=${sortOrder}">이전</a>
							</c:if>
							<c:forEach begin="1" end="${lastPage}" var="i">
								<c:choose>
									<c:when test="${criteria.page == i}">
										<span class="current">${i}</span>
									</c:when>
									<c:otherwise>
										<a
											href="list?page=${i}&keyword=${keyword}&category=${selectedCategory}&sortColumn=${sortColumn}&sortOrder=${sortOrder}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${criteria.page < lastPage}">
								<a
									href="list?page=${criteria.page+1}&keyword=${keyword}&category=${selectedCategory}&sortColumn=${sortColumn}&sortOrder=${sortOrder}">다음</a>
							</c:if>
						</div>
					</div>
				</div>
				<%@ include file="bestPosts.jsp"%>
			</div>
		</main>
		<%@ include file="footer.jsp"%>
	</div>
	<script>
window.addEventListener("DOMContentLoaded", function() {

    const ad_slides = document.querySelectorAll('.carousel-slide');
    const ad_dots = document.querySelectorAll('.carousel-dot');
    if (ad_slides.length > 0) {
        let ad_current = 0;
        let ad_timer = null;

        function showAdSlide(idx) {
            ad_slides.forEach((slide, i) => {
                slide.classList.remove('active', 'inactive');
                if (i === idx) slide.classList.add('active');
                else slide.classList.add('inactive');
            });
            ad_dots.forEach((dot, i) => dot.classList.toggle('active', i === idx));
            ad_current = idx;
        }

        function nextAdSlide() {
            let next = (ad_current + 1) % ad_slides.length;
            showAdSlide(next);
        }

        function startAdAuto() {
            if (ad_timer) clearInterval(ad_timer);
            ad_timer = setInterval(nextAdSlide, 10000);
        }

        ad_dots.forEach((dot, i) => {
            dot.addEventListener('click', () => {
                showAdSlide(i);
                startAdAuto();
            });
        });
        showAdSlide(0);
        startAdAuto();
    }

    const noticeWrapper = document.querySelector('.notice-carousel-wrapper');
    if (noticeWrapper) {
        const track = noticeWrapper.querySelector('.notice-carousel-track');
        const items = track.querySelectorAll('.notice-item');

        if (items.length > 1) {
            const itemHeight = 45;
            let currentIndex = 0;

            track.appendChild(items[0].cloneNode(true));
            const totalItems = items.length; 
            setInterval(() => {
                currentIndex++;
                track.style.transform = `translateY(-${itemHeight * currentIndex}px)`;

                if (currentIndex === totalItems) {

                    setTimeout(() => {
                        track.style.transition = 'none';
                        currentIndex = 0;
                        track.style.transform = 'translateY(30)';

                        setTimeout(() => {
                            track.style.transition = 'transform 0.5s ease-in-out';
                        }, 50);

                    }, 500);
                }
            }, 3000);
        }
    }

    const adSidebar = document.getElementById('adSidebar');
    const bestSidebar = document.querySelector('.best-posts');
    const table = document.getElementById('hotdealTable');
    const anchor = document.querySelector('.layout-anchor');

    if (!adSidebar && !bestSidebar) return;

    let lastScrollY = window.scrollY;
    let adTop = 0;
    let bestTop = 0;
    let ticking = false;

    function clamp(val, min, max) {
        return Math.max(min, Math.min(max, val));
    }

    function getBounds() {
        if (!table || !anchor) return null;
        const tableRect = table.getBoundingClientRect();
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        return {
            tableTop: tableRect.top + scrollTop,
            tableHeight: table.offsetHeight,
            adHeight: adSidebar ? adSidebar.offsetHeight : 0,
            bestHeight: bestSidebar ? bestSidebar.offsetHeight : 0,
            anchorTop: anchor.getBoundingClientRect().top + scrollTop
        };
    }
    
    function updatePositions(deltaY) {
        const bounds = getBounds();
        if (!bounds) return;

        if (adSidebar) {
            const minAdTop = bounds.tableTop - bounds.anchorTop;
            const maxAdTop = bounds.tableTop + bounds.tableHeight - bounds.adHeight - bounds.anchorTop;
            adTop += deltaY;
            adTop = clamp(adTop, minAdTop, maxAdTop);
            adSidebar.style.top = adTop + "px";
        }
        if (bestSidebar) {
            const minBestTop = bounds.tableTop - bounds.anchorTop;
            const maxBestTop = bounds.tableTop + bounds.tableHeight - bounds.bestHeight - bounds.anchorTop;
            bestTop += deltaY;
            bestTop = clamp(bestTop, minBestTop, maxBestTop);
            bestSidebar.style.top = bestTop + "px";
        }
    }
    
    function setInitialPositions() {
        const bounds = getBounds();
        if (!bounds) return;

        if (adSidebar) {
            adTop = clamp(bounds.tableTop - bounds.anchorTop, 0, Infinity);
            adSidebar.style.top = adTop + "px";
        }
        if (bestSidebar) {
            bestTop = clamp(bounds.tableTop - bounds.anchorTop, 0, Infinity);
            bestSidebar.style.top = bestTop + "px";
        }
    }

    setInitialPositions();

    window.addEventListener('scroll', function() {
        const nowScrollY = window.scrollY;
        const deltaY = nowScrollY - lastScrollY;
        lastScrollY = nowScrollY;

        if (!ticking) {
            window.requestAnimationFrame(function() {
                updatePositions(deltaY);
                ticking = false;
            });
            ticking = true;
        }
    });
    
    window.addEventListener('resize', setInitialPositions);
});
</script>
</body>
</html>
