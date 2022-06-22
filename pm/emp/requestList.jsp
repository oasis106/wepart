<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    

<style>
	#empMainContent{
		background-color: white;
		border-top-left-radius: 20px;
	    border-top-right-radius: 20px;
	    border-bottom-right-radius: 20px;
	    border-bottom-left-radius: 20px;
	    padding: 50px;
	    font-size: 1.3rem;
	}
	
	#empMainContent table th {
		font-size: 1.3rem;
	}
	
	#empMainContent table td{
		font-size: 1.1rem; 
 		font-weight: 600; 
	}

	.empList_Header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-weight: 600;
		text-align: center;
		margin-bottom: 20px;
	}
	.empList_Header>span{
		font-size: 1.5em;
	}
	
	
	.empCount{
		margin-top: 20px;
		font-weight: 600;
	}
	
	.empUpdateForm_header{
		border-bottom: 1px solid #e0e0e0;
	    padding: 16px;
	    display: flex;
	    justify-content: space-between;
	    font-size: 1.3em;
	    font-weight: 600;
	}
	
	.empUpdateForm_main{
		padding: 16px;
	}
	
	.empAddForm_header{
		border-bottom: 1px solid #e0e0e0;
		padding: 16px;
		display:flex;
		justify-content: space-between;
		font-size: 1.3em;
		font-weight: 600;
	}
	
	.empAddForm_main{
		padding: 16px;
	}
	
	.form-group.row{
		display: flex;
		align-items: center;
		justify-content: space-around;
	}
	
	.col-sm-2.col-form-label{
		margin-bottom: 0;
		white-space: nowrap;
	}
	
	.error{
		color: red;
	}
	
	.possible{
		color: green;
	}
	
	#empList tr:hover{
		background: #F8F9FA;
	}
	
	#add_submitBtn{
		width: 85%;
	}
	
	#update_submitBtn, #delete_submitBtn{
		width: 45%;
	}
	.form-group.row.submitBtnArea{
		margin-bottom: 0;
		display: flex;
		justify-content: space-evenly;
	}
	
	.closeBtn_insert, .closeBtn_update{
		cursor: pointer;
	}
	
	.thState{
		text-align: center;
	}
	
	.tooltip-inner{
		max-width: 100px;
		min-width: 100px;
		margin: auto;
	}
	
	.reqCancelBtn{
		font-size: 1.5rem;
		background-color: #26b726;
    	border-color: #26b726;
	}
	
	.tooltip-success .tooltip-inner {
	    background-color: #26b726;
	    color: #ffffff;
	}
	
	.table #empList .tdSdate{
		overflow:hidden;
		white-space:nowrap;
 		max-width:300px; 
 		text-overflow:ellipsis;
	}
</style>

<section id="empMainContent">
	<div class="empList_Header">
		<span>나의 요청내역</span>
	</div>

	<table class="table">
		<thead class="table thead-white">
			<th>요청 종류</th>
			<th class="thSdate">요청사항</th>
			<th class="thState">상태</th>
			<th>신청일자</th>
			<th>비고</th>
		</thead>
		<tbody id="empList">
			<c:if test="${not empty reqList }">
				<c:forEach items="${reqList }" var="eachReq">
					<tr>
						<td>
							<c:choose>
								<c:when test="${eachReq.scSort == 'amHoli' }">
									반차(오전)
								</c:when>
								<c:when test="${eachReq.scSort == 'pmHoli' }">
									반차(오후)
								</c:when>
								<c:otherwise>
									연차
								</c:otherwise>
							</c:choose>
						</td>
						<td class="tdSdate">
							<c:forEach items="${eachReq.reqList }" var="eachDay">
								${eachDay.scSdate }, 
							</c:forEach>
						</td>
						<td>
							<c:choose>
								<c:when test="${eachReq.scState == null }">
									<div class="tooltip-primary"><div class="tooltip-inner">대기중</div></div>
								</c:when>
								<c:when test="${eachReq.scState == 'Y' }">
									<div class="tooltip-info"><div class="tooltip-inner">승인됨</div></div>
								</c:when>
								<c:when test="${eachReq.scState == 'N' }">
									<div class="tooltip-danger"><div class="tooltip-inner">거절됨</div></div>
								</c:when>
								<c:otherwise>
									<div class="tooltip-success"><div class="tooltip-inner">취소됨</div></div>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${eachReq.scReqdate }</td>
						<td>
							<c:if test="${eachReq.scState == null }">
							<button class="btn btn-success reqCancelBtn" data-holiid="${eachReq.holiId }">취소</button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</section>


<script>
	$(function(){
		$('.reqCancelBtn').on('click', function(){
			Swal.fire({
			  title: '해당 요청을 취소할까요?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						url: '${cPath}/emp/holi/update/C',
						data: {
							'holiId': this.dataset.holiid,
							'scState': 'C'
						},
						dataType: 'text',
						method: 'post',
						success: function(resp){
							if(resp == 'success'){
								Swal.fire({
									  icon: 'success',
									  title: '취소 완료',
									  showConfirmButton: false,
									  timer: 1500
								})
								location.reload();
							}else {
								Swal.fire({
			     				   icon: 'error',
			     				   title: '서버오류: 취소 실패',
			     				   text: '잠시 후에 다시 시도해주세요.',
			     				   showConfirmButton: false,
			     				   timer: 1500
			     				})
							}
						},
						error: function(error){
							console.log(error);
						}
					})
			  }
			})
		})
	})
	
</script>
