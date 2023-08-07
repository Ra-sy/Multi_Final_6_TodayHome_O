<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- <%@ page session="false" %> --%>
<html>
<head>
<title>오늘의집</title>
<link rel="stylesheet" href="/resources/css/home.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {

	$(function(){
		
		// 이벤트글 selectAll
		$.ajax({
		  url: "/evJsonSelectAllBanner",
		  method: 'GET',
		  dataType: 'json',
		  success: function(arr) {
		    console.log('ajax...success...ebanner:', arr);

		    let tag_vos = '';
		    let currentIndex = 0;

		    // 이미지 변경 함수
		    function changeImage() {
		      // 현재 인덱스에 해당하는 이미지 정보 가져오기
		      const vo = arr[currentIndex];

		      // 이미지 태그 생성
		      const imageTag = `
		          <div class="banner-random-event">
		            <div class="e-banner-img-wrap">
		              <a href="/evSelectOne/\${vo.num}"><img class="e-banner-img" src="resources/evImgBanner/\${vo.img}"></a>
		            </div>
		          </div>
		      `;

		      // 이미지 업데이트
		      $("#vos").html(imageTag);

		      // 다음 인덱스로 이동
		      currentIndex = (currentIndex + 1) % arr.length;
		    }

		    // 초기 이미지 표시
		    changeImage();

		    // 5초마다 이미지 변경
		    setInterval(changeImage, 5000);
		  },
		  error: function(xhr, status, error) {
		    console.log('xhr.status:', xhr.status);
		  }
		}); // end $.ajax()...

	
		//랜덤글 배너
		$.ajax({
			url : "/json_b_random",
			method:'GET',
			dataType:'json',
			success : function(vo2) {
				console.log('ajax...success...brandom: ', vo2);

				let data = '';
						data += `<div class="banner-random-main" style="position: relative;">
									<div class="banner-random-board" >
										<a href="/bSelectOne/\${vo2.num}">
											<div class="s_banner_img1-wrap" style="border: 2px dotted #dadada; border-radius: 5px">
												<img class="s_banner_img1" src="resources/uploadimg/\${vo2.imgThumb}">
											</div>
										</a>
										<div class="banner-random-inside" style="position: absolute; bottom:25px; left:42px;color:white;">
											<div class="s_banner_text">\${vo2.title}</div>
											<div class="banner-random-nick">
												<div><img class="s_banner_img2" src="resources/uploadimg/\${vo2.mbrImg}" style="width:25px;border-radius:50%;margin-right:5px;"></div>
												<div class="s_banner_text2" style="font-size:15px;font-weight:bold;">\${vo2.mbrNickname}</div>
											</div>
										</div>
									</div>
								</div>`;

				$('#vo2').html(data);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
		//최신글 목록-집들이
		$.ajax({
			url : "/json_b_views",
			method:'GET',
			dataType:'json',
			success : function(arr) {
				console.log('ajax...success...ros:', arr);

	 			let tag_ros = '';

	 			$.each(arr,function(index,vo){
	 				//console.log('ajax...success...ros:', vo.imgThumb,vo.title);

	 				if (index % 4 === 0) {
	 					tag_ros += '<tr>';
	 	            }

	 				tag_ros += `
	 					<td>
	 						<div class="homes-wrap">
	 							<a href="/bSelectOne/\${vo.num}">
		 							<div class="liimg">
		 								<img class="home-img" src="resources/uploadimg/\${vo.imgThumb}">
		 							</div>
		 							<div class="litext">\${vo.title}</div>
	 							</a>
	 						</div>
	 					</td>
	 				`;

	 				if ((index + 1) % 4 === 0 || index === arr.length - 1) {
	 					tag_ros += '</tr>';
            		}
	 			});

				$("#ros").html(tag_ros);


			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
		//인기글 목록-집들이
		$.ajax({
			url : "/json_b_views2",
			method:'GET',
			dataType:'json',
			success : function(arr) {
				console.log('ajax...success...ros2: ', arr);

	 			let tag_ros = '';

	 			$.each(arr,function(index,vo){
	 				//console.log('ajax...success...ros2: ', vo.imgThumb,vo.title);

	 				if (index % 4 === 0) {
	 					tag_ros += '<tr>';
	 	            }

	 				tag_ros += `
	 					<td>
	 						<div class="homes-wrap">
	 							<a href="/bSelectOne/\${vo.num}">
		 							<div class="liimg"><img class="home-img" src="resources/uploadimg/\${vo.imgThumb}"></div>
		 							<div class="litext">\${vo.title}</div>
	 							</a>
	 						</div>
	 					</td>
	 				`;

	 				if ((index + 1) % 4 === 0 || index === arr.length - 1) {
	 					tag_ros += '</tr>';
            		}
	 			});

				$("#ros2").html(tag_ros);


			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
		//최신글 목록-자유게시판
		$.ajax({
			url : "/json_b_viewsFree",
			method:'GET',
			dataType:'json',
			success : function(arr) {
				console.log('ajax...success...rosfree:', arr);

	 			let tag_ros = '';

	 			$.each(arr,function(index,vo){
	 				//console.log('ajax...success...rosfree:', vo.imgThumb,vo.title);

	 				if (index % 4 === 0) {
	 					tag_ros += '<tr>';
	 	            }

	 				tag_ros += `
	 					<td>
 						<div class="homes-wrap">
							<a href="/bSelectOne/\${vo.num}">
								<div class="liimg">
									<img class="home-img"
										src="resources/uploadimg/\${vo.imgThumb}" height=150px;
										width=240px;>
								</div>
								<div class="litext">\${vo.title}</div>
							</a>
						</div>
	 					</td> 
	 				`;
	 				
	 				if ((index + 1) % 4 === 0 || index === arr.length - 1) {
	 					tag_ros += '</tr>';
            		}
	 			});
				
				$("#rosfree").html(tag_ros);
				
	
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
		//인기글 목록-자유게시판
		$.ajax({
			url : "/json_b_viewsFree2",
			method:'GET',
			dataType:'json',
			success : function(arr) {
				console.log('ajax...success...rosfree2:', arr);

	 			let tag_ros = '';

	 			$.each(arr,function(index,vo){
	 				//console.log('ajax...success...rosfree2:', vo.imgThumb,vo.title);

	 				if (index % 4 === 0) {
	 					tag_ros += '<tr>';
	 	            }

	 				tag_ros += `
	 					<td>
 						<div class="homes-wrap">
							<a href="/bSelectOne/\${vo.num}">
								<div class="liimg">
									<img class="home-img"
										src="resources/uploadimg/\${vo.imgThumb}" height=150px;
										width=240px;>
								</div>
								<div class="litext">\${vo.title}</div>
							</a>
						</div>
	 					</td>
	 				`;

	 				if ((index + 1) % 4 === 0 || index === arr.length - 1) {
	 					tag_ros += '</tr>';
            		}
	 			});

				$("#rosfree2").html(tag_ros);


			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	});// end onload
	
});// end ready...
	
	
	

</script>
</head>
<body>
<div class="fixed-menu">
<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
<jsp:include page="../topMenu.jsp">
	<jsp:param name="usrImg" value="${currMbr.img}"/>
</jsp:include>
</div>

	<div class="banner">
		<div class="s_banner" id="vo2"></div>
		<div class="side_banner">
			<div class="outer">
				<div id="vos" class="inner-list"></div>
			</div>
		</div>
	</div>

	<div class="more">
	<!-- 	<a href="" class="">최근 게시한 글</a> -->
		<div class="more-exp">🏠집들이🏠 | 최근 게시한 글</div>
		<div class="more-a-tag">
			<a href="/bSelectAll" class="">더보기</a>
		</div>
	</div>
	<table class="more-list">
		<tbody id="ros"></tbody>
	</table>
	<div class="more">
	<!-- 	<a href="" class="">최근 게시한 글</a> -->
		<div class="more-exp">🏠집들이🏠 | ✨최근 일주일간 사랑받은 콘텐츠✨</div>
		<div class="more-a-tag">
			<a href="/bSelectAll" class="">더보기</a>
		</div>
	</div>
	<table class="more-list">
		<tbody id="ros2"></tbody>
	</table>


	<div class="more">
	<!-- 	<a href="" class="">최근 게시한 글</a> -->
		<div class="more-exp">😆자유게시판😆 | 최근 게시한 글</div>
		<div  class="more-a-tag">
			<a href="/topics/living" class="">살림수납</a>
			<a>·</a>
			<a href="/topics/cook" class="">홈스토랑</a>
			<a>·</a>
			<a href="/topics/dailylife" class="">취미일상</a>
		</div>
	</div>
	<table class="more-list">
		<tbody id="rosfree"></tbody>
	</table>
	<div class="more">
	<!-- 	<a href="" class="">최근 게시한 글</a> -->
		<div class="more-exp">😆자유게시판😆 | ✨최근 일주일간 사랑받은 콘텐츠✨</div>
		<div  class="more-a-tag">
			<a href="/topics/living" class="">살림수납</a>
			<a>·</a>
			<a href="/topics/cook" class="">홈스토랑</a>
			<a>·</a>
			<a href="/topics/dailylife" class="">취미일상</a>
		</div>
	</div>
	<table class="more-list">
		<tbody id="rosfree2"></tbody>
	</table>


</body>
</html>
