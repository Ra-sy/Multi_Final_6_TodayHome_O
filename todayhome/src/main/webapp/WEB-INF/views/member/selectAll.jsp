<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의집 | 회원목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">

</script>


	<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"/mJsonSelectAll",
			method:'GET',
			dataType:'json',
			success: function(arr){
				console.log('ajax...success',arr);
				
				let tag_vos='';
				
				$.each(arr,function(index,vo){
					console.log(index);
					console.log(vo.num);
					tag_vos +=`
					<tr>
					<td>
					<a href="/mSelectOne/\${vo.num}">\${vo.num}</a>
					</td>
					<td>\${vo.email}</td>
					</tr>
					`;
				})
				$('#vos').html(tag_vos);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:',xhr.status);
			}
		});//end $ajax
	});//end load..
	
</script>

</head>
<body>
<table>

<tbody id="vos">
</tbody>
</table>

	
</body>
</html>