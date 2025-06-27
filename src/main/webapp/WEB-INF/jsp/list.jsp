<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핫딜 게시판</title>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

.wrapper {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

main {
	flex: 1;
	min-height: 480px;
	display: flex;
	flex-direction: column;
}

/* [수정] 게시판과 베스트글의 위치 기준이 될 래퍼 */
.content-wrapper {
	position: relative; /* 자식 요소의 absolute 위치 기준점 */
	width: 900px; /* 게시판과 동일한 너비 */
	margin: 40px auto 0 auto; /* 이 래퍼를 중앙 정렬 (결과적으로 게시판이 중앙에 위치) */
}

/* [수정] 너비와 마진은 부모(content-wrapper)가 담당하므로 삭제 */
.hotdeal-board {
	display: flex;
	flex-direction: column;
	flex: 1 0 auto;
}

.hotdeal-board table {
	width: 100%;
	border-collapse: collapse;
}

.hotdeal-board th, .hotdeal-board td {
	border: 1px solid #e0e0e0;
	padding: 8px;
	text-align: center;
	height: 70px;
	vertical-align: middle;
}

.hotdeal-board th {
	background-color: #f8f8f8;
	font-weight: bold;
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
	color: #0056b3;
	text-decoration: none;
}

.hotdeal-board a:hover {
	text-decoration: underline;
}

.pagination-row {
	position: relative;
	margin-top: auto;
	height: 40px;
	display: flex;
	align-items: center;
}

.pagination-center {
	display: flex;
	justify-content: center;
	align-items: center;
	flex: 1;
	height: 100%;
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
	margin-left: 18px;
	padding: 8px 18px;
	background: #007bff;
	color: #fff;
	border-radius: 4px;
	text-decoration: none;
	font-weight: bold;
	font-size: 15px;
	height: 36px;
	line-height: 20px;
	display: inline-block;
}

.write-btn:hover {
	background: #0056b3;
}

.search-box {
	text-align: right;
	margin-bottom: 16px;
}

.search-box input[type="text"] {
	padding: 5px;
	width: 200px;
}

.search-box button {
	padding: 5px 10px;
}

/* [수정] position: absolute로 변경하여 위치 지정 */
.best-posts {
	position: absolute; /* content-wrapper를 기준으로 위치 지정 */
	top: 0;
	left: 100%; /* content-wrapper의 바로 오른쪽 */
	margin-left: 24px; /* 게시판과의 간격 */
	width: 220px;
	border: 1px solid #e0e0e0;
	border-radius: 4px;
	padding: 16px;
	background-color: #fdfdfd;
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
								<th>번호</th>
								<th>이미지</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일</th>
								<th>조회</th>
								<th>추천</th>
								<th>비추천</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty hotdealList}">
									<c:forEach var="deal" items="${hotdealList}">
										<tr>
											<td>${deal.id}</td>
											<td><c:if test="${not empty deal.thumbnail}">
													<img src="${deal.thumbnail}" alt="썸네일">
												</c:if></td>
											<td><a href="detail?id=${deal.id}">${deal.title}</a></td>
											<td>${deal.author}</td>
											<td>${deal.regDate}</td>
											<td>${deal.views}</td>
											<td>${deal.likes}</td>
											<td>${deal.dislikes}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="8">등록된 핫딜이 없습니다.</td>
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
						<c:if test="${not empty sessionScope.loginUser}">
							<a href="write" class="write-btn">새글등록</a>
						</c:if>
					</div>
				</div>

				<aside class="best-posts">
					<h3>베스트 게시글</h3>
					<ul>
						<c:forEach var="item" items="${bestList}" varStatus="status">
							<li><a href="detail?id=${item.id}" title="${item.title}">
									${status.index + 1}. <c:if test="${not empty item.category}">
                        [${item.category}]
                    </c:if> ${item.title} <span
									style="color: #007bff; font-weight: bold;">
										(${item.likes - item.dislikes}) </span>
							</a></li>
						</c:forEach>
						<c:if test="${empty bestList}">
							<li style="color: #aaa;">베스트 게시글이 없습니다.</li>
						</c:if>
					</ul>
				</aside>


			</div>
		</main>
		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>