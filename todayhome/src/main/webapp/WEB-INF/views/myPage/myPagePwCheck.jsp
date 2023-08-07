<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | pw확인</title>
<link rel="stylesheet" href="../../../resources/css/myPagePwCheck.css">
<link rel="stylesheet" href="../../../resources/css/myPageProfile.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
	$(function() {
		$('#myButton').hide();
	});
	function pwCheck() {
		console.log('pwCheck()....');
		console.log('pw:', $("#pw").val());
		console.log('email:', '${memberModel.email}');
		$.ajax({
			url : "mJsonPwCheck",
			data : {
				email : '${memberModel.email}',
				pw : $("#pw").val()
			},
			method : 'GET',//default get
			//			method:'POST',
			dataType : 'json', //xml,text
			success : function(response) {
				console.log('ajax...success:', response);//{"result":"OK"}
				let msg;

				if (response.result === 'OK') {
					$('#demo').css('color','#35c5f0');
					
					msg = '비밀번호가 일치합니다';
					// $('#myButton').show();
					location.href='/myPage/user/${memberModel.num}/update';

				} else {
					$('#demo').css('color','red');
					msg = '비밀번호가 일치하지 않습니다';
					// $('#myButton').hide();
					
				}
				$("#demo").html(msg);

			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});
	}
</script>

</head>
<body>
<div class="fixed-menu">
	<jsp:include page="../topMenu.jsp">
		<jsp:param name="usrImg" value="${memberModel.img}"/>
	</jsp:include>

	<div class="top">
		<div class="top-menu upper">
			<div class="top-menu-item"><a href="/myPage/user/${memberModel.num}">프로필</a></div>
			<div class="top-menu-item top-menu-item-two"><a href="">설정</a></div>
		</div>
	</div>
</div>

	<div id="pwcheck" style="margin-top: 160px">
		<form action="/myPage/user/${memberModel.num}/update" method="GET" id="updateForm">
			<table>
			
				<tr>
					<td>
						<input type="hidden" name="num" value="${memberModel.num}">
					</td>
				</tr>

				<tr>
					<td>
						<input type="hidden" id="email" name="email" value="${memberModel.email}">
					</td>
				</tr>
				
				<tr>
					<td id="pwinsert">
						<div>비밀번호를 입력하세요.</div>
					</td>
				</tr>
				
				<tr id="xx">
					<td>
						<input type="password" id="pw" name="pw" value="">
						<button type="button" id="Button" onclick="pwCheck()">비밀번호 확인</button>
					</td>
				</tr>

				<tr>
					<td><div id="demo"></div></td>
				</tr>

				<tr>
					<td><input type="submit" value="회원정보 수정" class="myButton" id="myButton"></td>
				</tr>




			</table>
		</form>

	</div>



</body>
</html>