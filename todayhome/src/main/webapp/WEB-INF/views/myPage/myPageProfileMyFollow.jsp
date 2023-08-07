<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>myPage</title>
  <link rel="stylesheet" href="../../../resources/css/myPageProfile.css">
  <link rel="stylesheet" href="../../../resources/css/myPageProfileMyFollow.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
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
      <div class="top-menu-item"><a href="../${memberModel.num}/myFavor">좋아요</a></div>
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
        <div class="user-text followTo">팔로워 <a href="">${followMap.followToCnt}</a></div>
        <div class="user-text followFrom">팔로잉 <a href="">${followMap.followFromCnt}</a></div>
        <div class="user-text favor">좋아요 <a href="../${memberModel.num}/myFavor">${favorMap.favorCnt}</a></div>
        <br>
        <div class="user-text user-introduce">${memberModel.introduce}</div>
      </div>
    </div>
  </div>

  <div class="content">

    <div class="menu-title">팔로워</div>
    <div class="swiper">
      <div class="swiper-wrapper">
        <c:forEach var="flwTo" items="${followMap.followTo}">
          <div class="swiper-slide user-profile">
            <img class="user-profile-img" src="../../../resources/uploadimg/${flwTo.mbrImg}">
            <div class="user-profile-text">
              <div class="user-profile-nickname">${flwTo.mbrNickname}</div>
              <div class="user-profile-introduce">${flwTo.mbrIntroduce}</div>
            </div>
          </div>
        </c:forEach>

<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>

      </div>
    </div>

    <div class="menu-title">팔로잉</div>
    <div class="swiper">
      <div class="swiper-wrapper">
        <c:forEach var="flwFrom" items="${followMap.followFrom}">
          <div class="swiper-slide user-profile">
            <img class="user-profile-img" src="../../../resources/uploadimg/${flwFrom.mbrImg}">
            <div class="user-profile-text">
              <div class="user-profile-nickname">${flwFrom.mbrNickname}</div>
              <div class="user-profile-introduce">${flwFrom.mbrIntroduce}</div>
            </div>
          </div>
        </c:forEach>

<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="swiper-slide user-profile">--%>
<%--          <img class="user-profile-img" src="../../../resources/img/default.png">--%>
<%--          <div class="user-profile-text">--%>
<%--            <div class="user-profile-nickname">NICK</div>--%>
<%--            <div class="user-profile-introduce">ITRDC</div>--%>
<%--          </div>--%>
<%--        </div>--%>

      </div>
    </div>
  </div>
</div>
</body>
<script src="../../../resources/js/myPageProfileMyFollow.js"></script>
</html>