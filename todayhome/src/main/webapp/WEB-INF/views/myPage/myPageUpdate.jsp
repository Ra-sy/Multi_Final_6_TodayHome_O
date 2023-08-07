<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 회원정보수정</title>
<link rel="stylesheet" href="/resources/css/myPageUpdate.css">
<link rel="stylesheet" href="/resources/css/myPageProfile.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	let currNickname = '<c:out value="${memberModel.nickname}"/>';

function changeNickname(){
	$('#demo').text('닉네임 중복 확인이 필요합니다.');
}

function checkUpdate() {
	if($('#nickname').val().trim() == ''){
		alert('이메일을 입력해주십시오.');
		return false;
	}

	if($('#demo').text() === '닉네임 중복 확인이 필요합니다.'){
		alert('닉네임 중복 확인이 필요합니다.');
		return false;
	}

	if($('#demo').text() === '사용중인 닉네임입니다.'){
		alert('사용중인 닉네임입니다.');
		return false;
	}

		$.ajax({
			url : "/mUpdate/nicknameCheck",
			data:{nickname:$('#nickname').val()},
			method:'GET',
			dataType:'json',
			success : function(obj) {
				console.log('ajax...success:', obj);

				if(obj.result==='OK'){
					return true;
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});

}

function NNCheck() {
		console.log('NNCheck()....');
		console.log('nickname:', $("#nickname").val());

		if($('#nickname').val().trim() == ''){
			let msg = '닉네임을 입력해주십시오.';
			$('#demo').text(msg);
		}
		else{
			$.ajax({
				url : "/mUpdate/nicknameCheck",
				data:{nickname:$('#nickname').val()},
				method:'GET',
				dataType:'json',
				success : function(obj) {
					console.log('ajax...success:', obj);
					console.log('ajax...success:', obj.result);
					let msg = '';
					if(obj.result==='OK'){
						msg = '사용가능한 닉네임입니다.';
					}else{
						if($('#nickname').val() == currNickname){
							msg = '현재 닉네임입니다.'
						}
						else{
							msg = '사용중인 닉네임입니다.';
						}
					}
					$('#demo').text(msg);


				},
				error:function(xhr,status,error){
					console.log('xhr.status:', xhr.status);
				}
			});//end $.ajax()...
		}
	}

function deleteMember(){
	let msg = confirm('정말로 회원 탈퇴 하시겠습니까?');

	if(msg == true){
		location.href='mDeleteOK';
	}
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
	<div class="mypage-update-wrapper">

		<div class="mupdate-head">
			<div id="title" class="mupdate-title">
				<h1>회원정보수정</h1>
			</div>
			<div id="delete" class="mupdate-delete">
				<a onclick="deleteMember()">탈퇴하기</a>
			</div>
		</div>
		
		<div id="All">
			<form action="/mUpdateOK" method="post" enctype="multipart/form-data" accept-charset="utf-8" onSubmit="return checkUpdate()">
				<table>
					<label for="num" style="display:none;">회원번호</label>
					<input type="hidden" name="num" value="${memberModel.num}" readonly>

					<tr>
						<td id="emailTd">
							<label for="email">이메일</label>
							<input type="text" name="email" value="${memberModel.email}" readonly>
						</td>
					</tr>
						<tr ><td id="x" style="margin-left:50px;">이메일을 변경하시려면 운영자에게 이메일을 보내주세요.</td></tr>


					<tr>
						<td id="nicknameTd">
							<label for="nickname">닉네임</label> 
							<input type="text" name="nickname" id="nickname" value="${memberModel.nickname}" placeholder="이전 닉네임 : ${memberModel.nickname }" oninput="changeNickname()">
						</td>
					</tr>
					<tr>
						<td id="nicknameButtonTd">
							<button type="button" id="nicknameButton" onclick="NNCheck()"
								class="nicknameButton">닉네임 중복 확인</button> <span id="demo"></span>
						</td>
					</tr>

					<tr>
						<td>
							<label for="sex" style="margin-right:80px;">성별</label>
							<input type="radio" name="sex" id="male" value="male">남자
							<input type="radio" name="sex" id="female" value="female">여자
						</td>
					</tr>
					<tr>
						<td>
							<label for="birth">생년월일</label> 
							<input type="text" name="birth" id="birth" value="${memberModel.birth }" placeholder="1990-12-30 형태로 입력해주세요.">
						</td>
					</tr>
					<tr>

						<td>
							<label for="imgfile">프로필 이미지</label> 
							<input type="file" name="imgFile" id="imgFile">
						</td>
					</tr>

					<tr>
						<td>
							<label for="introduce">한줄소개</label> 
							<input type="text" name="introduce" value="${memberModel.introduce }">
						</td>

					</tr>
					<tr>
						<td>
						<input type="submit"  value="회원정보수정" class="myButton"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
