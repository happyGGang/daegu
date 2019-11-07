<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${getContextPath}/resources/cms/jqTree/css/jqtree.css">
<script src="${getContextPath}/resources/cms/jqTree/js/tree.jquery.js" type="text/javascript"></script>
<script src="${getContextPath}/resources/cms/js/jq_plugin/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
var beforeSelected_node = '';

function treeOnLoad() {
	$.ajax({
		url : 'getAddressTreeList.do',
		async : true ,
		success : function(data) {
			data = eval(data);
			var source = [];
	        var items = [];
	        // build hierarchical source.
	        for (var i = 0; i < data.length; i++) {
	            var code = data[i];
	            var parent_address_book_idx = code['parent_address_book_idx'];
	            var id = code['address_book_idx'];
	            var title = code['address_book_name'];

	            if (items[parent_address_book_idx]) {
	                var item =
	                {
	                	id: id,
	                    label: title
	                };

	                if (!items[parent_address_book_idx].children) {
	                    items[parent_address_book_idx].children = [];
	                }

	                items[parent_address_book_idx].children[items[parent_address_book_idx].children.length] = item;
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
				dragAndDrop: false,
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
	            
    			if(beforeSelected_node!='') {
    				$tree.tree('removeFromSelection', beforeSelected_node);	
    			}
    			$tree.tree('addToSelection', selected_node);
    			
    			beforeSelected_node = selected_node;
    			
    			if(selected_node.id == 0) {
    				<%-- 처음 disable 화면 처리 --%>
    				//$('#itemLayer').load('auth.do?editMode=FIRST');
    				/* $('td#storage_id_left').html('');
					$('td#address_book_name_left').html('');
					 */
    			} else {
    				$.ajax({
						url : 'getAddressOne.do?address_book_idx=' + selected_node.id,
						async : true ,
						success : function(data) {
							data = eval(data);
							$('#editForm #address_book_idx').val(data.address_book_idx);
							$('#editForm #address_book_name').val(data.address_book_name);
						}
					});	
    				
    				$('#itemLayer').load('getItemList.do?address_book_idx=' + selected_node.id);
    			}
						
    			e.preventDefault();
			});
			
			$tree.on('tree.move', function(event) {
				if(confirm(event.move_info.moved_node.name + ' 을(를)\n\n' + event.move_info.target_node.name + '의 하위조직으로 이동 하시겠습니까?')) {
					if(confirm(event.move_info.moved_node.name + ' 의 모든 하위조직들도 함께 이동됩니다.\n\n이동 하시겠습니까?')) {
						$('#parent_address_book_idx ').val(event.move_info.target_node.id);
						$('#address_book_idx').val(event.move_info.moved_node.id);
						$('#editMode').val('PARENTMOVE');
						
						jQuery.ajaxSettings.traditional = true;
						
						if ( doAjaxPost($('#parentMoveForm')) ) {
							location.reload();
						} 
					}
				}
				return false;
			});
			
			$('.tree-menu li:last-child').addClass('last');
			$('#itemLayer').load('getItemList.do?editMode=FIRST');
		}
	});
}

$(document).ready(function() {
	
	$('a#storage_add').on('click', function(e) {
		//열려있는 다이얼로그를 삭제한다.(중복방지)
		//$('.dialog-common').remove();
		e.preventDefault();
		
		if ( beforeSelected_node.id == null ) {
			alert('등록할 주소록의 상위 주소록을 선택해주세요.');
			return false;
		}
		$('#editForm #editMode').val('ADD');
		$('#editForm #parent_address_book_idx').val(beforeSelected_node.id);
		
		if ( doAjaxPost($('#editForm')) ) {
			treeOnLoad();
		}
		
	});
	
	$('a#storage_modify').on('click', function(e) {
		if(beforeSelected_node.id == null) {
			alert('수정할 주소록을 선택하세요.');			
		} else{
			if(beforeSelected_node.id == 0) {
				alert('최상위 "주소록"은 수정할 수 없습니다.')				
			} else {
				$('#editForm #editMode').val('MODIFY');
				if ( doAjaxPost($('#editForm')) ) {
					treeOnLoad();
				}
			}
		}
		
		e.preventDefault(); 
	});
	
	$('a#storage_delete').on('click', function(e) {
		if(beforeSelected_node.id == null) {
			alert('삭제할 주소록을 선택하세요.');			
		} else{
			if(beforeSelected_node.id == 0) {
				alert('최상위 "주소록"은 삭제할 수 없습니다.');				
			} else {
				if(confirm('정말 삭제 하시겠습니까? 주소록 내 모든 자료가 삭제되며 복구가 불가능합니다.')) {
					$.ajax({
						url : 'save.do?editMode=DELETE&address_book_idx=' + beforeSelected_node.id,
						async : true ,
						method : 'POST',
						success : function(data) {
							alert(data.message);
							if(data.valid) {
								treeOnLoad();
							}
						}
					});
				}	
			}
		}	
		
		e.preventDefault(); 
	});
	
	treeOnLoad();
	
	<%-- 처음 disable 화면 처리 --%>
	//$('#itemLayer').load('auth.do?editMode=FIRST');
	//$('#itemLayer').load('memberOrga.do?editMode=FIRST');
});
</script>
 
<%
int leftSize = 475; //왼쪽 컨텐츠 사이즈
int leftSizeInput = leftSize-125; //왼쪽 컨텐츠 검색 input 사이즈
%>

<form:form id="parentMoveForm" modelAttribute="addressBook" action="save.do">
	<form:hidden path="editMode" value="PARENTMOVE"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="address_book_idx"/>
	<form:hidden path="address_book_name"/>
</form:form>

<div class="group-menu code-config">
	<div style="display: inline-flex;">
		<div class="tree-area" style="width:<%=leftSize%>px; border: 1px solid #ccc;">
			<div class="tree-box" style="height:500px;">
				<div class="tree-menu" id="tree1">
				</div>
			</div>
			<div class="table-wrap">
				<form:form id="editForm" modelAttribute="addressBook" action="save.do">
					<form:hidden path="editMode" />
					<form:hidden path="homepage_id"/>
					<form:hidden path="address_book_idx" class="text"/>
					<form:hidden path="parent_address_book_idx" class="text"/>
					<table class="border-all">
						<colgroup>
							<col width="100"/>
							<col width=""/>
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">주소록 정보</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>주소록 명</th>
								<td id="address_book_name_left">
									<form:input path="address_book_name" class="text" style="width:96%"/>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="button" style="border-width:0px;">
						<a href="" class="btn btn5" id="storage_add"><i class="fa fa-plus"></i><span>주소록 신규등록</span></a>
						<a href="" class="btn btn1" id="storage_modify"><i class="fa fa-pencil"></i><span>수정</span></a>
						<a href="" class="btn" id="storage_delete"><i class="fa fa-minus"></i><span>삭제</span></a>
					</div>
				</form:form>
			</div>
		&nbsp; * 주소록은 가나다순으로 정렬됩니다.
		</div>
		<div class="set-area" style="padding-left: 20px; padding-right:20px; border: 1px solid #ccc;">
			<div style="height:100%;" id="itemLayer">
			
			</div>
		</div>
	</div>
	<br/>
	
</div>