<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 집들이</title>
<link rel="stylesheet" href="../resources/css/board_selectAll.css">
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
        const typeKey = $('#typeKey').val();
        const familytypeKey = $('#familytypeKey').val();
        const workingareaKey = $('#workingareaKey').val();
        const workerKey = $('#workerKey').val();
        
        <% 
		int usrMnum = 0;
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
		    usrMnum = Integer.parseInt(user_id);
		}
		%>

        // 선택된 옵션으로 URL 생성
        let newUrl = "?";

        if (sortKey) {
            newUrl += "sortKey=" + sortKey;
        }
        if (typeKey) {
            newUrl += "&typeKey=" + typeKey;
        }
        if (familytypeKey) {
            newUrl += "&familytypeKey=" + familytypeKey;
        }
        if (workingareaKey) {
            newUrl += "&workingareaKey=" + workingareaKey;
        }
        if (workerKey) {
            newUrl += "&workerKey=" + workerKey;
        }

        // URL 업데이트
        window.history.replaceState(null, null, newUrl);
        console.log(newUrl);

        $('#vos').empty();	//기존데이터들 비우기

        $.ajax({
            url: "/bJsonSelectIntersection" + newUrl,
            method: 'GET',
            dataType: 'json',
            success: function (arr) {
                console.log("ajax success:", arr);

                // 페이지 설정을 위해 결과 배열에 데이터 저장 (첫페이지에 기본 12개)
                result = [];
                currentPage = 0;
                list = arr;
                //console.log(list);
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

            if (index % 3 === 0) {
                vos += '<tr>';
            }

            vos += `
                <td>
                    <div class="boards-container" style="position: relative;">
                        <div class="boards-img-wrap">
                        	<a href="bSelectOne/\${vo.num}">
                        	<img class="boards-img" src="resources/uploadimg/\${vo.imgThumb}">
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


            if ((index + 1) % 3 === 0 || index === arr.length - 1) {
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
            window.location.href = '/bSelectAll';
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
		<select id="typeKey">
			<option value="">주거형태</option>
			<option value="oneroom">원룸&오피스텔</option>
			<option value="apartment">아파트</option>
			<option value="villa">빌라&연립</option>
			<option value="house">단독주택</option>
			<option value="office">사무공간</option>
			<option value="commercial">상업공간</option>
			<option value="etc">기타</option>
		</select>
		<select id="familytypeKey">
			<option value="">가족형태</option>
			<option value="singlelife">싱글라이프</option>
			<option value="honeymoon">신혼 부부</option>
			<option value="withbaby">아기가 있는 집</option>
			<option value="withchild">취학 자녀가 있는 집</option>
			<option value="withparent">부모님과 함께 사는 집</option>
			<option value="etc">기타</option>
		</select>
		<select id="workingareaKey">
			<option value="">분야</option>
			<option value="remodeling">리모델링</option>
			<option value="homestyling">홈스타일링</option>
			<option value="partial">부분공사</option>
			<option value="construct">건축</option>
		</select>
		<select id="workerKey">
			<option value="">작업자</option>
			<option value="self">셀프&DIY</option>
			<option value="halfself">반셀프</option>
			<option value="expert">전문가</option>
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