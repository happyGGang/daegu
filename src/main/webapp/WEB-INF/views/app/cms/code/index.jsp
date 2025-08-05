<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${getContextPath}/resources/cms/jqTree/css/jqtree.css">
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
var current_node = '';
$(document).ready(function() {
	var beforeSelected_node = '';
	function treeOnLoad(homepage_id) {
		$.ajax({
			url : 'getCodeGroupTreeList.do?homepage_id='+homepage_id,
			async : true ,
			success : function(data) {
				data = eval(data);
				var source = [];
		        var items = [];
		        // build hierarchical source.
		        for (var i = 0; i < data.length; i++) {
		            var code = data[i];
		            var parent_group_id = code['parent_group_id'];
		            var id = code['group_id'];
		            var title = code['group_name'];

		            if (items[parent_group_id]) {
		                var item =
		                {
		                	id: id,
		                    label: title
		                };

		                if (!items[parent_group_id].children) {
		                    items[parent_group_id].children = [];
		                }

		                items[parent_group_id].children[items[parent_group_id].children.length] = item;
		                items[id] = item;
		            } else {
		                items[id] =
		                {
		                	id: id,
		                    label: title
		                };

		                source[0] = items[id];
		            }
		        }
				
				var $tree = $('#tree1').unbind().tree({
					data : source , 
					autoOpen: true,
					dragAndDrop: true,
					onCreateLi: function(node, $li) {
						// Append a link to the jqtree-element div.
						// The link has an url '#node-[id]' and a data property 'node-id'.
						if(node.id != 0) {
							var menuTreeHTML = ''; 
							/* menuTreeHTML += '<a href="#node-'+node.id+'" class="menu_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  padding-left:5px; "><img width="42" height="13" src="/resources/cms/jqTree/img/btn_menuEdit.png" alt="메뉴수정하기" /></a>';
							menuTreeHTML += '<a href="#node-'+node.id+'" class="content_edit" data-node-id="'+node.id +'" style="position: absolute; top:4px; *top:1px;  margin-left:50px; "><img width="50" height="13" src="/resources/cms/jqTree/img/btn_contentEdit.png" alt="콘텐츠수정하기" /></a>'; */
							$li.find('.jqtree-element').append(menuTreeHTML);
						}
					}
				});
				
				<%-- 왼쪽메뉴 트리 클릭했을 경우 --%>
				$tree.on('tree.click', function(e) {
					// Disable single selection
		            var selected_node = e.node;
					current_node = e.node.element.children;
		            
	    			if(beforeSelected_node!='') {
	    				$tree.tree('removeFromSelection', beforeSelected_node);	
	    			}
	    			$tree.tree('addToSelection', selected_node);
	    			
	    			beforeSelected_node = selected_node;
	    			
	    			if(selected_node.id == 'ROOT') {
	    				<%-- 처음 disable 화면 처리 --%>
	    				$('#codeLayer').load('code.do?editMode=FIRST');
	    			} else {
	    				$.ajax({
							url : 'getCodeGroupOne.do?homepage_id=' + $('input#homepage_id_1').val() + '&group_id=' + selected_node.id,
							async : true ,
							success : function(data) {
								data = eval(data);
								$('td#group_name_left').html(data.group_name);
								$('td#group_id_left').html(data.group_id);
								$('td#remark_left').html(data.remark);
								$('td#homepage_yn_left').html(data.homepage_yn);
								
								$('#codeLayer').load('code.do?editMode=ADD&homepage_id=' + $('input#homepage_id_1').val() + '&group_id=' + selected_node.id);
							}
						});	
	    			}
							
	    			e.preventDefault();
				});
				
				$('.tree-menu li:last-child').addClass('last');
			}
		});
	}
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			
			$('input#homepage_id_1').val($(this).val());
			treeOnLoad($(this).val());
		}
		
		e.preventDefault();
	});
	
	<%-- 코드그룹 신규등록  --%>
	$('a#editGroup_add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');	
		}
		else {
			//열려있는 다이얼로그를 삭제한다.(중복방지)
			//$('.dialog-common').remove();
			$('input#editMode_1').val('ADD');
			$('#dialog-1').load('editCodeGroup.do?' + $('#form_1').serialize(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});	
		}
		
		e.preventDefault(); 
	});
	
	<%-- 코드그룹 수정 --%>
	$('a#editGroup_modify').on('click', function(e) {
		//열려있는 다이얼로그를 삭제한다.(중복방지)
		//$('.dialog-common').remove();

		if(beforeSelected_node.id == null) {
			alert('수정할 코드그룹을 선택하세요.');			
		} else{
			if(beforeSelected_node.id == 'ROOT') {
				alert('코드그룹 모음은 수정할 수 없습니다.')				
			} else {
				$('input#editMode_1').val('MODIFY');
				$('input#group_id').val(beforeSelected_node.id);
				$('#dialog-1').load('editCodeGroup.do?' + $('#form_1').serialize(), function( response, status, xhr ) {
					$('#dialog-1').dialog('open');
				});
			}
		}
		
		e.preventDefault(); 
	});
	
	<%-- 코드그룹 삭제 --%>
	$('a#editGroup_delete').on('click', function(e) {
		if(beforeSelected_node.id == null) {
			alert('삭제할 코드그룹을 선택하세요.');			
		} else{
			if(beforeSelected_node.id == 'ROOT') {
				alert('코드그룹 모음은 삭제할 수 없습니다.')				
			} else {
				if(confirm('삭제 하시겠습니까?')) {
					$('input#editMode_1').val('DELETE');
					$('input#group_id').val(beforeSelected_node.id);
					$.ajax({
						url : 'saveCodeGroup.do?' + $('#form_1').serialize(),
						async : true ,
						method : 'POST',
						success : function(data) {
							alert(data.message);
							if(data.valid) {
								location.reload();
							}
						}
					});
				}	
			}
		}	
		
		e.preventDefault(); 
	});
	
	$('#search-btn').on('click', function(e) {
		var search_text = $('#search_text').val();
		$('.tree-box span').each(function(i, element) {
			element = $(element);
			if ( element.text().indexOf(search_text) != -1 ) {
				element.css('background', 'yellow');
				
				element[0].scrollIntoView(true);	
			}
			else {
				element.css('background', 'white');
			}
		});
	});
	
	<%-- 왼쪽 트리 로드 --%>
	treeOnLoad('${code.homepage_id}');
	<%-- 처음 disable 화면 처리 --%>
	$('#codeLayer').load('code.do?mode=${code.mode}&homepage_id=' + $('input#homepage_id_1').val() + '&editMode=FIRST');
	
});
</script>
 
<%
int leftSize = 400; //왼쪽 컨텐츠 사이즈
int leftSizeInput = leftSize-125; //왼쪽 컨텐츠 검색 input 사이즈
%>

<form:form id="form_1" modelAttribute="code" onsubmit="return false;">
	<form:hidden id="editMode_1" path="editMode" />
	<form:hidden id="homepage_id_1" path="homepage_id" />
	<form:hidden path="group_id"/>
</form:form>
<div class="container-box">
    <div class="page-header">
        <div>코드관리</div>
    </div>
    <div class="main-content">
        <div class="tree-area" style="width:<%=leftSize%>px">
            <div class="tree-area-header">
                <div >
                    <fieldset class="search-bar">
                        <input id="search_text" class="custom-search" type="text" style="width:-webkit-fill-available"/>
                        <div class="icon-btn black" id="search-btn">
                            <img alt="" src="/resources/cms/img/main/search.svg">
                            <div>검색</div>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div>
                <div class="tree-menu" id="tree1">
                </div>
            </div>
            <div class="table-wrap">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th colspan="2">코드그룹 정보</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>코드그룹명</th>
                            <td id="group_name_left">${code.group_name}</td>
                        </tr>
                        <tr>
                            <th>코드그룹ID</th>
                            <td id="group_id_left">${code.group_id}</td>
                        </tr>
                        <tr>
                            <th>홈페이지 사용</th>
                            <td id="homepage_yn_left"></td>
                        </tr>
                        <tr>
                            <th>설명</th>
                            <td id="remark_left">${code.remark}</td>
                        </tr>
                    </tbody>
                </table>
                <div class="btn-wrapper" style="justify-content: flex-end; margin-top: 10px; display: flex">
                <c:if test="${authC}">
                    <a class="icon-btn navy" href="" id="editGroup_add">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>코드그룹 신규등록</div>
                    </a>
                </c:if>
                <c:if test="${authU}">
                    <a class="icon-btn gray" href="" id="editGroup_modify">
                        <div>수정</div>
                    </a>
                </c:if>
                <c:if test="${authD}">
                    <a class="icon-btn red" href="" id="editGroup_delete">
                        <img src="/resources/cms/img/main/delete.svg" alt="">
                        <div>삭제</div>
                    </a>
                </c:if>
                </div>
            </div>
        </div>
        <div class="set-area">
            <div id="codeLayer">

            </div>
        </div>
    </div>
</div>

<div id="dialog-1" class="dialog-common" title="코드그룹">
</div>