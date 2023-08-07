<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Comments</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
  <!-- 게시글 내용 및 댓글 등록 폼 -->
  <div id="post">
    <h1>게시글 제목</h1>
    <p>게시글 내용</p>
    <form id="commentForm">
      <input type="text" id="commentInput">
      <button type="submit">댓글 등록</button>
    </form>
  </div>

  <!-- 댓글 목록 -->
  <div id="comments">
    <h2>댓글 목록</h2>
    <ul id="commentList">
      <!-- 댓글 목록 출력 -->
    </ul>
  </div>
</body>
</html>