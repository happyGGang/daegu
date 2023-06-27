
var materialListPage = 1;
var ajaxLoading = false;
$(document).ready(function(){
		var data = {};
		data.pageIndex = 1;
		var filter = "win16|win32|win64|mac";
		if( navigator.platform  ){
			if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
				// mobile접속
				data.recordCountPerPage= 2;
			}else{
				// pc접속
				data.recordCountPerPage= 4;
			}
		}
		
		data.searchType = 'Tags';
		data.searchKeyword = '경상북도교육청 군위도서관';
		data.orderType = 2;
		data.searchOrder = 'D';
/*
		var data 
		= 
		'pageIndex=1
		&recordCountPerPage=10
		&orderType=2
		&searchOrder=D
		&searchType=Tags
		&searchKeyword=%EA%B2%BD%EC%83%81%EB%B6%81%EB%8F%84%EA%B5%90%EC%9C%A1%EC%B2%AD%EC%A0%95%EB%B3%B4%EC%84%BC%ED%84%B0';
*/
		searchDgitalQ(data);
	},
	searchDgitalQ = function(data){
		$.ajax({
			url: '//q.gbelib.kr/curation/api/boardList.json',
			data : data,
			dataType: 'jsonp',
			type: 'GET',
			jsonpCallback : 'jsonp_callback',
			success: function(response) {

				var pcPlatform = true;
				var filter = "win16|win32|win64|mac";
				if( navigator.platform  ){
					if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
						// mobile접속
						pcPlatform=false;
					}
				}

				var rows = response.rows;
				if(data.pageIndex>1 && rows.length==0){
					data.pageIndex =1;
					searchDgitalQ(data);
					return false;
				}
				html  = '<div class="title">';
				html += '<h3>L-큐레이션 <a href="http://q.gbelib.kr/index.jsp?gid=21" target="_blank" class="more-curation">더보기 +</a></h3>';
				html += '</div>';
				html +='<div class="list">';
				html +='<div class="bx-controls bx-has-controls-direction"><div class="bx-controls-direction"><a class="bx-prev" id="bxprev" href="javascript:void(0);">Prev</a><a class="bx-next" id="bxnext" href="javascript:void(0);">Next</a></div></div>';
				html +='<ul>';
				for(var i=0; i< rows.length; i++){
					if(pcPlatform){
						if(rows.length>4) break;
					}else{
						if(rows.length>2) break;
					}
					obj = rows[i];
					html += '<li>';
					html +=   '<a href="'+obj.url+'" target="_blank" data-namose-orgahref="'+obj.url+'">';
					html +=     '<div class="img-box">';
					html +=       '<img src="'+obj.thumbnail_path+'" alt="'+obj.title+'" />';
					html +=     '</div>';
					html +=     '<div class="txt-box">';
					html +=     '<h3>' + obj.title + '</h3>';
					html +=     '<p>'+obj.cur_desc+'</p>';
					var ddt = obj.dist_dt;
					if(obj.dist_dt != undefined && obj.dist_dt != null && obj.dist_dt != '' && obj.dist_dt.length > 10){
						ddt = ddt.substr(0, 10);
					}
					html +=     '<span>'+ddt+'</span>';
					html +=     '</div>';

					html +=    '</a>';
					html += '</li>';
/*
					if(pcPlatform){
						if(i==3 || (rows.length<4&&(rows.length-1)==i)){
							html +=       '<div class="bx-controls bx-has-controls-direction"><div style="width:100px;" class="bx-controls-direction"><a class="bx-prev" id="bxprev" href="javascript:void(0);">Prev</a><a class="bx-next" id="bxnext" href="javascript:void(0);">Next</a><a style="position:absolute;right:0px;" href="http://q.gbelib.kr/index.jsp?gid=4" target="_blank"><img src="/resources/common/img/board_more_btn.png" alt="더보기" /></a></div></div>';
						}
					}else{
						if(i==1 || (rows.length<2&&(rows.length-1)==i)){
							html +=       '<div class="bx-controls bx-has-controls-direction"><div style="width:100px;" class="bx-controls-direction"><a class="bx-prev" id="bxprev" href="javascript:void(0);">Prev</a><a class="bx-next" id="bxnext" href="javascript:void(0);">Next</a><a style="position:absolute;right:0px;" href="http://q.gbelib.kr/index.jsp?gid=4" target="_blank"><img src="/resources/common/img/board_more_btn.png" alt="더보기" /></a></div></div>';
						}
					}
*/
				}
				html += '</ul>';
				html += '</div>';

				$('#result').html(html);

				var prev = $('#bxprev');
				if(prev!=undefined){
					prev.click(function(){
						if(data.pageIndex >1){
							data.pageIndex=data.pageIndex-1
						}
						searchDgitalQ(data);
					});
				}
				var next = $('#bxnext');
				if(next!=undefined){
					next.click(function(){
						data.pageIndex=data.pageIndex+1
						searchDgitalQ(data);
					});
				}
			},
			error:function(request,status,error){
				console.log(request);
				console.log(status);
				console.log(error);
			}
		});
	}
);
