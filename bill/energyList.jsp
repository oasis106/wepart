<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<style>

 	.container.content{ 
 		margin: 0; 
 		padding: 0; 
 		max-width: 100%; 
 		width: 100%; 
 		height: 100vh; 
 	} 
	
	
 	.mainContainer_div{ 
		max-width: 100%; 
		height: 100%; 
 	} 
 	
	
 	.site-section { 
 	    padding: 50px 0; 
	    height: 100vh;
 	} 
	
	#energySection{
		width: 100%;
		height: 100%;
	}

	#energySection .mb-3 {
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
		border-color: #ced4da;
	}
	
	#mainchart_div{
		
		border-style: none;
	}
	
	#chart_list{
		display: flex;
		margin-bottom: 50px;
	}
	
	#feeAndUsage_div{
		display: flex;
		flex-direction: column;
		width: 50%; 
 		height: 520px; 
	}
	
	#feeAndUsage_div > div{
		height: 100%;
	} 
	
	#feeAndUsage_div .card-body{
		box-shadow: 0 25px 20px -20px rgb(0 0 0 / 30%), 0 0 15px rgb(0 0 0 / 6%);
		border-radius: 8px;
		border-style: none;
		width: 100%; 
  		height: 200px; 
	}
	
	#mainchart_div{
		width: 50%;
		height: 520px;
		margin-right: 12px;
	}
	
 	#mainchart_div .card-body{ 
 		width: 100%; 
 		height: 500px; 
 		box-shadow: 0 25px 20px -20px rgb(0 0 0 / 30%), 0 0 15px rgb(0 0 0 / 6%);
		border-radius: 8px;
 	} 

	
	h4{
		text-align: center;
		padding: 12px;
	}
	
	.mainContainer_div .table_div{
		margin-top: 30px;
		width: 100%;
	}
	
	tr, th, td{
		text-align: center;
	}
	
	td:nth-child(2), td:nth-child(3){
		text-align: right;
	}
	
	.table.table-bordered{
		caption-side: top;	
	}
	
	caption{
		caption-side: top;	
		text-align: center;
		font-weight: 600;
		font-size: 1.3em;
		color: black;
	}
	
	.sumDIV{
		display: flex;	
		align-items: center;
 		justify-content: center; 
		text-align: center;
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
	
	.card-header{
		font-weight: 600;
	}
	
	#energySection > .card{
		width: 90%;
		padding: 20px;
		border: 10px solid;
	}
	
	.table_div.card{
		padding: 0;
	}
	
	.feefirst{
		margin-bottom: 20px;
	}
	
	
</style>
<script src="https://kit.fontawesome.com/801f56afe5.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    
<section id="energySection">    
	<div class="card">
	
	<div class="input-group mb-3">
		<select name="month" class="custom-select" id="selectMonth">
			<c:if test="${not empty esList }">
				<c:forEach items="${esList }" var="eachES">
					<option value="${eachES.month6}">
						${fn:substring(eachES.month6,0,4)}??? ${fn:substring(eachES.month6,4,6)}???
					</option>
				</c:forEach>
			</c:if>
		</select>
	</div>
	<div class="mainContainer_div"> 
		<div id="chart_list">
			<div id="mainchart_div">
				<div class="card">
					<div class="card-header">
						?????? 1?????? ????????? ????????????
					</div>
					<div class="card-body">
	<!-- 					<h4>?????? 1?????? ????????? ????????????</h4>  -->
						<canvas class="canvas" id="mainChart" height="100"></canvas> 				
					</div>
				</div>
			</div>
			<div id="feeAndUsage_div">
				<div class="card feefirst">
					<div class="card-header">
						???????????? ???????????? ??????
					</div>
					<div class="card-body">
	<!-- 				<h4>???????????? ???????????? ??????</h4>  -->
						<canvas class="canvas" id="feeChart" height="100"></canvas>
					</div>
				</div>
				<div class="card">
					<div class="card-header">
						???????????? ????????? ??????
					</div>
					<div class="card-body">
	<!-- 				<h4>???????????? ????????? ??????</h4>  -->
						<canvas class="canvas" id="usageChart" height="100"></canvas> 
					</div>
				</div>
			</div>
		</div>
		<div class="table_div card">
			<div class="card-header" id="table_caption">
				
			</div>
			<div class="card-body">
				<table class="table table-bordered">
					<thead class="table thead-light">
						<th>??????</th>
						<th>?????????</th>
						<th>????????????</th>
						<th>??????????????????</th>
						<th>??????(?????????, ??????????????????)</th>
					</thead>
					<tbody id="feeTbody">
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>
</section>





<script>
$(function(){
	
	const selectMonth = $('#selectMonth');
	const monthOptions = $('#selectMonth').find('option');
	
	let main_context = document.getElementById('mainChart'); //1?????? ???????????? ????????? ?????????
	let feeChart = new Chart(document.getElementById('feeChart'), {}); // ???????????? ???????????????
	let usageChart = new Chart(document.getElementById('usageChart'), {}); // ????????? ???????????????
	
	let labels = [];
	let myBill = [];
	<c:if test="${not empty myFeeList }">
		<c:forEach items="${myFeeList }" var="eachBill">
			labels.push('${fn:substring(eachBill.billNo,1,5)}.${fn:substring(eachBill.billNo,5,7)}');
			myBill.push('${eachBill.energyFee}');			
		</c:forEach>
	</c:if>
	let avgBill = [];
	<c:if test="${not empty avgFeeList}">
		<c:forEach items="${avgFeeList}" var="eachAVG">
			avgBill.push('${eachAVG.energyFee}');
		</c:forEach>
	</c:if>
	
	// 1?????? ???????????? ?????? ?????????
	let mainChart = new Chart(main_context, {
	    type: 'bar', // ????????? ??????
	    data: { // ????????? ????????? ?????????
	        labels : labels,
	        datasets: [
	        	{ //?????????
	                label: '?????????', //?????? ??????
	                fill: false, // line ????????? ???, ??? ????????? ???????????? ???????????????
	                data: myBill,
	                backgroundColor: 'rgb(255, 99, 132, 0.5)',
	                borderColor: 'rgb(255, 99, 132)',
	                tension: 0
	        	},
	        	{
	        		label: '???????????? ??????',
	        		fill: false,
	        		data: avgBill,
	        		backgroundColor: 'rgb(40, 152, 196)',
	        		borderColor: 'rgb(40, 152, 196)',
	        		tension: 0
	        	}
	        	]
	    },
	    options: {
	    	title: {
	        		display: true,
	        		text: '?????? 1?????? ????????? ????????????'
	        	},
	    	maintainAspectRatio: false,
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
	}); // 1?????? ???????????? ????????? ????????? ???
	
	let table_caption = $('#table_caption');
	let feeTbody = $('#feeTbody');
	let chartAjax = function(value){
		$.ajax({
			url: location.href,
			method: 'get',
			data: {
				'month4': value.substr(2, 4),
				'month6': value
				},
			dataType: 'json',
			success: function(resp){
				console.log(resp);
				let myBill_list = [0];
				let avgBill_list = [0];
				let lyBill_list = [0];
				let labels = ['??????', '??????', '??????', '??????', '??????'];

				resp.myBillList.forEach(bill => {
					myBill_list[0] += bill.btailSum;
					myBill_list.push(bill.btailSum);
				})
				resp.avgBillList.forEach(bill => {
					avgBill_list[0] += bill.btailSum;
					avgBill_list.push(bill.btailSum);
				})
				resp.lastYearBillList.forEach(bill => {
					lyBill_list[0] += bill.btailSum;
					lyBill_list.push(bill.btailSum);
				})
				
				let trs = [];

				for(let i=0; i<labels.length; i++){
					console.log(myBill_list[i]);
					console.log(lyBill_list[i]);
					let cv = ((myBill_list[i] ? myBill_list[i] : 0)-(avgBill_list[i] ? avgBill_list[i] : 0));
					let tr = `
						<tr>
							<td>`+labels[i]+`</td>
							<td>`+(myBill_list[i] ? myBill_list[i] : 0).toLocaleString()+`</td>
							<td>`+(lyBill_list[i] ? lyBill_list[i] : 0).toLocaleString()+`</td>
							<td>`+(avgBill_list[i] ? avgBill_list[i] : 0).toLocaleString()+`</td>
					`;
					console.log(cv);
					if(cv > 0){
						tr += `<td><div class='sumDIV'><div class='sumUp'></div>`+cv.toLocaleString()+`</div></td></tr>`;
					}else if(cv < 0){
						tr += `<td><div class='sumDIV'><div class='sumDown'></div>`+cv.toLocaleString()+`</div></td></tr>`;
					}else{
						tr += `<td><div class='sumDIV'>`+cv.toLocaleString()+`</div></td></tr>`;
					}
					
					trs.push(tr);
				}
				feeTbody.html(trs);
				
				///////////////////////////////////////////////////////
				// ???????????? ???????????????
				let fee_plugins = {
				        type: 'bar', // ????????? ??????
				        data: { // ????????? ????????? ?????????
				            labels : labels,
				            datasets: [
				            	{ 
				                    label: '?????????', //?????? ??????
				                    data: myBill_list,
				                    backgroundColor: 'rgb(255, 99, 132, 0.5)',
				                    borderColor: 'rgb(255, 99, 132)',
				                    tension: 0
				            	},
				            	{
				                    label: '??????????????????', //?????? ??????
				                    data: avgBill_list,
				                    backgroundColor: 'rgb(40, 152, 196)',
				                    borderColor: 'rgb(40, 152, 196)',
				                    tension: 0
				            	}
				            ]
				        },
				        options: {
				        	title: {
			 	        		display: true,
			 	        		text: '???????????? ?????? ???????????? ??????'
			 	        	},
			 	        	maintainAspectRatio: false,
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
				// ???????????? ????????? ?????? ??????????????? ????????? ?????????.
				feeChart.destroy();
				feeChart = new Chart(document.getElementById('feeChart'), fee_plugins); // ???????????? ???????????????
				////////////////////////////////////////////////////////////////
				
				let myUsage_list = [];
				let avgUsage_list = [];
				let labels_usage = ['??????(kwh)', '??????(ton)', '??????', '??????'];
				
				resp.myUsageList.forEach(bill => {
					myUsage_list.push(bill.readThis);
				})
				resp.avgUsageList.forEach(bill => {
					avgUsage_list.push(bill.readThis);
				})
				
				// ????????? ???????????????
				let usage_plugins = {
				        type: 'bar', // ????????? ??????
				        data: { // ????????? ????????? ?????????
				            labels : labels_usage,
				            datasets: [
				            	{ 
				                    label: '?????????', //?????? ??????
				                    data: myUsage_list,
				                    backgroundColor: 'rgb(255, 99, 132, 0.5)',
				                    borderColor: 'rgb(255, 99, 132)',
				                    tension: 0
				            	},
				            	{
				                    label: '??????????????????', //?????? ??????
				                    data: avgUsage_list,
				                    backgroundColor: 'rgb(40, 152, 196)',
				                    borderColor: 'rgb(40, 152, 196)',
				                    tension: 0
				            	}
				            ]
				        },
				        options: {
				        	title: {
			 	        		display: true,
			 	        		text: '???????????? ?????? ????????? ??????'
			 	        	},
			 	        	maintainAspectRatio: false,
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
				// ???????????? ????????? ?????? ??????????????? ????????? ?????????.
				usageChart.destroy();
				usageChart = new Chart(document.getElementById('usageChart'), usage_plugins); // ????????? ???????????????
				table_caption.html(value.substr(0,4)+"??? "+value.substr(4,2) + "??? ????????? ????????????")
			},
			error: function(error){
				console.log(error);
			}
		})
	}
	
	selectMonth.val(monthOptions[monthOptions.length-1].value);
	chartAjax(selectMonth.val());
	

	$('#selectMonth').on('change', function(){
		chartAjax(this.value);
	})
	

	
})
</script>

