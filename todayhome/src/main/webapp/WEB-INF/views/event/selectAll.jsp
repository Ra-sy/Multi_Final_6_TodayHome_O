<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>
<link rel="stylesheet" href="../resources/css/event_selectAll.css">
<style>
.fixed-menu {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 999;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

	$(function(){
		$(function(){
		    $.ajax({
		        url:"/evJsonSelectAll",
		        method:'GET',
		        dataType:'json',
		        success: function(arr){
		            console.log('ajax...success: ',arr);
		            
		            // 종료된 이벤트와 진행 중인 이벤트를 분리
		            let completedEvents = [];
		            let ongoingEvents = [];
		            
		            $.each(arr,function(index,vo){
		                // 현재 날짜 가져오기 -> 진행중 or 종료 표시하기
		                let currentDate = new Date();
		                let endDate = new Date(vo.enddate.replace(/-/g, '/')); // 날짜 형식 변환
		                let status = endDate < currentDate ? '종료' : '진행중'; // 현재 날짜와 비교하여 상태 설정
		                
		                vo.status = status; // 이벤트 객체에 상태 정보 추가
		                
		                if (status === '종료') {
		                    completedEvents.push(vo); // 종료된 이벤트 배열에 추가
		                } else {
		                    ongoingEvents.push(vo); // 진행 중인 이벤트 배열에 추가
		                }
		            })
		            
		            // 종료된 이벤트와 진행 중인 이벤트를 병합
		            let ev_vos = ongoingEvents.concat(completedEvents);
		            
		            let tableHTML = '';
		            
		            $.each(ev_vos, function(index, vo){
		                if (index % 2 === 0) {
		                    tableHTML += '<tr>';
		                }
		                
		                let statusColor = vo.status === '종료' ? '#b0b0b0' : '#35C5F0'; // 종료인 경우 회색, 진행중인 경우 파란색으로 설정
		                
		                tableHTML += `
		                    <td class="ev_wrap">
		                        <div><a href="evSelectOne/\${vo.num}">
		                            <img class="ev-img" src="../resources/evImg/\${vo.img}">
		                        </a></div>
		                        <div class="oneline">
		                            <span class="oneline-status" style="color: \${statusColor}; font-weight: bold;">\${vo.status}</span>
		                            <span class="oneline-date">\${vo.startdate}~\${vo.enddate}</span>
		                        </div>
		                    </td>
		                `;
		                
		                if ((index + 1) % 2 === 0 || index === ev_vos.length - 1) {
		                    tableHTML += '</tr>';
		                }
		            })
		            
		            $("#ev_vos").html(tableHTML);
		        },
		        error: function(xhr, status, error){
		            console.log('xhr.status: ',xhr.status);
		        }
		    });
		});//end ajax...
	});//end onload...
	
</script>
</head>
<body>
<div class="fixed-menu">
<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
<jsp:include page="../topMenu.jsp">
	<jsp:param name="usrImg" value="${currMbr.img}"/>
</jsp:include>
</div>


	<table style="margin-top: 170px;">
		<thead>
		
		</thead>
		<tbody id="ev_vos">
		
		</tbody>
	
	</table>

</body>
</html>
