<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>myPage</title>
  <link rel="stylesheet" href="../../../resources/css/myPageProfile.css">
  <link rel="stylesheet" href="../../../resources/css/myPageProfileMyFavor.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script>

  </script>
</head>
<body>
<div id="wrapper">
  <jsp:include page="../topMenu.jsp">
    <jsp:param name="usrImg" value="${memberModel.img}"/>
  </jsp:include>

  <div>
    <div class="top-menu upper">
      <div class="top-menu-item top-menu-item-one"><a href="../${memberModel.num}">프로필</a></div>
      <div class="top-menu-item"><a href="../${memberModel.num}/pwCheck">설정</a></div>
    </div>
    <div class="top-menu lower">
      <div class="top-menu-item"><a href="../${memberModel.num}">모두보기</a></div>
      <div class="top-menu-item"><a href="../${memberModel.num}/myBoard">내가쓴글</a></div>
      <div class="top-menu-item top-menu-item-one"><a href="">좋아요</a></div>
    </div>
  </div>

  <div class="profile">
    <div>
      <a href="../${memberModel.num}/pwCheck"><img class="profile-setting-btn" src="../../../resources/icon/setting.png"></a>
    </div>
    <div class="user-info">
      <div class="user-text user-img">
        <img src="../../../resources/uploadimg/${memberModel.img}">
      </div>
      <div class="user-text-area">
        <div class="user-text user-nickname">${memberModel.nickname}</div>
        <br>
        <div class="user-text followTo">팔로워 <a href="../${memberModel.num}/myFollow">${followMap.followToCnt}</a></div>
        <div class="user-text followFrom">팔로잉 <a href="../${memberModel.num}/myFollow">${followMap.followFromCnt}</a></div>
        <div class="user-text favor">좋아요 <a href="">${favorMap.favorCnt}</a></div>
        <br>
        <div class="user-text user-introduce">${memberModel.introduce}</div>
      </div>
    </div>
  </div>

  <div class="content">
    <div class="board-set-wrapper">
      <c:forEach var="fb" items="${myFavorBoardModel}">
        <div class="board-set">
          <div class="board-set-profile">
            <img class="board-set-img" src="../../../resources/uploadimg/${fb.mbrImg}">
            <div class="board-set-nickname">${fb.mbrNickname}</div>
          </div>
          <a href="../../../bSelectOne/${fb.num}"><img class="board-set-thumbImg" src="../../../resources/uploadimg/${fb.imgThumb}"></a>
          <div class="board-set-btn">
            <div><button class="btn favor"></button><div>${fb.fvCnt}</div></div>
            <div><button class="btn comments"></button><div>${fb.cmtCnt}</div></div>
          </div>
        </div>
      </c:forEach>
    </div>

  </div>
</div>
</body>
</html>