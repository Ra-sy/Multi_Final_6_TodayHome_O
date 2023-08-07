<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | pw변경</title>
<link rel="stylesheet" href="../resources/css/member_pwUpdate.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">
    function letterCheck() {
        $('.password-input').on('input', function () {
            var pw = $(this).val();
            var hasNum = /\d/.test(pw);            // 숫자 여부 확인
            var hasText = /[a-zA-Z]/.test(pw);    // 문자 여부 확인

            if (pw.length < 8 || !hasNum || !hasText) {
                $('div.password-length').text('영문, 숫자를 모두 포함하여 8자 이상');
                $('div.password-confirm:not(:empty)').text('');   // 일치하지 않음 안내 메시지 삭제
                $('input[type="submit"]').prop('disabled', true); // 버튼 비활성화
            } else {
                $('div.password-length').text('');
                checkPasswordMatch(); // 비밀번호 일치 여부 확인
            }
        });
    }

    function checkPasswordMatch() {
        var pw = $('.password-input').val();
        var pwCheck = $('.password-input-check').val();

        if (pw === pwCheck) {
            $('div.password-confirm').text('');
            if ($('.password-length').text() === '') {	
                $('input[type="submit"]').prop('disabled', false); // 버튼 활성화
            } else { //8자 이상이 안될 때
                $('input[type="submit"]').prop('disabled', true); // 버튼 비활성화
            }
        } else {
            $('div.password-confirm').text('비밀번호가 일치하지 않습니다.');
            $('input[type="submit"]').prop('disabled', true); // 버튼 비활성화
        }
    }

    $(document).ready(function () {
        letterCheck();
        $('.password-input-check').on('input', checkPasswordMatch); // 비밀번호 확인 값이 변경될 때마다 일치 여부 확인
    });

</script>
</head>
<body>
<div class="fixed-menu">
    <%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
    <jsp:include page="../topMenu.jsp">
        <jsp:param name="usrImg" value="${currMbr.img}"/>
    </jsp:include>
</div>

<form action="/pwUpdateOK" method="post">
    <table>
        <tr>
            <td><input type="hidden" id="num" name="num" value="${vo2.num}"></td>
        </tr>
        <tr>
            <td><input type="password" class="password-input" id="password" name="password" placeholder="새 비밀번호"></td>
        </tr>
        <tr>
            <td><input type="password" class="password-input-check" id="pw" name="pw" placeholder="새 비밀번호 확인"></td>
        </tr>
        <tr>
            <td><div class="password-length"></div></td>
        </tr>
        <tr>
            <td><div class="password-confirm"></div></td>
        </tr>
        <tr>
            <td><input type="submit" class="resetpw-final" value="비밀번호 변경하기"></td>
        </tr>
    </table>
</form>

</body>
</html>
