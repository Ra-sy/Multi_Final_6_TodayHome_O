<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" %>
<html>
<head>
	<title>오늘의집 | 404</title>
</head>
<body>
<div class="fixed-menu">
	<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
	<jsp:include page="topMenuMini.jsp"></jsp:include>
</div>

<div style="display: flex; justify-content: center">
	<img style="width: 300px; margin-top: 50px" src="../../../resources/icon/error404.png">
</div>
<div style="text-align: center; margin-top: 25px">
	<a style="text-decoration: none; color: black; font-family: 'IBM Plex Sans KR', sans-serif; font-size: 30px; font-weight: bold" href="/">홈으로</a>

</div>
</body>
</html>
