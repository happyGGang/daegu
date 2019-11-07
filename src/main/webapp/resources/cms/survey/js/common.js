$(document).ready(function() {
	/*
	$('.date-picker').datepicker({
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true
	});
	*/
});

function serializeObject(form) {
	var o = {};
	var a = form.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

function serializeCustom(form) {
	var a = form.serialize();
	return a.replace(/(\w*=&)|(&\w*=$)/g,'');
}

function serializeParameter(inputNames) {
	var param = '';
	
	for(var i=0;i<inputNames.length; i++) {
		var inputNameValue = $('input#'+inputNames[i]).val();
		var selectNameValue = $('select#'+inputNames[i]).val();
		
		
		if(inputNameValue != '' && inputNameValue != undefined) {
			if(param != '') {
				param += '&';
			}
			param += inputNames[i] + '=' + inputNameValue;
		} 
		
		if(selectNameValue != '' && selectNameValue != undefined) {
			if(param != '') {
				param += '&';
			}
			param += inputNames[i] + '=' + selectNameValue;
		} 
	}
	
	return param;
	
}

function doAjaxPost(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var formData = serializeObject(form);

	$.ajax({
		type : 'POST',
		dataType : 'json',
		url : form.attr('action'),
		async : false,
		data : formData,
		success : function(response) {
			if (response.valid) {
				if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
					alert(response.message);
				}
				if (response.targetOpener == true) {
					if(response.data != null && response.data.replace(/\s/g,'').length!=0) {
						$(opener.location).attr('href', response.url+'?'+response.data);
						window.close();
					}
				}
				if (response.url != null && response.url.replace(/\s/g, '').length != 0) {
					/**
					 * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
					 */
					if (ajaxBody != null && ajaxBody.replace(/\s/g, '').length != 0) {
						doAjaxLoad(ajaxBody, response.url, response.data);
					} else {
						doGetLoad(response.url, response.data);
					}
				}
				if (response.closeFlag == true) {
					window.close();
				}
			} else {
				if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
					alert(response.message);
				} else {
					for (var i = 0; i < response.result.length; i++) {
						alert(response.result[i].code);
						$('#' + response.result[i].field).focus();
						break;
					}
				}
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		}
	});
}

function doAjaxPost(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var formData = serializeObject(form);
	var returnObj;
	$.ajax({
		type : 'POST',
		dataType : 'json',
		url : form.attr('action'),
		async : false,
		data : formData,
		success : function(response) {
			response = eval(response);
			if (response.valid) {
				returnObj = response.data;
				if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
					alert(response.message);
				}
				if (response.targetOpener == true) {
					if(response.data != null && response.data.replace(/\s/g,'').length!=0) {
						$(opener.location).attr('href', response.url+'?'+response.data);
						window.close();
					}
				}
				if (response.url != null && response.url.replace(/\s/g, '').length != 0) {
					/**
					 * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
					 */
					if (ajaxBody != null && ajaxBody.replace(/\s/g, '').length != 0) {
						doAjaxLoad(ajaxBody, response.url, response.data);
					} else {
						doGetLoad(response.url, response.data);
					}
				}
				if (response.closeFlag == true) {
					window.close();
				}
			} else {
				if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
					alert(response.message);
				} else {
					for (var i = 0; i < response.result.length; i++) {
						alert(response.result[i].code);
						$('#' + response.result[i].field).focus();
						break;
					}
				}
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		}
	});
	return returnObj;
}

function doAjaxMobilePost(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var formData = serializeObject(form);
	
	$.ajax({
		type : "POST",
		dataType : 'json',
		url : form.attr('action'),
		async : false,
		data : formData,
		success : function(response) {
			if (response.valid) {
				if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
					alert(response.message);
				}
				if (response.url != null && response.url.replace(/\s/g, '').length != 0) {
					$.mobile.changePage(response.url, {
						transition : 'pop',
						reverse: false,
						changeHash: false,
						data: resopnse.data
					});
				}
			} else {
				if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
					alert(response.message);
				} else {
					for (var i = 0; i < response.result.length; i++) {
						alert(response.result[i].code);
						$('#' + response.result[i].field).focus();
						break;
					}
				}
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		}
	});
}

function doAjaxOption(url, formData, ajaxType) {
    $.ajax({
        type: ajaxType,
        dataType : 'json',
        url: url,
        async: false,
        data: formData,
        success: function(response) {
            if(response.valid) {
                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
                	 alert(response.message);
                 }
                 if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
                	 /**
                	  * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
                	  */
                	 if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
                		 doAjaxLoad(ajaxBody, response.url);
                		 
                	 } else {
                		 doGetLoad(response.url, response.data);
                	 }
                 }
			} else {
                for(var i =0 ; i < response.result.length ; i++) {
					alert(response.result[i].code);
					$('#'+response.result[i].field).focus();
					break;
				}
			}
         },
         error: function(jqXHR, textStatus, errorThrown) {
             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
         }
    });
}

function doGetLoad(url, param) {
	var fullUrl = url;
	if(param != null && param.replace(/\s/g,'').length!=0) {
		fullUrl = fullUrl+'?'+param;
	}
	
	$(location).attr('href', fullUrl);
}

function doAjaxLoad(ajaxBody, url, param) {
	var fullUrl = url;
	if(param != null && param.replace(/\s/g,'').length!=0) {
		fullUrl = fullUrl+'?'+param;
	}
	
	$(ajaxBody).load(fullUrl);
}

/**
 * malsup.js 를 이용한 Ajax 파일 업로드용 function
 * @param form
 * @param ajaxBody
 * @returns response
 */
function doAjaxPostFileUpload(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var option = {
			type: "POST",
			dataType : 'json',
			url: form.attr('action'),
			async: false,
			data: form.serialize(),
			success: function(response) {
				if (response.valid) {
					if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
						alert(response.message);
					}
					if (response.targetOpener == true) {
						if(response.data != null && response.data.replace(/\s/g,'').length!=0) {
							$(opener.location).attr('href', response.url+'?'+response.data);
							window.close();
						}
					}
					if (response.url != null && response.url.replace(/\s/g, '').length != 0) {
						/**
						 * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
						 */
						if (ajaxBody != null && ajaxBody.replace(/\s/g, '').length != 0) {
							doAjaxLoad(ajaxBody, response.url, response.data);
						} else {
							doGetLoad(response.url, response.data);
						}
					}
					if (response.closeFlag == true) {
						window.close();
					}
				} else {
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
					} else {
						if (response.result != null) {
							for(var i =0 ; i < response.result.length ; i++) {
								alert(response.result[i].code);
								$('#'+response.result[i].field).focus();
								break;
							}
						}
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				return false;
			}
	};
	form.ajaxSubmit(option);
}

/**
 * malsup.js 를 이용한 Ajax 파일 업로드용 function
 * @param form
 * @param ajaxBody
 * @returns response
 */
function doAjaxPostMalsup(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var responseData; //리턴될 response 
	var option = {
			type: "POST",
			dataType : 'json',
	        url: form.attr('action'),
	        async: false,
	        data: form.serialize(),
			success: function(response) {
				responseData = response;
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				return false;
			}
	};
	form.ajaxSubmit(option);
	return responseData;
}

/**
 * doAjaxPostMalsup() 이후 결과에 대해 alert, location 등을 처리하기 위한 function
 * @param response doAjaxPostMalsup()의 리턴값
 * @param ajaxBody load될 영역
 */
function doAjaxPostMalsupAfter(response, ajaxBody) {
	if(response.valid) {
    	responseData = response.data;
    	if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
        	 alert(response.message);
         }
         if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
        	 /**
        	  * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
        	  */
        	 if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
        		 doAjaxLoad(ajaxBody, response.url, response.data);
        	 } else {
        		 doGetLoad(response.url, response.data);
        	 }
         }
	} else {
		if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
			alert(response.message);
		} else {
			if (response.result != null) {
				for(var i =0 ; i < response.result.length ; i++) {
					alert(response.result[i].code);
					$('#'+response.result[i].field).focus();
					break;
				}
			}
		}
	}
}

/**
 * 로그인상태 세션값 유지상태
 * @returns {Boolean}false = 세션만료
 */
function loginSessionCheck() {
	var flag = false;
	$.ajax({
		url: '/loginSessionCheck.do',
		type: 'post',
		async: false,
		success: function(response) {
			if (response == true) {
				flag = true;
			} else {
				alert('세션이 만료되었습니다.');
				flag = false;
			}
		},
		error: function(jqXHR, testStatus, errorThrown) {
			alert('연결 오류가 발생하였습니다.');
			flag = false;
		}
	});
	return flag;
}

/**
 * 우편번호
 */
function searchZipcode(addr, zipcode, target) {
		var parent = $('#'+target).parent('div.item');
		parent.children('input').eq(0).val(zipcode);
		addr = addr.trim();
		addr = addr.replace(/\s\s/g,' ');
		$('#'+target).val(addr);
		$('#'+target+'_1').focus();
}
 



function doAjaxPostMalsup2(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var responseData; //리턴될 response 
	var option = {
			type: "POST",
			dataType : 'json',
	        url: form.attr('action'),
	        async: false,
	        data: form.serialize(),
			success: function(response) {
				if(response.valid) {
			    	responseData = response.data;
			    	if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
			        	 alert(response.message);
			         }
			         if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
			        	 /**
			        	  * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
			        	  */
			        	 if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
			        		 doAjaxLoad(ajaxBody, response.url, response.data);
			        	 } else {
			        		 doGetLoad(response.url, response.data);
			        	 }
			         }
				} else {
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
					} else {
						if (response.result != null) {
							for(var i =0 ; i < response.result.length ; i++) {
								alert(response.result[i].code);
								$('#'+response.result[i].field).focus();
								break;
							}
						}
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				return false;
			}
	};
	form.ajaxSubmit(option);
	return responseData;
}