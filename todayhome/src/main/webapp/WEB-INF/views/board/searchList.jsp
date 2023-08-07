<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 검색</title>
<link rel="stylesheet" href="/resources/css/board_searchList.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<div class="fixed-menu">
<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
<jsp:include page="../topMenu.jsp">
	<jsp:param name="usrImg" value="${currMbr.img}"/>
</jsp:include>
</div>

<div class="board-housing-wrap" style="margin-top: 170px;">

	<c:if test="${searchFlag == 1}">
		<table>
			<tbody>
			<c:forEach var="vo" items="${vos}" varStatus="status">
				<c:if test="${status.index % 3 == 0}">
					<tr>
				</c:if>

				<td class="boards-container" style="position: relative;">
					<div class="boards-img-wrap">
						<div class="boards-img-wrap-sub"><a href="/bSelectOne/${vo.num}">
							<img class="boards-img" src="../resources/uploadimg/${vo.imgThumb}">
						</a></div>
					</div>
					<div style="text-align: center;">
						<div class="housing-title">${vo.title}</div>
						<div class="housing-nickname">${vo.nickname}</div>
						<div class="housing-count">좋아요 ${vo.fvCnt} · 조회 ${vo.vcount}</div>
						<c:if test="${vo.boardNo == 1}"><div class="housing-boardNo">집들이</div></c:if>
						<c:if test="${vo.boardNo == 2}"><div class="housing-boardNo">살림수납</div></c:if>
						<c:if test="${vo.boardNo == 3}"><div class="housing-boardNo">홈스토랑</div></c:if>
						<c:if test="${vo.boardNo == 4}"><div class="housing-boardNo">취미일상</div></c:if>
					</div >
				</td>

				<c:if test="${(status.index + 1) % 3 == 0 || status.last}">
					</tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${searchFlag == 0}">
		<img class="no-result-img" src="../../../resources/icon/NoResult.png">
		<div class="no-result-text">검색 결과가 없습니다.</div>
	</c:if>

</div>

	
</body>
</html>
