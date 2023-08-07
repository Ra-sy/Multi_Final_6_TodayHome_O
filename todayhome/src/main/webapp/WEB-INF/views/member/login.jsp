<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 로그인</title>
<link rel="stylesheet" href="/resources/css/member_login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
    <div class="all">
        <main class="main">
            <div class="a">
                <a href="/" style="color:#000000;font-weight:bold;">
                <img src="resources/jspimg/logo1.png" width=50px, height=50px style="border-radius:10px;margin-bottom:-10px;">
                오늘의 집</a>
            </div>
            <div class="body">
                <div class="b">
                    <form action="/loginOK" method="post">
                        <div>
                            <input name="email" type="email" placeholder="이메일">
                        </div>
                        <div>
                            <input name="pw" type="password" placeholder="비밀번호">
                        </div>
                        <p style="color:red;">${message}</p>
                        <button class="login" type="submit"> 로그인</button>
                        <section> 
                            <a href="/findpw" style="margin-right:10px;color:black">비밀번호 재설정</a>
                            <a href="/mInsert" style="color:black">회원가입</a>
                        </section>
                    </form>
                </div>
            </div>
            <footer>
                <a href="" target="_blank"> © Time 6.final project </a> .All Rights Reserved
            </footer>
        </main>
    </div>
</body>
</html>
