<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	<c:if test="${teacher.editMode ne 'ADD'}">
	$('#full_adder').val($('#teacher_zipcode').val() + " " + $('#teacher_address').val());
	</c:if>
	
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					jQuery.ajaxSettings.traditional = true;
					
					if ((isEmpty($('#t_edu00').val()) && isEmpty($('#t_edu01').val())) && 
							(isEmpty($('#t_edu10').val()) && isEmpty($('#t_edu11').val())&& isEmpty($('#t_edu12').val()) && $("#t_edu13").is(":checked") == false) &&
							(isEmpty($('#t_edu20').val()) && isEmpty($('#t_edu21').val()) && isEmpty($('#t_edu22').val()) && $("#t_edu23").is(":checked") == false) && 
							(isEmpty($('#t_edu30').val()) && isEmpty($('#t_edu31').val()))) {
							
							alert("고등학교, 대학교, 대학원, 기타 중 하나는 필수로 입력하여야 합니다.");
							
							//의문
							$('#t_edu00').focus();
							$('.education').css('border', 'solid 3px red');
							$('.education').on('change', function() {
								$(this).css('border', 'solid 1px #e5e8eb');
								$(this).css('border-right', 'none'); 
							});
							return;
						}
						
						
						if ($('#t_edu00').val() != "" || $('#t_edu01').val() != "") {
							if ($('#t_edu00').val() == "" && $('#t_edu01').val() != "") {
								alert("고등학교 -> 학교명을 입력해주세요.");
								$('#t_edu00').focus();
								$('#t_edu00').css('border-color', 'red');
				    			$('#t_edu00').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($('#t_edu00').val() != "" && $('#t_edu01').val() == "")  {
								alert("고등학교 -> 수료(졸업)일을 입력해주세요.");
								$('#t_edu01').focus();
								$('#t_edu01').css('border-color', 'red');
				    			$('#t_edu01').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($('#t_edu01').val() != "") {
								if ($('#t_edu01').val().length < 6) {
									alert("고등학교 -> 수료(졸업)일 날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_edu01').focus();
									$('#t_edu01').css('border-color', 'red');
					    			$('#t_edu01').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
						}
						
						if ($('#t_edu10').val() != "" || $('#t_edu11').val() != "" || $('#t_edu12').val() != "" || $("#t_edu13").is(":checked") != false) {
							
							if ($('#t_edu10').val() == ""){
								alert("대학교 -> 학교명을 입력해주세요.");
								$('#t_edu10').focus();
								$('#t_edu10').css('border-color', 'red');
				    			$('#t_edu10').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($('#t_edu11').val() == "" ){
								alert("대학교 -> 수료(졸업)일을 입력해주세요.");
								$('#t_edu11').focus();
								$('#t_edu11').css('border-color', 'red');
				    			$('#t_edu11').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($('#t_edu12').val() == "" ) {
								alert("대학교 -> 학과를 입력해주세요.");
								$('#t_edu12').focus();
								$('#t_edu12').css('border-color', 'red');
				    			$('#t_edu12').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($("#t_edu13").is(":checked") == false && $("#t_edu14").is(":checked") == false && $("#t_edu15").is(":checked") == false) {
								alert("대학교 -> 학적사항을 입력해주세요.");
								$('#t_edu13').focus();
								$('.t_edu1').css('border', 'solid 3px red');
				    			$('.t_edu1').on('change', function() {
				    				$(this).css('border', 'solid 1px #e5e8eb');
				    				$(this).css('border-right', 'none');
				    			});
				    			
								return;
							}
							
							if ($('#t_edu11').val() != "") {
								if ($('#t_edu11').val().length < 6) {
									alert("대학교-> 수료(졸업)일 날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_edu11').focus();
									$('#t_edu11').css('border-color', 'red');
					    			$('#t_edu11').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
							
						}
							
						if ($('#t_edu20').val() != "" || $('#t_edu21').val() != "" || $('#t_edu22').val() != "" || $("#t_edu23").is(":checked") != false) {
							if ($('#t_edu20').val() == ""){
								alert("대학원 -> 학교명을 입력해주세요.");
								$('#t_edu20').focus();
								$('#t_edu20').css('border-color', 'red');
				    			$('#t_edu20').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($('#t_edu21').val() == "" ){
								alert("대학원 -> 수료(졸업)일을 입력해주세요.");
								$('#t_edu21').focus();
								$('#t_edu21').css('border-color', 'red');
				    			$('#t_edu21').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($('#t_edu22').val() == "" ) {
								alert("대학원 -> 학과를 입력해주세요.");
								$('#t_edu22').focus();
								$('#t_edu22').css('border-color', 'red');
				    			$('#t_edu22').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($("#t_edu23").is(":checked") == false && $("#t_edu24").is(":checked") == false && $("#t_edu25").is(":checked") == false) {
								alert("대학원 -> 학적사항을 입력해주세요.");
								$('#t_edu23').focus();
								$('.t_edu2').css('border', 'solid 3px red');
				    			$('.t_edu2').on('change', function() {
				    				$(this).css('border', 'solid 1px #e5e8eb');
				    				$(this).css('border-right', 'none');
				    			});
								return;
							}
							
							if ($('#t_edu21').val() != "") {
								if ($('#t_edu21').val().length < 6) {
									alert("대학원 -> 수료(졸업)일 날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_edu21').focus();
									$('#t_edu21').css('border-color', 'red');
					    			$('#t_edu21').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
						}
						
						if ($('#t_edu30').val() != "" || $('#t_edu31').val() != "") {
							if ($('#t_edu30').val() == "" && $('#t_edu31').val() != "") {
								alert("기타 -> 학교명을 입력해주세요.");
								$('#t_edu30').focus();
								$('#t_edu30').css('border-color', 'red');
				    			$('#t_edu30').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($('#t_edu30').val() != "" && $('#t_edu31').val() == "")  {
								alert("기타 -> 수료(졸업)일을 입력해주세요.");
								$('#t_edu31').focus();
								$('#t_edu31').css('border-color', 'red');
				    			$('#t_edu31').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
								return;
							}
							
							if ($('#t_edu31').val() != "") {
								if ($('#t_edu31').val().length < 6) {
									alert("기타 -> 수료(졸업)일 날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_edu31').focus();
									$('#t_edu31').css('border-color', 'red');
					    			$('#t_edu31').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
						}
						
						// 자격 면허 수상
						
						if ($('#t_cer00').val() != "" ||  $('#t_cer01').val() != "" || $('#t_cer02').val() != "") {
							if ($('#t_cer00').val() == "") {
								alert("자격·면허·수상 첫번째 취득년월일을 입력해주세요.");
								$('#t_cer00').focus();
								$('#t_cer00').css('border-color', 'red');
				    			$('#t_cer00').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_cer01').val() == "") {
								alert("자격·면허·수상 첫번째 내역을 입력해주세요.");
								$('#t_cer01').focus();
								$('#t_cer01').css('border-color', 'red');
				    			$('#t_cer01').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_cer02').val() == "") {
								alert("자격·면허·수상 첫번째 시행처를 입력해주세요.");
								$('#t_cer02').focus();
								$('#t_cer02').css('border-color', 'red');
				    			$('#t_cer02').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
						} 
						if ($('#t_cer10').val() != "" ||  $('#t_cer11').val() != "" || $('#t_cer12').val() != "") {
							if ($('#t_cer10').val() == "") {
								alert("자격·면허·수상 두번째 취득년월일을 입력해주세요.");
								$('#t_cer10').focus();
								$('#t_cer10').css('border-color', 'red');
				    			$('#t_cer10').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_cer11').val() == "") {
								alert("자격·면허·수상 두번째 내역을 입력해주세요.");
								$('#t_cer11').focus();
								$('#t_cer11').css('border-color', 'red');
				    			$('#t_cer11').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_cer12').val() == "") {
								alert("자격·면허·수상 두번째 시행처를 입력해주세요.");
								$('#t_cer12').focus();
								$('#t_cer12').css('border-color', 'red');
				    			$('#t_cer12').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
						}
						if ($('#t_cer20').val() != "" ||  $('#t_cer21').val() != "" || $('#t_cer22').val() != "") {
							if ($('#t_cer20').val() == "") {
								alert("자격·면허·수상 세번째 취득년월일을 입력해주세요.");
								$('#t_cer20').focus();
								$('#t_cer20').css('border-color', 'red');
				    			$('#t_cer20').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_cer21').val() == "") {
								alert("자격·면허·수상 세번째 내역을 입력해주세요.");
								$('#t_cer21').focus();
								$('#t_cer21').css('border-color', 'red');
				    			$('#t_cer21').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_cer22').val() == "") {
								alert("자격·면허·수상 세번째 시행처를 입력해주세요.");
								$('#t_cer22').focus();
								$('#t_cer22').css('border-color', 'red');
				    			$('#t_cer22').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
						}
						if ($('#t_cer30').val() != "" ||  $('#t_cer31').val() != "" || $('#t_cer32').val() != "") {
							if ($('#t_cer30').val() == "") {
								alert("자격·면허·수상 네번째 취득년월일을 입력해주세요.");
								$('#t_cer30').focus();
								$('#t_cer30').css('border-color', 'red');
				    			$('#t_cer30').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_cer31').val() == "") {
								alert("자격·면허·수상 네번째 내역을 입력해주세요.");
								$('#t_cer31').focus();
								$('#t_cer31').css('border-color', 'red');
				    			$('#t_cer31').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_cer32').val() == "") {
								alert("자격·면허·수상 네번째 시행처를 입력해주세요.");
								$('#t_cer32').focus();
								$('#t_cer32').css('border-color', 'red');
				    			$('#t_cer32').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
						}
							
						// 강의 계획
						if ($('#t_exp00').val() != "" ||  $('#t_exp01').val() != "" || $('#t_exp02').val() != "" || $('#t_exp03').val() != "" || $('#t_exp04').val() != "") {
							if ($('#t_exp00').val() == "") {
								alert("강의경력 첫번째 근무기간 시작날짜를 입력해주세요.");
								$('#t_exp00').focus();
								$('#t_exp00').css('border-color', 'red');
				    			$('#t_exp00').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp01').val() == "") {
								alert("강의경력 첫번째 근무기간 종료날짜를 입력해주세요.");
								$('#t_exp01').focus();
								$('#t_exp01').css('border-color', 'red');
				    			$('#t_exp01').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp02').val() == "") {
								alert("강의경력 첫번째 근무처를 입력해주세요.");
								$('#t_exp02').focus();
								$('#t_exp02').css('border-color', 'red');
				    			$('#t_exp02').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp03').val() == "") {
								alert("강의경력 첫번째 직위를 입력해주세요.");
								$('#t_exp03').focus();
								$('#t_exp03').css('border-color', 'red');
				    			$('#t_exp03').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp04').val() == "") {
								alert("강의경력 첫번째 주요업무를 입력해주세요.");
								$('#t_exp04').focus();
								$('#t_exp04').css('border-color', 'red');
				    			$('#t_exp04').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp00').val() != "") {
								if ($('#t_exp00').val().length < 6) {
									alert("강의경력 첫번째 근무기간 시작날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_exp00').focus();
									$('#t_exp00').css('border-color', 'red');
					    			$('#t_exp00').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
							
							if ($('#t_exp01').val() != "") {
								if ($('#t_exp01').val().length < 6) {
									alert("강의경력 첫번째 근무기간 종료날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_exp01').focus();
									$('#t_exp01').css('border-color', 'red');
					    			$('#t_exp01').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
						}
						
						if ($('#t_exp10').val() != "" ||  $('#t_exp11').val() != "" || $('#t_exp12').val() != "" || $('#t_exp13').val() != "" || $('#t_exp14').val() != "") {
							if ($('#t_exp10').val() == "") {
								alert("강의경력 두번째 근무기간 시작날짜를 입력해주세요.");
								$('#t_exp10').focus();
								$('#t_exp10').css('border-color', 'red');
				    			$('#t_exp10').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp11').val() == "") {
								alert("강의경력 두번째 근무기간 종료날짜를 입력해주세요.");
								$('#t_exp11').focus();
								$('#t_exp11').css('border-color', 'red');
				    			$('#t_exp11').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp12').val() == "") {
								alert("강의경력 두번째 근무처를 입력해주세요.");
								$('#t_exp12').focus();
								$('#t_exp12').css('border-color', 'red');
				    			$('#t_exp12').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp13').val() == "") {
								alert("강의경력 두번째 직위를 입력해주세요.");
								$('#t_exp13').focus();
								$('#t_exp13').css('border-color', 'red');
				    			$('#t_exp13').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp14').val() == "") {
								alert("강의경력 두번째 주요업무를 입력해주세요.");
								$('#t_exp14').focus();
								$('#t_exp14').css('border-color', 'red');
				    			$('#t_exp14').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp10').val() != "") {
								if ($('#t_exp10').val().length < 6) {
									alert("강의경력 두번째 근무기간 시작날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_exp10').focus();
									$('#t_exp10').css('border-color', 'red');
					    			$('#t_exp10').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
							
							if ($('#t_exp11').val() != "") {
								if ($('#t_exp11').val().length < 6) {
									alert("강의경력 두번째 근무기간 종료날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_exp11').focus();
									$('#t_exp11').css('border-color', 'red');
					    			$('#t_exp11').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
							
						}
						
						
						if ($('#t_exp20').val() != "" ||  $('#t_exp21').val() != "" || $('#t_exp22').val() != "" || $('#t_exp23').val() != "" || $('#t_exp24').val() != "") {
							if ($('#t_exp20').val() == "") {
								alert("강의경력 세번째 근무기간 시작날짜를 입력해주세요.");
								$('#t_exp20').focus();
								$('#t_exp20').css('border-color', 'red');
				    			$('#t_exp20').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp21').val() == "") {
								alert("강의경력 세번째 근무기간 종료날짜를 입력해주세요.");
								$('#t_exp21').focus();
								$('#t_exp21').css('border-color', 'red');
				    			$('#t_exp21').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp22').val() == "") {
								alert("강의경력 세번째 근무처를 입력해주세요.");
								$('#t_exp22').focus();
								$('#t_exp22').css('border-color', 'red');
				    			$('#t_exp22').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp23').val() == "") {
								alert("강의경력 세번째 직위를 입력해주세요.");
								$('#t_exp23').focus();
								$('#t_exp23').css('border-color', 'red');
				    			$('#t_exp23').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp24').val() == "") {
								alert("강의경력 세번째 주요업무를 입력해주세요.");
								$('#t_exp24').focus();
								$('#t_exp24').css('border-color', 'red');
				    			$('#t_exp24').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp20').val() != "") {
								if ($('#t_exp20').val().length < 6) {
									alert("강의경력 세번째 근무기간 시작날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_exp20').focus();
									$('#t_exp20').css('border-color', 'red');
					    			$('#t_exp20').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
							
							if ($('#t_exp21').val() != "") {
								if ($('#t_exp21').val().length < 6) {
									alert("강의경력 세번째 근무기간 종료날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_exp21').focus();
									$('#t_exp21').css('border-color', 'red');
					    			$('#t_exp21').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
						}
						
						
						if ($('#t_exp30').val() != "" ||  $('#t_exp31').val() != "" || $('#t_exp32').val() != "" || $('#t_exp33').val() != "" || $('#t_exp34').val() != "") {
							if ($('#t_exp30').val() == "") {
								alert("강의경력 네번째 근무기간 시작날짜를 입력해주세요.");
								$('#t_exp30').focus();
								$('#t_exp30').css('border-color', 'red');
				    			$('#t_exp30').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp31').val() == "") {
								alert("강의경력 네번째 근무기간 종료날짜를 입력해주세요.");
								$('#t_exp31').focus();
								$('#t_exp31').css('border-color', 'red');
				    			$('#t_exp31').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp32').val() == "") {
								alert("강의경력 네번째 근무처를 입력해주세요.");
								$('#t_exp32').focus();
								$('#t_exp32').css('border-color', 'red');
				    			$('#t_exp32').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp33').val() == "") {
								alert("강의경력 네번째 직위를 입력해주세요.");
								$('#t_exp33').focus();
								$('#t_exp33').css('border-color', 'red');
				    			$('#t_exp33').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp34').val() == "") {
								alert("강의경력 네번째 주요업무를 입력해주세요.");
								$('#t_exp34').focus();
								$('#t_exp34').css('border-color', 'red');
				    			$('#t_exp34').on('change', function() {
				    				$(this).css('border-color', '');
				    			});	
				    			return;
							}
							
							if ($('#t_exp30').val() != "") {
								if ($('#t_exp30').val().length < 6) {
									alert("강의경력 네번째 근무기간 시작날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_exp30').focus();
									$('#t_exp30').css('border-color', 'red');
					    			$('#t_exp30').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
							
							if ($('#t_exp31').val() != "") {
								if ($('#t_exp31').val().length < 6) {
									alert("강의경력 네번째 근무기간 종료날짜 형식이 잘못되었습니다. ex) YYYYMM");
									$('#t_exp31').focus();
									$('#t_exp31').css('border-color', 'red');
					    			$('#t_exp31').on('change', function() {
					    				$(this).css('border-color', '');
					    			});	
									return;
								}
							}
						}
					
					
					$('input[type=file]').each(function(i) {
						if($(this).val() == '') {
							$(this).remove();
						}
					});
					
					var teacher_phone = $('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val();
					if(teacher_phone != '--') {
						$('#teacher_phone').val(teacher_phone);
					}
					$('#teacher_cell_phone').val($('#cell_phone1').val()+'-'+$('#cell_phone2').val()+'-'+$('#cell_phone3').val());

					$('#teacher_education').val(inputs2json('t_edu'));
					$('#teacher_experience').val(inputs2json('t_exp'));
					$('#teacher_certifications').val(inputs2json('t_cer'));
					
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#teacherForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
				    			location.reload();
							} else {
								if ( response.message != null ) {
									alert(response.message);
								}
								else {
									for(var i =0 ; i < response.result.length ; i++) {
										alert(response.result[i].code);
										if (response.result[i].field == 'teacher_phone') {
											var teacher_phone = $('#teacher_phone').val();
											
											var teacher_phone_split = teacher_phone.split('-');
											
											if (teacher_phone_split[0].match('^[\\d]{2,3}') == null ) {
												$('#phone1').focus();
											} else if (teacher_phone_split[1].match('^[\\d]{3,4}') == null) {
												$('#phone2').focus();
											} else if (teacher_phone_split[2].match('^[\\d]{4}') == null) {
												$('#phone3').focus();
											}
										} else if (response.result[i].field == 'teacher_cell_phone') {
											
											var teacher_cell_phone = $('#teacher_cell_phone').val();
											
											var teacher_cell_phone_split = teacher_cell_phone.split('-');
											
											if (teacher_cell_phone_split[0].match('^01[0|1|6|7|8|9]') == null ) {
												$('#cell_phone1').focus();
											} else if (teacher_cell_phone_split[1].match('^[\\d]{3,4}') == null) {
												$('#cell_phone2').focus();
											} else if (teacher_cell_phone_split[2].match('^[\\d]{4}') == null) {
												$('#cell_phone3').focus();
											}
										}
										$('#'+response.result[i].field).focus();
										break;
									}	
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         },
				         complete : function (response) {   // 정상이든 비정상인든 실행이 완료될 경우 실행될 함수

				         	if ($('#open_file1').length == 0) {
				         		$('.fileTd').append('<input type="file" id="open_file1" name="open_file" class="text" title="파일선택" />');
				         	}
				         }
					};
					$('#teacherForm').ajaxSubmit(option);
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$('.findPostCode').on('click', function(e){
		e.preventDefault();
		var addressInput 	= $(this).attr('keyValue1');
		var focusInput = $(this).attr('keyValue1');

		daum.postcode.load(function() {
			new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }
	                
					// $(zipcodeInput).val(data.zonecode);
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $(addressInput).val(data.zonecode+' '+fullAddr);
	                // 커서를 상세주소 필드로 이동한다.
	                $(focusInput).focus();
	            }
	        }).open();
		});
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 700
	});
	
	$('a.idCheck').on('click', function(e) {
		$.get('checkId.do?homepage_id=' + $('#homepage_id').val() + '&teacher_id='+ $('#teacher_id').val() + '&search_api_type=' + $('[name="search_api_type"]:checked').val(), function(response) {
			if ( response.resultMsg != null ) {
				alert(response.resultMsg);	
			}
			else {
				$('#teacherForm #member_key').val(response.memberInfo.SEQ_NO);
				$('#teacherForm #teacher_name').val(response.memberInfo.USER_NAME);
				try {
					var MOBILE_NO = response.memberInfo.MOBILE_NO;
					$('#cell_phone1').val(MOBILE_NO.substr(0, 3));
					$('#cell_phone2').val(MOBILE_NO.substr(3, 4));
					$('#cell_phone3').val(MOBILE_NO.substr(7, 4));
				} catch(e) {
					
				}
			}
		});
		e.preventDefault();
	});
	$('input#teacher_birth').datepicker({
		yearRange: 'c-80:c',
		maxDate:0,
		onClose: function(selectedDate){
			$('input#teacher_subject_name').focus();
		}
	});
	
	$('input.ui-calendar').each(function(i) {
		if($(this).data('datepicker') == null) {
			$(this).datepicker({
				yearRange: 'c-80:c',
				maxDate:0 });
		}
	});
	
	$('input[type=text]').on('keydown', function(e) {
	    var event = e || window.event;
	    var keyID = (event.which) ? event.which : event.keyCode;
	    if (keyID == 13) {
	        return false;
	    } else {
	        return;
	    }
	});
	
	json2inputs('#teacher_education', '학력을 불러오는 도중에 오류가 발생했습니다.');
	json2inputs('#teacher_experience', '경력사항을 불러오는 도중에 오류가 발생했습니다.');
	json2inputs('#teacher_certifications', '자격 및 면허를 불러오는 도중에 오류가 발생했습니다.');
	
	try {
		var json_teacher_open_files = JSON.parse($('#teacher_open_files').val());
		for(var i=0; i < json_teacher_open_files.length; ++i) {
			var file = json_teacher_open_files[i];
			$('#td_teacher_open_files').append('<a href="/cms/module/teacherReqManage/download2/${teacher.homepage_id}/${teacher.teacher_idx}/' + file.file_hash + '.do"><i class="fa fa-floppy-o"></i> ' + file.file_name + '.' + file.file_extension + '</a><br>');
		}
	} catch(e) {
		
	}
	
});

function isEmpty(value){ 
	if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ 
		return true 
	}else{ 
		return false 
	} 
};

function inputs2json(prefix) {
	var assoc = {};
	$('input[id^="'+prefix+'"]').each(function(i) {
		var id = $(this).attr('id');
		var val = $(this).val();
		if(id != 'prefix') {
			var type = $(this).prop('type');
			if(type == 'checkbox' || type == 'radio') {
				if($(this).prop('checked') == true) {
					assoc[id] = val;
				}
			} else {
				assoc[id] = val;
			}
		}
	});
	
	return JSON.stringify(assoc);
}

function json2inputs(selector, msg) {
	var json = $(selector).val();
	if(!!json) {
		var assoc = '';
		try {
			assoc = JSON.parse(json);
		} catch(e) {
			alert(msg);
			return;
		}
		for (var id in assoc) {
			var input = $('#'+id);
			input.val(assoc[id]);
			if(assoc[id] != '' && (input.prop('type') == 'checkbox' || input.prop('type') == 'radio')) {
				input.prop('checked', true);
			}
		}
	}
}

function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 9 || keyID == 46 || keyID == 37 || keyID == 39 ) 
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
<form:form id="teacherForm" modelAttribute="teacher" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="teacher_idx"/>
	<form:hidden path="member_key"/>
	<form:hidden path="editMode"/>
	<form:hidden path="teacher_education"/>
	<form:hidden path="teacher_experience"/>
	<form:hidden path="teacher_certifications"/>
	<form:hidden path="teacher_open_files"/>
	<form:hidden path="teacher_zipcode"/>
	<form:hidden path="teacher_address"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>강사ID(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${teacher.editMode eq 'ADD' }">
	         				<form:input path="teacher_id" class="text" /> <form:radiobutton path="search_api_type" value="WEBID" label="웹ID"/> <form:radiobutton path="search_api_type" value="USERID" label="대출번호"/> <a class="btn btn1 idCheck">ID 확인</a>	
	         			</c:when>
	         			<c:otherwise>
	         				${teacher.teacher_id}
	         			</c:otherwise>
	         		</c:choose>
         		</td>
        	</tr>
			<tr>
	         	<th>이름(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
		         		<c:when test="${teacher.editMode eq 'ADD'}">
		         			<form:input path="teacher_name" class="text" readonly="true" maxlength="16"/>
	         			</c:when>
	         			<c:otherwise>
	         				${teacher.teacher_name}
	         				<form:hidden path="teacher_name"/>
	         			</c:otherwise>
         			</c:choose>	
         		</td>
        	</tr>
        	<tr>
	         	<th>생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
		         	<c:choose>
		         		<c:when test="${teacher.editMode eq 'ADD' or empty teacher.teacher_birth}">
	         				<form:input path="teacher_birth" class="text ui-calendar"/>
	         				<div class="ui-state-highlight">
								<em>* 연도는 현재 선택한 연도부터 과거 80년까지 나옵니다. </em> <br>
								<em>&nbsp;&nbsp;현재 선택창에 더 오래된 연도가 없을 시, 선택창의 연도 중 가장 오래된 연도를 선택하면 과거 80년이 더 추가됩니다.</em>
							</div>
	         			</c:when>
	         			<c:otherwise>
	         				${teacher.teacher_birth}
	         				<form:hidden path="teacher_birth"/>
	         			</c:otherwise>
         			</c:choose>
     			</td>
     			
        	</tr>
	        <tr>
	         	<th>성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${teacher.editMode eq 'ADD' }">
	         				<c:choose>
	         				<c:when test="${memberInfo.sex eq '0001'}">
	         				남
	         				<form:hidden path="teacher_sex" value="남" />
	         				</c:when>
	         				<c:when test="${memberInfo.sex eq '0002'}">
	         				여
	         				<form:hidden path="teacher_sex" value="여" />
	         				</c:when>
	         				<c:otherwise>
			         		<form:radiobutton path="teacher_sex" value="남" /> <label for="teacher_sex1" style="cursor:pointer;">남</label>&nbsp;
							<form:radiobutton path="teacher_sex" value="여"/> <label for="teacher_sex2" style="cursor:pointer;">여</label>
	         				</c:otherwise>
	         				</c:choose>
						</c:when>
						<c:otherwise>
							${teacher.teacher_sex}
							<form:hidden path="teacher_sex" />
						</c:otherwise>
					</c:choose>
				</td>
	        </tr>
	        <tr> 
				<th>휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="teacher_cell_phone" class="text" maxlength="13"/>
					<c:set var="cellPhoneArr" value="${fn:split(teacher.teacher_cell_phone, '-')}"/>
					<input id="cell_phone1" style="width:40px;" class="text" maxlength="3" numberonly="true" value="${cellPhoneArr[0]}" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/> -
					<input id="cell_phone2" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${cellPhoneArr[1]}" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/> -
					<input id="cell_phone3" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${cellPhoneArr[2]}" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/>
					<div class="ui-state-highlight">
						<em>* ex) 010-1234-5678</em>
					</div>
				</td>
			</tr>
			<tr>
<%-- 				<form:input path="teacher_address" class="text" style="width:70%" maxlength="30" title="주소 입력" /> --%>
	         	<th>주소(<span style="color: red; font-weight: bold;">*</span>)</th>			
	         	<td>
	         		<input type="text" id="full_adder" name="full_adder" class="text" style="width:70%" maxlength="120" title="주소 입력"/> <button class="btn btn2 findPostCode" keyValue1="#full_adder" title="새창열림">우편번호 찾기</button>
	         		<div class="ui-state-highlight">
						<em>* ex) 12345 대구 달서구 갈밭남로 38 (우편번호 주소)</em><br>
						<em>* 주소는 지번주소(구주소)가 아닌 도로명 주소(신주소)를 입력해 주십시오. </em>
					</div>
	         	</td>
        		
        	</tr>
        	<tr> 
				<th>이메일</th>
				<td><form:input path="teacher_email" class="text" style="width:100%;" maxlength="50" title="이메일 입력" /></td>
			</tr>
			<tr> 
				<th>전화번호</th>
				<td>
					<form:hidden path="teacher_phone"/>
					<c:set var="phoneArr" value="${fn:split(teacher.teacher_phone, '-')}"/>
					<input id="phone1" style="width:40px;" class="text" maxlength="3" numberonly="true" value="${phoneArr[0]}" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/> -
					<input id="phone2" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${phoneArr[1]}" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/> -
					<input id="phone3" style="width:50px;" class="text" maxlength="4" numberonly="true" value="${phoneArr[2]}" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/>
					<div class="ui-state-highlight">
						<em>* ex) 053-666-7777</em>
					</div>
				</td>
			</tr>
        	<tr>
	         	<th>과목구분(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:select path="subject_cd" cssClass="selectmenu">
	         			<form:option value="" label="없음"></form:option>
	         			<form:options items="${subjectCodeList}" itemLabel="code_name" itemValue="code_id"/>
	         		</form:select>
				</td>
	        </tr>
        	<tr>
	         	<th>과목명(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="teacher_subject_name" class="text" style="width:99%" maxlength="30"/></td>
        	</tr>
	        <tr>
	         	<th>강의가능지역(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:select path="teacher_location_code" cssClass="selectmenu">
	         			<form:option value="" label="없음"></form:option>
	         			<form:options items="${locationCodeList}" itemLabel="code_name" itemValue="code_id"/>
	         		</form:select>
				</td>
	        </tr>
        	<tr>
	         	<th>(구) 강사이력</th>
	         	<td><form:textarea path="teacher_history" class="text" style="width:100%;height:80px;"/></td>
        	</tr>
        	<c:if test="${teacher.file_name != null and teacher.file_name != ''}">
	        	<tr>
	        		<th>(구) 현재 첨부파일	<br/>강사등록신청서</th>
		         	<td><a href="/cms/module/teacherReqManage/download/${teacher.homepage_id}/${teacher.teacher_idx}.do"><i class="fa fa-floppy-o"></i> ${teacher.file_name}<c:if test="${not empty teacher.file_extension}">.${teacher.file_extension}</c:if></a></td>
	        	</tr>
        	</c:if>
<%--
        	<tr>
        		<th>(구) 첨부파일	<br/>강사등록신청서</th>
        		<td class="fileTd"><input type="file" id="file" name="file" class="text"/></td>
        	</tr>
--%>
        	<c:if test="${not empty teacher.teacher_open_files}">
        	<tr>
        	 	<th>현재 첨부파일<br/>강의 계획서</th>
	         	<td id="td_teacher_open_files"></td>
        	</tr>
        	</c:if>
        	<tr>
        		<th>첨부파일<br/>강의 계획서</th>
        		<td class="fileTd">
        			<input type="file" id="open_file1" name="open_file" class="text" title="파일선택" />
        		</td>
        	</tr>
		</tbody>
	</table>
	<h4>학력</h4>
	<table class="type2 education">
		<colgroup>
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
				<th></th>
				<th>학교명</th>
				<th>수료(졸업)일</th>
				<th>학과</th>
				<th>학적사항</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>고등학교</td>
				<td><input type="text" id="t_edu00" class="text" maxlength="30"></td>
				<td><input type="text" id="t_edu01" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)"></td>
				<td><input type="text" id="t_edu02" class="text" maxlength="30"></td>
				<td>
					<input type="checkbox" id="t_edu03" value="Y"><label for="t_edu03">검정고시</label>
				</td>
			</tr>
			<tr>
				<td>대학교</td>
				<td><input type="text" id="t_edu10" class="text" maxlength="30"></td>
				<td><input type="text" id="t_edu11" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)"></td>
				<td><input type="text" id="t_edu12" class="text" maxlength="30"></td>
				<td  class="t_edu1">
					<input type="radio" id="t_edu13" name="t_edu13" value="Y"><label for="t_edu13">졸업</label> &nbsp;
					<input type="radio" id="t_edu14" name="t_edu13" value="Y"><label for="t_edu14">졸업예정</label> &nbsp;
					<input type="radio" id="t_edu15" name="t_edu13" value="Y"><label for="t_edu15">수료</label>
				</td>
			</tr>
			<tr>
				<td>대학원</td>
				<td><input type="text" id="t_edu20" class="text" maxlength="30"></td>
				<td><input type="text" id="t_edu21" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)"></td>
				<td><input type="text" id="t_edu22" class="text" maxlength="30"></td>
				<td  class="t_edu2">
					<input type="radio" id="t_edu23" name="t_edu23" value="Y"><label for="t_edu23">졸업</label> &nbsp;
					<input type="radio" id="t_edu24" name="t_edu23" value="Y"><label for="t_edu24">졸업예정</label> &nbsp;
					<input type="radio" id="t_edu25" name="t_edu23" value="Y"><label for="t_edu25">수료</label>
				</td>
			</tr>
			<tr>
				<td>기타</td>
				<td><input type="text" id="t_edu30" class="text" maxlength="30"></td>
				<td><input type="text" id="t_edu31" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)"></td>
				<td><input type="text" id="t_edu32" class="text" maxlength="30"></td>
				<td><input type="text" id="t_edu33" class="text" maxlength="30" style="width:100%;"></td>
			</tr>
		</tbody>
	</table>
	<div class="ui-state-highlight">
		<em>* 고등학교, 대학교, 대학원, 기타 중 하나는 필수로 입력하여야 합니다.</em><br/>
		<em>* 수료(졸업)일 : 예) 198102 (연도4자리+월2자리)</em> <br>
	</div>
	<h4>자격·면허·수상</h4>
	<table class="type2">
		<colgroup>
			<col width="200" />
			<col width="*" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>취득년월일</th>
				<th>자격 면허명</th>
				<th>시행처</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" id="t_cer00" class="text ui-calendar" readonly="readonly"><button class="btn" onclick="$('#t_cer00').val(''); return false;" style="width: 50px;">삭제</button></td>
				<td><input type="text" id="t_cer01" class="text" maxlength="30" style="width:99%;"></td>
				<td><input type="text" id="t_cer02" class="text" maxlength="30"></td>
			</tr>
			<tr>
				<td><input type="text" id="t_cer10" class="text ui-calendar" readonly="readonly"><button class="btn" onclick="$('#t_cer10').val(''); return false;" style="width: 50px;">삭제</button></td>
				<td><input type="text" id="t_cer11" class="text" maxlength="30" style="width:99%;"></td>
				<td><input type="text" id="t_cer12" class="text" maxlength="30"></td>
			</tr>
			<tr>
				<td><input type="text" id="t_cer20" class="text ui-calendar" readonly="readonly"><button class="btn" onclick="$('#t_cer20').val(''); return false;" style="width: 50px;">삭제</button></td>
				<td><input type="text" id="t_cer21" class="text" maxlength="30" style="width:99%;"></td>
				<td><input type="text" id="t_cer22" class="text" maxlength="30"></td>
			</tr>
			<tr>
				<td><input type="text" id="t_cer30" class="text ui-calendar" readonly="readonly"><button class="btn" onclick="$('#t_cer30').val(''); return false;" style="width: 50px;">삭제</button></td>
				<td><input type="text" id="t_cer31" class="text" maxlength="30" style="width:99%;"></td>
				<td><input type="text" id="t_cer32" class="text" maxlength="30"></td>
			</tr>
		</tbody>
	</table>
	<div class="ui-state-highlight">
		<em>* 연도는 현재 선택한 연도부터 과거 80년까지 나옵니다. </em> <br>
		<em>&nbsp;&nbsp;현재 선택창에 더 오래된 연도가 없을 시, 선택창의 연도 중 가장 오래된 연도를 선택하면 과거 80년이 더 추가됩니다.</em> <br/>
		<em>* 취득년월일을 삭제하려면 '삭제' 버튼을 클릭하세요. </em> <br/>
	</div>
	<h4>강의경력</h4>
	<table class="type2">
		<colgroup>
			<col width="300" />
			<col width="100" />
			<col width="100" />
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
				<th>근무기간</th>
				<th>근무처</th>
				<th>직위</th>
				<th>주요업무</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" id="t_exp00" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)" style="width: 70px;"> ~ <input type="text" id="t_exp01" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)" style="width: 70px;"></td>
				<td><input type="text" id="t_exp02" class="text" maxlength="30"></td>
				<td><input type="text" id="t_exp03" class="text" maxlength="30"></td>
				<td><input type="text" id="t_exp04" class="text" maxlength="30"></td>
			</tr>
			<tr>
				<td><input type="text" id="t_exp10" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)" style="width: 70px;"> ~ <input type="text" id="t_exp11" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)" style="width: 70px;"></td>
				<td><input type="text" id="t_exp12" class="text" maxlength="30"></td>
				<td><input type="text" id="t_exp13" class="text" maxlength="30"></td>
				<td><input type="text" id="t_exp14" class="text" maxlength="30"></td>
			</tr>
			<tr>
				<td><input type="text" id="t_exp20" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)" style="width: 70px;"> ~ <input type="text" id="t_exp21" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)" style="width: 70px;"></td>
				<td><input type="text" id="t_exp22" class="text" maxlength="30"></td>
				<td><input type="text" id="t_exp23" class="text" maxlength="30"></td>
				<td><input type="text" id="t_exp24" class="text" maxlength="30"></td>
			</tr>
			<tr>
				<td><input type="text" id="t_exp30" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)" style="width: 70px;"> ~ <input type="text" id="t_exp31" class="text" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="6" placeholder="예) 198102 (연도4자리+월2자리)" style="width: 70px;"></td>
				<td><input type="text" id="t_exp32" class="text" maxlength="30"></td>
				<td><input type="text" id="t_exp33" class="text" maxlength="30"></td>
				<td><input type="text" id="t_exp34" class="text" maxlength="30"></td>
			</tr>
		</tbody>
	</table>
	<div class="ui-state-highlight">
		<em>* 근무기간 : 예) 198102 (연도4자리+월2자리)</em> <br>
	</div>

</form:form>
