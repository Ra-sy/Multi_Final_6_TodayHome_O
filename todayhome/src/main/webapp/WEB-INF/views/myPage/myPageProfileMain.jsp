<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>myPage</title>
  <link rel="stylesheet" href="../../../resources/css/myPageProfile.css">
  <link rel="stylesheet" href="../../../resources/css/myPageProfileMain.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
</head>
<body>
<div id="wrapper">
  <jsp:include page="../topMenu.jsp">
    <jsp:param name="usrImg" value="${memberModel.img}"/>
  </jsp:include>

  <div class="top">
    <div class="top-menu upper">
      <div class="top-menu-item top-menu-item-one"><a href="">프로필</a></div>
      <div class="top-menu-item"><a href="${memberModel.num}/pwCheck">설정</a></div>
    </div>
    <div class="top-menu lower">
      <div class="top-menu-item top-menu-item-one"><a href="">모두보기</a></div>
      <div class="top-menu-item"><a href="${memberModel.num}/myBoard">내가쓴글</a></div>
      <div class="top-menu-item"><a href="${memberModel.num}/myFavor">좋아요</a></div>
    </div>
  </div>

  <div class="profile">
    <div>
      <a href="${memberModel.num}/pwCheck"><img class="profile-setting-btn" src="../../../resources/icon/setting.png"></a>
    </div>
    <div class="user-info">
      <div class="user-text user-img">
        <img src="/resources/uploadimg/${memberModel.img}">
      </div>
      <div class="user-text-area">
        <div class="user-text user-nickname">${memberModel.nickname}</div>
        <br>
        <div class="user-text followTo">팔로워 <a href="${memberModel.num}/myFollow">${followMap.followToCnt}</a></div>
        <div class="user-text followFrom">팔로잉 <a href="${memberModel.num}/myFollow">${followMap.followFromCnt}</a></div>
        <div class="user-text favor">좋아요 <a href="${memberModel.num}/myFavor">${favorMap.favorCnt}</a></div>
        <br>
        <div class="user-text user-introduce">${memberModel.introduce}</div>
      </div>
    </div>
  </div>

  <div class="content">
    <div class="menu-title">내가 쓴 글 ${myBoardModel.size()}</div>
    <div class="swiper">
      <div class="swiper-wrapper">
        <c:forEach var="mb" items="${myBoardModel}" end="8">
          <div class="swiper-slide">
            <a href="../../bSelectOne/${mb.num}"><img src="../../resources/uploadimg/${mb.imgThumb}"></a>
          </div>
        </c:forEach>
<%--        <div class="swiper-slide"><a href=""><img src="../../../resources/img/default.png"></a></div>--%>
<%--        <div class="swiper-slide"><a href=""><img src="../../../resources/img/default.png"></a></div>--%>
<%--        <div class="swiper-slide"><a href=""><img src="../../../resources/img/default.png"></a></div>--%>
<%--        <div class="swiper-slide"><a href=""><img src="../../../resources/img/default.png"></a></div>--%>
<%--        <div class="swiper-slide"><a href=""><img src="../../../resources/img/default.png"></a></div>--%>
<%--        <div class="swiper-slide"><a href=""><img src="../../../resources/img/default.png"></a></div>--%>
<%--        <div class="swiper-slide"><a href=""><img src="../../../resources/img/default.png"></a></div>--%>
<%--        <div class="swiper-slide"><a href=""><img src="../../../resources/img/default.png"></a></div>--%>
        <div class="swiper-slide"><a href="../../bInsert"><img class="img-plusCircle" src="../../../resources/icon/plusCircle2.png"></a></div>
      </div>
    </div>

    <div class="menu-title">좋아요한 글 ${myFavorBoardModel.size()}</div>
    <div class="swiper">
      <div class="swiper-wrapper">
        <c:forEach var="fb" items="${myFavorBoardModel}" end="8">
          <div class="swiper-slide">
            <a href="../../bSelectOne/${fb.num}"><img src="../../resources/uploadimg/${fb.imgThumb}"></a>
          </div>
        </c:forEach>
        <div class="swiper-slide"><a href="../../bSelectAll"><img class="img-plusCircle" src="../../../resources/icon/plusCircle2.png"></a></div>
      </div>
    </div>

  </div>
</div>
</body>
<script src="../../../resources/js/myPageProfileMain.js"></script>
</html>