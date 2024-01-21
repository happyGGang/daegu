<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${getContextPath}/resources/cms/jqTree/css/jqtree.css">
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>

<script type="text/javascript">
$(document).ready(function() {
	var beforeSelected_node = '';
	
	function treeOnLoad(homepage_id) {		
		$.ajax({
			url : 'getMenuTreeList.do?homepage_id='+homepage_id,
			async : true ,
			success : function(data) {
				data = eval(data);
				var source = [];
		        var items = [];
		        // build hierarchical source.
		        for (var i = 0; i < data.length; i++) {
		            var menu = data[i];
		            var parent_menu_id = menu['parent_menu_idx'];
		            var id = menu['menu_idx'];
		            var title = menu['menu_name'];
		            var menu_type = menu['menu_type'];
		            if (items[parent_menu_id]) {
		                var item =
		                {
		                	id: id,
		                    label: title,
		                    menu_type : menu_type,
		                };

		                if (!items[parent_menu_id].children) {
		                    items[parent_menu_id].children = [];
		                }

		                items[parent_menu_id].children[items[parent_menu_id].children.length] = item;
		                items[id] = item;
		            }
		            else {
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
					autoOpen : true,
					dragAndDrop: true
				});
				
				$tree.on('tree.click', function(e) {
					$(this).focus();
					//열려있는 다이얼로그를 삭제한다.(중복방지)
	    			$('.dialog-common').remove();
		            // Disable single selection
	            	var selected_node = e.node;
	    			if(beforeSelected_node!='') {
	    				$tree.tree('removeFromSelection', beforeSelected_node);	
	    			}	
	    			
	    			$tree.tree('addToSelection', selected_node);
	    			beforeSelected_node = selected_node;
	    			
	    			$('input#menu_idx_1').val(selected_node.id);
	    			
					if(e.node.id != '0') {
						$('input#editMode_1').val('MODIFY');
		    			$('div#editLayer').load('${getContextPath}/cms/menu/edit.do?'+$('#form_1').serialize());	
		            } else {
		    			$('input#editMode_1').val('ADD');
		            	$('div#editLayer').load('${getContextPath}/cms/menu/edit.do?editMode=FIRST');
		            }
	    			
					e.preventDefault();
				});
				$tree.on('tree.move', function(event) {
					if(confirm(event.move_info.moved_node.name + ' 을(를)\n\n' + event.move_info.target_node.name + '의 하위메뉴로 이동 하시겠습니까?')) {
						if(confirm(event.move_info.moved_node.name + ' 의 모든 하위메뉴들도 함께 이동됩니다.\n\n이동 하시겠습니까?')) {
							$('#move_target_menu_idx_1').val(event.move_info.target_node.id);
							$('#menu_idx_1').val(event.move_info.moved_node.id);
							$('#editMode_1').val('parentMenuModify');
							
							jQuery.ajaxSettings.traditional = true;
							
							var option = {
								type: 'POST',
						        url: '/cms/menu/save.do',
						        data: $('#form_1').serialize(),
						        success: function(response){
						            if(response.valid) {
						                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						                	alert(response.message);
											location.reload();
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
							};
							$("#form_1").ajaxSubmit(option);
						}
					}
					return false;
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
	
	<%-- 메뉴추가 --%>
	$('a#add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');	
		}
		else {
			var node_id;
			if(beforeSelected_node.id==undefined || beforeSelected_node.id=='') {
				node_id = 0;
			} else {
				node_id = beforeSelected_node.id;
			}
			$('input#parent_menu_idx_1').val(node_id);
			$('input#editMode_1').val('ADD');
			
			//열려있는 다이얼로그를 삭제한다.(중복방지)
			$('.dialog-common').remove();
			$('div#editLayer').load('${getContextPath}/cms/menu/edit.do?' + $('#form_1').serialize());	
		}
		
		e.preventDefault();
	});
	
	$('a#del').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');	
		}
		else {
			if ( confirm('선택한 메뉴를 삭제 하시겠습니까?\n\n삭제된 메뉴는 복구 불가능합니다.') ) {
				var node_id;
				if ( beforeSelected_node.id == undefined || beforeSelected_node.id == '' ) {
					node_id = 0;
				} else {
					node_id = beforeSelected_node.id;
				}
				
				$('input#parent_menu_idx_1').val(node_id);
				$('input#editMode_1').val('DELETE');	
				$('#form_1').attr('action','delete.do');
				if ( doAjaxPost($('#form_1')) ) {
					location.reload();
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
	
	<%-- 처음 disable 화면 처리 --%>
	$('div#editLayer').load('${getContextPath}/cms/menu/edit.do?editMode=FIRST');
	treeOnLoad('${menu.homepage_id}');	
});
</script>
<form:form id="form_1" modelAttribute="menu" onsubmit="return false;" enctype="multipart/form-data">
<form:hidden id="parent_menu_idx_1" path="parent_menu_idx" />
<form:hidden id="move_target_menu_idx_1" path="move_target_menu_idx" />
<form:hidden id="menu_idx_1" path="menu_idx" />
<form:hidden id="editMode_1" path="editMode" />
<form:hidden id="homepage_id_1" path="homepage_id"/>
</form:form>
<c:if test="${!authU}">
<em>* 수정권한이 있어야 메뉴 상세보기가 가능합니다.</em>
</c:if>
<div class="group-menu">
	<div class="tree-area">
		<div class="search" style="margin-right:20px;">
			<fieldset>
				<label class="blind">검색</label>
				<input id="search_text" type="text" class="text" />
				<button id="search-btn"><i class="fa fa-search"></i><span>검색</span></button>
			</fieldset>
		</div>
		<div class="group-menu-header">
			<div class="title"><i class="fa fa-navicon"></i><span>메뉴목록</span></div>
			<div class="button">
				<c:if test="${authC}">
					<a href="" class="btn btn5" id="add"><i class="fa fa-plus"></i><span>추가</span></a>
				</c:if>
				<c:if test="${authD}">
					<a href="" class="btn" id="del"><i class="fa fa-minus"></i><span>삭제</span></a>
				</c:if>
			</div>
		</div>
		<div class="tree-box">
			<div class="tree-menu" id="tree1">
			</div>
		</div>
	</div>
	<div class="set-area" id="editLayer">
		
	</div>
</div>