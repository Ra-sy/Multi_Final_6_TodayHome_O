<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${board.title} | todayhome : 수정</title>
<link rel="stylesheet" href="../../../resources/css/board_update.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="//cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
<script src="../resources/ckeditor/ckeditor.js"></script>
<script src="../../../resources/js/boardUpdate.js"></script>
</head>
<body>

<div class="fixed-menu">
	<jsp:include page="../topMenuMini.jsp"></jsp:include>
</div>
	<form action="/bJsonUpdate" method="post" enctype="multipart/form-data" accept-charset="utf-8" id="updateForm">
		<div class="select-board">
			<div class="select-board-base">
			    <label for="boardNo">게시판을 선택하세요</label>
		        <select name="boardNo" id="boardNo">
					<option value="">선택하세요</option>
		            <option value="1" <c:if test="${board.boardNo eq 1}">selected</c:if>>집들이</option>
		            <option value="2" <c:if test="${board.boardNo eq 2}">selected</c:if>>살림수납</option>
		           	<option value="3" <c:if test="${board.boardNo eq 3}">selected</c:if>>홈스토랑</option>
		           	<option value="4" <c:if test="${board.boardNo eq 4}">selected</c:if>>취미일상</option>
		        </select>
		    </div>
		    <div id="additionalForm1">
		        <h3>집들이 게시판 추가 입력사항</h3>
		        <h6>* 표시는 필수 입력사항입니다.</h6>
		        <div>
		            <label>주거형태</label>
		        	<span>*</span>
	                <select name="type" id="type">
	                    <option value="">선택해주세요</option>
						<option value="oneroom" <c:if test="${board.type eq 'oneroom'}">selected</c:if>>원룸&오피스텔</option>
						<option value="apartment" <c:if test="${board.type eq 'apartment'}">selected</c:if>>아파트</option>
						<option value="villa" <c:if test="${board.type eq 'villa'}">selected</c:if>>빌라&연립</option>
						<option value="house" <c:if test="${board.type eq 'house'}">selected</c:if>>단독주택</option>
						<option value="office" <c:if test="${board.type eq 'office'}">selected</c:if>>사무공간</option>
						<option value="commercial" <c:if test="${board.type eq 'commercial'}">selected</c:if>>상업공간</option>
						<option value="etc" <c:if test="${board.type eq 'etc'}">selected</c:if>>기타</option>
	                </select>
		        </div>
		        <div>    
		            <label for="familyType">가족형태</label>
		        	<span>*</span>
	                <select name="familyType" id="familyType">
	                    <option value="">선택해주세요</option>
						<option value="singlelife" <c:if test="${board.familyType eq 'singlelife'}">selected</c:if>>싱글라이프</option>
						<option value="honeymoon" <c:if test="${board.familyType eq 'honeymoon'}">selected</c:if>>신혼 부부</option>
						<option value="withbaby" <c:if test="${board.familyType eq 'withbaby'}">selected</c:if>>아기가 있는 집</option>
						<option value="withchild" <c:if test="${board.familyType eq 'withchild'}">selected</c:if>>취학 자녀가 있는 집</option>
						<option value="withparent" <c:if test="${board.familyType eq 'withparent'}">selected</c:if>>부모님과 함께 사는 집</option>
						<option value="etc" <c:if test="${board.familyType eq 'etc'}">selected</c:if>>기타</option>
	                </select>
		        </div> 
		        <div>    
		            <label for="workingArea">작업분야</label>
		        	<span>*</span>
	                <select name="workingArea" id="workingArea">
	                    <option value="">선택해주세요</option>
						<option value="remodeling" <c:if test="${board.workingArea eq 'remodeling'}">selected</c:if>>리모델링</option>
						<option value="homestyling" <c:if test="${board.workingArea eq 'homestyling'}">selected</c:if>>홈스타일링</option>
						<option value="partial" <c:if test="${board.workingArea eq 'partial'}">selected</c:if>>부분공사</option>
						<option value="construct" <c:if test="${board.workingArea eq 'construct'}">selected</c:if>>건축</option>
	                </select>
		        </div>
		        <div> 
		        	<label for="worker">작업자</label>
		        	<span>*</span>
	                <select name="worker" id="worker">
	                    <option value="">선택해주세요</option>
						<option value="self" <c:if test="${board.worker eq 'self'}">selected</c:if>>셀프&DIY</option>
						<option value="halfself" <c:if test="${board.worker eq 'halfself'}">selected</c:if>>반셀프</option>
						<option value="expert" <c:if test="${board.worker eq 'expert'}">selected</c:if>>전문가</option>
	                </select>
		        </div>
				<div>
					<label for="sqft">평수</label> 
					<select name="sqft" id="sqft">
						<option value="">선택해주세요</option>
						<option value="sqft9" <c:if test="${board.sqft eq  'sqft9'}">selected</c:if>>0~9평</option>
						<option value="sqft10" <c:if test="${board.sqft eq 'sqft10'}">selected</c:if>>10평대</option>
						<option value="sqft20" <c:if test="${board.sqft eq 'sqft20'}">selected</c:if>>20평대</option>
						<option value="sqft30" <c:if test="${board.sqft eq 'sqft30'}">selected</c:if>>30평대</option>
						<option value="sqft40" <c:if test="${board.sqft eq 'sqft40'}">selected</c:if>>40평대</option>
						<option value="sqft50" <c:if test="${board.sqft eq 'sqft50'}">selected</c:if>>50평대</option>
						<option value="sqft60" <c:if test="${board.sqft eq 'sqft60'}">selected</c:if>>60평 이상</option>
					</select>
				</div>
				<div>    
		            <label for="roomNum">방개수</label>
	                <select name="roomNum" id="roomNum">
	                    <option value="">선택해주세요</option>
	                    <option value="rn1" <c:if test="${board.roomNum eq 'rn1'}">selected</c:if>>1개</option>
	                    <option value="rn1.5" <c:if test="${board.roomNum eq 'rn1.5'}">selected</c:if>>1.5개</option>
	                    <option value="rn2" <c:if test="${board.roomNum eq 'rn2'}">selected</c:if>>2개</option>
	                    <option value="rn3" <c:if test="${board.roomNum eq 'rn3'}">selected</c:if>>3개</option>
	                    <option value="rn4" <c:if test="${board.roomNum eq 'rn4'}">selected</c:if>>4개</option>
	                    <option value="rn5" <c:if test="${board.roomNum eq 'rn5'}">selected</c:if>>5개이상</option>
	                </select>
		        </div>
				<div>
					<label for="direction">방향</label>
					<select name="direction" id="direction">
						<option value="">선택해주세요</option>
						<option value="south" <c:if test="${board.direction eq 'south'}">selected</c:if>>남향</option>
						<option value="west" <c:if test="${board.direction eq 'west'}">selected</c:if>>서향</option>
						<option value="east" <c:if test="${board.direction eq 'east'}">selected</c:if>>동향</option>
						<option value="north" <c:if test="${board.direction eq 'north'}">selected</c:if>>북향</option>
						<option value="south-west" <c:if test="${board.direction eq 'south-west'}">selected</c:if>>남서향</option>
						<option value="south-east" <c:if test="${board.direction eq 'south-east'}">selected</c:if>>남동향</option>
						<option value="north-west" <c:if test="${board.direction eq 'north-west'}">selected</c:if>>북서향</option>
						<option value="north-east" <c:if test="${board.direction eq 'north-east'}">selected</c:if>>북동향</option>
					</select>
				</div>
		        <div>
		            <label for="year">준공연도</label>
	                <select name="year" id="year">
	                    <option value="">선택해주세요</option>
						<option value="year1980" <c:if test="${board.year eq 'year1980'}">selected</c:if>>1980~1990</option>
						<option value="year1990" <c:if test="${board.year eq 'year1990'}">selected</c:if>>1990~2000</option>
						<option value="year2000" <c:if test="${board.year eq 'year2000'}">selected</c:if>>2000~2010</option>
						<option value="year2010" <c:if test="${board.year eq 'year2010'}">selected</c:if>>2010~2020</option>
	                    <option value="year2020" <c:if test="${board.year eq 'year2020'}">selected</c:if>>2020~</option>
	                </select>
		        </div> 
		        <div>    
		            <label for="location">지역</label>
	                <select name="location" id="location">
	                    <option value="">선택해주세요</option>
	                    <option value="Seoul" <c:if test="${board.location eq 'Seoul'}">selected</c:if>>서울특별시</option>
	                    <option value="Busan" <c:if test="${board.location eq 'Busan'}">selected</c:if>>부산광역시</option>
	                    <option value="Daegu" <c:if test="${board.location eq 'Daegu'}">selected</c:if>>대구광역시</option>
						<option value="Incheon" <c:if test="${board.location eq 'Incheon'}">selected</c:if>>인천광역시</option>
						<option value="Gwangju" <c:if test="${board.location eq 'Gwangju'}">selected</c:if>>광주광역시</option>
						<option value="Daejeon" <c:if test="${board.location eq 'Daejeon'}">selected</c:if>>대전광역시</option>
						<option value="Ulsan" <c:if test="${board.location eq 'Ulsan'}">selected</c:if>>울산광역시</option>
	                    <option value="Gangwon" <c:if test="${board.location eq 'Gangwon'}">selected</c:if>>강원도</option>
	                    <option value="Gyeonggi" <c:if test="${board.location eq 'Gyeonggi'}">selected</c:if>>경기도</option>
	                    <option value="Gyeongsang" <c:if test="${board.location eq 'Gyeongsang'}">selected</c:if>>경상도</option>
	                    <option value="Jeolla" <c:if test="${board.location eq 'Jeolla'}">selected</c:if>>전라도</option>
	                    <option value="Chungcheong" <c:if test="${board.location eq 'Chungcheong'}">selected</c:if>>충청도</option>
	                    <option value="Sejong" <c:if test="${board.location eq 'Sejong'}">selected</c:if>>세종특별자치시</option>
	                    <option value="Jeju" <c:if test="${board.location eq 'Jeju'}">selected</c:if>>제주특별자치도</option>
	                </select>
		        </div> 
		    </div>
		    <div id="additionalForm2">
		        <h3>살림수납 게시판 추가 입력사항</h3>
		        <h6>* 표시는 필수 입력사항입니다.</h6>
		        <div>
		            <label>분야</label>
		        	<span>*</span>
	                <select name="livingtype" id="livingtype">
	                    <option value="">선택해주세요</option>
						<option value="living1" <c:if test="${board.livingtype eq 'living1'}">selected</c:if>>수납꿀팁</option>
						<option value="living2" <c:if test="${board.livingtype eq 'living2'}">selected</c:if>>청소루틴</option>
						<option value="living3" <c:if test="${board.livingtype eq 'living3'}">selected</c:if>>미니멀라이프</option>
	                </select>
		        </div>
		    </div>
		    <div id="additionalForm3">
		        <h3>홈스토랑 게시판 추가 입력사항</h3>
		        <h6>* 표시는 필수 입력사항입니다.</h6>
		        <div>
		            <label>분야</label>
		        	<span>*</span>
	                <select name="cooktype" id="cooktype">
	                    <option value="">선택해주세요</option>
						<option value="cook1" <c:if test="${board.cooktype eq 'cook1'}">selected</c:if>>홈카페</option>
						<option value="cook2" <c:if test="${board.cooktype eq 'cook2'}">selected</c:if>>홈쿡</option>
						<option value="cook3" <c:if test="${board.cooktype eq 'cook3'}">selected</c:if>>그릇수집</option>
						<option value="cook4" <c:if test="${board.cooktype eq 'cook4'}">selected</c:if>>홈파티</option>
						<option value="cook5" <c:if test="${board.cooktype eq 'cook5'}">selected</c:if>>홈바</option>
	                </select>
		        </div>
		    </div>
		    <div id="additionalForm4">
		        <h3>취미일상 게시판 추가 입력사항</h3>
		        <h6>* 표시는 필수 입력사항입니다.</h6>
		        <div>
		            <label>분야</label>
		        	<span>*</span>
	                <select name="dailytype" id="dailytype">
						<option value="">선택해주세요</option>
						<option value="daily1" <c:if test="${board.dailytype eq 'daily1'}">selected</c:if>>플랜테리어</option>
						<option value="daily2" <c:if test="${board.dailytype eq 'daily2'}">selected</c:if>>핫플레이스</option>
						<option value="daily3" <c:if test="${board.dailytype eq 'daily3'}">selected</c:if>>빈티지수집</option>
						<option value="daily4" <c:if test="${board.dailytype eq 'daily4'}">selected</c:if>>육아</option>
						<option value="daily5" <c:if test="${board.dailytype eq 'daily5'}">selected</c:if>>음악감상</option>
						<option value="daily6" <c:if test="${board.dailytype eq 'daily6'}">selected</c:if>>반려동물</option>
						<option value="daily7" <c:if test="${board.dailytype eq 'daily7'}">selected</c:if>>선물추천</option>
						<option value="daily8" <c:if test="${board.dailytype eq 'daily8'}">selected</c:if>>키덜트</option>
						<option value="daily9" <c:if test="${board.dailytype eq 'daily9'}">selected</c:if>>향테리어</option>
						<option value="daily10" <c:if test="${board.dailytype eq 'daily10'}">selected</c:if>">캠핑</option>
					</select>
		        </div>
		    </div>
	    </div>

		<table>
			<tbody>
			<input type="hidden" name="num" id="num" value="${board.num}">
			<tr>
				<td><label for="title" style="display:none;">제목</label></td>
				<td><input type="text" id="title" name="title" placeholder="제목을 입력해주세요."
						   value="${board.title}" class="binsert-title"></td>
			</tr>
			<tr>
				<td><label for=thumbfile style="display:none;">커버 사진 추가하기</label></td>
				<td class="binsert-thumb">
					<label style="font-size:18px;color:gray;margin-right:10px;">커버 사진 추가하기</label>
					<input type="file" id="thumbFile" name="thumbFile" value="">
				</td>
			</tr>
			<tr>
				<td><label for="nickname" style="display:none;">nickname:</label></td>
				<td><input type="hidden" id="nickname" name="nickname"
						   value="" placeholder="닉네임"></td>
			</tr>
			<tr>
				<td><label for="content"  style="display:none;">내용</label></td>
				<td class="binsert-content">
					<textarea rows="20" cols="80" name="content" id="content">${board.content}</textarea>
					<script>CKEDITOR.replace('content',ckeditor_config);</script>
				</td>
			</tr>
			<tr>
				<td><label for="tag" style="display:none;">tag:</label></td>
				<td><input type="hidden" id="tag" name="tag"
						   value="" placeholder="tag"></td>
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