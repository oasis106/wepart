<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.notice_title{
		cursor: pointer;
	}
	
	.notice_title:hover {
	  text-decoration: underline;
	}
	
	#pagingArea{
		display: flex;
		justify-content: center;
	}
	
 	.table tfoot tr td{ 
 		padding: 0; 
 	} 
 	
 	.form-control, #searchBtn{
  		height: 38px; 
 	}
	
	.pagination{
		padding-top: 16px; 
	}
	
	#searchDIV{
		display: flex;
		justify-content: center;
		margin: auto;
		width: 80%;
		padding: 16px 0;
	}
	
	#searchDIV select{
		flex: 1;
		border-radius: 0;
		margin-right: 6px;
	}
	#searchDIV [name=searchWord]{
		flex: 1.7;
		border-radius: 0;
	}
	#insertBtnTR td{
		margin-bottom: 12px;
		border: none;
	}
	
 th, td{
 	text-align: center;
 }
 .table{
 table-layout: fixed;
 }
.count{
  color: blue;
  font-weight: bold;
}

.card-body{
	width : 1500px;
}
.card{
	width : 1500px;
}
.container.content{
	padding : 40px;
	margin:40px;
	margin-top: 10px;
}
.site-section {
    padding: 0em 0;
}	
</style>
<script src="${cPath }/resources/js/jquery.form.min.js"></script>

<div class="card">
	<div class="card-body">
		<h3 class="font-weight-bold">공지사항</h3>
		<br>
		<table class="table table-hover">
			<thead class="thead">
					<c:if test="${authMem.memRole != 'ROLE_USER' }">
						<tr id="insertBtnTR">
							<td colspan="0">
								<button id="insertNotice" class="btn btn-primary">글쓰기</button>
							</td>
						</tr>		
					</c:if>
					<tr>
						<th style="width:100px;" scope="col">글번호</th>
						<th style="width:400px;" scope="col">제목</th>
						<th style="width:150px;" scope="col">작성자</th>
						<th style="width:150px;" scope="col">작성일</th>
						<th style="width:100px;" scope="col">조회</th>
						<th style="width:100px;" scope="col">추천수</th>
					</tr>
				</thead>
				
				<tbody id="noticeArea">
				
				</tbody>
				
				<tfoot>
					<tr>
						<td colspan="6">
							<div id="pagingArea">
							
							</div>
						</td>
					</tr>
					<tr>
						<td id="searchTd" colspan="6">
							<div id="searchDIV">
								<select class="form-control" name="searchDate">
									<option value="all">전체</option>
									<option value="day">1일</option>
									<option value="week">1주</option>
									<option value="month">1개월</option>
									<option value="halfYear">6개월</option>
									<option value="year">1년</option>
								</select>
								<select class="form-control" name="searchType">
									<option value="title">제목</option>
									<option value="content">내용</option>
									<option value="titleContent">제목+내용</option>
									<option value="writer">작성자</option>
								</select>
								<input type="text" class="form-control" name="searchWord" />
								<input type="button" id="searchBtn" class="btn btn-primary" value="검색" />
							</div>
						</td>
					</tr>
				</tfoot>
		</table>
	
	</div>
</div>
	
<form id="searchForm">
	<input type="hidden" name="page" id="pageInput"/>
	<input type="hidden" name="searchDate" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>

<script>
	
	// 글쓰기 버튼 클릭시, 글등록 화면으로 이동
	$('#insertNotice').on('click', function(){
		location.href = '${cPath}/notice/new';
	})
	
	// 게시글의 제목 클릭시, 게시글 상세페이지로 이동
	let noticeArea = $('#noticeArea').on('click', '.notice_title', function(){
		let ntNo = $(this).data('ntno');
		let viewURL = CONTEXTPATH + '/notice/' + ntNo +'?mp=M70';
		if(!viewURL) return false;
		location.href = viewURL;
	});
	
	let pageInput = $('#pageInput');
	
	// 페이지 번호 클릭시, 해당페이지로 이동.
	let pagingArea = $('#pagingArea').on('click', '.page-link', function(){
		event.preventDefault();
		pageInput.val($(this).data('page'));
		searchForm.submit();
	});
	
	let searchDIV = $('#searchDIV');
	
	// searchForm에 submit 요청방식을 비동기요청으로 변경하고, 요청발생시 응답데이터 처리.
	let searchForm = $('#searchForm').ajaxForm({
		dataType: 'json',
		method: 'get',
		success: function(paging){
			let noticeList = paging.dataList;
			if(noticeList == null || noticeList.length == 0){
				let tr = "<tr><td colspan=6>조회된 게시글이 없습니다.</td></tr>";
				noticeArea.html(tr);
			}else{
				let trs = [];
				for(let i=0; i<noticeList.length; i++){
					let tr = "<tr id='TR_" + noticeList[i].ntNo + "'>";
					tr += "<td>"+ (paging.totalRecord-noticeList[i].rnum+1) +"</td>";
					tr += "<td data-ntno=" + noticeList[i].ntNo + " class='notice_title'>"+ noticeList[i].ntTitle +"</td>";
					tr += "<td>"+ noticeList[i].empId +"</td>";
					tr += "<td>"+ noticeList[i].ntCreate +"</td>";
					tr += "<td>"+ noticeList[i].ntHit +"</td>";
					tr += "<td>"+ noticeList[i].ntLike +"</td>";
					tr += "</tr>";
					trs.push(tr);
				}			
				noticeArea.html(trs);
				pagingArea.html(paging.pagingHTML);
				
			}
			
		}
	}).submit();
	
	// 검색버튼 클릭시 이벤트
	let searchBtn = $('#searchBtn').on('click', function(){
		let inputs = searchDIV.find(':input[name]');
		let formInputs = searchForm.find('input[name]');
		$(formInputs[0]).val('');
		for(let i=0; i<inputs.length; i++){
			$(formInputs[i+1]).val(inputs[i].value);
		}
		searchForm.submit();
	})
</script>