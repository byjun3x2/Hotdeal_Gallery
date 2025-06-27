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
/* CSS 스타일은 이전과 동일하게 유지됩니다. */
html, body { height: 100%; margin: 0; padding: 0; }
.wrapper { min-height: 100vh; display: flex; flex-direction: column; }
main { flex: 1; }
.content-wrapper { display: flex; flex-wrap: wrap; gap: 24px; width: 95%; max-width: 1200px; margin: 40px auto; }
.hotdeal-board { flex: 3; min-width: 600px; display: flex; flex-direction: column; }
.best-posts { flex: 1; min-width: 220px; border: 1px solid #e0e0e0; border-radius: 4px; padding: 16px; background-color: #fdfdfd; height: fit-content; }
@media (max-width: 992px) {
	.content-wrapper { flex-direction: column; width: 90%; }
	.hotdeal-board, .best-posts { min-width: 100%; flex: none; width: 100%; }
}
.hotdeal-board table { width: 100%; border-collapse: collapse; }
.hotdeal-board th, .hotdeal-board td { border: 1px solid #e0e0e0; padding: 8px; text-align: left; height: 70px; vertical-align: middle; }
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
.search-box { text-align: right; margin-bottom: 16px; }
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
</style>
</head>
<body>
	<div class="wrapper">
		<%@ include file="topMenu.jsp"%>
		<main>
			<div class="content-wrapper">
				<div class="hotdeal-board">
					<form method="get" action="list" class="search-box">
						<input type="text" name="keyword" value="${keyword}"
							placeholder="제목 검색">
						<button type="submit">검색</button>
						<input type="hidden" name="page" value="1" />
					</form>
					<table>
						<thead>
							<tr>
								<th style="width: 8%;">번호</th>
								<th style="width: 10%;">이미지</th>
								<th>제목</th>
								<th style="width: 12%;">작성자</th>
								<th style="width: 12%;">등록일</th>
								<th style="width: 8%;">조회</th>
								<th style="width: 8%;">추천</th>
								<th style="width: 8%;">비추천</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty hotdealList}">
									<c:forEach var="deal" items="${hotdealList}">
										<tr>
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
													<span> | 배송료 ${deal.product.deliveryFee}</span>
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

					<div class="pagination-row">
						<div class="pagination-center">
							<div class="pagination">
								<c:set var="lastPage"
									value="${(totalCount/perPageNum) + (totalCount%perPageNum > 0 ? 1 : 0)}" />
								<c:if test="${page > 1}">
									<a href="list?page=${page-1}&keyword=${keyword}">이전</a>
								</c:if>
								<c:forEach begin="1" end="${lastPage}" var="i">
									<c:choose>
										<c:when test="${page == i}">
											<span class="current">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="list?page=${i}&keyword=${keyword}">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${page < lastPage}">
									<a href="list?page=${page+1}&keyword=${keyword}">다음</a>
								</c:if>
							</div>
						</div>
						<div>
							<c:if test="${not empty sessionScope.loginUser}">
								<a href="write" class="write-btn">새글등록</a>
							</c:if>
						</div>
					</div>
				</div>

				<%-- bestPosts.jsp 파일을 여기에 포함시킵니다 --%>
				<%@ include file="bestPosts.jsp" %>
				
			</div>
		</main>
		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>
