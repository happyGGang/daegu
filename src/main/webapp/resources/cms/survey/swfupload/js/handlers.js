/* **********************
   Event Handlers
   These are my custom event handlers to make my
   web application behave the way I went when SWFUpload
   completes different tasks.  These aren't part of the SWFUpload
   package.  They are part of my application.  Without these none
   of the actions SWFUpload makes will show up in my application.
   ********************** */
var fileNum = 0;
var updateNum = 0;
var fileListAreaID;		//select 박스 id
var previewAreaID;		//미리보기 ID
var fileSizeViewID;		//파일사이즈 ID
var defaultPath;			//기본 경로
var totalFileSize;		//파일 총 크기
var singleFileSize;		//파일당 크기
var fileCount;			//파일 허용갯수
var fileList = new Array(); // 파일 목록 저장 배열 추가

function fileQueued(file) {
	file.status = -1;
	updateNum++;
	fileList.push( file );
	
	showFileList();
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setFileName(file.name);
		progress.setStatus("로딩중...");
		progress.toggleCancel(false, this);
	} catch (ex) {
		this.debug(ex);
	}

}

function fileQueueError(file, errorCode, message) {
	if(fileNum > 0) {
		fileNum++;
	}
	file.status = -3;
	fileList.push( file );
	changeFileStatus( file );
	try {
		if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
			alert('파일은 '+message+'개 까지만 업로드 가능합니다.');
			return;
		}
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		progress.toggleCancel(false);

		// 에러 발생시 메시지 출력 후 1초 후 사라짐
		setTimeout( function () {
			 progress.disappear();
		}, 1000 );
		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			progress.setStatus(settings.file_size_limit + ' 이상의 파일은 업로드 하실 수 없습니다.');
			this.debug("Error Code: File too big, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			alert( settings.file_size_limit + ' 이상의 파일은 업로드 하실 수 없습니다.');
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			file.status = -3;
			progress.setStatus("0Byte 파일은 업로드 하실 수 없습니다.");
			this.debug("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			alert('0Byte 파일은 업로드 하실 수 없습니다.');
			break;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			file.status = -3;
			progress.setStatus("Invalid File Type.");
			this.debug("Error Code: Invalid File Type, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			alert( file.name + ' 는(은) 업로드 하실 수 없는 파일입니다.');
			break;
		default:
			if (file !== null) {
				progress.setStatus("Unhandled Error");
			}
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (numFilesSelected > 0) {
			//$(this.customSettings.cancelButtonId).disabled = false;   // 업로드 중 취소 버튼 활성화 유무
			showProgressBarLayer();	// 상태바 보여주기 함수
		}

		/* I want auto start the upload and I can do that here */
		//this.startUpload(); //업로드 시작 함수를 셀렉트 박스 줄인 다음 실행하도록 즉 showProgressBarLayer 으로 이동
	} catch (ex)  {
        this.debug(ex);
	}
}

function uploadStart(file) {
	try {
		// 파일을 업로드 상태로 변경하고 기존 배열에서 해당 파일을 찾아 상태 변경
		file.status = -2;
		changeFileStatus( file );
		showFileList();

		this.checkSpeed = 0; // 업로드 속도 저장 변수
		this.checkTime = 0;
		this.checkByte = 0;
		this.checkCount = 0;

		/* I don't want to do any file validation or anything,  I'll just update the UI and
		return true to indicate that the upload should start.
		It's important to update the UI here because in Linux no uploadProgress events are called. The best
		we can do is say we are uploading.
		 */
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setFileName(file.name);
		progress.setStatus("업로드중...");
		progress.toggleCancel(false, this);
	}
	catch (ex) {}
	return true;
}

function uploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
		var status = percent + "% - (" + calculateFileSize(bytesLoaded) + "/" + calculateFileSize(bytesTotal) + ")";

		// 속도 체크 ( 3번 갱신 될 때의 평균을 냄 )
		if( this.checkCount == 0 ) {
			this.checkTime = new Date().getTime();
			this.checkByte = bytesLoaded;
			this.checkCount++;
		} else {
			if( this.checkCount == 3 ) {
				this.checkSpeed = ( bytesLoaded - this.checkByte ) * ( 1 / ( ( new Date().getTime() - this.checkTime ) / 1000 ) );
				this.checkTime = null;
				this.checkByte = 0;
				this.checkCount = 0;
			} else {
				this.checkCount++;
			}
		}

		if( this.checkSpeed > 0 ) {
			status += " - " + calculateFileSize( this.checkSpeed ) + "/s";
		}

		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setProgress(percent);
		progress.setStatus( status );
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadSuccess(file, serverData) {
	/*
		기본적인 file 객체의 내용

		name= msxml6.msi
		status= -4
		id= SWFUpload_0_0
		index= 0
		modificationdate= Fri Jul 18 13:59:18 UTC+0900 2008
		size= 1528320
		type= .msi
		creationdate= Fri Jul 18 13:59:18 UTC+0900 2008
		post= [object Object]
		makeValue = 실제 select option value로 들어갈 값 (// 로 값이 구분된다.)
		path = 파일의 실제 경로

		아래 부분에서는 해당 file 객체에 saveFileName( 서버에 저장된 파일명 ),
	*/
	var progressMessage = '';
	
	var json = $.parseJSON(serverData);
	
	var realFileName = json.file_nm;
	var fileName = json.file_real_nm;
	var filePath = json.file_url;
	var valid = json.valid;
	var msg = json.msg;
	
	// 실제 서버에 저장되는 파일명을 저장한다.
	file.saveFileName = realFileName;
	file.path = filePath;
	
	// 파일 상태값 입력 : -4(완료)
	if(fileNum > 0) {	// fileNum 이 0보다 크다면 수정모드에서 값이 변경되었으므로 file.index 값을 수정한다.
		file.index = fileNum++;
	}
	if(valid) {
		file.status = -4;
		file.makeValue = file.name+'//'+file.saveFileName+'//'+file.size+'//'+file.type+'//'+file.index;
		progressMessage = '완료';
	} else {
		//var error = json[ 'error' ];
		var error = msg;
		alert(error);
		file.status = -3;
		progressMessage = error;
	}
	changeFileStatus( file );

	//showFileList(this.customSettings.fileListObjId);
	showFileList();

	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setComplete();
		progress.setStatus(progressMessage);
		progress.toggleCancel(false);

	} catch (ex) {
		this.debug(ex);
	}
}

function uploadError(file, errorCode, message) {
	if(fileNum > 0) {
		fileNum++;
	}
	file.status = -3;
	changeFileStatus( file );
	showFileList();
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		progress.toggleCancel(false);

		// 에러 발생시 메시지 출력 후 1초 후 사라짐
		setTimeout( function () {
			 progress.disappear();
		}, 1000 );

		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
			alert('내부 에러가 발생하여 파일을 업로드 할수 없습니다.');
			progress.setStatus("에러: " + message);
			this.debug("Error Code: HTTP Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
			progress.setStatus("Upload Failed.");
			this.debug("Error Code: Upload Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.IO_ERROR:
			progress.setStatus("Server (IO) Error");
			this.debug("Error Code: IO Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
			progress.setStatus("Security Error");
			this.debug("Error Code: Security Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			progress.setStatus("Upload limit exceeded.");
			this.debug("Error Code: Upload Limit Exceeded, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
			progress.setStatus("Failed Validation.  Upload skipped.");
			this.debug("Error Code: File Validation Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			// If there aren't any files left (they were all cancelled) disable the cancel button
			if (this.getStats().files_queued === 0) {
				//$(this.customSettings.cancelButtonId).disabled = true;	// 업로드 중 취소 버튼 활성화 유무
			}
			progress.setStatus("취소");
			progress.setCancelled();
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			progress.setStatus("정지");
			break;
		default:
			progress.setStatus("Unhandled Error: " + errorCode);
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}

function uploadComplete(file) {
	// 파일 큐가 비워진다면( 모두 완료되면 )
	if (this.getStats().files_queued === 0) {
		//$(this.customSettings.cancelButtonId).disabled = true;	// 업로드 중 취소 버튼 활성화 유무

		var progress = new FileProgress(file, this.customSettings.progressTarget);
		//previewUpload();

		// 에러 발생시 메시지 출력 후 1초 후 사라짐
		setTimeout( function () {
			 progress.disappear();
		}, 1000 );
	}
}

// This event comes from the Queue Plugin
function queueComplete(numFilesUploaded) {
	var status = $("divStatus");
	status.innerHTML = numFilesUploaded + " file" + (numFilesUploaded === 1 ? "" : "s") + " uploaded.";
}

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
				totalSize += parseInt(fileList[i].size);
			}

			if( text ) {
				var optionElement = document.createElement("OPTION");

				var textNode = document.createTextNode( text );

				optionElement.appendChild( textNode );
				var tempMakeValue = fileList[i].makeValue.replace(/,/g,';;');
				
				optionElement.setAttribute( "value", tempMakeValue );      // fileSize , 실제파일명 , 확장자명 으로 후에 변경 ( 확장자명 통일 jpeg -> jpg )
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
				
				var tempMakeValue = fileList[i].makeValue.replace(/,/g,';;');
				
				optionElement.appendChild( textNode );
				
				optionElement.setAttribute( "value", tempMakeValue );      // fileSize , 실제파일명 , 확장자명 으로 후에 변경 ( 확장자명 통일 jpeg -> jpg )
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
	/*var selectObj = fileListAreaID;

	var file;
	if( selectObj.selectedIndex != -1 ) {
		var fileId = selectObj.options[selectObj.selectedIndex].value;
		var splitValue = fileId.split('//');
		// 업로드가 완료되었을때만 프리뷰 사용가능
		if( fileList[splitValue[4]].status == -4 ) {
			file = fileList[splitValue[4]];
			fileView(file);
		}
	}*/
}

function previewUpload() {
	var selectObj = fileListAreaID;
	
	if( selectObj.length > 0 ) {
		var fileId = selectObj.options[selectObj.length-1].value;
		var splitValue = fileId.split('//');
		
		// 업로드가 완료되었을때만 프리뷰 사용가능
		if( fileList[splitValue[4]].status == -4 ) {
			file = fileList[splitValue[4]];	// 에러!@
			fileView(file);
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
		// 이미지 파일 처리
		if( file.type.toLowerCase() == ".jpg" ||
			file.type.toLowerCase() == ".bmp" ||
			file.type.toLowerCase() == ".gif" ||
			file.type.toLowerCase() == ".png" ) {

			previewObj.innerHTML = '<img src="'+previewPath+'"width="'+previewObj.offsetWidth+'"height="'+previewObj.offsetHeight+'"/>';
		} else
		if( file.type.toLowerCase() == ".mp3" || // 음악 파일 처리
			file.type.toLowerCase() == ".wma" ) {
			previewObj.innerHTML  = '<span><embed style="filter:gray alpha(opacity=100,finishopacity=0,style=2);width:88px;height:28px;" src="'+previewPath+'" type="application/x-mplayer2" autostart="false" autoplay="false" invokeurls="false" allowscriptaccess="never" allownetworking="internal" loop="true" showpositioncontrols="false" enablecontextmenu="false"></embed></span>';
		} else {
			// 이미지나 음악에 속하지 않는 파일에 대한 처리
			previewObj.innerHTML  = defaultMessage;
		}
	} else {
		// 이미지나 음악에 속하지 않는 파일에 대한 처리
		previewObj.innerHTML  = defaultMessage;
	}
}

function showProgressBarLayer() {
	var selectObj = fileListAreaID;

	// 셀렉트 박스 크기를 줄이고
	var height = selectObj.offsetHeight;

	if( height > 100 ) {
		selectObj.style.height = height - 5;
		setTimeout("showProgressBarLayer()", 5);
	} else {
		swfu.startUpload(); // 업로드 시작
	}

}

function hideProgressBarLayer() {
	var selectObj = fileListAreaID;

	// 셀렉트 박스 크기를 틀이고
	var height = selectObj.offsetHeight;

	if( height < 130 ) {
		selectObj.style.height = height + 5;
		setTimeout("hideProgressBarLayer()", 5);
	}
}

/**
 * 파일 삭제 처리(select 리스트에서만)
 * ( ajax 를 통하여 실제 파일을 삭제)
 */
function deleteFiles(board_idx, mode) {
	var selectObj = fileListAreaID;

	if( selectObj.selectedIndex < 0 ) {
		alert("삭제할 파일을 선택하여 주십시오.");
		return false;
	}
	if(mode == 'add') {
		if( selectObj.selectedIndex != -1 ) {
			for(var i=0;i<selectObj.length;i++) {
				if(selectObj.options[i].selected==true) {
					var splitValue = selectObj.options[i].value.split('//');
					var pars = 'fileName='+splitValue[1]+'&fileListSeq='+splitValue[4]+'&fileSize='+splitValue[2]+'&mode='+mode;
					
					$.ajax({
				        type: "POST",
				        url: '/board/boardFile/delete.ws',
				        data: pars,
				        success: function(response){
				            if(response.valid) {
				            	var fileListSeq = response.data;
				            	
				            	fileList[parseInt(fileListSeq)].status = -5; // 취소 처리
				            	var splitValue = fileList[parseInt(fileListSeq)].makeValue.split('//');
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
				}
			}
		}
	} else {
		if( selectObj.selectedIndex != -1 ) {
			for(var i=0;i<selectObj.length;i++) {
				if(selectObj.options[i].selected==true) {
					var splitValue = selectObj.options[i].value.split('//');
					fileList[parseInt(splitValue[4])].status = -5; // 취소 처리
				}
			}
		}

	}
	showFileList();
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

function pasteHTML(contentId) {
	var sHTML = '';
	var selectObj = fileListAreaID;
	if( selectObj.selectedIndex < 0 ) {
		alert("에디터에 삽입할 이미지 파일를 선택하여 주십시오.");
		return false;
	}

	if( selectObj.selectedIndex != -1 ) {
		var fileId = selectObj.options[selectObj.selectedIndex].value;
		var splitValue = fileId.split('//');
		// 업로드가 완료되었을때만 프리뷰 사용가능
		if( fileList[splitValue[4]].status == -4 ) {
			file = fileList[splitValue[4]];
		}
	}
	if( file ) {
		var previewPath = defaultPath+file.path+encodeURI(file.saveFileName);
		// 이미지 파일 처리
		if( file.type.toLowerCase() == ".jpg" ||
			file.type.toLowerCase() == ".bmp" ||
			file.type.toLowerCase() == ".gif" ||
			file.type.toLowerCase() == ".png" ) {
			sHTML = '<img src="'+previewPath+'" width="540px" />';
		} else	if( file.type.toLowerCase() == ".mp3" || // 음악 파일 처리
			file.type.toLowerCase() == ".wma" ) {
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

function setPreviewImg() {
	var selectObj = fileListAreaID;

	if( selectObj.selectedIndex != -1 ) {
		for(var i=0;i<selectObj.length;i++) {
			if(selectObj.options[i].selected==true) {
				var selectValue = selectObj.options[i].value;
				var splitValue = selectValue.split('//');
				if( splitValue[3].toLowerCase() == ".jpg" || splitValue[3].toLowerCase() == ".bmp" || splitValue[3].toLowerCase() == ".gif" || splitValue[3].toLowerCase() == ".png" ) {
					$('preview_img_layer').innerHTML = splitValue[1];
					$('preview_img').value = splitValue[0];
					$('preview_img_name').value = splitValue[1];
				}
			}
		}
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