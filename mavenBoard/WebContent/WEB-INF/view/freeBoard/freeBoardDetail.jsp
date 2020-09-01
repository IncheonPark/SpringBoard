<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>

<!--function modify(){
	var form = document.insertForm;
	form.action = "./freeBoardModify.ino";
	form.method="POST";
	form.submit();
}-->

<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js "></script>
<script type="text/javascript">
// 여기서 일단 데이터들의 유효성을 체크하고 
// 서버에서도 체크를 하긴 하는데 방식이 다르다.
	
	function trim(string) {
		var result = string.replace(/^\s+|\s+$/g,"");
		return result;
	}
	
	function validate() {
		var title = $("#title");
		var content = $("#content");
		var tTitle = trim(title.val());
		var tContent = trim(content.val());
		
		if(tTitle == null || tTitle == "") {
			alert("제목을 입력해 주세요.");
			title.focus();
			return false;

		} else if(tTitle.length < 2 || tTitle.length > 20) {
			alert("제목은 두 글자 이상 스무 글자 이하로 입력해주세요.");
			title.focus();
			return false;
		} else if(tContent == null || tContent == "") {
			alert("내용을 입력해 주세요.");
			content.focus();
			return false;
			
		} /* else if(tContent.length < 1 || tContent.length > 500) {
			alert("내용은 한 글자 이상 500글자 이하로 입력 가능합니다.");
			content.focus();
			return false;
		} */ else {
			var result = confirm("글 수정을 완료하시겠습니까?");
			if (result) {
				return result;
			} else {
				return result;
			}
		} 
	}
	
function updateAjax() {
		
		var result = validate();
		if(result) {
			var serializedText = $("#updateForm").serialize();
			console.log(serializedText);
			//return false; //시작 방지용
			$.ajax({ url: "./freeBoardModifyAjax.ino",
				 type: "post",
				 data: serializedText,
				 dataType: "json", 
				 success: function(data) {
					 if (data.judgement) {
						 alert("DB쿼리 실행 성공 :"+data.judgement);
						 location.href="./main.ino";
					 } else {
						 alert("실패 : DB수정 조건이 맞지 않습니다. "+data.judgement);
						 location.reload();
					 }
	 
				 }, error: function(request,status,error) {
					 alert(error.statusText+" 실패"); 
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

					 }
			}); 
		}
			
	}
	
function goDelete() {
	var result = confirm("삭제를 진행하시겠습니까?");
	if (result) {
		var serializedText = $("#updateForm").serialize();
		console.log(serializedText);
		//return false; //시작 방지용
		$.ajax({ url: "./freeBoardDeleteAjax.ino",
			 type: "post",
			 data: serializedText,
			 dataType: "json", 
			 success: function(data) {
				 if (data.judgement) {
					 alert("성공 data.judgement :"+data.judgement);
					 location.href="./main.ino";
				 } else {
					 alert("실패 data.judgement :"+data.judgement);
					 location.reload();
				 }

			 }, error: function(request,status,error) {
				 alert(error.statusText+" 실패"); 
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

				 }
		}); 
		
	} else {
		location.reload();
	}
}
</script>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

		<form:form role="form" id="updateForm" commandName="freeBoardDto"  onsubmit="return validate();" action="./freeBoardModify.ino" method="post">
		<input type="hidden" id="num" name="num" value="${freeBoardDto.num }" />
		
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" name="name" value="${freeBoardDto.name }" readonly/>
		</div>
		
		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left">
			<!-- <input type="text" name="title"  value="${freeBoardDto.title }"/> -->
			<form:input type="text" id="title" path="title" value="${freeBoardDto.title }" />
			<form:errors path="title" />
		</div>
	
		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left">
			<input type="text" name="regdate"  value="${freeBoardDto.regdate }" readonly/>
		</div>
	
		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left">
			<!-- <textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea> -->
			<form:textarea path="content" id="content" rows="25" cols="65" value="${freeBoardDto.content }"></form:textarea>
			</br> <form:errors path="content" />
		</div>
		<div align="right">
		<input type="submit" value="수정"> <!-- onclick= modify() -->
		<input type="button" onclick="updateAjax()" id="updateBtn" value="AJAX수정" />
		<input type="button" value="다시쓰기" onclick="reset()">
		<input type="button" value="AJAX삭제" onclick = "goDelete();" >
		<!-- "location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }' "-->
		
		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div>
	</form:form>

</body>
</html>