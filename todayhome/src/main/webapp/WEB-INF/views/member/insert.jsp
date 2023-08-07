<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오늘의집 | 회원가입</title>
    <link rel="stylesheet" href="/resources/css/member_insert.css">
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <script type="text/javascript">

        var code = "";		//이메일로 전송된 인증코드를 저장하기 위한 코드

        function checkInput() {		//이메일을 기입할 때만 확인버튼 활성화
            var emailInput = document.getElementById('email');
            var confirmButton = document.getElementById('confirmButton');

            // 이메일 유효성을 검사하는 정규 표현식
            var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (emailRegex.test(emailInput.value.trim())) {
                confirmButton.disabled = false;
            } else {
                confirmButton.disabled = true;
            }
        }

        //이메일 확인되면 '인증코드받기'버튼 나타남

        function checkInput2() {	//인증번호를 기입할 때만 확인버튼 활성화
            var authInput = document.getElementById('auth');
            var confirmButton2 = document.getElementById('confirmButton2');

            if (authInput.value.trim() !== '') {
                confirmButton2.disabled = false;
            } else {
                confirmButton2.disabled = true;
            }
        }

        function authChange(){
            $("#btn-auth").prop("disabled", false);
            $("#btn-auth").on();
            $("#confirmButton2").prop("disabled", false);

            $("#btn-auth").css("background-color", '#f2f2f2');
            $("#btn-auth").css("color", '#888888');
            $("#confirmButton2").css("background-color", '#f2f2f2');
            $("#confirmButton2").css("color", '#888888');
        }

        function emailCheck() {
            console.log('emailCheck()...');
            console.log('email:', $('#email').val());
            $.ajax({
                url: "/json_emailCheck",
                data: {email: $("#email").val()},
                method: 'GET',
                dataType: 'json',
                success: function (response) {
                    console.log('ajax...success:', response);//{"result":"OK"}
                    let msg = response.result === 'OK' ? '사용가능' : '사용중'
                    $("#demo").html(msg);

                    if (msg == '사용가능') {
                        $('.mail-check-wrap').show();
                        $('.mail-non').hide();

                        $("#btn-auth").prop("disabled", '');
                        $("#btn-auth").on();
                        $("#confirmButton2").prop("disabled", '');

                        $("#btn-auth").css("background-color", '#35C5F0');
                        $("#btn-auth").css("color", '#ffffff');
                        $("#confirmButton2").css("background-color", '#35C5F0');
                        $("#confirmButton2").css("color", '#ffffff');
                    } else {
                        $('.mail-check-wrap').hide();
                        $('.mail-non').show();
                    }

                    let vos = ``;
                    vos += `
				<a href="/pwUpdate/\${response.num}" style="text-decoration:none;"><button class="resetpw">비밀번호 재설정하기</button></a>
			`;

                    $('#vos').html(vos);

                },
                error: function (xhr, status, error) {
                    console.log('xhr.status:', xhr.status);
                }
            });
        }

        function authEmailCheck() {
            var inputCode = $(".mail-check-input").val();        // 사용자가 입력하는 인증번호
            if (inputCode == code) {
                $('.mail-check-true').show();
                $('#email').prop('readonly', true);  // 이메일 입력란 readonly로 변경
                $('#email').css('background-color', '#EDEDED');
                $('#auth').prop('readonly', true);  // 인증코드 입력란 readonly로 변경
                $('#auth').css('background-color', '#EDEDED');

                $("#confirmButton").prop("disabled", 'disabled');
                $("#btn-auth").prop("disabled", 'disabled');
                $("#btn-auth").off();
                $("#confirmButton2").prop("disabled", 'disabled');

                $("#confirmButton").css("background-color", '#f2f2f2');
                $("#confirmButton").css("color", '#888888');
                $("#btn-auth").css("background-color", '#f2f2f2');
                $("#btn-auth").css("color", '#888888');
                $("#confirmButton2").css("background-color", '#f2f2f2');
                $("#confirmButton2").css("color", '#888888');

                $('#authVal').val('Y');
                if ($('#authVal').val() == 'Y' &&
                    $('#pwVal').val() == 'Y' &&
                    $('#nicknameVal').val() == 'Y' &&
                    $('#checkVal').val() == 'Y') {
                    document.getElementById('btn-submit').disabled = false;
                }
                alert('이메일 인증이 성공했습니다.');
            } else if (inputCode != code) {
                alert('인증번호가 일치하지 않습니다.')
            } else {
                $('.mail-check-true').hide();		//hide로 바꾸기!!!!!!
            }
        }

        function letterCheck() {
            $('.password-input').on('input', function () {
                var pw = $(this).val();
                var hasNum = /\d/.test(pw);            // 숫자 여부 확인
                var hasText = /[a-zA-Z]/.test(pw);    // 문자 여부 확인

                if (pw.length < 8 || !hasNum || !hasText) {
                    $('.password-length').text('비밀번호는 영문, 숫자를 포함하여 8자 이상이어야 합니다.');
                    $('.password-confirm:not(:empty)').text('');   // 일치하지 않음 안내 메시지 삭제
                    document.getElementById('btn-submit').disabled = true;
                } else {
                    $('.password-length').text('');
                    checkPasswordMatch(); // 비밀번호 일치 여부 확인
                }
            });
        }

        function checkPasswordMatch() {
            var pw = $('.password-input').val();
            var pwCheck = $('.password-input-check').val();

            if (pw === pwCheck) {
                $('.password-confirm').text('');
                if ($('.password-length').text() === '') {
                    $('#pwVal').val('Y') // 버튼 활성화
                    if ($('#authVal').val() == 'Y' &&
                        $('#pwVal').val() == 'Y' &&
                        $('#nicknameVal').val() == 'Y' &&
                        $('#checkVal').val() == 'Y') {
                        document.getElementById('btn-submit').disabled = false;
                    }
                }
            } else {
                $('.password-confirm').text('비밀번호가 일치하지 않습니다.');
                $('#pwVal').val('N');
                document.getElementById('btn-submit').disabled = true;
            }
        }

        function NNCheck() {
            console.log('NNCheck()....');
            console.log('nickname:', $("#nickname").val());

            if ($('#nickname').val() === '') {
                msg = '닉네임을 입력해주십시오.';
                $('#demo2').text(msg);
                $('#nicknameVal').val('N');
                document.getElementById('btn-submit').disabled = true;
            } else {
                $.ajax({
                    url: "/mUpdate/nicknameCheck",
                    data: {nickname: $('#nickname').val()},
                    method: 'GET',
                    dataType: 'json',
                    success: function (obj) {
                        console.log('ajax...success...obj:', obj);
                        console.log('ajax...success...obj.r:', obj.result);
                        let msg = '';
                        if (obj.result === 'OK') {
                            msg = '사용가능한 닉네임입니다.';
                            $('#nicknameVal').val('Y');

                            if ($('#authVal').val() == 'Y' &&
                                $('#pwVal').val() == 'Y' &&
                                $('#nicknameVal').val() == 'Y' &&
                                $('#checkVal').val() == 'Y') {
                                    document.getElementById('btn-submit').disabled = false;
                            }
                        }
                        else {
                            msg = '사용중인 닉네임입니다.';
                            $('#nicknameVal').val('N');
                            document.getElementById('btn-submit').disabled = true;
                        }
                        $('#demo2').text(msg);
                    },
                    error: function (xhr, status, error) {
                        console.log('xhr.status:', xhr.status);
                    }
                });
            }
        }

        function NNchange(){
            $('#demo2').text('닉네임 중복 확인이 필요합니다.');
            document.getElementById('btn-submit').disabled = true;
        }

        function checkSelectAll() {
            const checkboxes
                = document.querySelectorAll('input[name="cb"]');
            const checked
                = document.querySelectorAll('input[name="cb"]:checked');
            const selectAll
                = document.querySelector('input[name="checkAll"]');
            const submitButton
                = document.querySelector('.btn-submit');


            if (checkboxes.length === checked.length) {
                selectAll.checked = true;
                $('#checkVal').val('Y');

                if ($('#authVal').val() == 'Y' &&
                    $('#pwVal').val() == 'Y' &&
                    $('#nicknameVal').val() == 'Y' &&
                    $('#checkVal').val() == 'Y') {
                    document.getElementById('btn-submit').disabled = false;
                }
            } else {
                selectAll.checked = false;
                $('#checkVal').val('N');
                document.getElementById('btn-submit').disabled = true;
            }
        }

        function allCheck(check) {
            const checkboxes
                = document.getElementsByName('cb');

            checkboxes.forEach((checkbox) => {
                checkbox.checked = check.checked
            })
        }

        document.addEventListener('DOMContentLoaded', function () {
            let checkAll = document.getElementById('checkAll');

            checkAll.addEventListener('change', function () {
                if (checkAll.checked == true) {
                    $('#checkVal').val('Y');

                    if ($('#authVal').val() == 'Y' &&
                        $('#pwVal').val() == 'Y' &&
                        $('#nicknameVal').val() == 'Y' &&
                        $('#checkVal').val() == 'Y') {
                        document.getElementById('btn-submit').disabled = false;
                    }
                } else {
                    $('#checkVal').val('N');
                    document.getElementById('btn-submit').disabled = true;
                }
            });
        });

        $(document).ready(function () {

            /* 인증번호 이메일 전송 */
            $("#btn-auth").click(function () {	//인증코드 받기 버튼 눌렀을 때

                alert('인증코드를 발송했습니다.');

                var email = $(".mail_input").val();			// 입력한 이메일
                var checkBox = $(".mail-check-input");		// 인증번호 입력란
                var boxWrap = $(".mail-check-input-box");	// 인증번호 입력란 박스

                const url = "/mailCheck?email=" + email;

                $.ajax({
                    type: "GET",
                    url: url,
                    success: function (data) {
                        //console.log("인증코드:"+data);		//!!!!!!확인하고 나중에 지워야하는 코드!!!!!
                        checkBox.attr("disabled", false);
                        code = data;
                    }
                });
            });

            $('#confirmButton').click(function () {	//확인버튼 클릭 했을 때
                const email = $('#email').val(); 			// 이메일 주소값 얻어오기!
                console.log('완성된 이메일 : ' + email);		// 이메일 오는지 확인
            }); // end send email

            /* 인증코드 비교 */
            $(".mail-check-input").on("input", function () {
                var inputCode = $(".mail-check-input").val();        // 사용자가 입력하는 인증번호
                var checkResult = $(".mail-check-input-box-warn");   // 비교 결과 표시

                if (inputCode == code) {                             // 일치할 경우
                    //checkResult.html("인증번호 일치");
                    //checkResult.attr("class", "correct");
                    $('#confirmButton2').prop('disabled', false);


                } else {                                             // 일치하지 않을 경우
                    //checkResult.html("인증번호 불일치");
                    //checkResult.attr("class", "incorrect");
                    $('#confirmButton2').prop('disabled', true);
                }
            });

            letterCheck();
            $('.password-input-check').on('input', checkPasswordMatch); // 비밀번호 확인 값이 변경될 때마다 일치 여부 확인
            $('#nickname').on('input',NNchange);
            $('#email').on('input',authChange)


        });
    </script>


</head>
<body>
<div class="fixed-menu">
    <%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
    <jsp:include page="../topMenuMini.jsp"></jsp:include>
</div>

<form action="mInsertOK" method="post">
    <div class="container">

        <div>
            <div class="register">회원가입</div>
            <hr class="register-hr">
        </div>

        <div class="wrapper">
            <div class="minsert-title">이메일</div>

            <div class="mail-input-wrap2">
                <div class="box int_email">
                    <input type="text" class="mail_input" name="email" id="email" maxlength="30" oninput="checkInput()">
                    <button type="button" id="confirmButton" class="btn-email-check" onclick="emailCheck()" disabled>
                        확인
                    </button>
                </div>
            </div>
            <div class="mail-input-wrap3">
                <div class="mail-non" style="display: none;">이미 가입한 이메일입니다. 로그인해주세요.</div>
                <span class="demo" id="demo" style="display: none;"></span>
            </div>

            <div class="mail-check-wrap" style="display: none;">
                <div id="mail-check-btn" class="mail-check-btn">
                    <button type="button" class="btn-auth" name="" id="btn-auth" onclick="showMailCheckInput()">
                        <div>이메일 인증하기</div>
                    </button>
                </div>
                <div class="mail-check-input-box">
                    <input class="mail-check-input" id="auth" placeholder="인증코드 6자리 입력"
                           maxlength="6" oninput="checkInput2()" disabled="disabled">
                    <button type="button" id="confirmButton2" class="btn-auth-check" onclick="authEmailCheck()"
                            disabled><span>확인</span></button>
                </div>
                <span class="mail-check-input-box-warn"></span>
            </div>
        </div>

        <div class="wrapper">
            <div class="wrapper-pw">
                <div class="minsert-title">비밀번호</div>
                <div class="infor">영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.</div>
                <input type="password" class="password-input" id="password" name="password" maxlength="20">
                <span class="password-length"></span>
            </div>
            <div>
                <div class="minsert-title">비밀번호 확인</div>
                <input type="password" class="password-input-check" id="pw" name="pw" maxlength="20">
                <span class="password-confirm"></span>
            </div>
        </div>

        <div class="wrapper">
            <div class="minsert-title">닉네임</div>
            <div class="infor">다른 유저와 겹치지 않도록 입력해주세요.(2~15자)</div>

            <div><input type="text" name="nickname" id="nickname" minlength="2" maxlength="15"></div>
            <div>
                <button type="button" id="nicknameButton" onclick="NNCheck()" class="nicknameButton">닉네임 중복 확인</button>
                <span id="demo2"></span>
            </div>

        </div>

        <div class="wrapper">
            <div class="minsert-title">약관동의</div>
            <input type="checkbox" id="checkAll" name="checkAll" onclick="allCheck(this)"> 전체동의
            <br>
            <input type="checkbox" name="cb" onclick="checkSelectAll()"> 만 14세 이상입니다 <span class="auth-p">(필수)</span>
            <br>
            <input type="checkbox" name="cb" onclick="checkSelectAll()"> 이용약관 <span class="auth-p">(필수)</span>
            <br>
            <input type="checkbox" name="cb" onclick="checkSelectAll()"> 개인정보수집 및 이용동의 <span class="auth-p">(필수)</span>
        </div>

        <div class="wrapper">
            <input type="submit" value="회원가입" class="btn-submit" id="btn-submit" disabled>
        </div>

        <input type="hidden" id="authVal" name="auth" value="N">
        <input type="hidden" id="pwVal" name="pwVal" value="N">
        <input type="hidden" id="nicknameVal" name="nicknameVal" value="N">
        <input type="hidden" id="checkVal" name="checkVal" value="N">

    </div>
</form>

<script>
    function showMailCheckInput() {
        $('.mail-check-box').show();
    }
</script>
</body>
</html>
