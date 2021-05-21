var fileNum = 0;
var updateNum = 0;
var fileListAreaID;		//select 박스 id
var previewAreaID;		//미리보기 ID
var fileSizeViewID;		//파일사이즈 ID
var defaultPath;			//기본 경로
var fileList = new Array(); // 파일 목록 저장 배열 추가

function fileQueued(file) {
	file.status = -1;
	file.index = updateNum;
	file.id = 'file_'+updateNum;
	updateNum++;
	fileList.push( file );

	showFileList();
}

function uploadStart(file) {
	fileQueued(file);
	// 파일을 업로드 상태로 변경하고 기존 배열에서 해당 파일을 찾아 상태 변경
	file.status = -2;
	changeFileStatus( file );
	showFileList();
}

function uploadSuccess(file, serverData) {
	/*
		기본적인 file 객체의 내용

		name= 파일이름
		status= -4
		id= file_0
		index= 0
		size= 파일사이즈
		ext = 파일확장자
		makeValue = 실제 select option value로 들어갈 값 (// 로 값이 구분된다.)
		path = 파일의 실제 경로

		아래 부분에서는 해당 file 객체에 saveFileName( 서버에 저장된 파일명 ),
	*/
	var progressMessage = '';

	var realFileName = serverData.server_file_name;
	var fileName = serverData.org_file_name;
	var filePath = serverData.file_url;
	var valid = serverData.valid;
	var msg = serverData.msg;
	var size = serverData.file_size;

	// 실제 서버에 저장되는 파일명을 저장한다.
	file.saveFileName = realFileName;
	file.path = filePath;
	file.size = size;

	// 파일 상태값 입력 : -4(완료)
	if(fileNum > 0) {	// fileNum 이 0보다 크다면 수정모드에서 값이 변경되었으므로 file.index 값을 수정한다.
		file.index = fileNum++;
	}
	if(valid) {
		file.status = -4;
		var fileName = file.name.toLowerCase();
		file.ext = fileName.substring(fileName.lastIndexOf("."));

		var commaIndex = -1;

		var fileNameNew = file.name;

		if(file.name != '' && file.name != undefined) {
			commaIndex = file.name.indexOf(',');
			if(commaIndex > -1) {
				fileNameNew = file.name.replace(/,/g,';;');
			}
		}

		file.makeValue = fileNameNew+'//'+file.saveFileName+'//'+file.size+'//'+file.ext+'//'+file.index+'//new';
		progressMessage = '완료';

	} else {
		//var error = json[ 'error' ];
		var error = msg;
		alert(error);
		file.status = -3;
		progressMessage = error;
	}
	changeFileStatus( file );

	showFileList();
}

/*function uploadComplete(file) {
	// 파일 큐가 비워진다면( 모두 완료되면 )
	if (this.getStats().files_queued === 0) {
		//$(this.customSettings.cancelButtonId).disabled = true;	// 업로드 중 취소 버튼 활성화 유무

		var progress = new FileProgress(file, this.customSettings.progressTarget);
		previewUpload();

		// 에러 발생시 메시지 출력 후 1초 후 사라짐
		setTimeout( function () {
			 progress.disappear();
		}, 1000 );
	}
}*/

/**
 * 현재 fileList 에 있는 파일 데이터들 중 상태가 변경된 데이터를 찾아서 교체한다.
 *
 * @param file 새로 업로드 되거나 정보가 변경된 파일
 */
function changeFileStatus( file ) {
	for( var i = 0; i < fileList.length; i++ ) {
		if( fileList[i].id == file.id ) {
			fileList[i] = file;
			break;
		}
	}
}

/**
 * 셀렉트 박스에 파일 정보를 업데이트 한다.
 */
function showFileList() {
	var selectObj = fileListAreaID;

	var length = selectObj.childNodes.length - 1;

	while(selectObj.childNodes.length > 0) {
		selectObj.removeChild(selectObj.childNodes[length--]);
	}

	var text;

	var totalSize = 0;

	for( var i = 0; i < fileList.length; i++ ) {
		text = "";

		if( fileList[i] != null ) {

			// 파일 상태에 따른 데이터 변경
			/*
				QUEUED		 : -1,
				IN_PROGRESS	 : -2,
				ERROR		 : -3,
				COMPLETE	 : -4,
				CANCELLED	 : -5
			*/
			if( fileList[i].status == -1 ) {
				text = fileList[i].name + "(" + calculateFileSize( fileList[i].size ) + ") 대기 중..";
			} else if( fileList[i].status == -2 ) {
				text = fileList[i].name + "(" + calculateFileSize( fileList[i].size ) + ") 업로드 중..";
			} else if( fileList[i].status == -4 ) {
				text = fileList[i].name + "(" + calculateFileSize( fileList[i].size ) + ") 완료";
				// 업로드가 완료된 데이터에 한해서만 사이즈를 저장한다.
				totalSize += fileList[i].size;
			}

			if( text ) {
				var optionElement = document.createElement("OPTION");

				var textNode = document.createTextNode( text );

				optionElement.appendChild( textNode );
				optionElement.setAttribute( "value", fileList[i].makeValue );		// fileSize , 실제파일명 , 확장자명 으로 후에 변경 ( 확장자명 통일 jpeg -> jpg )
				optionElement.setAttribute( "label", text );

				selectObj.appendChild( optionElement );
			}
		}
	}
	// 총 업로드 사이즈 출력
	fileSizeViewID.innerHTML = calculateFileSize( totalSize );
}

function modifyShowFileList() {
	var selectObj = fileListAreaID;

	var text;

	var totalSize = 0;

	for( var i = 0; i < fileList.length; i++ ) {
		text = "";

		if( fileList[i] != null ) {

			// 파일 상태에 따른 데이터 변경
			/*
				QUEUED		 : -1,
				IN_PROGRESS	 : -2,
				ERROR		 : -3,
				COMPLETE	 : -4,
				CANCELLED	 : -5
			*/
			if( fileList[i].status == -1 ) {
				text = fileList[i].name + "(" + calculateFileSize( fileList[i].size ) + ") 대기 중..";
			} else if( fileList[i].status == -2 ) {
				text = fileList[i].name + "(" + calculateFileSize( fileList[i].size ) + ") 업로드 중..";
			} else if( fileList[i].status == -4 ) {
				text = fileList[i].name + "(" + calculateFileSize( fileList[i].size ) + ") 완료";
				// 업로드가 완료된 데이터에 한해서만 사이즈를 저장한다.
				totalSize += fileList[i].size;
			}
			if( text ) {
				var optionElement = document.createElement("OPTION");

				var textNode = document.createTextNode( text );

				optionElement.appendChild( textNode );

				optionElement.setAttribute( "value", fileList[i].makeValue );		// fileSize , 실제파일명 , 확장자명 으로 후에 변경 ( 확장자명 통일 jpeg -> jpg )
				optionElement.setAttribute( "label", text );

				selectObj.appendChild( optionElement );
			}
		}
	}
}

/**
 * 가독성을 위해 byte 단위의 사이즈를 KB 나 MB 로 출력
 */
function calculateFileSize( fileSize ) {
	// 사이즈가 1메가 초과일 경우
	if( fileSize > 1048576 )
		fileSize = Math.floor( ( ( fileSize / 1024 ) / 1024  ) * 100 ) / 100 + "MB";
	else if( fileSize > 1024 )
		fileSize = Math.floor( ( fileSize / 1024 ) * 100 ) / 100 + "KB";
	else
		fileSize += "Byte";
	return fileSize;
}

/**
 * 이미지 파일이나 음악 파일에 대한 preview 기능을 제공
 */
function preview() {
	var selectObj = fileListAreaID;

	var file;
	if( selectObj.selectedIndex != -1 ) {
		var fileId = selectObj.options[selectObj.selectedIndex].value;
		var splitValue = fileId.split('//');
		// 업로드가 완료되었을때만 프리뷰 사용가능
		if( fileList[splitValue[4]].status == -4 ) {
			file = fileList[splitValue[4]];
			fileView(file);
		}
	}
}

function previewUpload() {
	var selectObj = fileListAreaID;

	if( selectObj.length > 0 ) {
		var fileId = selectObj.options[selectObj.length-1].value;
		var splitValue = fileId.split('//');

		try {
			// 업로드가 완료되었을때만 프리뷰 사용가능
			if( fileList[splitValue[4]].status == -4 ) {
				file = fileList[splitValue[4]];	// 에러!@
				fileView(file);
			}
		} catch (e) {
			// TODO: handle exception
		}
	}
}

/**
 * 파일 미리보기
 */
function fileView(file) {
	var previewObj = previewAreaID;
	var defaultMessage = '<img width="88" height="78" src="" />';

	// 프리뷰 시킬 데이터가 있다면 확장자를 검사한다.
	if( file ) {
		var previewPath = defaultPath+file.path+encodeURI(file.saveFileName);

		//console.log(previewPath);
		// 이미지 파일 처리
		if( file.ext.toLowerCase() == ".jpg" ||
			file.ext.toLowerCase() == ".jpeg" ||
			file.ext.toLowerCase() == ".bmp" ||
			file.ext.toLowerCase() == ".gif" ||
			file.ext.toLowerCase() == ".png" ) {

			previewObj.innerHTML = '<img src="'+previewPath+'"width="'+previewObj.offsetWidth+'"height="'+previewObj.offsetHeight+'"/>';
		/*} else
		if( file.type.toLowerCase() == "audio/mp3" || // 음악 파일 처리
			file.type.toLowerCase() == "audio/wma" ) {
			console.log(1);
			previewObj.innerHTML  = '<span><embed style="filter:gray alpha(opacity=100,finishopacity=0,style=2);width:88px;height:28px;" src="'+previewPath+'" type="application/x-mplayer2" autostart="false" autoplay="false" invokeurls="false" allowscriptaccess="never" allownetworking="internal" loop="true" showpositioncontrols="false" enablecontextmenu="false"></embed></span>';*/
		} else {
			// 이미지나 음악에 속하지 않는 파일에 대한 처리
			previewObj.innerHTML  = defaultMessage;
		}
	} else {
		// 이미지나 음악에 속하지 않는 파일에 대한 처리
		previewObj.innerHTML  = defaultMessage;
	}
}

/**
 * 파일 삭제 처리(select 리스트에서만)
 * ( ajax 를 통하여 실제 파일을 삭제)
 */
function deleteFiles(manage_idx, board_idx, mode) {
	var selectObj = fileListAreaID;
	if ( !confirm('파일 삭제시 복구가 불가능 합니다. 정말 삭제 하시겠습니까?') ) {
		return false;
	}
	if( selectObj.selectedIndex < 0 ) {
		alert("삭제할 파일을 선택하여 주십시오.");
		return false;
	}
	if( selectObj.selectedIndex != -1 ) {
		for(var i=0;i<selectObj.length;i++) {
			if(selectObj.options[i].selected==true) {
				var splitValue = selectObj.options[i].value.split('//');
				//if (splitValue[5] == 'new') {
					var pars = 'server_file_name='+splitValue[1]+'&file_list_seq='+splitValue[4]+'&mode='+mode+'&board_idx='+board_idx+'&manage_idx='+manage_idx;

					$.ajax({
				        type: "POST",
				        url: '/board/boardFile/deleteFile.do',
				        dataType : 'json',
				        data: pars,
				        success: function(response){
				            if(response.valid) {
				            	var fileListSeq = response.data;

				            	fileList[parseInt(fileListSeq)].status = -5; // 취소 처리
				            	var splitValue = fileList[parseInt(fileListSeq)].makeValue.split('//');
				            	var previewObj = previewAreaID;
				            	previewObj.innerHTML = '미리보기';
				            	if(splitValue[0] == $('preview_img').value) {
				            		$('preview_img_layer').innerHTML = '';
				            		$('preview_img').value = '';
				            	}
				            	showFileList();
				            } else {
				            	alert('에러');
				            }
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					});
				/*} else {
					var splitValue = selectObj.options[i].value.split('//');
					fileList[parseInt(splitValue[4])].status = -5; // 취소 처리
				}*/
			}
		}
	}
	showFileList();
}

function pasteHTML(contentId) {
	var sHTML = '';
	var selectObj = fileListAreaID;
	if( selectObj.selectedIndex < 0 ) {
		alert("에디터에 삽입할 이미지 파일를 선택하여 주십시오.");
		return false;
	}

	for(var i = 0; i < selectObj.selectedOptions.length; i++) {
		
		if( selectObj.selectedIndex != -1 ) {
			var fileId = selectObj.options[selectObj.selectedOptions[i].index].value;
			var splitValue = fileId.split('//');
			// 업로드가 완료되었을때만 프리뷰 사용가능
			if( fileList[splitValue[4]].status == -4 ) {
				file = fileList[splitValue[4]];
			}
		}
		if( file ) {
			var previewPath = defaultPath+file.path+encodeURI(file.saveFileName);
			// 이미지 파일 처리
			if( file.ext.toLowerCase() == ".jpg" ||
				file.ext.toLowerCase() == ".bmp" ||
				file.ext.toLowerCase() == ".gif" ||
				file.ext.toLowerCase() == ".png" ) {
				sHTML = '<img src="'+previewPath+'" width="730px" />';
			} else	if( file.type.toLowerCase() == ".mp3" || // 음악 파일 처리
				file.ext.toLowerCase() == ".wma" ) {
				alert('이미지 형태의 파일만 에디터에 넣을 수 있습니다.');
				//sHTML = "<span style='color:#FF0000'>이미지 등도 이렇게 삽입하면 됩니다.</span>";
			} else {
				alert('이미지 형태의 파일만 에디터에 넣을 수 있습니다.');
				// 이미지나 음악에 속하지 않는 파일에 대한 처리
				//previewObj.innerHTML  = defaultMessage;
			}
			oEditors.getById[contentId].exec("PASTE_HTML", [sHTML]);
		} else {
			// 이미지나 음악에 속하지 않는 파일에 대한 처리
			//previewObj.innerHTML  = defaultMessage;
		}
	
	}
}

function deleteFolder(manager_seq,mode,board_seq) {
	var url = 'folderDelete.do';
	var pars = 'manager_seq='+manager_seq+'&mode='+mode+'&boardSeq='+board_seq;
	var myAjax = new Ajax.Request(
		url,
		{
			method: 'post',
			parameters: pars,
			asynchronous:false
		}
	);
}

function showResponse(originalRequest) {
	var json = originalRequest.responseText.evalJSON();
	var complete =  json[ 'complete' ];
	var error =  json[ 'error' ];
	var fileListSeq = json[ 'fileListSeq' ];
	if(complete=='Y') {
		fileList[parseInt(fileListSeq)].status = -5; // 취소 처리
		var splitValue = fileList[parseInt(fileListSeq)].makeValue.split('//');
		if(splitValue[0] == $('preview_img').value) {
			$('preview_img_layer').innerHTML = '';
			$('preview_img').value = '';
		}
	} else {
		alert(error);
	}
}

function getFileList() {
	var selectObj = fileListAreaID;
	var fileListValue = '';

	if( selectObj.selectedIndex != -1 ) {
		for(var i=0;i<selectObj.length;i++) {
			fileListValue = selectObj.options[i].value;
			var splitValue = selectValue.split('//');
			FileListValue += splitValue[0]+",";
		}
	}

	return fileListValue;
}