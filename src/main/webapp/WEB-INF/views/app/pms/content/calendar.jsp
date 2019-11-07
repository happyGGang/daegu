<%@ page language="java" pageEncoding="utf-8"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>

<div id="calendar">

	<div class="cal-func">
		<div class="date-view">
			<b class="date">2016-12</b>
			<a id="before-btn" href="#prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
			<a id="next-btn" href="#next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
	
			<select class="selectmenu" style="width:80px">
				<option>2016년</option>
				<option>2015년</option>
			</select>
			<select class="selectmenu" style="width:65px">
				<option>12월</option>
				<option>11월</option>
			</select>
			<button class="btn">이동</button>
		</div>
		<div class="date-type">
			<span class="type-r"><i></i><em>휴관일</em></span>
			<span class="type-e"><i></i><em>행사일정</em></span>
			<span class="type-m"><i></i><em>영화상영</em></span>
		</div>
	</div>
	<table class="cal-tbl">
		<thead>
			<tr>
				<th class="sun">일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th class="sat">토</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="sun"><div>&nbsp;</div></td>
				<td><div>&nbsp;</div></td>
				<td><div>&nbsp;</div></td>
				<td><div>&nbsp;</div></td>
				<td><div>1</div></td>
				<td><div>2</div></td>
				<td class="sat"><div>3</div></td>
			</tr>

			<tr>
				<td class="sun"><div>4</div></td>
				<td class="data1">
					<div>5</div>
					<ul>
						<li title="휴관일">
							<span class="type-r"><i></i><em>휴관일입니다 휴관일 입니다</em></span>
						</li>
					</ul>
				</td>
				<td class="data2">
					<div>6</div>
					<ul>
						<li title="금호글사랑주부독서회 12월모임">
							<a href=""><span class="type-e"><i></i><em>금호글사랑주부독서회 12월모임</em></span></a>
						</li>
						<li title="문화가 있는 날">
							<a href=""><span class="type-e"><i></i><em>문화가 있는 날</em></span></a>
						</li>
					</ul>
				</td>
				<td><div>7</div></td>
				<td><div>8</div></td>
				<td class="today"><div>9</div></td>
				<td class="sat"><div>10</div></td>
			</tr>
			<tr>
				<td class="sun"><div>11</div></td>
				<td><div>12</div></td>
				<td class="data3">
					<div>13</div>
					<ul>
						<li title="금호글사랑주부독서회 12월모임">
							<a href=""><span class="type-e"><i></i><em>금호글사랑주부독서회 12월모임</em></span></a>
						</li>
						<li title="문화가 있는 날">
							<a href=""><span class="type-e"><i></i><em>문화가 있는 날</em></span></a>
						</li>
						<li title="금호글사랑주부독서회 12월모임">
							<a href=""><span class="type-e"><i></i><em>금호글사랑주부독서회 12월모임</em></span></a>
						</li>
					</ul>
				</td>
				<td><div>14</div></td>
				<td><div>15</div></td>
				<td><div>16</div></td>
				<td class="sat"><div>17</div></td>
			</tr>
			<tr>
				<td class="sun"><div>18</div></td>
				<td><div>19</div></td>
				<td><div>20</div></td>
				<td><div>21</div></td>
				<td><div>22</div></td>
				<td class="data"><!-- 4개이상 -->
					<div>23</div>
					<ul>
						<li title="금호글사랑주부독서회 12월모임">
							<a href=""><span class="type-e"><i></i><em>금호글사랑주부독서회 12월모임</em></span></a>
						</li>
						<li title="금호글사랑주부독서회 12월모임">
							<a href=""><span class="type-e"><i></i><em>금호글사랑주부독서회 12월모임</em></span></a>
						</li>
						<li title="문화가 있는 날">
							<a href=""><span class="type-e"><i></i><em>문화가 있는 날</em></span></a>
						</li>
						<li title="금호글사랑주부독서회 12월모임">
							<a href=""><span class="type-e"><i></i><em>금호글사랑주부독서회 12월모임</em></span></a>
						</li>
					</ul>
				</td>
				<td class="sat"><div>24</div></td>
			</tr>
		</tbody>
	</table>

	<br/><br/><br/>

	<div class="calendar-view">

		<h2>이달의 행사 자세히 보기</h2>
		<p class="txt-box"><i class="fa fa-calendar"></i> 2015년 12월 12일</p>
		<ul>
			<li><label>행사명 :</label> <span class="type-e"><i></i><em>금호글사항주부독서회 12월모임</em></span></li>
			<li><label>기 간 :</label> <span>2015년 12월 12일</span></li>
			<li><label>내 용 :</label>
				<div class="cont">토론도서: (박완서 산문집) 호미, 박완서</div>
			</li>
		</ul>
	
	</div>

</div>

<div class="button bbs-btn center">
	<a href="" class="btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
</div>

<!-- <button id="btn1" class="btn">내용 보기</button> -->

<script type="text/javascript">
$(function(){
	/*
	//모달창
	$('.calendar-view').dialog({ //모달창 기본 스크립트 선언
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
				click: function(){
					$(this).dialog('destroy');
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function(){
					$(this).dialog('destroy');
				}
			}
		]
	});
	$(".calendar-view").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 300
	});

	//모달창 링크 버튼
	$('#btn1').on('click',function(event){
		$('.calendar-view').dialog('open').load('content/calendar-view.jsp',function(data){
			//alert();
		});
		event.preventDefault();
	});
	*/

	function cwFunc(){
		var cw = ($('#calendar td').width())-8;
		$('#calendar td ul').css({'width':cw+'px'}).show();
	}
	cwFunc();
	
	$(window).resize(function(){
		cwFunc();
	});
});
</script>