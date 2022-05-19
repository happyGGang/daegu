package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.lang.time.DateUtils;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.showPerformance.ShowPerformance;
import kr.co.whalesoft.app.cms.module.showPerformance.apply.ShowApply;

public class CalendarShowPerformanceUserProgram extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<ShowPerformance> showPerformanceList;
	private List<CalendarManage> calendarManageList;
	private List<ShowApply> showApplyList;
	private String plan_date;
	private String mode;
	private String member_id;
	
	@Override
	public int doEndTag() throws JspException {
		StringBuffer sb = new StringBuffer();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date planDate = null;
		try {
			planDate = sf.parse(plan_date);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		if (mode.equals("admin")) {
			for (int i = 0; i < showPerformanceList.size(); i++) {
				ShowPerformance showPerformance = showPerformanceList.get(i);
				String planMonth = plan_date.substring(0, 7);
				String startMonth = showPerformance.getStart_date().substring(0, 7);
				String endMonth = showPerformance.getEnd_date().substring(0, 7);

				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-") + 1));
				int startDay = Integer.parseInt(showPerformance.getStart_date().substring(showPerformance.getStart_date().lastIndexOf("-") + 1));
				int endDay = Integer.parseInt(showPerformance.getEnd_date().substring(showPerformance.getEnd_date().lastIndexOf("-") + 1));

				Date now = new Date();

				// int toDay = 0;/*Integer.parseInt(toDate.substring(toDate.lastIndexOf("-")+1));*/
				
				
				int maxApplyCount = showPerformance.getMax_apply();
				int curApplyCount = showPerformance.getApply_count();
				

				if (planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					/*sb.append("<li title=\"" + showPerformance.getCode_name() + "\">");
					sb.append("[" + showPerformance.getCode_name() + "]<br>");*/
					sb.append("" + showPerformance.getStart_time() + "" + "~" + "" + showPerformance.getEnd_time() + "<br>");
					
					boolean flag = true;
					for (int j = 0; j < showApplyList.size(); j++) {
						ShowApply showApply = showApplyList.get(j);
						int startReqDay = Integer.parseInt(showApply.getStart_date().substring(showApply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(showApply.getEnd_date().substring(showApply.getEnd_date().lastIndexOf("-") + 1));

						if (showApply.getShowPerformance_idx() == showPerformance.getShowPerformance_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if(member_id.equals(showApply.getApplicant_member_id())) {
									if (showApply.getApply_state().equals("3")) {
										sb.append("<span class=\"type-r\"><i></i><em><strong>승인완료</strong>(" + showApply.getAgency_name() + ")</em></span><br>");
									} else if (showApply.getApply_state().equals("2")) {
										sb.append("<span class=\"type-e\"><i></i><em>승인불가(" + showApply.getAgency_name() + ")</em></span><br>");
									} else if (showApply.getApply_state().equals("1")) {
										sb.append("<span class=\"type-h\"><i></i><em>승인대기(" + showApply.getAgency_name() + ")</em></span><br>");
									}
									flag = false;
								}
							}
						}
					}
					if (flag) {
						if (showPerformance.getApply_yn().equals("Y") && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
								/*sb.append("<a href=\"\" class=\"\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>비회원신청</em></span></a><br>");*/
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
									/*sb.append("<a href=\"\" class=\"\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>비회원신청</em></span></a><br>");*/
								} else {
									sb.append("<a href=\"#\"><span style=\"type-r\"><i><em>신청마감</em></i></span></a><br>");
								}
							}
						}
					}
					sb.append("</li>");
				} else if (planDay >= startDay && planDay <= endDay) {
					/*sb.append("<li title=\"" + showPerformance.getCode_name() + "\">");
					sb.append("[" + showPerformance.getCode_name() + "]<br>");*/
					sb.append("" + showPerformance.getStart_time() + "" + "~" + "" + showPerformance.getEnd_time() + "<br>");

					
					boolean flag = true;
					for (int j = 0; j < showApplyList.size(); j++) {
						ShowApply showApply = showApplyList.get(j);
						int startReqDay = Integer.parseInt(showApply.getStart_date().substring(showApply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(showApply.getEnd_date().substring(showApply.getEnd_date().lastIndexOf("-") + 1));

						if (showApply.getShowPerformance_idx() == showPerformance.getShowPerformance_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if(member_id.equals(showApply.getApplicant_member_id())) {
									if (showApply.getApply_state().equals("3")) {
										sb.append("<span class=\"type-r\"><i></i><em><strong>승인완료</strong>(" + showApply.getAgency_name() + ")</em></span><br>");
									} else if (showApply.getApply_state().equals("2")) {
										sb.append("<span class=\"type-e\"><i></i><em>승인불가(" + showApply.getAgency_name() + ")</em></span><br>");
									} else if (showApply.getApply_state().equals("1")) {
										sb.append("<span class=\"type-h\"><i></i><em>승인대기(" + showApply.getAgency_name() + ")</em></span><br>");
									}
									flag = false;
								}
							}
						}
					}
					if (flag) {
						if (showPerformance.getApply_yn().equals("Y") && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
								/*sb.append("<a href=\"\" class=\"\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>비회원신청</em></span></a><br>");*/
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
									/*sb.append("<a href=\"\" class=\"\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>비회원신청</em></span></a><br>");*/
								} else {
									sb.append("<a href=\"#\"><span style=\"type-r\"><i><em>신청마감</em></i></span></a><br>");
								}
							}
						}
					}
					sb.append("</li>");
				} else if (!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					/*sb.append("<li title=\"" + showPerformance.getCode_name() + "\">");
					sb.append("[" + showPerformance.getCode_name() + "]<br>");*/
					sb.append("" + showPerformance.getStart_time() + "" + "~" + "" + showPerformance.getEnd_time() + "<br>");

					boolean flag = true;
					for (int j = 0; j < showApplyList.size(); j++) {
						ShowApply showApply = showApplyList.get(j);
						int startReqDay = Integer.parseInt(showApply.getStart_date().substring(showApply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(showApply.getEnd_date().substring(showApply.getEnd_date().lastIndexOf("-") + 1));

						if (showApply.getShowPerformance_idx() == showPerformance.getShowPerformance_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if(member_id.equals(showApply.getApplicant_member_id())) {
									if (showApply.getApply_state().equals("3")) {
										sb.append("<span class=\"type-r\"><i></i><em><strong>승인완료</strong>(" + showApply.getAgency_name() + ")</em></span><br>");
									} else if (showApply.getApply_state().equals("2")) {
										sb.append("<span class=\"type-e\"><i></i><em>승인불가(" + showApply.getAgency_name() + ")</em></span><br>");
									} else if (showApply.getApply_state().equals("1")) {
										sb.append("<span class=\"type-h\"><i></i><em>승인대기(" + showApply.getAgency_name() + ")</em></span><br>");
									}
									flag = false;
								}
							}
						}
					}
					if (flag) {
						if (showPerformance.getApply_yn().equals("Y") && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
								/*sb.append("<a href=\"\" class=\"\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>비회원신청</em></span></a><br>");*/
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
									/*sb.append("<a href=\"\" class=\"\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + plan_date + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"type-r\"><i></i><em>비회원신청</em></span></a><br>");*/
								} else {
									sb.append("<a href=\"#\"><span style=\"type-r\"><i><em>신청마감</em></i></span></a><br>");
								}
							}
						}
					}
					sb.append("</li>");
				}
			}

			// 도서관일정
			for (int i = 0; i < calendarManageList.size(); i++) {
				CalendarManage cm = calendarManageList.get(i);
				String planMonth = plan_date.substring(0, 7);
				String startMonth = cm.getStart_date().substring(0, 7);
				String endMonth = cm.getEnd_date().substring(0, 7);
				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-") + 1));
				int startDay = Integer.parseInt(cm.getStart_date().substring(cm.getStart_date().lastIndexOf("-") + 1));
				int endDay = Integer.parseInt(cm.getEnd_date().substring(cm.getEnd_date().lastIndexOf("-") + 1));
				if (planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					if (planDay >= startDay && planDay <= 31) {
						if (cm.getDate_type().equals("1")) {
							sb.append("<li title=\"" + cm.getTitle() + "\">");
							sb.append("<span class=\"type-e\"><i></i><em>" + cm.getTitle() + "</em></span>");
							sb.append("</li>");
						} else {
							sb.append("<li title=\"" + cm.getTitle() + "\">");
							sb.append("<span class=\"type-e\"><i></i><em>" + cm.getTitle() + "</em></span>");
							sb.append("</li>");
						}
					}
				}
				if (!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					if (planDay >= 1 && planDay <= endDay) {
						if (cm.getDate_type().equals("1")) {
							sb.append("<li title=\"" + cm.getTitle() + "\">");
							sb.append("<span class=\"type-e\"><i></i><em>" + cm.getTitle() + "</em></span>");
							sb.append("</li>");
						} else {
							sb.append("<li title=\"" + cm.getTitle() + "\">");
							sb.append("<span class=\"type-e\"><i></i><em>" + cm.getTitle() + "</em></span>");
							sb.append("</li>");
						}
					}
				}
				if (planDay >= startDay && planDay <= endDay) {
					if (cm.getDate_type().equals("1")) {
						sb.append("<li title=\"" + cm.getTitle() + "\">");
						sb.append("<span class=\"type-e\"><i></i><em>" + cm.getTitle() + "</em></span>");
						sb.append("</li>");
					} else {
						sb.append("<li title=\"" + cm.getTitle() + "\">");
						sb.append("<span class=\"type-e\"><i></i><em>" + cm.getTitle() + "</em></span>");
						sb.append("</li>");
					}
				}

			}
		}

		try {
			pageContext.getOut().println(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}

	public List<ShowPerformance> getShowPerformanceList() {
		if (showPerformanceList != null) {
			List<ShowPerformance> arrayList = new ArrayList<ShowPerformance>();
			arrayList.addAll(this.showPerformanceList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setShowPerformanceList(List<ShowPerformance> showPerformanceList) {
		if (showPerformanceList != null) {
			this.showPerformanceList = new ArrayList<ShowPerformance>();
			this.showPerformanceList.addAll(showPerformanceList);
		}
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public List<ShowApply> getShowApplyList() {
		if (showApplyList != null) {
			List<ShowApply> arrayList = new ArrayList<ShowApply>();
			arrayList.addAll(this.showApplyList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setShowApplyList(List<ShowApply> showApplyList) {
		if (showApplyList != null) {
			this.showApplyList = new ArrayList<ShowApply>();
			this.showApplyList.addAll(showApplyList);
		}
	}

	public List<CalendarManage> getCalendarManageList() {
		if (calendarManageList != null) {
			List<CalendarManage> arrayList = new ArrayList<CalendarManage>();
			arrayList.addAll(this.calendarManageList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setCalendarManageList(List<CalendarManage> calendarManageList) {
		if (calendarManageList != null) {
			this.calendarManageList = new ArrayList<CalendarManage>();
			this.calendarManageList.addAll(calendarManageList);
		}
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

}
