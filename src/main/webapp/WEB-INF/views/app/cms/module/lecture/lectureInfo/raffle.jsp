<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">

	let originalRaffle = ${raffleLectureRequestList};
	let beforeRaffArr = [];
	let afterRaffleArr = [];

	// 신청자 초기화
	function initList() {
		originalRaffle.forEach(request => {
			$('#raffle_before').append(optionItem(request.add_id, request.request_name));
		});
	}

	// option 신청자 폼
	function optionItem(add_id, request_name) {
		return `<option value="`+add_id+`">`+request_name+`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`+add_id+`</option>`
	}

$(function() {
	initList();

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

					if (afterRaffleArr.length <= 0) {
						if(!confirm("추첨을 하지 않고 저장하면\n" +
								"기존의 추첨자 전부가 추첨대기 상태가 됩니다.\n" +
								"정말 저장하시겠습니까?")) return;
					}
					else if(!confirm("정말 추첨 내역을 저장하시겠습니까?\n(이전에 추첨했던 기록은 전부 사라집니다.)")) {
						return;
					}

					jQuery.ajaxSettings.traditional = true;

					var ajaxData = {
						'lecture_id' : '${lectureInfo.lecture_id}',
						'request_type' : '온라인',
						'editMode' : 'UPDATE',
						'after_raffle_list' : JSON.stringify(afterRaffleArr)
					};

					$.ajax({
						url : '../lectureRequest/saveRaffle.do',
						type : 'POST',
 						data : ajaxData,
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
							 	$('#dialog-2').dialog('destroy');
							 	$('#dialog-3').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
								location.reload();
							} else {
								if ( response.message != null ) {
									alert(response.message);
								} else{
									alert("관리자에게 문의하세요");
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					});
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

	$('#dialog-3').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 950
	});

});

// 추첨버튼
function raffle() {
	beforeRaffArr = [];
	afterRaffleArr = [];

	beforeRaffArr = JSON.parse(JSON.stringify(originalRaffle));

	while(beforeRaffArr.length > ${lectureInfo.wait_request_count + lectureInfo.online_request_count}-${lectureInfo.online_person_count} && beforeRaffArr.length > 0){
		var movenum = beforeRaffArr.splice(Math.floor(Math.random() * beforeRaffArr.length),1)[0];
		afterRaffleArr.push(movenum);
	}

	$('#raffle_before').empty();
	$('#raffle_after').empty();

	beforeRaffArr.forEach(request => {
		$('#raffle_before').append(optionItem(request.add_id, request.request_name));
	});

	afterRaffleArr.forEach(request => {
		$('#raffle_after').append(optionItem(request.add_id, request.request_name));
	});

	$('#before_raffle_count').text(beforeRaffArr.length);
	$('#after_raffle_count').text(afterRaffleArr.length);
}

// 리셋 버튼
function reset() {
	beforeRaffArr = [];
	afterRaffleArr = [];

	beforeRaffArr = JSON.parse(JSON.stringify(originalRaffle));

	$('#raffle_before').empty();
	$('#raffle_after').empty();

	beforeRaffArr.forEach(request => {
		$('#raffle_before').append(optionItem(request.add_id, request.request_name));
	});

	afterRaffleArr.forEach(request => {
		$('#raffle_after').append(optionItem(request.add_id, request.request_name));
	});
}

/*function shuffle(array) {
	for (let index = array.length - 1; index > 0; index--) {
		// 무작위 index 값을 만든다. (0 이상의 배열 길이 값)
		const randomPosition = Math.floor(Math.random() * (index + 1));

		// 임시로 원본 값을 저장하고, randomPosition을 사용해 배열 요소를 섞는다.
		const temporary = array[index];
		array[index] = array[randomPosition]; array[randomPosition] = temporary;
	}
}*/


</script>

<style>
	#edit-modal {
		height: 80vh;
		overflow-y: auto;
	}
</style>

<div id="edit-modal">
<form:form modelAttribute="lectureInfo" id="lectureInfoEdit" action="save.do" enctype="multipart/form-data" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="lecture_id"/>
</form:form>

	<div class="leftBox" style="width: 45%; display: inline-block;">
		<div class="contentsBox">
			<div class="categoryEdit ">
				<p class="title" style="text-align: center;">추첨 대기자</p>
				<select id="raffle_before" name="raffle_before" size=2 style="width: 100%; height: 70vh;">

				</select>
			</div>
		</div>
		<%--<div class="arrayArea" style="margin-top: 10px;">
			<a class="btn i01" id="up_cate"><span><i class="fa fa-arrow-up" aria-hidden="true"></i>위로</span></a>
			<a class="btn i02" id="down_cate"><span><i class="fa fa-arrow-down" aria-hidden="true"></i>아래</span></a>
			<a class="btn" id="save_list"><span><i class="fa fa-floppy-o" aria-hidden="true"></i>저장</span></a>
			<a class="btn" id="add_code1"><span><i class="fa fa-plus" aria-hidden="true"></i>추가</span></a>
			<a class="btn" id="modify_code1"><span><i class="fa fa-pencil-square-o" aria-hidden="true"></i>수정</span></a>
		</div>--%>
	</div>

	<div style="display: inline-block; width: 8%;">
		<div style="text-align: center; position: relative; bottom: 250px;">
			<a class="btn i01" onclick="raffle()"><span><i class="fa fa-star" aria-hidden="true"></i>추첨</span></a>
			<a class="btn i01" style="margin-top: 4px;" onclick="reset()"><span><i class="fa fa-arrow-left" aria-hidden="true"></i>리셋</span></a>
		</div>
	</div>

	<div class="rightBox" style="width: 45%; display: inline-block;">
		<div class="categoryEdit">
			<p class="title" style="text-align: center;">추첨완료</p>
			<select id="raffle_after" name="raffle_after" size=2 style="width: 100%; height: 70vh;">

			</select>
		</div>
		<%--<div class="arrayArea" style="margin-top: 10px;">
			<a class="btn i01" id="up_cate2"><span><i class="fa fa-arrow-up" aria-hidden="true"></i>위로</span></a>
			<a class="btn i02" id="down_cate2"><span><i class="fa fa-arrow-down" aria-hidden="true"></i>아래</span></a>
			<a class="btn" id="save_list2"><span><i class="fa fa-floppy-o" aria-hidden="true"></i>저장</span></a>
			<a class="btn" id="add_code2"><span><i class="fa fa-plus" aria-hidden="true"></i>추가</span></a>
			<a class="btn" id="modify_code2"><span><i class="fa fa-pencil-square-o" aria-hidden="true"></i>수정</span></a>
		</div>--%>
	</div>

	<div class="leftBox" style="width: 45%; display: inline-block;">
		총 추첨대기인원 : <span id="before_raffle_count">${lectureInfo.wait_request_count + lectureInfo.online_request_count}</span>명
	</div>

	<div style="display: inline-block; width: 8%;">

	</div>

	<div class="rightBox" style="width: 45%; display: inline-block;">
		현재인원 : <span id="after_raffle_count">0</span>명 | 추첨인원 : ${lectureInfo.online_person_count}명
	</div>
</div>

