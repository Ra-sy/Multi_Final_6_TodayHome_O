<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | pw찾기</title>
<link rel="stylesheet" href="../resources/css/member_findpw.css">

	<style>
		*{
			font-family: 'IBM Plex Sans KR', sans-serif;
			font-weight: bold;
		}
	</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script>

	var code = "";		//이메일로 전송된 인증코드를 저장하기 위한 코드
	
	function checkInput() {		//이메일을 기입할 때만 확인버튼 활성화
		var emailInput = document.getElementById('email');
		var confirmButton = document.getElementById('confirmButton');

		if (emailInput.value.trim() !== '') {
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
	
	function emailCheck(){
		console.log('emailCheck()...');
		console.log('email:',$('#email').val());
		$.ajax({
			url:"/json_emailCheck",
			data:{email:$("#email").val()},
			method:'GET',
			dataType:'json',
			success: function(response)	{
				console.log('ajax...success:', response);//{"result":"OK"}
				let msg = response.result === 'OK'?'사용가능':'사용중'
				$("#demo").html(msg);
				
				if(msg=='사용가능'){
					$('.mail-check-wrap').hide();
					$('.mail-non').show();
				}else{
					$('.mail-check-wrap').show();
					$('.mail-non').hide();
				}
				
				let vos = ``;
				vos +=`
					<a href="/pwUpdate/\${response.num}" style="text-decoration:none;"><button class="resetpw">비밀번호 재설정하기</button></a>
				`;

				$('#vos').html(vos);
				
			},
			error: function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
	
	function authEmailCheck() {
		var inputCode = $(".mail-check-input").val();        // 사용자가 입력하는 인증번호
		if(inputCode==code){
			$('.mail-check-true').show();
		}else{
			$('.mail-check-true').hide();		//hide로 바꾸기!!!!!!
		}
	}

	$(document).ready(function() {
		
		/* 인증번호 이메일 전송 */
		$("#mail-check-btn").click(function(){	//인증코드 받기 버튼 눌렀을 때
			var email = $(".mail_input").val();			// 입력한 이메일
			var checkBox = $(".mail-check-input");		// 인증번호 입력란
			var boxWrap = $(".mail-check-input-box");	// 인증번호 입력란 박스
			
			const url = "/mailCheck?email=" + email;

			alert('인증코드를 발송했습니다.');

		    $.ajax({
		        type:"GET",
		        url:url,
		        success:function(data){
		        	//console.log("인증코드:"+data);		//!!!!!!확인하고 나중에 지워야하는 코드!!!!!
		        	checkBox.attr("disabled",false);
		        	code=data;
		        }
		    });
		});

		$('#confirmButton').click(function() {	//확인버튼 클릭 했을 때
			const email = $('#email').val(); 			// 이메일 주소값 얻어오기!
			console.log('완성된 이메일 : ' + email);		// 이메일 오는지 확인
		}); // end send email
		
		/* 인증코드 비교 */
		$(".mail-check-input").on("input", function() {
		    var inputCode = $(".mail-check-input").val();        // 사용자가 입력하는 인증번호
		    var checkResult = $(".mail-check-input-box-warn");   // 비교 결과 표시
		    
		    if (inputCode == code) {                             // 일치할 경우
		        checkResult.html("인증번호 일치");
		        //checkResult.attr("class", "correct");
		        $('#confirmButton2').prop('disabled', false);
		    } else {                                             // 일치하지 않을 경우
		        checkResult.html("인증번호 불일치");
		        //checkResult.attr("class", "incorrect");
		        $('#confirmButton2').prop('disabled', true);
		    }
		});
	});
	
</script>

</head>
<div class="fixed-menu">
<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
<jsp:include page="../topMenu.jsp">
	<jsp:param name="usrImg" value="${currMbr.img}"/>
</jsp:include>
</div>

<body>
	<div id="wrapper">
		<div class="mail-input-wrap">
			<div style="font-size:14px;">가입한 이메일 주소를 입력해주세요.<br/></div>
		</div>
		<div class="mail-input-wrap2">
			<div class="box int_email"> 
				<input type="text" class="mail_input" name="userEmail" id="email" maxlength="30" placeholder="&nbsp;&nbsp;이메일" oninput="checkInput()">
				<button type="button" id="confirmButton" class="btn-email-check" onclick="emailCheck()" disabled>확인</button>
			</div> 
		</div>
		<div class="mail-input-wrap3">
			<div class="mail-non" style="display: none;">등록되지 않은 이메일입니다.</div>
			<span class="demo" id="demo" style="display: none;"></span>
		</div>
		
		<div class="mail-check-wrap" style="display: none;">	<!-- style="display: none;" -->
			<div id="mail-check-btn" class="mail-check-btn">
				<button type="button" class="btn-auth" name="" id="" onclick="showMailCheckInput()">
					<span>이메일로 인증코드 받기</span>
				</button>
			</div>
			<div class="mail-check-input-box">
				<input class="mail-check-input" id="auth" placeholder="인증코드 6자리 입력" 
					maxlength="6" oninput="checkInput2()" disabled="disabled">
				<button type="button" id="confirmButton2" class="btn-auth-check" onclick="authEmailCheck()" disabled><span>확인</span></button>
			</div>
			<span class="mail-check-input-box-warn"></span>
		</div>
		
		<div class="mail-check-true" id="vos" style="display: none;"></div> <!-- style="display: none;" -->
	</div>
	
	<script>
		function showMailCheckInput() {
			$('.mail-check-box').show();
		}
	</script>
</body>
</html>
