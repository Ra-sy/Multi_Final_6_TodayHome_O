<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>

<style>
.fixed-menu {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 999;
}
.table1 {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0;
}
.ev-img {
    width: 600px;
}
.comment-wrapper {
    margin-bottom: 2px;
    padding: 10px;
    border: 0px solid #ccc;	/*마지막에 0px로 바꿔주기*/
    border-bottom: 0px solid #ccc;	/*마지막에 0px로 바꿔주기*/
}
.comment-info {
    display: flex;
    align-items: center;
}
.comment-info img {
    width: 35px;
    margin-right: 10px;
     border-radius: 50%;
}
.comment-writer{
    width: 35px;
    margin-right: -25px;
     border-radius: 50%;
}
.comment-content {
    margin-top: 10px;
}
.comment-time {
    margin-top: 10px;
    color: gray;
    font-size: 11px;
}

#commentInput{
    padding-left: 10px;
    font-weight:bold;
    font-family: 'IBM Plex Sans KR', sans-serif;
}

#submitButton{
    font-weight:bold;
    font-family: 'IBM Plex Sans KR', sans-serif;
}

.comment-container {
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'IBM Plex Sans KR', sans-serif;
    font-weight: bold;
}
.comment-list {
    margin-top: 15px;
    width: 100%;
    max-width: 780px; /* 댓글들의 너비 */
}
.comment-title{
	font-size:20px;
	font-weight:bold;
    font-family: 'IBM Plex Sans KR', sans-serif;
}
.btn-insert{
	position: absolute; 
	top: 0; 
	right: 10px; 
	height: 100%;
	background-color: transparent;
	border:none;
	color:grey;
	font-size:15px;
	font-weight:bold;
	cursor: default;

}
.btn-insert.active {
    cursor: pointer;
}
.btn-delete{
	display: inline;
	background-color: transparent;
	border:none;
	color: gray;
    font-size: 11px;
    cursor: pointer;
    font-family: 'IBM Plex Sans KR', sans-serif;
    font-weight: bold;
}
.comment-my{
margin-left:10px;
font-size:10px;
font-weight:bold;
background-color:#35C5F0;
color:white;
border-radius: 6px;
padding:5px;
}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

	var user_id = '${user_id}'; // JavaScript 변수로 선언
	

    function formatRelativeTime(timestamp) {
        var now = new Date();
        var targetDate = new Date(timestamp);
        
        //서버시간이랑 맞춰주기 (-9시간)
        var targetDateLocal = new Date(targetDate.getTime() - targetDate.getTimezoneOffset() * 60000);

        var elapsed = now.getTime() - targetDateLocal.getTime();
        var seconds = Math.floor(elapsed / 1000);
        var minutes = Math.floor(seconds / 60);
        var hours = Math.floor(minutes / 60);
        var days = Math.floor(hours / 24);
        var months = Math.floor(days / 30); // 한달은 30일로 가정

        if (months > 0) {
            return months + "개월 전";
        } else if (days > 0) {
            return days + "일 전";
        } else if (hours > 0) {
            return hours + "시간 전";
        } else if (minutes > 0) {
            return minutes + "분 전";
        } else {
            return "방금 전";
        }
    }

    function selectAll(num = 0) {
        console.log('selectAll()...num:', num);

        $.ajax({
            url: "/evcJsonSelectAll",
            data: {
                evnum: ${vo2.num}
            },
            method: 'GET',
            dataType: 'json',
            success: function (vos) {
                console.log('ajax...success:', vos);
                let tag_txt = '';

                $.each(vos, function (index, vo) {
                    console.log('user_id: '+user_id+', vo.mnum: '+vo.mnum+', vo.num: '+vo.num);
                    var relativeTime = formatRelativeTime(vo.wdate);
                    
                    let tag_div=``;
                    let myCommentText = '';
                    if(user_id == vo.mnum){
                    	tag_div = `
                    		<div class="comment-delete" style="display: inline-block;">
                    			<button class="btn-delete" onclick="deleteOK(\${vo.num})">· 삭제</button>
                    		</div>
                    	`;
                    	myCommentText = '내 댓글';
                    }

                    tag_txt += `
                        <div class="comment-wrapper">
                            <div class="comment-info">
                            	<a href="/mSelectOne/\${vo.mnum}"><img src="/resources/uploadimg/\${vo.mbrImg}"></a>
                                <span style="font-weight:bold;">\${vo.mbrNickname}</span>
                                \${user_id == vo.mnum ? `<span class="comment-my">\${myCommentText}</span>` : ''}
                                
                            </div>
                            <div class="comment-content">\${vo.content}</div>
                            <div class="comment-time" style="display: inline-block;">\${relativeTime}</div>
                            \${tag_div}
                        </div>
                    `;
                });

                $('#evcomm_list').html(tag_txt);    //display 해주는 곳!!!
                $('#comment_count').text(vos.length);    // 댓글 수 표시
            },
            error: function (xhr, status, error) {
                console.log('xhr.status:', xhr.status);
            }
        }); //end ajax...
    } //end selectAll()...
    
    function checkInputValue() {
        var inputElement = document.getElementById("commentInput");
        var submitButton = document.getElementById("submitButton");
        
        if (inputElement.value.trim() !== "") {
            submitButton.disabled = false;
            submitButton.style.color = "#35C5F0";
            submitButton.classList.add("active");
        } else {
            submitButton.disabled = true;
            submitButton.style.color = "";
            submitButton.classList.remove("active");
            
        }
    }
    
	function insertOK(){
		console.log('insertOK()....');
		$.ajax({
			url : "/evcInsertOK",
			data:{
				evnum:${vo2.num},	//vo2.num
				mnum:'${user_id}',
				content:$('#commentInput').val()
			},
			method:'GET',	
			dataType:'json',	
			success : function(obj) {
				console.log('ajax...success:', obj);	//{"result":1}
				
				if(obj.result==1) {
					selectAll();
                    document.getElementById("commentInput").value = ""; // 입력란 초기화
                    checkInputValue(); // 입력란 상태 확인 및 버튼 상태 갱신
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
		
	}//end insertOK()...
	
	function deleteOK(num=0){
		console.log('deleteOK()....num:',num);
		
		$.ajax({
			url : "/evcDeleteOK",
			data:{
				num:num
			},
			method:'GET',
			dataType:'json',
			success : function(obj) {
				console.log('ajax...success:', obj);//{"result":1}
				if(obj.result==1) selectAll();
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
		
	}//end deleteOK
    
    
    
</script>
</head>
<body onload="selectAll()">
<div class="fixed-menu">
<%-- <h4>로그인 세션유지 확인 user_id : ${user_id}</h4> --%>
<jsp:include page="../topMenu.jsp">
    <jsp:param name="usrImg" value="${mvo2.img}"/>
</jsp:include>
</div>

<div >
    <table class="table1" style="margin-top: 150px;">
        <tbody>
            <tr style="display:none;">
                <th>num</th>
                <td>${vo2.num}</td>
            </tr>
            <tr style="display:none;">
                <th>title</th>
                <td>${vo2.title}</td>
            </tr>
            <tr style="display:none;">
                <th>content</th>
                <td>${vo2.content}</td>
            </tr>
            <tr>
                <th style="display:none;">contentimg</th>
                <td><img class="ev-img" src="/resources/evImg/${vo2.contentimg}"></td>
            </tr>
        </tbody>
    </table>

    <div class="comment-title" style="margin: 12px auto; width: 100%; max-width: 800px;">
	    댓글 <span id="comment_count" style="color: #35C5F0;"></span>
	</div>
    
    
    <table style="margin: 0 auto; width: 100%; max-width: 800px;">
        <tr>
<%--             <td style="width: 70px; font-size:20px;color:grey;">${mvo2.nickname}</td> --%>
            <td><img class="comment-writer" src="/resources/uploadimg/${mvo2.img}"></td>
            <td style="position: relative;">
            	<input type="text" id="commentInput" name="" value="" placeholder="댓글을 남겨 보세요." 
            	style="width:99%;height:35px;" maxlength="45" oninput="checkInputValue()">
            	<button onclick="insertOK()" class="btn-insert" id="submitButton" disabled>입력</button>
            </td>
        </tr>
    </table>

    <h3></h3>
    <div class="comment-container">
        <div class="comment-list" id="evcomm_list"></div>
    </div>
</div>
    
</body>
</html>
