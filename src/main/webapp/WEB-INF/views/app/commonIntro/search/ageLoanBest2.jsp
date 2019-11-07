<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/popularBook.css"/>
<style>
	.selected { border-bottom : 3px solid #ff8c00; }
</style>
<script>
$(function() {
// 	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
// 		autoOpen: false,
// 		resizable: true,
// 		modal: true, 
// 	    open: function(){
// 	        $('.ui-widget-overlay').addClass('custom-overlay');
// 	    },
// 	    close: function(){
// 	        $('.ui-widget-overlay').removeClass('custom-overlay');
// 	    }
// 	});
	
// 	$('div#ageLoanBest').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
// 		width: 1000,
// 		height: 800
// 	});
	$('a.loanBestSearch').on('click', function(e) {
		e.preventDefault();
     	location.href='/${homepage.context_path}/intro/search/index.do?menu_idx=${searchMenuIdx}&search_text='+$(this).next('span').text().trim();
	});
	$('a.loanBestSearchImg').on('click', function(e) {
		e.preventDefault();
     	location.href='/${homepage.context_path}/intro/search/index.do?menu_idx=${searchMenuIdx}&search_text='+$(this).attr('title').text().trim();
	});
	$('a.loanBestSearchImg2').on('click', function(e) {
		e.preventDefault();
     	location.href='/${homepage.context_path}/intro/search/index.do?menu_idx=${searchMenuIdx}&search_text='+$(this).find('span#s2').text().trim();
	});
	
	$('#seven').css('border-bottom', '3px solid #ff8c00');

	$('a.ageTab').on('click', function(e) {
		e.preventDefault();
		$('div.popularBook ul.age li').css('border-bottom', 'none');
		$(this).parent('li').css('border-bottom', '3px solid #ff8c00');
		$('div.ageDiv').hide();
		$('div.ageDiv#'+$(this).data('divid')).show();
	});
	
});
</script>

<div class="popularBook">
	<div class="ageBox">
		<ul class="age">
			<li id="seven">
				<a href="#" class="seven ageTab" data-divId="ageIndexSeventy">7세이하1</a>
			</li>
			<li id="nine">
				<a href="#" class="nine ageTab" data-divId="ageIndexEight">8~9세</a>
			</li>
			<li id="teen">
				<a href="#" class="teen ageTab" data-divId="ageIndexTeen">10대</a>
			</li>
			<li id="twen">
				<a href="#" class="twen ageTab" data-divId="ageIndexTwenty">20대</a>
			</li>
			<li id="thirty">
				<a href="#" class="thirty ageTab" data-divId="ageIndexThirty">30대</a>
			</li>
			<li id="forty">
				<a href="#" class="forty ageTab" data-divId="ageIndexForty">40대</a>
			</li>
			<li id="fifty">
				<a href="#" class="fifty ageTab" data-divId="ageIndexFifty">50대</a>
			</li>
			<li id="sixty">
				<a href="#" class="sixty ageTab" data-divId="ageIndexSixty">60대</a>
			</li>
			<li id="seventy">
				<a href="#" class="seventy ageTab" data-divId="ageIndexSeventy">70대</a>
			</li>
		</ul>
	</div>
	
	<div id="ageIndexSeven" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '0'}">
					<c:if test="${i.RANK le 5}">
					<li>
						<a href="#" class="loanBestSearchImg" alt="${i.TITLE}" title="${i.TITLE}">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="${i.COVER_SMALLURL}"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
								<a href="#" class="loanBestSearchImg2" alt="${i.TITLE}" title="${i.TITLE}">
									<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
								</a>
							</div>
						</a>
					</li>
					</c:if>
					</c:if>
					</c:forEach>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '0'}">
					<c:if test="${i.RANK ge 6 and i.RANK le 10}">
					<li>
						<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="${i.COVER_SMALLURL}"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
								<a href="#" class="loanBestSearchImg2" alt="${i.TITLE}" title="${i.TITLE}">
									<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
								</a>
							</div>
						</a>
					</li>
					</c:if>
					</c:if>
					</c:forEach>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '0'}">
					<c:if test="${i.RANK ge 11 and i.RANK le 15}">
					<li>
						<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="${i.COVER_SMALLURL}"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
								<a href="#" class="loanBestSearchImg2" alt="${i.TITLE}" title="${i.TITLE}">
									<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
								</a>
							</div>
						</a>
					</li>
					</c:if>
					</c:if>
					</c:forEach>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '0'}">
					<c:if test="${i.RANK ge 16}">
					<li>
						<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="${i.COVER_SMALLURL}"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
								<a href="#" class="loanBestSearchImg2" alt="${i.TITLE}" title="${i.TITLE}">
									<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
								</a>
							</div>
						</a>
					</li>
					</c:if>
					</c:if>
					</c:forEach>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '0'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div id="ageIndexEight" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/002/758/00275895.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '1'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>		
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/025/182/02518295.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '2'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/045/141/04514185.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '3'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/074/633/07463382.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '4'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/062/913/06291322.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '5'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/1/6/5/256078165s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '6'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>				
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/066/659/06665959.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '7'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/7/5/6/6/252097566s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '8'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/7/8/240538378s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '9'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/0/7/1/214038071s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '10'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/4/4/4/5/253454445s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '11'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/106/527/10652799.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '12'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="/resources/common/img/noImg.gif"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '13'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/074/633/07463382.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '14'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/7/7/0/260042770s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '15'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/3/2/8/259585328s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '16'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/4/2/9/256121429s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '17'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/067/759/06775975.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '18'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/6/7/4/246483674s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '19'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/071/312/07131216.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '1'}">
									<c:if test="${i.RANK  eq '20'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '1'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div id="ageIndexTeen" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/4/7/7/4/202614774s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '1'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>		
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/6/5/5/210723655s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '2'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/002/758/00275895.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '3'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="/resources/common/img/noImg.gif"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '4'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/074/660/07466066.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '5'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/071/312/07131216.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '6'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>				
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/9/8/8/255641988s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '7'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/4/5/259508345s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '8'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/067/694/06769446.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '9'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/077/177/07717751.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '10'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/0/7/1/214038071s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '11'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/5/8/6/247335586s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '12'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/025/182/02518295.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '13'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/066/659/06665959.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '14'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/107/281/10728155.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '15'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/1/1/0/265753110s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '16'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/9/7/1/265755971s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '17'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/6/3/0/9/256116309s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '18'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/9/6/5/8/253509658s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '19'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/9/4/6/212042946s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '2'}">
									<c:if test="${i.RANK  eq '20'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '2'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div id="ageIndexTwenty" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/1/7/7/264071177s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '1'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>		
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/7/3/1/267503731s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '2'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/5/1/267538351s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '3'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/5/8/9/259512589s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '4'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/6/0/4/4/257296044s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '5'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/6/2/8/1/255406281s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '6'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>				
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/103/747/10374788.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '7'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/6/3/4/253910634s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '8'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/3/5/8/201572358s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '9'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/7/0/3/262200703s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '10'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/3/9/3/255981393s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '11'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/4/9/8/267060498s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '12'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/4/6/4/5/236294645s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '13'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/3/8/7/222031387s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '14'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/4/8/3/1/221704831s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '15'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/7/7/0/222490770s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '16'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/2/1/1/262148211s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '17'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/046/847/04684753.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '18'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/2/0/7/240753207s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '19'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/0/2/6/255848026s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '3'}">
									<c:if test="${i.RANK  eq '20'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '3'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div id="ageIndexThirty" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/4/8/4/246660484s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '1'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>		
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/062/718/06271862.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '2'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/077/177/07717751.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '3'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/4/7/0/0/246954700s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '4'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/062/913/06291322.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '5'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/6/5/9/8/246096598s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '6'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>				
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/002/758/00275895.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '7'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/8/9/1/211155891s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '8'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/0/5/7/266230057s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '9'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/7/8/240538378s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '10'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/074/660/07466066.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '11'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/067/985/06798515.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '12'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/4/5/6/0/211864560s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '13'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/4/7/7/4/202614774s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '14'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/066/659/06665959.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '15'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/bookpark/good/0/2/4141802s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '16'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/067/254/06725410.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '17'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/0/0/6/263528006s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '18'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/9/0/2/3/261899023s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '19'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/5/6/6/256121566s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '4'}">
									<c:if test="${i.RANK  eq '20'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '4'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div id="ageIndexForty" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/077/177/07717751.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '1'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>		
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/066/821/06682123.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '2'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/074/660/07466066.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '3'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/3/6/7/221022367s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '4'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/9/0/2/5/253829025s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '5'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/2/1/1/262148211s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '6'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>				
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/062/913/06291322.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '7'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/2/7/1/238491271s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '8'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/4/5/259508345s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '9'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/067/694/06769446.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '10'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/3/5/0/255903350s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '11'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/045/141/04514185.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '12'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/6/0/1/3/263646013s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '13'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/6/4/7/204901647s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '14'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/060/617/06061750.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '15'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/062/718/06271862.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '16'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/065/978/06597885.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '17'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="/resources/common/img/noImg.gif"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '18'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/9/7/8/253362978s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '19'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/3/9/7/250455397s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '5'}">
									<c:if test="${i.RANK  eq '20'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '5'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div id="ageIndexFifty" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/7/8/240538378s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '1'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>		
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/7/6/3/260952763s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '2'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/2/7/1/238491271s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '3'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/3/6/7/221022367s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '4'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/6/2/6/1/217556261s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '5'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/2/9/5/261855295s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '6'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>				
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/9/5/2/8/260929528s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '7'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/9/8/3/4/256049834s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '8'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/1/6/4/254222164s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '9'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/0/3/7/264620037s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '10'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/5/4/7/255853547s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '11'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/7/1/1/7/257327117s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '12'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/1/7/3/253343173s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '13'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/5/6/1/256105561s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '14'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/8/5/5/255121855s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '15'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/4/8/1/239163481s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '16'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/9/7/8/6/263529786s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '17'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/074/090/07409033.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '18'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/3/3/0/243583330s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '19'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/1/6/9/263421169s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '6'}">
									<c:if test="${i.RANK  eq '20'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '6'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div id="ageIndexSixty" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/4/5/259508345s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '1'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>		
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/3/7/7/253863377s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '2'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/9/9/0/6/200689906s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '3'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="#"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '4'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/8/1/8/241211818s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '5'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/6/0/2/264773602s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '6'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>				
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/1/2/6/261822126s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '7'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/7/7/6/263400776s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '8'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/8/2/5/255903825s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '9'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/bookpark/good/0/4/1470704s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '10'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/7/2/2/2/237587222s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '11'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/6/3/6/266793636s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '12'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/0/9/5/266910095s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '13'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/7/4/5/251565745s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '14'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/6/7/245878367s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '15'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/7/0/8/243588708s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '16'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/2/5/7/264248257s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '17'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/5/0/3/251203503s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '18'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/033/094/03309417.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '19'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/3/8/2/4/261813824s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '7'}">
									<c:if test="${i.RANK  eq '20'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '7'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div id="ageIndexSeventy" class="ageDiv">
		<div class="ageImgBox1">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/8/4/7/263970847s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '1'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>		
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/045/141/04514185.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '2'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/4/4/3/265895443s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '3'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/3/3/8/260928338s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '4'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/000/051/00005160.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '5'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox2">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/028/563/02856335.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '6'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>				
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/1/8/9/257248189s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '7'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/7/4/5/2/259957452s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '8'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/0/1/3/6/255560136s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '9'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/1/9/8/8/255641988s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '10'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox3">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/7/2/4/6/254897246s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '11'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/2/6/2/5/254282625s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '12'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/8/7/3/6/268168736s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '13'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/4/8/0/255555480s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '14'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/5/8/4/237555584s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '15'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
		
		<div class="ageImgBox4">
				<ul class="ageImg">
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/4/6/9/267825469s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '16'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>			
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/4/0/3/0/250614030s.jpg"/>				
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '17'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/9/5/1/0/267269510s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '18'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bimage.interpark.com/goods_image/5/4/3/1/266905431s.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '19'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="bookImg">
								<div class="ImgBox">
									<img src="http://bookthumb.phinf.naver.net/cover/066/318/06631829.jpg"/>
								</div>
								<div class="underBar">
								</div>
							</div><br/>
							<div class="bookTitle">
							<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
								<c:if test="${i.AGECHECK eq '8'}">
									<c:if test="${i.RANK  eq '20'}">
										<span id="s1">${i.RANK}</span><span id="s2">${i.TITLE}</span>
									</c:if>
								</c:if>
							</c:forEach>						
							</div>
						</a>
					</li>
				</ul>
		</div>
	
		<div class="rankBook">
			<ul class="rankList">
				<c:forEach items="${ageLoanBestList.dsAgeBestList}" var="i" varStatus="status">
					<c:if test="${i.AGECHECK eq '8'}">
						<li style="float: left; /*padding-right: 10px; padding-bottom: 20px;*/ width:50%;" >
							<table>
								<colgroup>
									<col width="10%"/>
								<col />
								</colgroup>
								<tbody>
									<tr>
										<td><span style="text-align: center;">${i.RANK}</span></td>
										<td>
											<span style="padding-left: 10px;">
												<a href="#" class="loanBestSearch" alt="${i.TITLE}" title="${i.TITLE}">
													<c:choose>
													<c:when test="${fn:length(fn:trim(i.TITLE)) > 30}">${fn:substring(fn:trim(i.TITLE),0,30)}...</c:when>
													<c:otherwise>${fn:trim(i.TITLE)}</c:otherwise>
													</c:choose>
												</a>
												<span style="display: none;">${i.TITLE}</span>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
