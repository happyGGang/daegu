<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="replaceStr" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.search_text}</span>"/>
<c:set var="replaceStr1" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.searchKeyword1}</span>"/>
<c:set var="replaceStr2" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.searchKeyword2}</span>"/>
<c:set var="replaceStr3" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.searchKeyword3}</span>"/>
<c:set var="replaceStr4" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.searchKeyword4}</span>"/>
<c:choose>
	<c:when test="${totalSearch.more_type eq 'BOOK'}">
		<c:forEach items="${result.data}" var="i">
			<div class="row">
				<div class="thumb">
					<c:choose>
						<c:when test="${i.img eq '' or fn:contains(i.img, 'noimg')}">
							<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail noImg">
								<img src="/resources/common/img/noImg.gif" alt="noImage"/>
							</a>
						</c:when>
						<c:otherwise>
							<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail">
								<img src="${i.img}" alt="${i.title}"/>
							</a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="box">
					<div class="item">
						<div class="bif">
							<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="name goDetail">
								<c:choose>
									<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
										${fn:replace(i.title, totalSearch.search_text, replaceStr)}	
									</c:when>
									<c:otherwise>
										<c:set var="searchKeyword" value="${i.title}"/>
										<c:if test="${totalSearch.searchKeyword1 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword2 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword3 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword4 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
										</c:if>
										${searchKeyword}
									</c:otherwise>
								</c:choose>
							</a>
							<p>
								<c:choose>
									<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
										${fn:replace(i.author, totalSearch.search_text, replaceStr)}
									</c:when>
									<c:otherwise>
										<c:set var="searchKeyword" value="${i.author}"/>
										<c:if test="${totalSearch.searchKeyword1 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword2 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword3 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword4 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
										</c:if>
										${searchKeyword}
									</c:otherwise>
								</c:choose>
								
							</p>
							<p>
								<c:choose>
									<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
										${fn:replace(i.publisher, totalSearch.search_text, replaceStr)}, ${i.year}, ${i.libName}
									</c:when>
									<c:otherwise>
										<c:set var="searchKeyword" value="${i.publisher}"/>
										<c:if test="${totalSearch.searchKeyword1 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword2 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword3 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword4 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
										</c:if>
										${searchKeyword}, ${i.year}, ${i.libName}
									</c:otherwise>
								</c:choose>
							</p>
							<div class="stat">
								<a href="#" class="showSlide" vLoca="${i.libCode}" vCtrl="${i.rec_key}"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a>
								<span>[${i.callno}]</span>
							</div>
						</div>
						<div class="bci" style="display: none;">
							<!-- ajax_area -->
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:when test="${totalSearch.more_type eq 'NOTICE'}">
		<c:choose>
			<c:when test="${fn:length(noticeList) > 0}">
				<c:forEach items="${noticeList}" var="j">
					<tr>
						<td class="category important td2">
							<span class="ca ${j.imsi_v_19}">${j.imsi_v_20}</span>
						</td>
						<td class="important left">
							<a target="blank" href="/${j.imsi_v_19}/board/view.do?menu_idx=${j.imsi_n_2}&board_idx=${j.board_idx}&manage_idx=${j.manage_idx}" gbelib="true" >
								<span>
									<c:choose>
										<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
											${fn:replace(j.title, totalSearch.search_text, replaceStr)}
										</c:when>
										<c:otherwise>
											<c:set var="searchKeyword" value="${j.title}"/>
											<c:if test="${totalSearch.searchKeyword1 ne '' }">
												<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
											</c:if>
											<c:if test="${totalSearch.searchKeyword2 ne '' }">
												<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
											</c:if>
											<c:if test="${totalSearch.searchKeyword3 ne '' }">
												<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
											</c:if>
											<c:if test="${totalSearch.searchKeyword4 ne '' }">
												<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
											</c:if>
											${searchKeyword}
										</c:otherwise>
									</c:choose>
								</span>
								<c:if test="${j.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
								<c:if test="${j.comment_count > 0}">
								<span class="comment"><em>댓글</em> <i>${j.comment_count}</i></span>
								</c:if>
							</a>
						</td>
						<td class="num mmm1"><fmt:formatDate value="${j.add_date}" pattern="yyyy.MM.dd" /></td>
						<td class="num mmm1">${j.view_count}</td>
						<td class="file mmm1">
							<c:if test="${j.file_count > 0}">
								<i class="fa fa-floppy-o"></i>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<!-- <tr>
					<td colspan="5">더이상 불러올 데이터가 없습니다.</td>
				</tr> -->
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test="${totalSearch.more_type eq 'TEACH'}">
		<c:choose>
			<c:when test="${fn:length(teachList) > 0}">
				<c:forEach items="${teachList}" var="k">
					<div class="item">
						<div class="op_title category">
							<span class="ca ${k.context_path}">${k.homepage_alias}</span><span class="ca ty2">${k.group_name} ${k.category_name}</span>
							<a href="" class="name detail-btn" keyValue="${k.homepage_id}" keyValue1="${k.group_idx}" keyValue2="${k.category_idx}" keyValue3="${k.teach_idx}">
								<c:choose>
									<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
										${fn:replace(k.teach_name, totalSearch.search_text, replaceStr)}
									</c:when>
									<c:otherwise>
										<c:set var="searchKeyword" value="${k.teach_name}"/>
										<c:if test="${totalSearch.searchKeyword1 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword2 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword3 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
										</c:if>
										<c:if test="${totalSearch.searchKeyword4 ne '' }">
											<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
										</c:if>
										${searchKeyword}
									</c:otherwise>
								</c:choose>
							</a>
						</div>
						<div class="box">
							<div class="box2">
								<ul class="con2">
									<li class="first"><div><label>접수기간 </label> : ${k.start_join_date} ${k.start_join_time} ~ ${k.end_join_date} ${k.end_join_time}</div></li>
									<li><div><label>장소</label> : ${k.teach_stage}</div></li>
									<li><div><label>강좌일</label> : ${k.start_date} <c:if test="${k.start_date ne k.end_date}">~ ${k.end_date}</c:if> (
																	<c:forEach var="j" varStatus="status_j" items="${k.teach_day_arr}">
																		<c:choose>
																			<c:when test="${j eq '1'}">일</c:when>
																			<c:when test="${j eq '2'}">월</c:when>
																			<c:when test="${j eq '3'}">화</c:when>
																			<c:when test="${j eq '4'}">수</c:when>
																			<c:when test="${j eq '5'}">목</c:when>
																			<c:when test="${j eq '6'}">금</c:when>
																			<c:when test="${j eq '7'}">토</c:when>
																		</c:choose>
																		<c:if test="${!status_j.last}">
																			, 
																		</c:if>
																	</c:forEach>
																) ${k.start_time} ~ ${k.end_time}
									</div></li>
									<li><div><label>강사명</label> : ${k.teacher_name}</div></li>
									<li><div>
						        		<label>강의계획서</label> : 
							         	<span class="important td1">
							         		<c:if test="${k.real_file_name ne null and k.real_file_name ne '' }">
							         			<a style="color:#00f" href="download/${k.homepage_id}/${k.group_idx}/${k.category_idx}/${k.teach_idx}.do"><i class="fa fa-floppy-o"></i> ${k.plan_file_name}</a>
							         		</c:if>
						         		</span>
							        </div></li>
									
									<%-- <li><div><label>강좌설명</label> : ${k.teach_desc}</div></li> --%>
									<li><div class="status">
										<label>모집인원</label> :
										<span><strong>온라인</strong> ${k.teach_limit_count}명 </span>
										<c:if test="${k.teach_offline_count > 0}"><span>, <strong>오프라인</strong> ${k.teach_offline_count}명</span></c:if>
										<c:if test="${k.teach_backup_count > 0}"><span>, (<strong>대기자</strong> ${k.teach_backup_count}명 )</span></c:if>
									</div></li>
									<li><div class="status">
										<label>접수현황</label> :
										<span>
											온라인 :
											<span ${k.teach_join_count > 0 and (k.teach_join_count eq k.teach_limit_count)? 'style="color:red;"' : 'style="color:orange"'}>${k.teach_join_count}</span> / ${k.teach_limit_count}
										</span>
										<c:if test="${k.teach_offline_count > 0}">
											<span>
												오프라인 :
												<span ${k.teach_off_join_count > 0 and (k.teach_off_join_count eq k.teach_offline_count)? 'style="color:red;"' : 'style="color:orange"'}>${k.teach_off_join_count}</span> / ${k.teach_offline_count}
											</span>
										</c:if>
										<c:if test="${k.teach_backup_count > 0}">
											<span>
												(
												대기자 :
												<span ${k.teach_backup_join_count > 0 and (k.teach_backup_join_count eq k.teach_backup_count)? 'style="color:red;"' : 'style="color:orange"'}>${k.teach_backup_join_count}</span> / ${k.teach_backup_count}
												)
											</span>
										</c:if>
									</div></li>
									<li><div><label>모집대상</label> : ${k.teach_target}</div></li>
								</ul>
							</div>
						</div>
						<div class="stat">
							<c:choose>
								<c:when test="${member.login and (member.loginType eq 'HOMEPAGE') and (k.member_key eq member.seq_no)}">
									<a class="btn btn3 teachBook-btn" keyValue1="${k.homepage_id}" keyValue2="${k.group_idx}" keyValue3="${k.category_idx}" keyValue4="${k.teach_idx}">출석부</a>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${k.teach_status eq '0'}">
											<a href="" class="btn btn1 add" keyValue1="${k.homepage_id}" keyValue2="${k.group_idx}" keyValue3="${k.category_idx}" keyValue4="${k.teach_idx}" apply_status="1">
											<i class="fa fa-pencil-square-o"></i><span>수강신청 </span></a>
										</c:when>
										<c:when test="${k.teach_status eq '1'}">
											<a href="" class="btn btn1 add" keyValue1="${k.homepage_id}" keyValue2="${k.group_idx}" keyValue3="${k.category_idx}" keyValue4="${k.teach_idx}" apply_status="2">
											<i class="fa fa-pencil-square-o"></i><span>대기자신청</span></a>
										</c:when>
										<c:when test="${k.teach_status eq '2'}">
											<a href="javascript:void(0);" class="btn btn2" style="cursor: default;">
											<i class="fa fa-circle-o"></i><span>신청완료</span></a>
										</c:when>
										<%-- <c:when test="${k.teach_status eq '3'}">
											<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
											<i class="fa fa-sign-in"></i><span>대기자</span></a>
										</c:when> --%>
										<c:when test="${k.teach_status eq '4'}">
											<a href="javascript:void(0);" class="btn" style="cursor: default;">
											<i class="fa fa-pencil"></i><span>접수마감</span></a>
										</c:when>
										<c:when test="${k.teach_status eq '5'}">
											<a href="javascript:void(0);" class="btn" style="cursor: default;">
											<i class="fa fa-user"></i><span>정원마감</span></a>
										</c:when>
										<c:when test="${k.teach_status eq '6'}">
											<a href="javascript:void(0);" class="btn btn4" style="cursor: default;">
											<i class="fa fa-clock-o"></i><span>신청대기</span></a>
										</c:when>
										<%-- <c:when test="${k.teach_status eq '7' }">
											<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
											<i class="fa fa-times-circle"></i><span>신청불가(취소)</span></a>
										</c:when> --%>
									</c:choose>						
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<!-- <div class="nodata">
					<i class="fa fa-frown-o"></i>
					<p>더이상 불러올 데이터가 없습니다.</p>
				</div> -->
			</c:otherwise>
		</c:choose>
	</c:when>
</c:choose>