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
		<span>?????? ????????????</span>
	</div>

	<table class="table">
		<thead class="table thead-white">
			<th>?????? ??????</th>
			<th class="thSdate">????????????</th>
			<th class="thState">??????</th>
			<th>????????????</th>
			<th>??????</th>
		</thead>
		<tbody id="empList">
			<c:if test="${not empty reqList }">
				<c:forEach items="${reqList }" var="eachReq">
					<tr>
						<td>
							<c:choose>
								<c:when test="${eachReq.scSort == 'amHoli' }">
									??????(??????)
								</c:when>
								<c:when test="${eachReq.scSort == 'pmHoli' }">
									??????(??????)
								</c:when>
								<c:otherwise>
									??????
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
									<div class="tooltip-primary"><div class="tooltip-inner">?????????</div></div>
								</c:when>
								<c:when test="${eachReq.scState == 'Y' }">
									<div class="tooltip-info"><div class="tooltip-inner">?????????</div></div>
								</c:when>
								<c:when test="${eachReq.scState == 'N' }">
									<div class="tooltip-danger"><div class="tooltip-inner">?????????</div></div>
								</c:when>
								<c:otherwise>
									<div class="tooltip-success"><div class="tooltip-inner">?????????</div></div>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${eachReq.scReqdate }</td>
						<td>
							<c:if test="${eachReq.scState == null }">
							<button class="btn btn-success reqCancelBtn" data-holiid="${eachReq.holiId }">??????</button>
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
			  title: '?????? ????????? ????????????????',
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
									  title: '?????? ??????',
									  showConfirmButton: false,
									  timer: 1500
								})
								location.reload();
							}else {
								Swal.fire({
			     				   icon: 'error',
			     				   title: '????????????: ?????? ??????',
			     				   text: '?????? ?????? ?????? ??????????????????.',
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
