<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js "></script>
<script type="text/javascript"  >

function numberOnlyInput(obj,mark,index1,index2) {
	/*
	obj = 값이 들어가야할 필드
	mark = 값 사이에 들어가는 기호
	index1 = 기호가 들어갈 첫번째 위치
	index2 = 기호가 들어갈 두번째 위치
	*/
	
	//unEncodedMark에 인코딩 처리를 해준다.
	
	var number = obj.value.replace(/[^0-9]/g, "");
	var str = "";
	console.log(index1);
	console.log(index2);
	
	if (index1 != null && index2 == null) { //index가 1개일 때
		if (number.length < index1) {
			str = number;
		} else if (number.length >= index1) {
			str += number.substring(0, index1 -1);
			str += mark;
			str += number.substr(index1 -1);
		}
	}
	
	if (index1 != null && index2 != null) { //index가 2개일 때
		if (number.length < index1) {
			str = number;
		} else if (number.length < index2) {
			str += number.substring(0, index1 -1);
			str += mark;
			str += number.substr(index1 -1);
		} else {
			str += number.substring(0, index1 -1);
			str += mark;
			str += number.substring(index1 -1, index2 -1);
			str += mark;
			str += number.substr(index2 -1);
		}
	}
	obj.value = str;
}

function trim(string) {
		var result = string.replace(/^\s+|\s+$/g,"");
		return result;
	}

function goSearch() {
	
	var select = $("#select").val();
	var search = $("#search").val();
	
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();

	var tSearch = trim(search);
	var tStartDate = trim(startDate);
	var tEndDate = trim(endDate);
	var searchExp = /^[0-9]*$/;
	
	var dateExp = /[0-9]{4}\/[0-9]{2}\/[0-9]{2}/;
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var day = today.getDate();
	
	var alertDate = year+"/"+(("00"+month.toString()).slice(-2))+"/"+(("00"+day.toString()).slice(-2));
	
	/*if (search == null || search == "") {
		alert("검색어를 입력해 주세요.");
		$("#search").focus();
		return false;
	} else*/ if (tSearch.length > 30) {
		alert("검색어는 30글자 이하로 입력 가능합니다.");
		$("#search").focus();
		return false;
	
	} else if (!(startDate == "" && endDate == "")) {
		if (startDate == "") {
			alert("시작 날짜는 "+alertDate+" 형식으로 입력해주세요.");
			$("#startDate").focus();
			return false; 
		} else if (endDate == "") {
			alert("종료 날짜는 "+alertDate+" 형식으로 입력해주세요.");
			$("#endDate").focus();
			return false;
		}
		
	} else {
		if (select == "DCODE_PK1") { //dcode의 num을 의미
			if(!(searchExp.test(tSearch))) {
				alert("번호 검색 시 숫자만 입력해 주세요.");
				$("#search").focus();
				return false;
			}
			
		}
		
	} 
	return true;
	
}

 function searchAjax(i_curPage) {
	 
	var select = $("#select").val();
	var search = $("#search").val();
	
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	
	 var tSearch = trim(search);
	 var searchExp = /^[0-9]*$/;
	 //var dataCurPage = i_curPage;
	 
	 var tSearch = trim(search);
	 var tStartDate = trim(startDate);
	 
	 var dateExp = /[0-9]{4}\/[0-9]{2}\/[0-9]{2}/;
	 var today = new Date();
	 var year = today.getFullYear();
	 var month = today.getMonth()+1;
	 var day = today.getDate();
		
	 var alertDate = year+"/"+(("00"+month.toString()).slice(-2))+"/"+(("00"+day.toString()).slice(-2));
		
	 /* if (search == null || search == "") {
			alert("검색어를 입력해 주세요.");
			$("#search").focus();
			return false;
		} else  */if (tSearch.length > 30) {
			alert("검색어는 30글자 이하로 입력 가능합니다.");
			$("#search").focus();
			return false;
		
		} else if (!(startDate == "" && endDate == "")) {
			if (startDate == "") {
				alert("시작 날짜는 "+alertDate+" 형식으로 입력해주세요.");
				$("#startDate").focus();
				return false; 
			} else if (endDate == "") {
				alert("종료 날짜는 "+alertDate+" 형식으로 입력해주세요.");
				$("#endDate").focus();
				return false;
			}
			
		} else {
			if (select == "DCODE_PK1") { //dcode의 num을 의미
				if(!(searchExp.test(tSearch))) {
					alert("번호 검색 시 숫자만 입력해 주세요.");
					$("#search").focus();
					return false;
				}
				
			}

		}
	 
		if (i_curPage === null || i_curPage === undefined) {
			i_curPage = 1;
		}
		
	 var frm = $("#frm").serialize();
	 frm += "&curPageNum="+i_curPage;
	 console.log(frm);
	 //return false; //전송 방지용 false
	 
	 //뒤로가기 이벤트 발생 시 frm에 urlVal을 덮어 씌운다.
	 	 	 
	 $.ajax({ url: "./mainAjax.ino",
		 type: "post",
	 	 data: frm,
		 dataType: "json", 
		 success: function(data) {
			 
			 var url = "./main.ino?select="+data.select+"&search="+data.search+"&startDate="+data.startDate+"&endDate="+data.endDate+"&curPageNum="+data.curPageNum;	 
				history.pushState(null, null, url);
			 
			 //alert("성공"); 
			 
			 var select = data.select;
			 var search = data.search;
			 
			 var list = data.freeBoardList;
			 var pagination = data.freeBoardPagination;
			 
			 if (list == null || list.length == 0) { //value는 dto객체가 들어있는 list객체이다.
					// 검색 결과 없음 표시
						alert("value Empty");
						$("#mainDiv").empty();
						$("#mainEmpty").text("검색 결과가 없습니다.");
			} else {
				 var htmlDiv = "";
				 $("#mainDiv").empty();
				 $("#mainEmpty").text("");
				 for (var i = 0; i < list.length; i++) {

					 htmlDiv += "<div id='mainNum' style='width: 50px; float: left;'>"+list[i].num+"</div>";	
					 htmlDiv += "<div id='mainTitle' style='width: 300px; float: left;'>";
					 htmlDiv += "<a href='./freeBoardDetail.ino?num="+list[i].num+"'>"+list[i].title+"</a>";
					 htmlDiv += "</div>";
					 htmlDiv += "<div id='mainName' style='width: 150px; float: left;'>"+list[i].name+"</div>";
					 htmlDiv += "<div id='mainDate' style='width: 150px; float: left;'>"+list[i].regdate+"</div>";
					 htmlDiv += "<hr style='width: 600px'> ";
					}
				 $("#mainDiv").append(htmlDiv); // 더해라 
				 // $("#mainDiv").html(htmlDiv); // text를 그려라 
			 }
			 
			 if (pagination == null) { //pagination 객체가 비어 있을 경우
				alert("pagination Empty");
			 	
			 } else {
				 var pagingDiv = "";
				 var check = "";
				 $("#pagingBlock").empty();
				 $("#forCheck").empty();
				 //처음 태그 만들고
				 if (pagination.curBlockNum > 1) {
					 pagingDiv += "<a id='linkFirst' href='javascript:void(0)' onClick='searchAjax(1)'>[처음]</a> ";
				 }
				
				 //이전 태그 만들고
				 if (pagination.curPageNum > 1) {
					 pagingDiv += "<a id='linkPre' href='javascript:void(0)' onClick='searchAjax("+pagination.prePageNum+")'>[이전]</a> ";
				 }
				 
				 //스타트 넘버부터 엔드 넘버까지 번호태그 생성 반복
				 for (i_curPage = pagination.startPageNum; i_curPage <= pagination.endPageNum; i_curPage++ ){
					 
					 if (i_curPage == pagination.curPageNum ) {
						 pagingDiv += "<a id='linkNow' href='javascript:void(0)' onClick='searchAjax("+i_curPage+")'> <span style='color : green; font-weight : bold' >"+i_curPage+"</span>  </a>";
					 } else {
						 pagingDiv += "<a id='linkPages' href='javascript:void(0)' onClick='searchAjax("+i_curPage+")'>"+ i_curPage+ "</a> ";
					 }
					
				 }
				
				 //다음 태고 만들고
				 if (pagination.curPageNum < pagination.totalPage) {
					 pagingDiv += "<a id='linkNext' href='javascript:void(0)' onClick='searchAjax("+pagination.nextPageNum+")'>[다음]</a> ";
				 }
				 
				 //마지막 태그 만들고
				 if (pagination.curBlockNum < pagination.totalBlock) {
					 pagingDiv += "<a id='linkLast' href='javascript:void(0)' onClick='searchAjax("+pagination.totalPage+")'>[마지막]</a> ";
				 }
				 pagingDiv +="</br><a id='linkGoogle' href='https://google.com'>Google.com</a>";
				
				 check += "<p>조회된 게시물 수 : "+pagination.totalList+" 현재 페이지 : "+pagination.curPageNum+" 현재 블럭 : "+pagination.curBlockNum+" 총 페이지 : "
				 +pagination.totalPage+" 총 블럭 : "+pagination.totalBlock+" 시작페이지 : "
				 +pagination.startPageNum+" 끝 페이지 : "+pagination.endPageNum+"</p>";
				 
			 }
			 $("#pagingBlock").append(pagingDiv); //생성한 태그 덧 붙이기
			 $("#forCheck").append(check);
				 
			 
			 
			 }, 
		 error: function(request,status,error) {
			 alert(error.statusText+" 실패"); 
			 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

			 } 
		});
	 
	
	 
 }
 
 	function go_page(i_curPage) {
 		var select = $("#hiddenSelect").val();
 		var search = $("#hiddenSearch").val();
 		var startDate = $("#hiddenStartDate").val();
 		var endDate = $("#hiddenEndDate").val();
 		if (search == ""){
 			select = "";
 		}
 		console.log(select, search, startDate, endDate);
 		var url= "./main.ino?select="+select+"&search="+search+"&curPageNum="+i_curPage+"&startDate="+startDate+"&endDate="+endDate;
 		//$("#pagingBlock")의 자식 a들을 선택해서 href 속성값에 url을 넣는다.
 		$("#pagingBlock").children('a').attr("href", url);
 	}
 	
 	


 	
</script>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div>
		<input type="hidden" id="hiddenSelect" name="hiddenSelect" value="${select }"/>
		<input type="hidden" id="hiddenSearch" name="hiddenSearch" value="${search }"/>	
		<input type="hidden" id="hiddenStartDate" name="hiddenStartDate" value="${startDate }"/>	
		<input type="hidden" id="hiddenEndDate" name="hiddenEndDate" value="${endDate }"/>	
		
	</div>
	<form onsubmit="return goSearch();"  id="frm" name="frm">
		<!-- <div id="hiddenSearchData">
			히든 셀렉트
			히든 서치
			히든 시작일
			히든 종료일
		</div> -->
		
		<div>
		<select id="select" name="select">
			<!-- <option value="">전체</option> -->
			<c:forEach var = "list1" items="${commonList1 }" >
				<option value="${list1.DCODE_PK}" <c:if test="${list1.DCODE_PK eq select }" > selected = "selected" </c:if> >
					${list1.DCODE_NAME}
				</option>
			</c:forEach>
		</select>
		
		<select id="year" name="year">
			<c:forEach var = "list1" items="${commonList2 }">
				<option>
					${list1.DCODE_NAME}
				</option>
			</c:forEach>
		</select>
	
		<input type="text" id="search" name="search"  value="${search }" />
		<input type="submit" id="submit" value="검색" />
		<input type="button" onclick="searchAjax()" id="searchBtn" value="AJAX검색" />
		</div>
		
		<div>
		<a>기간</a>
		<input type="text" id="startDate" name="startDate" onkeyup="numberOnlyInput(this,'-',5,7);" maxlength="10" placeholder="YYYY-MM-DD" style= "width :100px" value="${startDate }" />
		<a>~</a>
		<input type="text" id="endDate" name="endDate" onkeyup="numberOnlyInput(this,'-',5,7);" maxlength="10" placeholder="YYYY-MM-DD" style= "width :100px" value="${endDate }" />
		</div>
	</form>		
		
	<div style="width:650px;" align="right">
		<a id="linkWrite" href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px">
	<div id="mainList">
		<div  style="width: 50px; float: left;">번호</div>	
		<div  style="width: 300px; float: left;"><a >제목</a></div>
		<div  style="width: 150px; float: left;">작성자</div>
		<div  style="width: 150px; float: left;">날짜</div> 
	<hr style="width: 600px">
	</div>

	<div id="mainDiv">
		<c:choose>
		<c:when test="${not empty freeBoardList }" >
			<c:forEach items="${freeBoardList }" var="dto">
				<div id="mainNum" style="width: 50px; float: left;">${dto.num }</div>	
				<div id="mainTitle" style="width: 300px; float: left;"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></div>
				<div id="mainName" style="width: 150px; float: left;">${dto.name }</div>
				<div id="mainDate" style="width: 150px; float: left;">${dto.regdate }</div> 
				<hr style="width: 600px">
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div style="width: 650px; float: left;"><a >검색 결과가 없습니다.</a></div>
			<hr style="width: 600px">
		</c:otherwise>
	</c:choose>
		
	</div>
	
	<div id="pagingBlock">
	
		<c:if test="${freeBoardPagination.curBlockNum ne 1 }">
			<a href="#" onClick="go_page(1)">[처음]</a>
		</c:if>
		<c:if test="${freeBoardPagination.curPageNum ne 1 }">
			<a href="#" onClick="go_page('${freeBoardPagination.prePageNum}')">[이전]</a>
		</c:if>
		
		<c:forEach var="i_curPage" begin="${freeBoardPagination.startPageNum}" end="${freeBoardPagination.endPageNum }">
			<c:choose>
				<c:when test="${i_curPage eq freeBoardPagination.curPageNum }" >
					<a href="#" onClick="go_page('${i_curPage}')"> <span style="color : green; font-weight : bold" > ${i_curPage } </span>  </a>
				</c:when>
				<c:otherwise>
					<a href="#" onClick="go_page('${i_curPage}')"> ${i_curPage } </a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
			<c:if test="${freeBoardPagination.curPageNum < freeBoardPagination.totalPage}">
				<a href="#" onClick="go_page('${freeBoardPagination.nextPageNum}')">[다음]</a>
			</c:if>
			<c:if test="${freeBoardPagination.curBlockNum < freeBoardPagination.totalBlock}">
				<a href="#" onClick="go_page('${freeBoardPagination.totalPage}')">[마지막]</a>
			</c:if>

	</div>

	<div id="forCheck"  >
			<p>조회된 게시물 수 ${freeBoardPagination.totalList },
			현재 페이지 ${freeBoardPagination.curPageNum}, 현재 블록 ${freeBoardPagination.curBlockNum}, 
			총 페이지 ${freeBoardPagination.totalPage }, 총 블록 ${freeBoardPagination.totalBlock },
			시작 페이지 ${freeBoardPagination.startPageNum}, 끝 페이지 ${freeBoardPagination.endPageNum }
			</p>
	</div>
	<div style="width: 650px; float: left;"><a id="mainEmpty" ></a></div>
	<hr style="width: 600px">	
</body>
</html>