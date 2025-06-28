<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>핫딜 게시판</title>
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
/* 광고 캐러셀 사이드바 */
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
/* 화살표 숨김 */
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
@media (max-width: 1650px) {
	.ad-sidebar-left { display: none; }
}
@media (max-width: 1350px) {
	.best-posts { display: none; }
	.layout-anchor { width: 90%; }
}
.best-posts {
	position: absolute;
	top: 0;
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
.hotdeal-board table { width: 100%; border-collapse: collapse; }
.hotdeal-board th, .hotdeal-board td { border: 1px solid #e0e0e0; padding: 8px; text-align: left; height: 70px; vertical-align: middle; }
.hotdeal-board tbody tr:hover { background-color: #f8f9fa; cursor: pointer; }
.hotdeal-board th { background-color: #f8f8f8; font-weight: bold; text-align: center; }
.hotdeal-board img { width: 60px; height: 60px; object-fit: cover; border-radius: 4px; display: block; margin: 0 auto; }
.hotdeal-board a { color: #0056b3; text-decoration: none; }
.hotdeal-board a:hover { text-decoration: underline; }
.pagination-row { margin-top: 20px; display: flex; align-items: center; justify-content: space-between; }
.pagination-center { display: flex; justify-content: center; flex: 1; }
.pagination { display: flex; align-items: center; }
.pagination a, .pagination span { display: inline-block; padding: 6px 12px; margin: 0 2px; border: 1px solid #ddd; color: #333; text-decoration: none; }
.pagination .current { background: #007bff; color: #fff; font-weight: bold; border: 1px solid #007bff; }
.write-btn { padding: 8px 18px; background: #007bff; color: #fff; border-radius: 4px; text-decoration: none; font-weight: bold; font-size: 15px; }
.write-btn:hover { background: #0056b3; }
.search-box { text-align: right; }
.search-box input[type="text"] { padding: 5px; width: 200px; }
.search-box button { padding: 5px 10px; }
.best-posts h3 { margin-top: 0; font-size: 18px; border-bottom: 2px solid #007bff; padding-bottom: 8px; margin-bottom: 12px; }
.best-posts ul { list-style: none; padding: 0; margin: 0; }
.best-posts li { margin-bottom: 10px; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.best-posts a { text-decoration: none; color: #333; }
.best-posts a:hover { text-decoration: underline; }
.deal-title-cell { text-align: left; padding-left: 15px !important; }
.deal-title-link { font-weight: bold; font-size: 1.1em; color: #333; text-decoration: none; }
.deal-title-link:hover { text-decoration: underline; }
.deal-title-link .category { color: #0056b3; }
.deal-meta-info { font-size: 0.9em; color: #666; margin-top: 6px; }
.deal-meta-info .price { font-weight: bold; color: #d9534f; }
/* [ADD] 카테고리 필터 스타일 */
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
</style>
</head>
<body>
	<div class="wrapper">
		<%@ include file="topMenu.jsp"%>
		<main>
			<div class="layout-anchor">

				<%@ include file="adCarousel.jsp" %>
				<div class="hotdeal-board" id="hotdealBoard">

                    <!-- [ADD] 카테고리 필터 UI -->
                    <div class="category-filter">
                        <a href="list?page=1&keyword=${keyword}" class="${empty selectedCategory ? 'active' : ''}">전체</a>
                        <c:forEach var="cat" items="${categoryList}">
                            <a href="list?category=${cat}&page=1&keyword=${keyword}" class="${cat == selectedCategory ? 'active' : ''}">
                                ${cat}
                            </a>
                        </c:forEach>
                    </div>

					<table id="hotdealTable">
						<thead>
							<tr>
								<th style="width: 5%;">번호</th>
								<th style="width: 8%;">이미지</th>
								<th>제목</th>
								<th style="width: 9%;">작성자</th>
								<th style="width: 9%;">등록일</th>
								<th style="width: 6%;">조회</th>
								<th style="width: 6%;">추천</th>
								<th style="width: 6%;">비추천</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty hotdealList}">
									<c:forEach var="deal" items="${hotdealList}">
										<tr onclick="location.href='detail?id=${deal.id}'">
											<td style="text-align: center;">${deal.id}</td>
											<td>
												<c:if test="${not empty deal.thumbnail}">
													<img src="${deal.thumbnail}" alt="썸네일">
												</c:if>
											</td>
											<td class="deal-title-cell">
												<div>
													<a href="detail?id=${deal.id}" class="deal-title-link">
														<span class="category">[${deal.product.category}]</span> ${deal.title}
													</a>
												</div>
												<div class="deal-meta-info">
													가격  <span class="price"><fmt:formatNumber value="${deal.product.price}" pattern="#,###" />원</span>
													<span> | 배송료 
                                                        <c:choose>
                                                            <c:when test="${deal.product.deliveryFee == '0' || empty deal.product.deliveryFee}">무료</c:when>
                                                            <c:otherwise>${deal.product.deliveryFee}</c:otherwise>
                                                        </c:choose>
                                                    </span>
													<span> | ${deal.product.shopName}</span>
												</div>
											</td>
											<td style="text-align: center;">${deal.author}</td>
											<td style="text-align: center;">${fn:substring(deal.regDate, 0, 10)}</td>
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

                    <!-- [MOVE] 검색창 위치 이동 및 페이지네이션/글쓰기 버튼과 함께配置 -->
					<div class="pagination-row">
						<div class="pagination-center">
							<div class="pagination">
								<c:set var="lastPage" value="${(totalCount + perPageNum - 1) / perPageNum}" />
								<c:if test="${page > 1}">
									<a href="list?page=${page-1}&keyword=${keyword}&category=${selectedCategory}">이전</a>
								</c:if>
								<c:forEach begin="1" end="${lastPage}" var="i">
									<c:choose>
										<c:when test="${page == i}">
											<span class="current">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="list?page=${i}&keyword=${keyword}&category=${selectedCategory}">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${page < lastPage}">
									<a href="list?page=${page+1}&keyword=${keyword}&category=${selectedCategory}">다음</a>
								</c:if>
							</div>
						</div>
                        <div style="display: flex; align-items: center; gap: 10px;">
                            <!-- [MOVE] 검색창 -->
						    <form method="get" action="list" class="search-box">
						    	<input type="text" name="keyword" value="${keyword}" placeholder="제목 검색">
						    	<button type="submit">검색</button>
						    	<input type="hidden" name="page" value="1" />
                                <!-- [ADD] 검색 시 현재 카테고리 유지 -->
                                <input type="hidden" name="category" value="${selectedCategory}" />
						    </form>
                            <!-- 글쓰기 버튼 -->
						    <c:if test="${not empty sessionScope.loginUser}">
						    	<a href="write" class="write-btn">새글등록</a>
						    </c:if>
                        </div>
					</div>
				</div>

				<%@ include file="bestPosts.jsp" %>
			</div>
		</main>
		<%@ include file="footer.jsp"%>
	</div>
	<script>
	window.addEventListener("DOMContentLoaded", function() {
		// 광고 캐러셀
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
			timer = setInterval(nextSlide, 10000); // 10초마다 자동 전환
		}
		dots.forEach((dot, i) => {
			dot.addEventListener('click', () => {
				showSlide(i);
				startAuto();
			});
		});
		showSlide(0);
		startAuto();

		// 광고 스크롤 동기화
		const adSidebar = document.getElementById('adSidebar');
		const table = document.getElementById('hotdealTable');
		const anchor = document.querySelector('.layout-anchor');

		let lastScrollY = window.scrollY;

		function clamp(val, min, max) {
			return Math.max(min, Math.min(max, val));
		}

		function getTableBounds() {
			const tableRect = table.getBoundingClientRect();
			const anchorRect = anchor.getBoundingClientRect();
			const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
			const tableTop = tableRect.top + scrollTop;
			const tableHeight = table.offsetHeight;
			const adHeight = adSidebar.offsetHeight;
			const anchorTop = anchorRect.top + scrollTop;
			const anchorHeight = anchor.offsetHeight;
			return {
				tableTop,
				tableHeight,
				adHeight,
				anchorTop,
				anchorHeight
			};
		}

		// 광고의 top 위치 상태
		let adTop = 0;

		function updateAdPositionByScroll(deltaY) {
			const { tableTop, tableHeight, adHeight, anchorTop, anchorHeight } = getTableBounds();
			const minTop = tableTop - anchorTop;
			const maxTop = tableTop + tableHeight - adHeight - anchorTop;

			adTop += deltaY;
			adTop = clamp(adTop, minTop, maxTop);

			adSidebar.style.top = adTop + "px";
		}

		function setAdInitialPosition() {
			const { tableTop, tableHeight, adHeight, anchorTop, anchorHeight } = getTableBounds();
			adTop = tableTop - anchorTop; // ★ 테이블 상단 경계선에 맞춤
			const minTop = tableTop - anchorTop;
			const maxTop = tableTop + tableHeight - adHeight - anchorTop;
			adTop = clamp(adTop, minTop, maxTop);
			adSidebar.style.top = adTop + "px";
		}

		setAdInitialPosition();

		let ticking = false;
		window.addEventListener('scroll', function(e) {
			const nowScrollY = window.scrollY;
			const deltaY = nowScrollY - lastScrollY;
			lastScrollY = nowScrollY;

			if (!ticking) {
				window.requestAnimationFrame(function() {
					updateAdPositionByScroll(deltaY);
					updateBestPositionByScroll(deltaY); // 베스트 게시글도 같이 동기화
					ticking = false;
				});
				ticking = true;
			}
		});
		window.addEventListener('resize', function() {
			setAdInitialPosition();
			setBestInitialPosition();
		});

		// === [베스트 게시글 사이드바 스크롤 연동] ===
		const bestSidebar = document.querySelector('.best-posts');

		function getBestTableBounds() {
			const tableRect = table.getBoundingClientRect();
			const anchorRect = anchor.getBoundingClientRect();
			const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
			const tableTop = tableRect.top + scrollTop;
			const tableHeight = table.offsetHeight;
			const bestHeight = bestSidebar.offsetHeight;
			const anchorTop = anchorRect.top + scrollTop;
			const anchorHeight = anchor.offsetHeight;
			return {
				tableTop,
				tableHeight,
				bestHeight,
				anchorTop,
				anchorHeight
			};
		}

		let bestTop = 0;

		function updateBestPositionByScroll(deltaY) {
			if (!bestSidebar) return;
			const { tableTop, tableHeight, bestHeight, anchorTop, anchorHeight } = getBestTableBounds();
			const minTop = tableTop - anchorTop;
			const maxTop = tableTop + tableHeight - bestHeight - anchorTop;

			bestTop += deltaY;
			bestTop = clamp(bestTop, minTop, maxTop);

			bestSidebar.style.top = bestTop + "px";
		}

		function setBestInitialPosition() {
			if (!bestSidebar) return;
			const { tableTop, tableHeight, bestHeight, anchorTop, anchorHeight } = getBestTableBounds();
			bestTop = tableTop - anchorTop; // ★ 테이블 상단 경계선에 맞춤
			const minTop = tableTop - anchorTop;
			const maxTop = tableTop + tableHeight - bestHeight - anchorTop;
			bestTop = clamp(bestTop, minTop, maxTop);
			bestSidebar.style.top = bestTop + "px";
		}

		setBestInitialPosition();
	});
	</script>
</body>
</html>
