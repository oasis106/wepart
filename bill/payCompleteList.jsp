<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	.container.content{
	    margin: 0;
	    padding: 0;
	    max-width: 100%;
	    width: 100%;
	    height: 100vh;
	}

	th{
		text-align: center;
	}
	
	td{
		text-align: center;
	}
	
	td:nth-child(4){
		text-align: right;
	}
	
	.card-header{
		font-weight: 600;
		font-size: 1.3rem;
	}
	
	#payListSection{
		padding: 20px;
		width: 90%;
		border: 10px solid;
	}
	
</style>

<section id="payListSection">
	<div class="card">
		<div class="card-header">
			${authMem.memName }님의 관리비 납부내역
		</div>
		<div class="card-body">
			<table class="table table-bordered">
				<thead class="table thead-light">
					<th>부과년월</th>
					<th>납부마감일</th>
					<th>결제일자</th>
					<th>결제금액</th>
				</thead>
				<tbody id="mainTbody">
					<c:if test="${not empty pcList }">
						<c:forEach items="${pcList }" var="pm">
							<tr>
								<td>${pm.billNo}</td>
								<td>${pm.billDline }</td>
								<td>${pm.billPaydate }</td>
								<td><fmt:formatNumber value="${pm.billPaysum }" pattern="#,###" /></td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</section>