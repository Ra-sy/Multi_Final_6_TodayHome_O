<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 회원정보수정</title>
<link rel="stylesheet" href="/resources/css/myPageUpdate.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	


<script type="text/javascript">
	function NNCheck() {
		console.log('NNCheck()....');
		console.log('nickname:', $("#nickname").val());

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
					msg = '사용중인 닉네임입니다.';
				}
				$('#demo').text(msg);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	}
</script>


</head>
<body>
<div class="fixed-menu">
<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
<jsp:include page="../topMenuMini.jsp"></jsp:include>
</div>


	<div class="mypage-update-wrapper">

		<div class="mupdate-head">
			<div id="title" class="mupdate-title">
				<h1>회원정보수정</h1>
			</div>
			<div id="delete" class="mupdate-delete">
				<a href="/mDeleteOK/${vo2.num}">탈퇴하기</a>
			</div>
		</div>
		
		<div id="All">
			<form action="/mUpdateOK" method="post" enctype="multipart/form-data" accept-charset="utf-8">
				<table>
					<label for="num" style="display:none;">회원번호</label>
					<input type="hidden" name="num" value="${vo2.num}" readonly>

					<tr>
						<td id="emailTd">
							<label for="email">이메일</label>
							<input type="text" name="email" value="${vo2.email}" readonly>
						</td>
					</tr>
						<tr ><td id="x" style="margin-left:50px;">이메일을 변경하시려면 운영자에게 이메일을 보내주세요.</td></tr>


					<tr>
						<td>
							<label for="nickname">닉네임</label> 
							<input type="text" name="nickname" id="nickname" value="${vo2.nickname }" placeholder="이전 닉네임 : ${vo2.nickname }">
						</td>
					</tr>
					<tr>
						<td>
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
							<input type="text" name="birth" id="birth" value="${vo2.birth }" placeholder="1990-12-30 형태로 입력해주세요.">
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
							<input type="text" name="introduce" value="${vo2.introduce }">
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
