<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 글쓰기</title>
<link rel="stylesheet" href="../resources/css/board_insert.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="//cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
<script src="resources/ckeditor/ckeditor.js"></script>
<script> 

      var ckeditor_config = {
	      resize_enaleb : false,
	      enterMode : CKEDITOR.ENTER_BR,
	      shiftEnterMode : CKEDITOR.ENTER_P,
		  filebrowserUploadUrl : "/bInsertCKEditor",
		  filebrowserImageUploadUrl : "/bInsertCKEditor",
	      height: "400px",
      };
      
      function showAdditionalForm() {
          var selectType = document.getElementById("boardNo");
          var additionalForm1 = document.getElementById("additionalForm1");
          var additionalForm2 = document.getElementById("additionalForm2");
          var additionalForm3 = document.getElementById("additionalForm3");
          var additionalForm4 = document.getElementById("additionalForm4");

          additionalForm1.style.display = "none";
          additionalForm2.style.display = "none";
          additionalForm3.style.display = "none";
          additionalForm4.style.display = "none";

          if (selectType.value === "1") {
              additionalForm1.style.display = "block";
          }
          if(selectType.value === "2"){
        	  additionalForm2.style.display = "block";
          }
          if(selectType.value === "3"){
        	  additionalForm3.style.display = "block";
          }
          if(selectType.value === "4"){
        	  additionalForm4.style.display = "block";
          }
      }

	  function onSubmitCheck(){
		if($('#boardNo').val() ==''){
			  alert('게시판을 선택해주십시오.')
			  $('#boardNo').focus();
			  return false;
		}
		if($('#boardNo').val() == 1){
			  if($('#type').val() == '' || $('#familyType').val() == '' ||
				  $('#workingArea').val() == '' || $('#worker').val() == ''){
				  alert('필수 입력사항을 입력해주십시오.');
				  $('#type').focus();
				  return false;
			  }
		}
		if($('#boardNo').val() == 2){
			  if($('#livingtype').val() == ''){
				  alert('필수 입력사항을 입력해주십시오.');
				  $('#livingtype').focus();
				  return false;
			  }
		}
		if($('#boardNo').val() == 3){
			  if($('#cooktype').val() == ''){
				  alert('필수 입력사항을 입력해주십시오.');
				  $('#cooktype').focus();
				  return false;
			  }
		}
		if($('#boardNo').val() == 4){
			  if($('#dailytype').val() == '') {
				  alert('필수 입력사항을 입력해주십시오.');
				  $('#dailytype').focus();
				  return false;
			  }
		}
		if($('#title').val() ==''){
			  alert('제목을 입력해주십시오.')
			$('#title').focus();
			  return false;
		}
		if($('#thumbFile').val() ==''){
			  alert('썸네일 이미지를 선택해주십시오.')
			$('#thumbFile').focus();
			  return false;
		}
		if(CKEDITOR.instances.content.getData() ==''
				|| CKEDITOR.instances.content.getData().length ==0){
			  alert('내용을 입력해주십시오.');
			  $('#content').focus()
			  return false;
		}
	  }

//       function uploadImage() {
//           // 작은 틀의 이미지 업로드 폼에 대한 JavaScript 처리
//           // 파일 업로드를 처리하고, 결과를 표시 (예: <div id="imageUploadResult"></div>)
//       }

//       document.getElementById("postForm").addEventListener("submit", function (event) {
//           event.preventDefault();
//           // 게시글 작성 폼에 대한 JavaScript 처리
//           // 서버로 데이터를 전송 (예: fetch API 사용)
//       });
      
      
</script>
</head>
<body>
<div class="fixed-menu">
<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
<jsp:include page="../topMenuMini.jsp"></jsp:include>
</div>

	<form action="/bInsertOK" method="post" enctype="multipart/form-data" id="insertForm" onsubmit="return onSubmitCheck()">
		<div class="select-board">
			<div class="select-board-base">
			    <label for="boardNo">게시판을 선택하세요</label>
		        <select name="boardNo" id="boardNo" onchange="showAdditionalForm()">
		            <option value="">선택하세요</option>
		            <option value="1">집들이</option>
		            <option value="2">살림수납</option>
		           	<option value="3">홈스토랑</option>
		           	<option value="4">취미일상</option>
		        </select>
		    </div>
		
		    <div id="additionalForm1" style="display: none;">
		        <h3>집들이 게시판 추가 입력사항</h3>
		        <h6><span>*</span> 표시는 필수 입력사항입니다.</h6>
		        <div>
		            <label >주거형태</label>
		        	<span>*</span>
	                <select name="type" id="type">
	                    <option value="">선택해주세요</option>
						<option value="oneroom">원룸&오피스텔</option>
						<option value="apartment">아파트</option>
						<option value="villa">빌라&연립</option>
						<option value="house">단독주택</option>
						<option value="office">사무공간</option>
						<option value="commercial">상업공간</option>
						<option value="etc">기타</option>
	                </select>
		        </div>
		        <div>    
		            <label for="familyType">가족형태</label>
		        	<span>*</span>
	                <select name="familyType" id="familyType">
	                    <option value="">선택해주세요</option>
						<option value="singlelife">싱글라이프</option>
						<option value="honeymoon">신혼 부부</option>
						<option value="withbaby">아기가 있는 집</option>
						<option value="withchild">취학 자녀가 있는 집</option>
						<option value="withparent">부모님과 함께 사는 집</option>
						<option value="etc">기타</option>
	                </select>
		        </div> 
		        <div>    
		            <label for="workingArea">작업분야</label>
		        	<span>*</span>
	                <select name="workingArea" id="workingArea">
	                    <option value="">선택해주세요</option>
						<option value="remodeling">리모델링</option>
						<option value="homestyling">홈스타일링</option>
						<option value="partial">부분공사</option>
						<option value="construct">건축</option>
	                </select>
		        </div>
		        <div> 
		        	<label for="worker">작업자</label>
		        	<span>*</span>
	                <select name="worker" id="worker">
	                    <option value="">선택해주세요</option>
						<option value="self">셀프&DIY</option>
						<option value="halfself">반셀프</option>
						<option value="expert">전문가</option>
	                </select>
		        </div>
				<div>
					<label for="sqft">평수</label> 
					<select name="sqft" id="sqft">
						<option value="">선택해주세요</option>
						<option value="sqft9">0~9평</option>
						<option value="sqft10">10평대</option>
						<option value="sqft20">20평대</option>
						<option value="sqft30">30평대</option>
						<option value="sqft40">40평대</option>
						<option value="sqft50">50평대</option>
						<option value="sqft60">60평 이상</option>
					</select>
				</div>
				<div>    
		            <label for="roomNum">방개수</label>
	                <select name="roomNum" id="roomNum">
	                    <option value="">선택해주세요</option>
	                    <option value="rn1">1개</option>
	                    <option value="rn1.5">1.5개</option>
	                    <option value="rn2">2개</option>
	                    <option value="rn3">3개</option>
	                    <option value="rn4">4개</option>
	                    <option value="rn5">5개이상</option>
	                </select>
		        </div>     
		        <div>
		            <label for="direction">방향</label>
	                <select name="direction" id="direction">
	                    <option value="">선택해주세요</option>
	                    <option value="south">남향</option>
	                    <option value="west">서향</option>
	                    <option value="east">동향</option>
	                    <option value="north">북향</option>
	                    <option value="south-west">남서향</option>
	                    <option value="south-east">남동향</option>
	                    <option value="north-west">북서향</option>
	                    <option value="north-east">북동향</option>
	                </select>
	            </div>   
		        <div>    
		            <label for="year">준공연도</label>
	                <select name="year" id="year">
	                    <option value="">선택해주세요</option>
	                    <option value="year1980">1980~1990</option>
	                    <option value="year1990">1990~2000</option>
	                    <option value="year2000">2000~2010</option>
	                    <option value="year2010">2010~2020</option>
	                    <option value="year2020">2020~</option>
	                </select>
		        </div> 
		        <div>    
		            <label for="location">지역</label>
	                <select name="location" id="location">
	                    <option value="">선택해주세요</option>
	                    <option value="Seoul">서울특별시</option>
	                    <option value="Busan">부산광역시</option>
	                    <option value="Daegu">대구광역시</option>
	                    <option value="Incheon">인천광역시</option>
	                    <option value="Gwangju">광주광역시</option>
	                    <option value="Daejeon">대전광역시</option>
	                    <option value="Ulsan">울산광역시</option>
	                    <option value="Gangwon">강원도</option>
	                    <option value="Gyeonggi">경기도</option>
	                    <option value="Gyeongsang">경상도</option>
	                    <option value="Jeolla">전라도</option>
	                    <option value="Chungcheong">충청도</option>
	                    <option value="Sejong">세종특별자치시</option>
	                    <option value="Jeju">제주특별자치도</option>
	                </select>
		        </div> 
		    </div>
		    
		    <div id="additionalForm2" style="display: none;">
		        <h3>살림수납 게시판 추가 입력사항</h3>
		        <h6><span>*</span> 표시는 필수 입력사항입니다.</h6>
		        <div>
		            <label>분야</label>
		        	<span>*</span>
	                <select name="livingtype" id="livingtype">
	                    <option value="">선택해주세요</option>
						<option value="living1">수납꿀팁</option>
						<option value="living2">청소루틴</option>
						<option value="living3">미니멀라이프</option>
	                </select>
		        </div>
		    </div>
		    <div id="additionalForm3" style="display: none;">
		        <h3>홈스토랑 게시판 추가 입력사항</h3>
		        <h6><span>*</span> 표시는 필수 입력사항입니다.</h6>
		        <div>
		            <label>분야</label>
		        	<span>*</span>
	                <select name="cooktype" id="cooktype">
	                    <option value="">선택해주세요</option>
						<option value="cook1">홈카페</option>
						<option value="cook2">홈쿡</option>
						<option value="cook3">그릇수집</option>
						<option value="cook4">홈파티</option>
						<option value="cook5">홈바</option>
	                </select>
		        </div>
		    </div>
		    <div id="additionalForm4" style="display: none;">
		        <h3>취미일상 게시판 추가 입력사항</h3>
		        <h6><span>*</span> 표시는 필수 입력사항입니다.</h6>
		        <div>
		            <label>분야</label>
		        	<span>*</span>
	                <select name="dailytype" id="dailytype">
						<option value="">선택해주세요</option>
						<option value="daily1">플랜테리어</option>
						<option value="daily2">핫플레이스</option>
						<option value="daily3">빈티지수집</option>
						<option value="daily4">육아</option>
						<option value="daily5">음악감상</option>
						<option value="daily6">반려동물</option>
						<option value="daily7">선물추천</option>
						<option value="daily8">키덜트</option>
						<option value="daily9">향테리어</option>
						<option value="daily10">캠핑</option>
					</select>
		        </div>
		    </div>
	    </div>
	    
		<table>
			<tbody>
<!-- 			<tr> -->
<!-- 				<td><label for="boardno">boardno:</label></td> -->
<!-- 				<td><input type="number" id="boardno" name="boardno" -->
<!-- 					value="1"></td> -->
<!-- 			</tr> -->
			<tr>
				<td><label for="title" style="display:none;">제목</label></td>
				<td><input type="text" id="title" name="title" placeholder="제목을 입력해주세요."
					value="" class="binsert-title"></td>
			</tr>
			<tr>
				<td><label for=thumbfile style="display:none;">썸네일 이미지 추가하기</label></td>
				<td class="binsert-thumb">
					<label style="font-size:18px;color:gray;margin-right:10px;">썸네일 이미지 추가하기</label>
					<input type="file" id="thumbFile" name="thumbFile" value="">
<!-- 					<button type="button" onclick="uploadImage()">이미지 업로드</button> -->
				</td>
			</tr>
			<tr>
				<td><label for="mbrNickname" style="display:none;">nickname:</label></td>
				<td><input type="hidden" id="mbrNickname" name="mbrNickname" value="${mvo2.nickname}"></td>
			</tr>			
			<tr>
				<td><label for="content"  style="display:none;">내용</label></td>
				<td class="binsert-content">
					<textarea rows="20" cols="80" name="content" id="content"></textarea>
					<script>CKEDITOR.replace('content',ckeditor_config);</script>
				</td>
			</tr>
			<tr>
				<td><label for="tag" style="display:none;">tag:</label></td>
				<td><input type="hidden" id="tag" name="tag"
					value="" placeholder="tag"></td>
			</tr>
			<tr>
				<td><label for="brdMnum" style="display:none;">m_num:</label></td>
				<td><input type="hidden" id="brdMnum" name="brdMnum"
					value="${user_id}"></td>
			</tr>
			</tbody>
			<tfoot>
			<tr>
				<td colspan="2"><input type="submit" value="제출" class="binsert-submit"></td>
			</tr>
			</tfoot>
		</table>
	</form>
	
</body>
</html>


