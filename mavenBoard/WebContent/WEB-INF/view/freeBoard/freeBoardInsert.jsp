<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
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
		var name = $("#name");
		var title = $("#title");
		var content = $("#content");
		var tName = trim(name.val());
		var tTitle = trim(title.val());
		var tContent = trim(content.val());
		
		if(tName == null || tName == "") {
			alert("이름을 입력해 주세요.");
			name.focus();
			return false;
			
		} else if (tName.length < 2 || tName.length > 10) {
			alert("이름은 최소 두 글자이상 10글자 이하로 입력 가능합니다.");
			name.focus();
			return false;
			
		} else if(tTitle == null || tTitle == "") {
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
		}  */else {
			var result = confirm("글 쓰기를 완료하시겠습니까?");
			if (result) {
				return result;
			} else {
				return result;
			}
		} 
	}

	function writeAjax() {
		
		var result = validate();
		if(result) {
			var serializedText = $("#insertForm").serialize();
			console.log(serializedText);
			//return false; //시작 방지용
			$.ajax({ url: "./freeBoardInsertAjax.ino",
				 type: "post",
				 data: serializedText,
				 dataType: "json", 
				 success: function(data) {
					 if(data.judge) {
						 alert("DB쿼리 실행 성공 :"+data.judge);
						 location.href="./main.ino";
					 } else {
						 alert("실패 : DB쿼리 실행 조건이 안 맞습니다."+data.judge);
						 location.reload();
					 }

				 }, error: function(request,status,error) {
					 alert(error.statusText+" 실패"); 
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

					 }
			}); 
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
	
	
	<!--<form action="./freeBoardInsertPro.ino">-->
	<form:form role="form" id="insertForm" commandName="freeBoardDto" onsubmit="return validate();" action="./freeBoardInsertPro.ino" method="post">
		
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left">
			<!-- <input type="text" name="name" value=""/> -->
			<form:input type="text" id="name" placeholder="이름을 입력하세요." maxlength="5" path="name" />
			<form:errors path="name" />
		</div>
		
		
		<div style="width: 150px; float: left;" >제목 :</div>
		<div style="width: 500px; float: left;" align="left">
			<!-- <input type="text" name="title"/> -->
			<form:input type="text" id="title" placeholder="제목을 입력하세요." path="title" />
			<form:errors path="title" />
		</div>
		
		
		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left">
			<!-- <textarea name="content" rows="25" cols="65"  ></textarea> -->
			<form:textarea path="content" id="content" placeholder="내용을 입력하세요." rows="25" cols="65" ></form:textarea>
			<form:errors path="content" />
		</div>
		
		<div align="right">
		<input type="submit" value="글쓰기">
		<input type="button" onclick="writeAjax()" id="writeBtn" value="AJAX글쓰기" />
		<input type="button" value="다시쓰기" onclick="location.href='./freeBoardInsert.ino'">
		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div>
	</form:form>
	
	
</body>
</html>