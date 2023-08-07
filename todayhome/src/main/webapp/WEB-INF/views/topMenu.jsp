<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../../../../resources/css/topMenu.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script>
        function toggleDropdown(){
            let menu = document.querySelector('.dropdown-menu');
            menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</head>
<body>
<c:set var = "usrImg" value = "${param.usrImg}"/>
<div class="tMenu">
    <div class="first-line">
        <div>
            <a class="first-line-head" href="/">
                <img class="first-line-logo" src="../../../../resources/icon/logo1.png">
                <div class="first-line-title">오늘의집</div>
            </a>
        </div>
        <div class="first-line-search">
            <form action="/bSearchList">
                <select name="searchKey" class="searchKey">
                    <option value="title">제목</option>
                    <option value="mbrNickname" class="mbrNickname">닉네임</option>
                </select>
                <input type="text" name="searchWord" class="searchWord" value="" placeholder="검색어를 입력하세요.">
                <input class="searchInput" type="submit" value="">
            </form>
        </div>
        <div class="first-line-menu-button" id="afterLogin">
            <img class="first-line-menu" onclick="toggleDropdown()" src="../../../../resources/uploadimg/${usrImg}">
            <button class="first-line-button right edit">
                <a href="/bInsert">글쓰기</a>
            </button>
        </div>
        <div class="first-line-menu-button" id="beforeLogin">
            <button class="first-line-button">
                <a href="/login">로그인</a>
            </button>
            <button class="first-line-button right">
                <a href="/mInsert">회원가입</a>
            </button>
        </div>
    </div>


    <div class="second-line">
        <div class="second-line-link-set">
            <div class="second-line-link left"><a href="/">홈</a></div>
            <div class="second-line-link"><a href="/bSelectAll">집들이</a></div>
            <div class="second-line-link"><a href="/topics/living">살림수납</a></div>
            <div class="second-line-link"><a href="/topics/cook">홈스토랑</a></div>
            <div class="second-line-link"><a href="/topics/dailylife">취미일상</a></div>
            <div class="second-line-link right"><a href="/evSelectAll">이벤트</a></div>
        </div>
        <div class="second-line-link-blank">
            <ul class="dropdown-menu">
                <li><a href="/myPage/user/${user_id}">마이페이지</a></li>
                <li><a href="/myPage/user/${user_id}/pwCheck">내 정보 수정</a></li>
                <li><a href="/logout">로그아웃</a></li>
            </ul>
        </div>
    </div>
</div>
</body>
<script>
    if ('${user_id}' === '') {	//로그인 안 했을 때
        $('#afterLogin').hide();
        $('#beforeLogin').show();
    } else {					//로그인 했을 때
        $('#afterLogin').show();
        $('#beforeLogin').hide();
    }
</script>
</html>
