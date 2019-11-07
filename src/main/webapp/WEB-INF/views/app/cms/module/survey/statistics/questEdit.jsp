<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>

<script type="text/javascript">
	$(function() {
		
		var quest_idx = $('#editQuest_idx').val();
		
		for (var j = 0; j < $('.detailTitle'+quest_idx).length; j++) {
			if ('${quest.quest_type}' == 'ONE' || '${quest.quest_type}' == 'MULTI'){
				$('#quest_detail_title'+quest_idx+j).val($('.title'+quest_idx+j).text());
				$('#cnt'+quest_idx+j).val($('.cntOne'+quest_idx+j).text());
			} else if ('${quest.quest_type}' == 'MATRIX') {
				$('#quest_detail_title'+quest_idx+j).val($('.title'+quest_idx+j).text());
				$('#matrix_title'+quest_idx+j).val($('.matrixTitle'+quest_idx+j).text());
				for (var k = 0; k < $('.count'+quest_idx+j).length; k++){
					$('#cnt'+quest_idx+j+k).val($('.cntOne'+quest_idx+j+k).text());
				}
			
				
			}
		}
		if('${quest.quest_type}' == 'ONE' || '${quest.quest_type}' == 'MULTI'){
			var dwidth = 400;
		} else {
			var dwidth = 750;
		}
		$("div#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
			width : dwidth,
			modal : true,
			close : function() {
				$(this).dialog('destroy');
			},
			buttons : [ {
				text : "적용",
				"class" : 'btn btn1',
				click : function() {
					/* if (doAjaxPost($('#questDetail'))) {
						$(this).dialog('destroy');
						for(var i = 0; i < doAjaxPost($('#questDetail')).length; i++ ){
							$('.title'+doAjaxPost($('#questDetail'))[i].quest_idx+i).text(doAjaxPost($('#questDetail'))[i].quest_detail_title);
						}
					} */
					jQuery.ajaxSettings.traditional = true;
					
					var formData;
					
					if('${quest.quest_type}' == 'ONE' || '${quest.quest_type}' == 'MULTI'){
						formData = serializeObject($('#questDetail'));
					} else {
						formData = serializeObject($('#questMatrix'));
					}
					chart(formData);
					 $(this).dialog('destroy');}
			}, {

				text : "취소",
				"class" : 'btn',
				click : function() {
					$(this).dialog('destroy');
				}
			} ]
		});
	})
	
	function chart(formData){
		 $.ajax({
		        type: "POST",
		        url: 'save.do',
		        async: false,
		        data: formData,
		        dataType:'json',
		        success: function(response) {
		        	response = eval(response);
		        	responseValid = response.valid;
		            if(response.valid) {            	
		                 if(response.data != null) {
		                	if (Array.isArray(chartLabels) && Array.isArray(chartData) && Array.isArray(label)) {
		             			chartLabels = [];
		             			chartData = [];
		             			label = [];
		             		}
		                	var answer_count = response.data.answer_count;
		                	var ratio;
		                	
		                	if ('${quest.quest_type}' == 'ONE' || '${quest.quest_type}' == 'MULTI'){
		                		
								for(var i = 0; i < response.data.quest_detail_list.length; i++ ){
									
									ratio = (response.data.quest_detail_list[i].cnt/answer_count)*100;
									
									$('.total_cnt'+response.data.quest_detail_list[i].quest_idx).text(answer_count);
									$('.title'+response.data.quest_detail_list[i].quest_idx+i).text(response.data.quest_detail_list[i].quest_detail_title);
									$('.cntOne'+response.data.quest_detail_list[i].quest_idx+i).text(response.data.quest_detail_list[i].cnt);
									$('.ratioOne'+response.data.quest_detail_list[i].quest_idx+i).text(ratio.toFixed(2));
									
									if (response.data.quest_detail_list.length > 3 && response.data.quest_detail_list.length < 6) {
										
										if (response.data.quest_detail_list[i].quest_detail_title.length > 10) {
											chartLabels.push(response.data.quest_detail_list[i].quest_detail_title.trim().substring(0, 7)+"..."+"("+response.data.quest_detail_list[i].cnt+"명)");
										} else {
											chartLabels.push(response.data.quest_detail_list[i].quest_detail_title.trim()+"("+response.data.quest_detail_list[i].cnt+"명)");
										}
										
									} else if (response.data.quest_detail_list.length > 5 && response.data.quest_detail_list.length < 10) {
										if (response.data.quest_detail_list[i].quest_detail_title.length > 3) {
											chartLabels.push(response.data.quest_detail_list[i].quest_detail_title.trim().substring(0, 2)+"..."+"("+response.data.quest_detail_list[i].cnt+"명)");
										} else {
											chartLabels.push(response.data.quest_detail_list[i].quest_detail_title.trim()+"("+response.data.quest_detail_list[i].cnt+"명)");
										}
										
									} else if (response.data.quest_detail_list.length >= 10) {
										if (response.data.quest_detail_list[i].quest_detail_title.length > 2) {
											chartLabels.push(response.data.quest_detail_list[i].quest_detail_title.trim().substring(0, 1)+"..."+"("+response.data.quest_detail_list[i].cnt+"명)");
										} else {
											chartLabels.push(response.data.quest_detail_list[i].quest_detail_title.trim()+"("+response.data.quest_detail_list[i].cnt+"명)");
										}
										
									} else {
										chartLabels.push(response.data.quest_detail_list[i].quest_detail_title.trim()+"("+response.data.quest_detail_list[i].cnt+"명)");
									}
									
									chartData.push(response.data.quest_detail_list[i].cnt)
									label.push('');
									
									$('a.btn'+response.data.quest_detail_list[i].quest_idx).attr('modify','ture');
									
									drawOneGraph2(response.data.quest_detail_list[0].quest_idx, "bar",chartLabels, chartData);
								}
								
								 modifyList.data.quest_idx.push(response.data.quest_detail_list[0].quest_idx);
								 
		                	}else if ('${quest.quest_type}' == 'MATRIX'){
		                		for (var j = 0; j <response.data.quest_detail_list.length; j++){
		                			chartLabels.push(response.data.quest_detail_list[j].quest_detail_title);
		                			$('.title'+response.data.quest_detail_list[j].quest_idx+j).text(response.data.quest_detail_list[j].quest_detail_title);
		                		}
		                		
		                		for(var i = 0; i < response.data.quest_matrix_list.length; i++ ){
		                			var x = 0;
									var row = [];
									
									
									for (var k = 0; k < response.data.quest_matrix_list[i].statisticsList.length; k++ ) {
										$('.matrixTitle'+response.data.quest_matrix_list[i].quest_idx+i).text(response.data.quest_matrix_list[i].matrix_title);
										$('.total_cnt'+response.data.quest_matrix_list[i].quest_idx).text(answer_count/response.data.quest_matrix_list.length);
										$('a.btn'+response.data.quest_matrix_list[i].quest_idx).attr('modify','ture');
										
									}
									
									for (var l = 0; l < response.data.quest_matrix_list[i].statisticsList[i].cntList.length; l++) {
										$('.cntOne'+response.data.quest_matrix_list[i].quest_idx+i+l).text(response.data.quest_matrix_list[i].statisticsList[i].cntList[x].cnt)
										
										ratio = (response.data.quest_matrix_list[i].statisticsList[i].cntList[x].cnt/response.data.quest_matrix_list[i].rowCount)*100;
										
										$('.ratioOne'+response.data.quest_matrix_list[i].quest_idx+i+l).text(ratio.toFixed(2));
										
										row.push(response.data.quest_matrix_list[i].statisticsList[i].cntList[x].cnt);
										
										x++;
									}
									
									chartData.push(row);
									
									
									label.push(response.data.quest_matrix_list[i].matrix_title);
								
									drawMatrixGraph2(response.data.quest_matrix_list[0].quest_idx, "bar",chartLabels, chartData, label);
		                		}
		                		
		                		modifyList.data.quest_idx.push(response.data.quest_matrix_list[0].quest_idx);
		                	}
			               
		                	modifyList.data.chartLabels.push(chartLabels);
		                	modifyList.data.chartData.push(chartData);
		                	modifyList.data.label.push(label);
							
		                 }
					} else {
						if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
							alert(response.message);
		                } else {
		                	if (response.result != null && response.result.length > 0) {
		                		for(var i =0 ; i < response.result.length ; i++) {
		                			alert(response.result[i].code);
		                			$('#'+response.result[i].field).focus();
		                			$('#'+response.result[i].field, $(form)).css('border-color', 'red');
		                			$('#'+response.result[i].field, $(form)).on('change', function() {
		                				$(this).css('border-color', '');
		                			});
		                			break;
		                		}
		                	}
		                }
						
						if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
							if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
								doAjaxLoad(ajaxBody, response.url, response.data);
							} else {
								doGetLoad(response.url, response.data);
		               	 	}
						}
					}
		         },
		         error: function(jqXHR, textStatus, errorThrown) {
		             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown + ', ' + jqXHR.status);
		         }
		    });
	}
	
	function onlyNumber(event){
	    event = event || window.event;
	    var keyID = (event.which) ? event.which : event.keyCode;
	    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
	        return;
	    else
	        return false;
	}
	 
	function removeChar(event) {
	    event = event || window.event;
	    var keyID = (event.which) ? event.which : event.keyCode;
	    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
	        return;
	    else
	        event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
</script>

<style>
	table th, table td {border : 1;}
</style>


<form:form modelAttribute="quest" action="save.do">
	<form:hidden path="quest_type" />
	<form:hidden path="quest_detail_free_yn"/>
</form:form>

<div class="ui-state-highlight" style="overflow:hidden">
	<em style="float:right;"><span style="color:red">*</span>수정된 데이터는 실제 데이터에 반영되지 않습니다.</em>
</div>


<c:if test="${quest.quest_type eq 'ONE' or quest.quest_type eq 'MULTI'}">
	<form:form modelAttribute="questDetail" action="save.do">

		<form:hidden path="editMode" />
		<form:hidden path="quest_idx" id="editQuest_idx" />
		<form:hidden path="answer_count"/>
		<input type="hidden" name="quest_type" value="${quest.quest_type}"/>
		<table class="type2 center border">
		<thead>
				<tr>
					<th>보기</th>
					<th>인원수</th>
				</tr>
			</thead>
		<c:forEach var="i" items="${questDetailList.quest_detail_list}" varStatus="status">
			
			<tbody>
				<tr>
					<th>
						<input type="text" class="text" id="quest_detail_title${i.quest_idx}${status.index}" name="quest_detail_list[${status.index}].quest_detail_title" value="${i.quest_detail_title}">
					</th>
					<td>
						<input class="text" id="cnt${i.quest_idx}${status.index}" name="quest_detail_list[${status.index}].cnt" value="${i.cnt}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'>
					</td>
			
				<tr>
			<c:set var="questIdx" value="${status.index}"/>
			
		</c:forEach>
			<c:if test="${quest.quest_detail_free_yn eq 'Y'}">
				<tr>
					<th>
						<input type="text" class="text" id="quest_detail_title${quest.quest_idx}${questIdx+1}" name="quest_detail_list[${questIdx+1}].quest_detail_title" value="기타" readonly="readonly">
					</th>
					<td>
						<input type="text" class="text" id="cnt${quest.quest_idx}${questIdx+1}" name="quest_detail_list[${questIdx+1}].cnt"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'>
					</td>
				</tr>
			</c:if>
				
			</tbody>
		</table>
	</form:form>
</c:if>

<c:if test="${quest.quest_type eq 'MATRIX'}">
	<form:form modelAttribute="questMatrix" action="save.do">
		<form:hidden path="editMode" />
		<form:hidden path="quest_idx" id="editQuest_idx" />
		<form:hidden path="answer_count"/>
		<input type="hidden" name="quest_type" value="${quest.quest_type}"/>
		<table class="type2 center border">
			<caption>매트릭스형 세부질문 및 보기</caption>
						
			<thead>
			<tr>
			<th>세부질문</th>			
				<c:forEach var="k" items="${questMatrixList.quest_detail_list}" varStatus="status_k">
					<th><input type="text" class="text" id="quest_detail_title${k.quest_idx}${status_k.index}"  name="quest_detail_list[${status_k.index}].quest_detail_title" value="${k.quest_detail_title}" size="9"></th>
				</c:forEach>
			</tr>
			</thead>
			<tbody>
		<c:forEach var="i" items="${questMatrixList.quest_matrix_list}" varStatus="status">
			
			<tr>
				<th><input type="text" class="text" id="matrix_title${i.quest_idx}${status.index}" value="${i.matrix_title}" name="quest_matrix_list[${status.index}].matrix_title"/></th>
				
				<c:forEach var="j" varStatus="status_j" items="${i.statisticsList}">
						<td ><input type="text"  class="text" id="cnt${i.quest_idx}${status.index}${status_j.index}" value="${j.cnt}" name="quest_matrix_list[${status.index}].statisticsList[${status.index}].cntList[${status_j.index}].cnt" size="3"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'></td>
				</c:forEach>
			</tr>
		</c:forEach>
		</tbody>
		</table>
	</form:form>
</c:if>
