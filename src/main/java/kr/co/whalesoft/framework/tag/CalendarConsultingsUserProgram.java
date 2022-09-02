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
import kr.co.whalesoft.app.cms.module.consultings.Consultings;
import kr.co.whalesoft.app.cms.module.consultings.apply.ConsultingApply;

public class CalendarConsultingsUserProgram extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<Consultings> consultingsList;
	private List<CalendarManage> calendarManageList;
	private List<ConsultingApply> applyList;
	private String plan_date;
	private String mode;

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
			for (int i = 0; i < consultingsList.size(); i++) {
				Consultings consultings = consultingsList.get(i);
				String planMonth = plan_date.substring(0, 7);
				String startMonth = consultings.getStart_date().substring(0, 7);
				String endMonth = consultings.getEnd_date().substring(0, 7);

				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-") + 1));
				int startDay = Integer.parseInt(consultings.getStart_date().substring(consultings.getStart_date().lastIndexOf("-") + 1));
				int endDay = Integer.parseInt(consultings.getEnd_date().substring(consultings.getEnd_date().lastIndexOf("-") + 1));

				Date now = new Date();

				// int toDay = 0;/*Integer.parseInt(toDate.substring(toDate.lastIndexOf("-")+1));*/

				int maxApplyCount = consultings.getMax_apply();
				int curApplyCount = consultings.getApply_count();

				if (planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					sb.append("<li title=\"" + consultings.getCode_name() + "\">");
					sb.append("[" + consultings.getCode_name() + "]<br>");
					sb.append("" + consultings.getStart_time() + "" + "~" + "" + consultings.getEnd_time() + "<br>");

					boolean flag = true;
					for (int j = 0; j < applyList.size(); j++) {
						ConsultingApply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-") + 1));

						if (apply.getConsultings_idx() == consultings.getConsultings_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if (apply.getApply_state().equals("3")) {
									sb.append("<span class=\"type-r\"><i></i><em>승인완료</em></span><br>");
								} else if (apply.getApply_state().equals("2")) {
									sb.append("<span class=\"type-e\"><i></i><em>승인불가</em></span><br>");
								} else if (apply.getApply_state().equals("1")) {
									sb.append("<span class=\"type-h\"><i></i><em>승인대기</em></span><br>");
								}
								flag = false;
							}
						}
					}
					if (flag) {
						if (consultings.getApply_yn().equals("Y") && consultings.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
								} else {
									sb.append("<a href=\"#\">신청 정원 마감</a>");
								}
							}
						}
					}
					sb.append("</li>");
				} else if (planDay >= startDay && planDay <= endDay) {
					sb.append("<li title=\"" + consultings.getCode_name() + "\">");
					sb.append("[" + consultings.getCode_name() + "]<br>");
					sb.append("" + consultings.getStart_time() + "" + "~" + "" + consultings.getEnd_time() + "<br>");

					boolean flag = true;
					for (int j = 0; j < applyList.size(); j++) {
						ConsultingApply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-") + 1));

						if (apply.getConsultings_idx() == consultings.getConsultings_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if (apply.getApply_state().equals("3")) {
									sb.append("<span class=\"type-r\"><i></i><em>승인완료</em></span><br>");
								} else if (apply.getApply_state().equals("2")) {
									sb.append("<span class=\"type-e\"><i></i><em>승인불가</em></span><br>");
								} else if (apply.getApply_state().equals("1")) {
									sb.append("<span class=\"type-h\"><i></i><em>승인대기</em></span><br>");
								}
								flag = false;
							}
						}
					}
					if (flag) {
						if (consultings.getApply_yn().equals("Y") && consultings.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
								} else {
									sb.append("<a href=\"#\">신청 정원 마감</a>");
								}
							}
						}
					}
					sb.append("</li>");
				} else if (!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					sb.append("<li title=\"" + consultings.getCode_name() + "\">");
					sb.append("[" + consultings.getCode_name() + "]<br>");
					sb.append("" + consultings.getStart_time() + "" + "~" + "" + consultings.getEnd_time() + "<br>");

					boolean flag = true;
					for (int j = 0; j < applyList.size(); j++) {
						ConsultingApply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-") + 1));

						if (apply.getConsultings_idx() == consultings.getConsultings_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if (apply.getApply_state().equals("3")) {
									sb.append("<span class=\"type-r\"><i></i><em>승인완료</em></span><br>");
								} else if (apply.getApply_state().equals("2")) {
									sb.append("<span class=\"type-e\"><i></i><em>승인불가</em></span><br>");
								} else if (apply.getApply_state().equals("1")) {
									sb.append("<span class=\"type-h\"><i></i><em>승인대기</em></span><br>");
								}
								flag = false;
							}
						}
					}
					if (flag) {
						if (consultings.getApply_yn().equals("Y") && consultings.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
								} else {
									sb.append("<a href=\"#\">신청 정원 마감</a>");
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

	public List<Consultings> getConsultingsList() {
		if (consultingsList != null) {
			List<Consultings> arrayList = new ArrayList<Consultings>();
			arrayList.addAll(this.consultingsList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setConsultingsList(List<Consultings> consultingsList) {
		if (consultingsList != null) {
			this.consultingsList = new ArrayList<Consultings>();
			this.consultingsList.addAll(consultingsList);
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

	public List<ConsultingApply> getApplyList() {
		if (applyList != null) {
			List<ConsultingApply> arrayList = new ArrayList<ConsultingApply>();
			arrayList.addAll(this.applyList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setApplyList(List<ConsultingApply> applyList) {
		if (applyList != null) {
			this.applyList = new ArrayList<ConsultingApply>();
			this.applyList.addAll(applyList);
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

}
