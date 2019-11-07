<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/cms/resources/cms/survey/swfupload/css/default.css" />
<script type="text/javascript" src="/cms/resources/cms/survey/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
$(document).ready(function() {
    var oEditors = [];

	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "ir1",
		sSkinURI: "/cms/resources/smart_editor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});

	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
	}

	function showHTML() {
		var sHTML = oEditors.getById["ir1"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
    });
</script>

<div class="brdTop_01">
	<h1>단일선택형 문항</h1>
</div>
<!--// 상단 -->

<!-- 안내글 -->
<div class="guide">
	<ul>
	<!-- 단일선택형 -->
		<li><em>[단일선택형]</em>은 여러 개의 보기정보중 하나의 보기만 선택하는 방식입니다.</li>
		<li>보기내용의 <em>[자유응답형 추가]</em>는 기타문항과 같이 별도로 서술식 기재가 필요한 경우 사용합니다.</li>
	<!--// 단일선택형 -->
		
	<!-- 복수선택형 -->
		<li><em>[복수선택형]</em>은 여러 개의 보기정보중 여러가지 보기를 선택할 수 있는 방식입니다.</li>
		<li>보기내용의 <em>[자유응답형 추가]</em>는 기타문항과 같이 별도로 서술식 기재가 필요한 경우 사용합니다.</li>
	<!--// 복수선택형 -->
		
	<!-- 매트릭스형 -->
		<li><em>[매트릭스형]</em>은 다수의 세부문항을 동일한 척도로 측정하고자 할 때 사용하는 표형태의 질문입니다.</li>
		<li>세부질문의 수를 입력하고 문항내용을 등록하십시오.</li>
		<li>보기의 수를 입력하고 보기명을 등록하십시오.</li>
	<!--// 매트릭스형 -->
	
	<!-- 서술형 -->
		<li>질문내용을 입력하신 후에 응답유형을 선택하여 주십시오.</li>
		<li><em>[단문응답형]</em>은 응답자가 자유롭게 <em>간단한 답변</em>을 기재하는 방식입니다.</li>
		<li><em>[장문응답형]</em>은 응답자가 자유롭게 <em>장문의 답변</em>을 기재하는 방식입니다.</li>
	<!--// 서술형 -->
	
	<!-- 주석문 -->
		<li><em>[주석문]</em>은 문항 사이에 기술하는 설명 및 안내문구를 입력할 수 있습니다.</li>
		<li>주석을 입력한 후 등록하기 버튼을 선택하여 주십시오.</li>
	<!--// 주석문 -->
	
	<!-- 이미지 -->
		<li>업로드하고자 하는 <em>[이미지]</em>를 선택한 후, 등록 버튼을 클릭하여 주세요.</li>
		<li><em>JPG 및 GIF</em> 파일 형태의 이미지만 업로드 가능합니다.</li>
	<!--// 이미지 -->
	</ul>
</div>
<!--// 안내글 -->
<p class="hspace10"></p>

<!-- 설문항 세부 작성 -->
<div class="boardEdit mysurvey">
	<table class="edit" summary="설문항 세부 목록을 작성할 수 있습니다.">
		<caption>설문항 세부 작성</caption>
		<colgroup>
			<col width="80" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>질문명</th>
				<td class="aL">
					<div class="item">
						<textarea title="" name="ir1" id="ir1" class="i_text" rows="10" cols="100"></textarea>
					</div>	
					<!-- 첨부파일 미리보기 -->
					<div id="attach_area" style="width:630px;">
						<h4>첨부파일 업로드</h4>
						<div class="fileUploader">
							<!--<div class="preview"><span><img width="88" height="78" src="" /></span></div>-->
							<div class="thumb"><span><img width="88" height="78" src="" alt="첨부파일 미리보기" /></span></div>
							<div class="fileListArea">
								 <select multiple="multiple"> 
									 <option></option> 
									 <option></option> 
									 <option></option>
									 <option></option>
									 <option></option> 
								</select> 
							</div>
							<div class="file_info">
								<div class="fileUploadControl">
									<span class="btn_add"><a href="#">파일추가</a></span>
									<a href="#"><span class="btn_del">선택삭제</span></a>
									<a href="#"><span class="btn_chooseThumb">썸네일 지정</span></a>
								<!--<a href="#"><span class="btn_preview">미리보기 이미지</span></a>
									
									<a href="#"><span class="btn_put">에디터에넣기</span></a>-->
									
								</div>
								<div class="file_attach_info">
									<span><strong>문서 첨부제한 :</strong></span> <span>5.87MB/ 200MB</span><br/>
									<span><strong>파일 제한크기 :</strong></span> <span>30MB (허용 확장자 : *.*)</span><br/>
									<span><strong>미리보기 이미지 :</strong></span> <span>img.jpg</span>
								</div>
							</div>
						</div>
						
						<div class="fileResult">
							<div class="rate">업로드 진행률</div>
							<div class="loading">
								<div class="progress_bar">
									<span style="width:50%;"></span>
								</div>
							</div>
							<div class="dsc_loading_no">
								<span class="progress">50%</span>
							</div>
						</div>
					</div>
					<!--// 첨부파일 미리보기 -->	
				</td>
			</tr>
			<tr>
				<th>필수여부</th>
				<td class="aL">
					<input id="" name="" type="radio" value="1" checked />
					<label for="">필수</label>
					
					<input id="" name="" type="radio" value="2" />
					<label for="">선택</label>
					
					<span class="em">*반드시 응답해야 하는 문항이면 필수를 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>세부질문명</th>
				<td class="aL">
					<!-- 질문입력 버튼 클릭 전 -->
					<label for="" style="margin:0">세부질문 수를 입력하세요</label>
					<input id="" name="" type="text" size="3" maxlength="2" class="mL10" />
					<span class="btn"><a href="#"><img src="/resources/cms/survey/img/btn_question.gif" alt="질문 입력" /></a></span>
					<!--// 질문입력 버튼 클릭 전 -->
					
					<!-- 질문입력 버튼 클릭 후-->
					<p class="after_click">
						<label for="">세부질문1</label>
						<input id="" name="" type="text" size="60" />
					</p>
					<p class="after_click">
						<label for="">세부질문2</label>
						<input id="" name="" type="text" size="60" />
					</p>
					<!--// 질문입력 버튼 클릭 후 -->
				</td>
			</tr>
			<tr>
				<th>응답유형</th>
				<td class="aL">
					<input id="" name="" type="radio" value="1" checked />
					<label for="">단문응답형</label>
					
					<input id="" name="" type="radio" value="2" />
					<label for="">장문응답형</label>
					
					<span class="btn"><a href="#"><img src="/resources/cms/survey/img/btn_check.gif" alt="확인" /></a></span>
				</td>
			</tr>
				<tr>
				<th>보기내용</th>
				<td class="aL">
					<!-- 보기입력 버튼 클릭 전 -->
					<label for="" style="margin:0">보기의 수를 입력하세요</label>
					<input id="" name="" type="text" size="3" maxlength="2" class="mL10" />
					<span class="btn"><a href="#"><img src="/resources/cms/survey/img/btn_answer.gif" alt="보기 입력" /></a></span>
					<!--// 보기입력 버튼 클릭 전 -->
					
					<!-- 보기입력 버튼 클릭 후 -->
					<p class="after_click">
						<label for="">보기1</label>
						<input id="" name="" type="text" size="60" />
						
						<input id="" name="" type="checkbox" value="1" />
						<label for="">자유응답형 추가</label>
					</p>
					<p class="after_click">
						<label for="">보기2</label>
						<input id="" name="" type="text" size="60" />
						
						<input id="" name="" type="checkbox" value="2" />
						<label for="">자유응답형 추가</label>
					</p>
					<!--// 보기입력 버튼 클릭 후 -->
					
					<!-- 응답유형 단문으로 선택 시 내용 나오는 경우 -->
					<p class="em">* 단문응답형을 선택하셨습니다.</p>
					<!--// 응답유형 단문으로 선택 시 내용 나오는 경우 -->
					
					<!-- 응답유형 장문으로 선택 시 내용 나오는 경우 -->
					<p class="em">* 장문응답형을 선택하셨습니다.</p>
					<!--// 응답유형 장문으로 선택 시 내용 나오는 경우 -->
					
					<!-- 응답유형을 단문으로 선택 후 확인 버튼 클릭 시 -->
					<p>
						<label for="" class="screen_out">단문응답 입력</label>
						<input id="" name="" type="text" size="85" maxlength="20" />
					</p>
					<!--// 응답유형을 단문으로 선택 후 확인 버튼 클릭 시 -->
					
					<!-- 응답유형을 장문으로 선택 후 확인 버튼 클릭 시 -->
					<p>
						<label for="" class="screen_out">장문응답 입력</label>
						<textarea id="" name="" class="i_text" rows="5" cols="100"></textarea>
					</p>
					<!--// 응답유형을 장문으로 선택 후 확인 버튼 클릭 시 -->
				</td>
			</tr>
			<tr>
				<th><label for="">이미지찾기</label></th>
				<td class="aL"><input id="" name="" type="file" /></td>
			</tr>
			<tr>
				<th>권한설정</th>
				<td class="aL">
					<input id="" name="" type="checkbox" value="1" checked />
					<label for="">학생</label>
					
					<input id="" name="" type="checkbox" value="2" />
					<label for="">학부모</label>
					
					<input id="" name="" type="checkbox" value="3" />
					<label for="">교사</label>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!--// 설문항 세부 작성 -->

<!-- 버튼 -->
<div class="brdBtn">
	<a href="#" class="button">등록</a>
</div>
<!--// 버튼 -->
<p class="hspace10"></p>