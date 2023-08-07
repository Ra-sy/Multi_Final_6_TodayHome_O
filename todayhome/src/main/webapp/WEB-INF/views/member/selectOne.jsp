<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 회원정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">


$(function(){
	console.log("log...");
		$.ajax({
			url : "mJsonSelectOne",
			data:{num:${param.num}},
			method:'GET',//default get
// 			method:'POST',
			dataType:'json', //xml,text
			success : function(vo2) {
				console.log('ajax...success:', vo2);//{}
				let tag_vo = `
	 				<tr>
	 					<td>\${vo2.num}</td>
	 					<td>\${vo2.email}</td>
	 					<a href="/pwCheck/\${param.num}">회원수정pwcheck</a>
	 					
	 				</tr>
	 			`;
				
				$("#vo2").html(tag_vo);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	});


</script>

</head>
<body>
<table>

<tbody id="vo2">

	<%-- <a href="mUpdate/${param.num}">회원수정update</a> --%>
	
</tbody>
</table>

	
</body>
</html>