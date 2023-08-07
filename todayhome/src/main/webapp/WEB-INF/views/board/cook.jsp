<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 홈스토랑</title>
<link rel="stylesheet" href="../resources/css/board_cook.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">
    let list = "";
    var result = [];
    let currentPage = 0;
    let isLoading = false;
    let isLastPage = false;		//마지막 페이지 여부를 확인하기 위한 변수

    function handleSelectChange() {
        console.log($('#sortKey').val() === "");
        // 선택된 옵션 값 가져오기
        const sortKey = $('#sortKey').val().length == 0 ? "new" : $('#sortKey').val();
        const cookKey = $('#cookKey').val();

        // 선택된 옵션으로 URL 생성
        let newUrl = "?";

        if (sortKey) {
            newUrl += "sortKey=" + sortKey;
        }
        if (cookKey) {
            newUrl += "&cookKey=" + cookKey;
        }
       

        // URL 업데이트
        window.history.replaceState(null, null, newUrl);
        console.log(newUrl);

        $('#vos').empty();	//기존데이터들 비우기

        $.ajax({
            url: "/bJsonSelect3" + newUrl,
            method: 'GET',
            dataType: 'json',
            success: function (arr) {
                console.log("ajax success:", arr);

                // 페이지 설정을 위해 결과 배열에 데이터 저장 (첫페이지에 기본 12개)
                result = [];
                currentPage = 0;
                list = arr;
                console.log(list);
                for (let i = 0; i < list.length; i += 12) {
                    result.push(list.slice(i, i + 12));
                }
                // 첫 페이지 표시
                fn_page(currentPage);
            },
            error: function (xhr, status, error) {
                console.log('xhr.status:', xhr.status);
            },
            complete: function () {
                isLoading = false; // 데이터 로딩 완료 후 isLoading 값을 false로 설정
            }
        });
    }

    function fn_page(num) {
        // 데이터를 표시할 HTML 생성
        let vos = ``;
        const arr = result[num]; // 해당 페이지의 데이터 가져오기
        
        if (typeof arr === 'undefined') {
            isLastPage = true; 	// 데이터가 없는 경우 마지막 페이지로 설정
            return;            	// 데이터가 없으므로 함수 실행 중지
        }

        if (!Array.isArray(arr) || arr.length === 0) {
            isLastPage = true; 	// 데이터가 없는 경우 마지막 페이지로 설정
           return; 				// 데이터가 없으므로 함수 실행 중지
        }

        $.each(arr, function (index, vo) {
            if (index % 4 === 0) {
                vos += '<tr>';
            }

            vos += `
                <td>
	                <div class="boards-container" style="position: relative;">
	                <div class="boards-img-wrap">
	                	<a href="/bSelectOne/\${vo.num}">
	                    <img class="boards-img" src="../resources/uploadimg/\${vo.imgThumb}">
	                	</a>
	                	<button data-num="\${vo.num}" class="favor-btn \${vo.fvYn === 1 ? 'on' : '' }"></button>
	                </div>
                    </div>
                    <div style="text-align: center;">
                        <div class="housing-title">\${vo.title}</div>
                        <div class="housing-nickname">\${vo.mbrNickname}</div>
                        <div class="housing-count">좋아요 \${vo.fvCnt} · 조회 \${vo.vcount}</div>
                    </div>
                </td>
            `;


            if ((index + 1) % 4 === 0 || index === arr.length - 1) {
                vos += '</tr>';
            }
        });

        $('#vos').append(vos);
        isLoading = false;
    }

    function handleScroll() {
        if (isLoading || isLastPage) {
            return; 	// 데이터 로딩 중이거나 마지막 페이지인 경우 함수 실행 중지
        }
        if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {	//스크롤이 닿는 거리
            isLoading = true;
            currentPage += 1;

            $('#loading').show();	// 로딩 표시 추가

            setTimeout(function() {
                fn_page(currentPage);
                $('#loading').hide();	// 로딩 표시 제거
            }, 500); // 500밀리초(0.5초)의 지연을 추가합니다.
            
            console.log('scroll...')
        }
    }

    function handleSelectChange1() {	//모두보기 선택시 집들이 초기상태로 돌아옴
        const selectElement = document.getElementById('sortKey');
        const selectedValue = selectElement.value;

        if (selectedValue === 'all') {
            window.location.href = '/topics/cook';
        }
    }
    
    $(document).ready(function () {
        $('select').on('change', handleSelectChange);

        // 초기 선택 변경 이벤트 트리거
        handleSelectChange();

        // 로딩 표시를 위한 HTML 요소 추가
        $('body').append('<div id="loading" style="display: none;">로딩 중...</div>');

        // 스크롤 이벤트 바인딩
        $(window).bind('scroll', handleScroll);
    });
    
    window.onload = function(){
		const data = {
			num : 0,
			usrMnum: <c:out value="${usrMnum}"/>
		};

		function fvClick(evBrdNum) {
			data.num = evBrdNum;

			if (data.usrMnum != 0) {
				$.ajax({
					url: '/bJsonSelectOneFvClick',
					data: JSON.stringify(data),
					contentType: 'application/json; charset=utf-8',
					method: 'POST',
					success: function(resp) {
						console.log("ajax success...resp: ", resp);

						if (resp.favorYn === 'Y') {
							$(`.favor-btn[data-num='\${evBrdNum}']`).addClass("on");
						} else {
							$(`.favor-btn[data-num='\${evBrdNum}']`).removeClass("on");
						}
					},
					error: function(xhr, status, error) {
						console.log('error');
					}
				});
			} else {
				alert('로그인 후 이용할 수 있습니다.');
				location.href='/login';
			}
		}

		function eventListener() {
			$('#area').off();
			$('#area').on('click', '.favor-btn', function(e) {
				fvClick(e.target.getAttribute("data-num"));
			});
		}

		eventListener();
	}
</script>


</head>
<body>
<div class="fixed-menu">
<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
<jsp:include page="../topMenu.jsp">
	<jsp:param name="usrImg" value="${currMbr.img}"/>
</jsp:include>
</div>

<div class="board-housing-wrap" style="margin-top: 190px;">
	<div class="select-container">
	<select id="sortKey" onchange="handleSelectChange1()">
		<option value="">정렬</option>
		<option value="new">최신순</option>
		<option value="old">오래된 순</option>
		<option value="popular">인기순</option>
		<option value="all">모두보기</option>
	</select>
	<select id="cookKey">
		<option value="">카테고리</option>
		<option value="cook1">홈카페</option>
		<option value="cook2">홈쿡</option>
		<option value="cook3">그릇수집</option>
		<option value="cook4">홈파티</option>
		<option value="cook5">홈바</option>
	</select>
	</div>
	
	<table id="area">
		<thead>

		</thead>
		<tbody>
			<tr>
				<td>
					<table>
						<tbody id="vos">

						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<script>
		$(window).unbind('scroll'); // 스크롤 이벤트 언바인딩 (마지막 데이터에 도달하면 스크롤 이벤트를 중지)
	</script>
	
</body>
</html>
