<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
	div.leftBox {float: left;}
	div.rightBox {float: right;}
</style>

<script>

	$(document).ready(function() {
		$('#dialog-6.dialog-common').dialog({  //모달창 기본 스크립트 선언
			autoOpen: false,
			resizable: false,
			modal: true,
			width: 1200,
			height: 650,
			open: function(){
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function(){
				$('.ui-widget-overlay').removeClass('custom-overlay');
			}
		});


		$('a#up_cate').on('click', function(e) {
			e.preventDefault();

			var idx = fm.cate1.options.selectedIndex;
			if(idx < 0) {
				alert("선택된 목록이 없습니다.");
				return;
			}

			moveOption(idx, -1, fm.cate1.options);
		});

		$('a#down_cate').on('click', function(e) {
			e.preventDefault();

			var idx = fm.cate1.options.selectedIndex;
			if(idx < 0) {
				alert("선택된 목록이 없습니다.");
				return;
			}

			moveOption(idx, 1, fm.cate1.options);
		});


		<%-- 정렬 순서저장 --%>
		$('a#save_list').on('click', function(e) {
			e.preventDefault();

			if(confirm("정렬기준을 저장하시겠습니까?")) {
				saveList();
			}
		});

		$('a#sort_plus').on('click', function(e) {
			var selectValue = $('#cate2').val();

			if(selectValue) {
				var text = $('#cate2 option:selected').text();
				var checkText = "";
				var cate1Text = "";
				var cate2Text = "";
				var plusYn = true;


				$('#cate1 option').each(function() {
					var splitText = text.split("(");
					checkText = $(this).text().split("(");

					cate1Text = checkText[0].trim();
					cate2Text = splitText[0].trim();

					if (cate1Text == cate2Text){
						plusYn = false;
					}
				});

				if (!plusYn){
					alert("정렬 기준에서 오름차순,내림차순 선택은 한개만 가능합니다.");
					return;
				}else {
					$('<option value="' + selectValue + '" selected>' + text + '</option>').appendTo('#cate1');
					$('#cate2 option:selected').remove();
				}

			}else {
				alert("선택된 목록이 없습니다.");
				return;
			}
		});

		$('a#sort_minus').on('click', function(e) {
			var selectValue = $('#cate1').val();

			if(selectValue) {
				var text = $('#cate1 option:selected').text();
				$('#cate1 option:selected').remove();
				$('<option value="' + selectValue + '">' + text + '</option>').appendTo('#cate2');
			}else {
				alert("선택된 목록이 없습니다.");
				return;
			}
		});


	});

	function moveOption(i, n, options) {
		if(n < 0 && i == 0) return;
		if(n > 0 && i >= options.length-1) return;

		var opt1 = options[i];
		var opt2 = options[i+n];


		var text = opt1.text;
		var value = opt1.value;

		opt1.text  = opt2.text;
		opt1.value = opt2.value;
		opt2.text = text;
		opt2.value = value;

		options.selectedIndex = i+n;
	}

	function saveList() {
		var data_list = [];
		var homepage_id = $('#homepage_id').val();

		if (fm.cate1.options.length > 0){
			for(var i = 0; i < fm.cate1.options.length; i++) {
				data_list.push({ sort_idx: fm.cate1.options[i].value, set_sort_name : fm.cate1.options[i].text, sort_num: (i + 1), homepage_id: homepage_id});
			}
		}else {
			data_list.push({ homepage_id: homepage_id});
		}

		$.ajax({
			url: '/cms/module/teach/teachSort/save.do',
			type: "POST",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(data_list),
			async: false,
			cache: false,
			processData: false,
			success: function(data) {
				if (data.valid) {
					alert(data.message);
					location.reload();
				} else {
					alert(data.message);
				}

			}
		});
	}

	function addOption(select, div) {
		return function(data) {
			var cate = data.data;
			if (div == '1') {
				$('<option>', { value: cate.large_code, text: cate.code_name }).appendTo(select);
			}
		}
	}


</script>

<div style="margin-left: 100px; height: 600px; text-align: center;">
	<form name="fm" method="post" action="#">
		<input type="hidden" name="homepage_id">
		<input type="hidden" name="data_list">
		<div class="leftBox" style="width: 390px;">
			<div class="contentsBox">
				<div class="categoryEdit ">
					<p class="title" style="text-align: center;">정렬 순서</p>
					<select id="cate1" name="cate1" size=2 style="width: 100%; height: 450px;">
						<c:forEach var="i" varStatus="status" items="${teachSetSortList}">
							<option value="${i.sort_idx}">${i.set_sort_name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="arrayArea" style="margin-top: 10px;">
				<a class="btn i01" id="up_cate"><span><i class="fa fa-arrow-up" aria-hidden="true"></i>위로</span></a>
				<a class="btn i02" id="down_cate"><span><i class="fa fa-arrow-down" aria-hidden="true"></i>아래</span></a>
				<a class="btn" id="save_list"><span><i class="fa fa-floppy-o" aria-hidden="true"></i>저장</span></a>
			</div>
		</div>
		<div class="leftBox" style="width: 200px; margin-left: 10px;  margin-top: 230px;">
			<a class="btn" id="sort_plus"><span><i class="fa fa-plus" aria-hidden="true"></i>추가</span></a><br>
			<a class="btn" id="sort_minus"><span><i class="fa fa-minus" aria-hidden="true"></i>제외</span></a>
		</div>
		<div class="rightBox" style="width: 390px; margin-right: 60px;">
			<div class="categoryEdit">
				<p class="title" style="text-align: center;">강좌 정렬 기준</p>
				<select id="cate2" name="cate2" size=2 style="width: 100%; height: 450px;">
					<c:forEach var="i" varStatus="status" items="${teachSortList}">
						<option value="${i.sort_idx}">${i.sort_name}</option>
					</c:forEach>
				</select>
			</div>
			<div class="arrayArea" style="margin-top: 10px;">
			</div>
		</div>
	</form>
</div>
