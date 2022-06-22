<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
	.site-section{
		padding: 50px 0;
	}
	
	#billSection.card{
		padding: 20px;
		width: 90%;
		border: 10px solid;
	}
	
	.container.content{
	    margin: 0;
	    padding: 0;
	    max-width: 100%;
	    width: 100%;
	    height: 100vh;
	}

	

	tbody tr td:nth-child(2), tbody tr td:nth-child(3){
		text-align: right;
	}
	
	.costInfo_wrap{
		display: flex;
		flex-direction: row;
		width: 100%;
		font-size: 1.5em;
	}
	
	.costdataBox{
		background-color: #EDEDED;
		display: flex;
		padding: 15px;
		width: 35%;
		border-radius: 12px 0 0 12px;
	}
	
	.costpayBox{
		border: 6px solid #EDEDED;
		width: 65%;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		border-radius: 0 12px 12px 0;
	}
	
	.costpayBox div{
		height: 45%;
		display: flex;
		justify-content: space-between;
		padding: 0 12px;
	}
	
	.costpayBox div:nth-child(1){
		align-items: flex-end;
	}
	
	.costpayBox div .costPay{
		margin-right: 20px;
	}
	
	.dayBox{
		background-color: #0276f8;
		color: white;
		border-radius: 6px;
		width: 5vw;
		height: 5vw;
		text-align: center;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}
	
	.dayBox p{
		margin-bottom: 0;
	}
	
	.endBox {
		display: flex;
		flex-direction: column;
		align-items: center;
 		justify-content: center; 
 		width: 75%; 
	}
	
	.endBox .deadline{
		color: #0276f8;
	}
	
	thead {
		text-align: center;
	}
	
	#mainTbody tr td{
		width: 25%;
	}
	
	.sumUp{
		width: 0px;
		height: 0px;
		border-top:20px solid none;
		border-bottom:20px solid red;
		border-right: 13px solid transparent;
		border-left: 13px solid  transparent;
		margin-right: 12px;
	}
	
	.sumDown{
		width: 0px;
		height: 0px;
		border-top:20px solid skyblue;
		border-bottom:20px solid none;
		border-right: 13px solid transparent;
		border-left: 13px solid  transparent;
		margin-right: 12px;
	}
	
	.sumDIV{
		display: flex;	
		align-items: center;
 		justify-content: center; 
		text-align: center;
	}
	
	#billSection .mb-3 {
		width: 25%;
		height: 50px;
		margin: auto;
		font-size: 1.2em;
		
	}
	.custom-select{
		height: 100%;
		border-radius: 50px;
		text-align: center;
	}
	
	.custom-select:focus{
/* 		border-color: #ced4da; */
	}
	
	.fname{
		cursor: pointer;
	}
	
	.modal{
/* 		width: 100vw; */
	}
	
	.modal-dialog{
		max-width: 85%;
		width: 85%;
	}
	
	.detailHeader{
		background-color: #404040;
		color: white;
		font-family: Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
	    font-size: .875rem;
	    letter-spacing: .2px;
	    font-weight: 500;
	}
	
	
	.detailHeaderWrapped{
		padding: 0 10px 0 20px;
		display: flex;
		justify-content: space-between;
		align-items: center;
		height: 40px;
	}
	
	.detailHeaderWrapped .modalCloseBtn{
		background-color: transparent;
		outline: none;
		border: none;
		color: white;
	}
	
	.detailMain{
		display: flex;
		flex-direction: column;
	}
	

	
	.detailMain .detail_table{
		width: 70%;
		margin: auto;
	}
	
	#detail_tbody tr td:nth-child(1){
		text-align: center;
	}
	
	.modalCloseBtn{
		cursor: pointer;
	}
	
	.excelDIV{
		display: flex;
		justify-content: flex-end;
	}
	
	#billSection > .billContainer{
		padding: 0;
	}
	
	.card-header{
		font-weight: 600;
	}
	
	.btn{
		height: 60px;
	    font-weight: 600;
    	font-size: 1.5rem;
    	border-radius: 20px;
    	margin-right: 12px;
	}
	
	
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script type="text/javascript"
   src="https://service.iamport.kr/js/iamport.payment-1.1.8.js"></script>
	
	
<section id="billSection" class="card">
	<div class="input-group mb-3">
		<select name="month" class="custom-select" id="selectMonth">
			<c:if test="${not empty billList }">
				<c:forEach items="${billList }" var="eachBill">
					<option value="${fn:substring(eachBill.billNo,1,7)}">
						${fn:substring(eachBill.billNo,1,5)}년 ${fn:substring(eachBill.billNo,5,7)}월
					</option>
				</c:forEach>
			</c:if>
		</select>
	</div>
	
	<div class="costInfo_wrap">
		<div class="costdataBox">
			<div class="dayBox">
	<!-- 		strong 안에 D-몇일 -->
				<strong></strong>
	<!-- 			p태그 안에 납기내 / 납기후 -->
				<p></p>
			</div>
			<div class="endBox">
				<span>납부마감일</span>
				<span class="deadline"></span>
			</div>
		</div>
		<div class="costpayBox">
			<div>
	<!-- 			몇월분 부과금액 -->
				<span class="text"></span>
				<span class="costPay"></span>
			</div>
			<div>
				<span class="text">납부하실 금액</span>
				<span class="costPay"></span>
			</div>
		</div>
	</div>
	
	
<!-- 	차트 그래프그리기 -->
	<div class="billContainer"> 
		<div class="row my-3"> 
			<div class="col"> 
				<div class="excelDIV">
					<button class="btn btn-primary" id="billPayBtn" >결제하기</button>
					<button class="btn btn-primary" id="downloadExcel" data-month="" data-href="">엑셀로 저장</button>
				</div>
			</div> 
		</div> 
		<div class="row my-2">
			<div class="col"> 
				<div class="card"> 
					<div class="card-header">
						최근 1년간 관리비 추이
					</div>
					<div class="card-body">
						<canvas id="myChart" height="100"></canvas> 
					</div> 
				</div> 
			</div> 
		</div> 
	</div>


	
	
	<div class="card">
		<div class="card-header">이번달 관리비 세부항목</div>
		<div class="card-body">
			<table class="table table-bordered">
				<thead class="table thead-light">
					<th>항목</th>
					<th>당월</th>
					<th>전월</th>
					<th>증감</th>
				</thead>
				<tbody id="mainTbody">
					
				</tbody>
			</table>
		</div>
	</div>
	
	
<!-- 	모달창 영역 -->
	<div class="modal"> 
		<div class="modal-dialog"> 
			<div class="modal-content">
			 	<div class="detailHeader">
			 		<div class="detailHeaderWrapped">		 		
				 		<span class="detailHeader_title">항목명</span>
				 		<button class="modalCloseBtn">x</button>
			 		</div>
			 	</div>
			 	<div class="detailMain">
			 		<div class="container"> 
						<div class="row my-3"> 
							<div class="col"> 
								<h4 class="detailMain_title">항목별 월별 차트</h4> 
							</div> 
						</div> 
						<div class="row my-2">
							<div class="col"> 
								<div class="card"> 
									<div class="card-body">
										<canvas id="detailChart" height="100"></canvas> 
									</div> 
								</div> 
							</div> 
						</div> 
					</div>
			 		<div class="detail_table">
				 		<table class="table table-bordered">
				 			<thead class="table thead-dark">
				 				<th>월</th>
				 				<th>우리집</th>
				 				<th>동일면적 평균</th>
				 			</thead>
				 			<tbody id="detail_tbody">
				 				
				 			</tbody>
				 		</table>
				 	</div>
			 	</div>
			</div>
		</div> 
	</div>
	


</section>


<script>
	$(function(){
		
		const tbody = $('#mainTbody');
		const selectMonth = $('#selectMonth');
		const deadlineSpan = $('.deadline');
		const costpayBox = $('.costpayBox');
		const costpay = costpayBox.find('.costPay');
		const costMonthText = costpayBox.find('.text')[0];
		const costPaySumText = costpayBox.find('.text')[1];
		const monthOptions = $('#selectMonth').find('option');
		const dayBox = $('.dayBox');
		const dayBoxPtag = dayBox.find('p');
		const modalHeader_title = $('.detailHeader_title');
		const modalMain_title = $('.detailMain_title');
		const today = new Date(); 
		const year_ = today.getFullYear(); // 년도
		let month_ = today.getMonth() + 1;  // 월
		let date_ = today.getDate();  // 날짜
		
		if(month_ < 10)	month_ = '0' + month_;
		if(date_ < 10)	date_ = '0' + date_;		
		const todaySTR = year_ + '-' + month_ + '-' + date_;
		const modal_tbody = $('#detail_tbody');
	
		
		
		let excelBtn = $('#downloadExcel').on('click', function(){
			location.href = this.dataset.href;
		})

		
	
		
		
	    let context = document.getElementById('myChart');
	    let detail_context = document.getElementById('detailChart');

		// 총액 차트 그리기
	    let labels = [];
	    let myBill = [];
	    <c:if test="${not empty oneYearBillList }">
			<c:forEach items="${oneYearBillList }" var="eachBill">
				labels.push('${fn:substring(eachBill.billNo,1,5)}년 ${fn:substring(eachBill.billNo,5,7)}월');
				myBill.push('${eachBill.billSum}');			
			</c:forEach>
		</c:if>
		let avgBill = [];
		<c:if test="${not empty avgList}">
			<c:forEach items="${avgList}" var="monthAVG">
				avgBill.push('${monthAVG.billSum}');
			</c:forEach>
		</c:if>

	    
	    let myChart = new Chart(context, {
	        type: 'bar', // 차트의 형태
	        data: { // 차트에 들어갈 데이터
	            labels : labels,
	            datasets: [
	            	{ //데이터
	                    label: '우리집', //차트 제목
	                    fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
	                    data: myBill,
	                    backgroundColor: 'rgb(255, 99, 132, 0.5)',
	                    borderColor: 'rgb(255, 99, 132)',
	                    tension: 0
	            	},
	            	{
	            		type: 'line',
	            		label: '동일면적 평균',
	            		fill: false,
	            		data: avgBill,
	            		backgroundColor: 'rgb(40, 152, 196)',
	            		borderColor: 'rgb(40, 152, 196)',
	            		tension: 0
	            	}
	            	]
	        },
	        options: {
	        	//금액에 콤마 찍어주기
	        	scales:{
	        		yAxes:[{
	        			ticks: {
	        				userCallback: function(value, index, values){
	        					value = value.toString();
	        					value = value.split(/(?=(?:...)*$)/);
	        					value = value.join(',');
	        					
	        					return value;
	        				}
	        			}
	        		}]
	        	}
	        }
	    }); // 총액 차트 그리기 끝
		
	    $('.modalCloseBtn').on('click', function(){
	    	$('div.modal').modal('hide')
	    })
	    
	    
	    let detailChart = new Chart(detail_context, {}); // 항복별 차트그리기
	    
		// 모달창 띄우기
		tbody.on('click', '.fname', function(){
			let clicked_fcode = this.dataset.fcode;
			let clicked_fname = this.innerText;

			// 한 세대의 월별 세부항목 ajax
			$.ajax({
				url: '${cPath}/bill/detail',
				data: {
					"fcode": clicked_fcode,
					"month": selectMonth.val()
				},
				dataType: 'json',
				method: 'get',
				success: function(myDetail){
					
					// 세부항목의 월별 동일면적 평균값 ajax
					$.ajax({
						url: '${cPath}/bill/detailAVG',
						data: {
							"fcode": clicked_fcode,
							"month": selectMonth.val()
						},
						dataType: 'json',
						method: 'get',
						success: function(detailAVG){
							let trs = [];
							
							let data_avg = [];
							let detail_labels = [];
							detailAVG.forEach((eachDetail, index) => {
								data_avg.push(eachDetail.btailSum);
								detail_labels.push(eachDetail.billMonth.substring(0,4)+'년 '+eachDetail.billMonth.substring(4,6)+'월');
								let tr = `<tr>
											<td>`+detail_labels[index]+`</td>
											<td>`+(myDetail[index] ? myDetail[index].toLocaleString() : 0)+`</td>
											<td>`+(eachDetail.btailSum ? eachDetail.btailSum.toLocaleString() : 0)+`</td>
										</tr>`;
								trs.push(tr);
							});
							modalHeader_title.html(clicked_fname);
							modalMain_title.html(clicked_fname);
							modal_tbody.html(trs);
							
							// 항목별 차트그리기
							let plugins = {
							        type: 'bar', // 차트의 형태
							        data: { // 차트에 들어갈 데이터
							            labels : detail_labels,
							            datasets: [
							            	{ //데이터
							                    label: '우리집', //차트 제목
							                    fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
							                    data: myDetail,
							                    backgroundColor: 'rgb(255, 99, 132, 0.5)',
							                    borderColor: 'rgb(255, 99, 132)',
							                    tension: 0
							            	},
							            	{
							            		type: 'line',
							            		label: '동일면적 평균', //차트 제목
							                    fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
							                    data: data_avg,
							                    backgroundColor: 'rgb(40, 152, 196)',
							            		borderColor: 'rgb(40, 152, 196)',
							                    tension: 0
							            	}	
							            ]
							        },
							        options: {
							        	scales:{
							        		yAxes:[{
							        			ticks: {
							        				userCallback: function(value, index, values){
							        					value = value.toString();
							        					value = value.split(/(?=(?:...)*$)/);
							        					value = value.join(',');
							        					return value;
							        				}
							        			}
							        		}]
							        	}
							        }
							    };
							// 기존차트 제거후 다시 생성해줘야 차트가 안겹침.
							detailChart.destroy();
							detailChart = new Chart(detail_context, plugins);
							
						    $('div.modal').modal();		
						} // 세부항목 동일면적 평균값 success 끝
					})
				}
			})
				
		}) // 모달창 끝
		
		
		// bill ajax 호출 함수
		let billAjax = function(month, preMonth){
			
			$.ajax({
				url: '${cPath}/bill/month',
				data: {
					'month' : month
				},
				dataType: 'json',
				method: 'get',
				success: function(curBill){
					
					$.ajax({
						url: '${cPath}/bill/month',
						data: {
							'month' : preMonth
						},
						dataType: 'json',
						method: 'get',
						success: function(preBill){
							excelBtn[0].dataset.month = month;
							excelBtn[0].dataset.href = '${cPath}/mbillExcelDownload?month='+month;

							let temp = month.substr(4);
							let realMonth = temp[0] == '0' ? temp.substr(1) : temp;
							let dline = curBill.billDline;
							let tmp_oversum = curBill.billOversum ? curBill.billOversum.toLocaleString() : 0;
							let tmp_paysum = curBill.billPaysum ? curBill.billPaysum.toLocaleString() : 0;
							let tmp_billsum = curBill.billSum ? curBill.billSum.toLocaleString() : 0;
							if(todaySTR >= dline){
								// 납기일이 지난경우임.
								if(curBill.billPaydate == null){
									// 결제를 안했다면, 납기후 금액을 보여줘야함.
									dayBoxPtag.html('납기후');				
									costPaySumText.innerHTML = "납부하실 금액"
									costpay[1].innerHTML = tmp_oversum + '원';
									billPayBtn[0].style.display = 'inline-block';
									billPayBtn.data('fee', tmp_oversum);
									billPayBtn.data('billno', curBill.billNo);
								}else{
									// 결제를 했다면, 결제완료로 보여주고.
									dayBoxPtag.html('완납');	
									costPaySumText.innerHTML = "(납부완료)";
									billPayBtn[0].style.display = 'none';
									if(dline > curBill.billPaydate){
										costpay[1].innerHTML = tmp_paysum + '원';										
									}else {										
										costpay[1].innerHTML = tmp_oversum + '원';										
									}
								}			
							}else{
								//납기일이 안지난경우. D-몇일 표시하는 코드 넣어줘야함.
								if(curBill.billPaydate == null){
									// 결제를 안했다면, 납기내 금액을 보여줘야함.
									dayBoxPtag.html('납기내');			
									costPaySumText.innerHTML = "납부하실 금액"
									costpay[1].innerHTML = tmp_billsum + '원';
									billPayBtn[0].style.display = 'inline-block';
									billPayBtn.data('fee', tmp_billsum);
									billPayBtn.data('billno', curBill.billNo);
								}else{
									// 결제를 했다면, 결제완료로 보여주고.
									dayBoxPtag.html('완납');		
									costPaySumText.innerHTML = "(납부완료)"
									costpay[1].innerHTML = tmp_paysum + '원';
									billPayBtn[0].style.display = 'none';
								}
							}
							dline = dline.substring(0,4) + '년 ' + dline.substring(5,7) + '월 ' + dline.substring(8,10) + '일';

							deadlineSpan.html(dline);
							costMonthText.innerHTML = realMonth + '월분 부과 금액';
							costpay[0].innerHTML = tmp_billsum + '원';
							let trs = [];
							let detailList = curBill.btailList;
							let preDetailList = preBill.btailList;
							if(preBill.billNo == null){
								detailList.forEach((detail, index)=>{
									let tr = "<tr>";
									tr += "<td class='fname' data-fcode="+ detail.fcode +">" + detail.fname + "</td>";
									tr += "<td>" + (detail.btailSum ? detail.btailSum.toLocaleString() : 0) + "</td>";
									tr += "<td>-</td>";
									tr += "<td>-</td>";
									tr += "</tr>";
									trs.push(tr);
								});
							}else{
								detailList.forEach((detail, index)=>{
									console.log(detail);
									let tr = "<tr>";
									tr += "<td class='fname' data-fcode="+ detail.fcode +">" + detail.fname + "</td>";
									tr += "<td>" + (detail.btailSum ? detail.btailSum.toLocaleString() : 0) + "</td>";
									let compareSum = detail.btailSum;
									if(preDetailList[index] == undefined){
										tr += "<td>-</td>";
									}else{
										tr += "<td>" + (preDetailList[index].btailSum ? preDetailList[index].btailSum.toLocaleString() : 0) + "</td>";										
										compareSum = detail.btailSum - preDetailList[index].btailSum;
									}
									if(compareSum > 0){
										tr += "<td><div class='sumDIV'><div class='sumUp'></div>" + compareSum.toLocaleString() + "</div></td>";										
									}else if(compareSum < 0){
										tr += "<td><div class='sumDIV'><div class='sumDown'></div>" + compareSum.toLocaleString() + "</div></td>";																				
									}else{
										tr += "<td><div class='sumDIV'>0</div></td>";
									}
									tr += "</tr>";
									trs.push(tr);
								});
							}
							tbody.html(trs);
						} // 저번달 bill success 끝
					}) // 저번달 bill ajax 끝
					
				} // 이번달 bill success 끝
			}) // 이번달 bill ajax 끝
			
		} // bill ajax 호출함수 끝
		
		
		// 관리비조회 페이지 요청시 처음에 가장 최근 고지서 내역을 불러오기 위한 코드
		let month = monthOptions[monthOptions.length-1].value;
		let preMonth = '';
		monthOptions.each(function(index, option){
			if(month == option.value){
				if(index == 0){
					return false;
				}
				preMonth = monthOptions[index-1].value;
				return false;
			}
		})
		
		billAjax(month, preMonth);
		selectMonth.val(monthOptions[monthOptions.length-1].value);
		
		// 월 선택시 이벤트.
		selectMonth.on('change', function(){
			let month = this.value;
			let preMonth = '';

			monthOptions.each(function(index, option){
				if(month == option.value){
					if(index == 0){
						return false;
					}
					preMonth = monthOptions[index-1].value;
					return false;
				}
			})
			// 현재 클릭한 월에서 전 index를 찾아서 전월로 구하기.
			billAjax(month, preMonth);
		}) 
		// select "change"이벤트 끝
		
		// 결제 로직
		let billPayBtn = $('#billPayBtn').on('click', function(){
			let payBillNo = $(this).data('billno');
			let fee = $(this).data('fee');
			let bill_title = selectMonth.val().substr(0,4)+'년 '+selectMonth.val().substr(4,2)+'월 관리비';
			fee = fee.replace(/[^\d]+/g, "");
			var IMP = window.IMP;
			IMP.init("imp91672119"); // 예: imp00000000
			// IMP.request_pay(param, callback) 결제창 호출
		    IMP.request_pay({ // param
		        pg: "html5_inicis",
		        pay_method: "card",
		        name: bill_title,
		        amount: 100,
		        buyer_name: '이응주',
		        buyer_email: 'doerdrea@gmail.com'
		    }, function (rsp) { // callback
			    	let msg = '';
			    	if (rsp.success) {
					   //console.log(msg);	
		               // 컨트롤러에 데이터를 전달하여 DB에 입력하는 로직
		               // 결제내역을 사용자에게 보여주기 위해 필요함.
		               console.log("결제성공!!!");
		    		console.log(rsp.pay_method);
		               $.ajax({
		            	   url: '${cPath}/bill/pay',
		            	   type: 'post',
		            	   data: {
		            		   'billNo': payBillNo,
		            		   'billPaysum': fee
		            	   },
		            	   dataType: 'text',
		            	   success: function(resp){
		            		   if(resp == 'success'){
		            			    let month = selectMonth.val();
		            				let preMonth = '';
		            				monthOptions.each(function(index, option){
		            					if(month == option.value){
		            						if(index == 0){
		            							return false;
		            						}
		            						preMonth = monthOptions[index-1].value;
		            						return false;
		            					}
		            				})
		            			   billAjax(month, preMonth);
		            				Swal.fire({
		            					  icon: 'success',
		            					  title: '결제 완료',
		            					  showConfirmButton: false,
		            					  timer: 1500
	            					})
		            		   }else if(resp == 'fail'){
		            			   Swal.fire({
		            				   icon: 'error',
		            				   title: '서버오류: 결제 실패',
		            				   text: '잠시 후에 다시 시도해주세요.',
		            				   showConfirmButton: false,
		            				   timer: 1500
		            				})
		            		   }
		            	   },
		            	   error: function(error){
		            		   console.log(error);
		            	   }
		               }) // ajax끝
		            } else {
		            	Swal.fire({
         				   icon: 'error',
         				   title: rsp.error_msg,
         				   showConfirmButton: false,
         				   timer: 1500
         				})
		            }
			    	
		    });
		  
		})
		// 결제 끝
		
	})
</script>