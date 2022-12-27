package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import kr.co.whalesoft.app.cms.module.volunteer.Volunteer;

public class CalendarVolunteerProgram extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<Volunteer> volunteerList;
	private String plan_date;
	private String mode;

	@Override
	public int doEndTag() throws JspException {

		StringBuffer sb = new StringBuffer();

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		String toDay = format.format(calendar.getTime());
		if (mode.equals("admin")) {
			for (int i = 0; i < volunteerList.size(); i++) {
				Volunteer volunteer = volunteerList.get(i);
				String planMonth = plan_date.substring(0, 7);
				String startMonth = volunteer.getStart_date().substring(0, 7);
				String endMonth = volunteer.getEnd_date().substring(0, 7);
				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-") + 1));
				int startDay = Integer.parseInt(volunteer.getStart_date().substring(volunteer.getStart_date().lastIndexOf("-") + 1));
				int endDay = Integer.parseInt(volunteer.getEnd_date().substring(volunteer.getEnd_date().lastIndexOf("-") + 1));

				int calendarDay = Integer.parseInt(plan_date.replaceAll("-", ""));
				int to_day = Integer.parseInt(toDay);
				
				String use_time = "";
				if("am".equals(volunteer.getUse_time())) {
					use_time = "오전";
				}else if("pm".equals(volunteer.getUse_time())) {
					use_time = "오후";
				}

				if (planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					if (planDay >= startDay && planDay <= 31) {
						sb.append("<input type='checkbox' name='volunteer_idx_arr' value='"+volunteer.getVolunteer_idx()+"'>");
						sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + volunteer.getVolunteer_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
						sb.append("[" + volunteer.getCode_name() + "]<br>");
						if(volunteer.getHomepage_id().equals("h50")) {
							sb.append("" + use_time + "<br>");
						}else {
							sb.append("" + volunteer.getStart_time() + "" + "~" + "" + volunteer.getEnd_time() + "<br>");
						}
						if (volunteer.getApply_yn().equals("Y")) {
							if (calendarDay >= to_day) {
								sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + volunteer.getVolunteer_idx() + "\" keyValue2=\"" + volunteer.getStart_date() + "\" keyValue3=\"" + volunteer.getStart_time() + "\" keyValue4=\"" + volunteer.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
							} else {
								sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
							}
						} else if (volunteer.getApply_yn().equals("N")) {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
						if (plan_date.equals(volunteer.getStart_date())) {
							sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + volunteer.getVolunteer_idx() + "\" id=\"check_apply\" keyValue=\"" + volunteer.getVolunteer_idx() + "\" keyValue2=\"" + volunteer.getStart_date() + "\" keyValue3=\"" + volunteer.getUse_time() + "\" keyValue4=\"" + volunteer.getStart_time() + "\" keyValue5=\"" + volunteer.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + volunteer.getApply_count() + ")</span></a>");
						}
						sb.append("<ul class=\"schedule\">");
						sb.append("</ul>");
					}
				} else if (planDay >= startDay && planDay <= endDay) {
					sb.append("<input type='checkbox' name='volunteer_idx_arr' value='"+volunteer.getVolunteer_idx()+"'>");
					sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + volunteer.getVolunteer_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
					sb.append("[" + volunteer.getCode_name() + "]<br>");
					if(volunteer.getHomepage_id().equals("h50")) {
						sb.append("" + use_time + "<br>");
					}else {
						sb.append("" + volunteer.getStart_time() + "" + "~" + "" + volunteer.getEnd_time() + "<br>");

					}
					if (volunteer.getApply_yn().equals("Y")) {
						if (calendarDay >= to_day) {
							sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + volunteer.getVolunteer_idx() + "\" keyValue2=\"" + volunteer.getStart_date() + "\" keyValue3=\"" + volunteer.getStart_time() + "\" keyValue4=\"" + volunteer.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
						} else {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
					} else if (volunteer.getApply_yn().equals("N")) {
						sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
					}
					if (plan_date.equals(volunteer.getStart_date())) {
						sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + volunteer.getVolunteer_idx() + "\" id=\"check_apply\" keyValue=\"" + volunteer.getVolunteer_idx() + "\" keyValue2=\"" + volunteer.getStart_date() +  "\" keyValue3=\"" + volunteer.getUse_time() + "\" keyValue4=\"" + volunteer.getStart_time() + "\" keyValue5=\"" + volunteer.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + volunteer.getApply_count() + ")</span></a>");
					}
					sb.append("<ul class=\"schedule\">");
					sb.append("</ul>");
				} else if (!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					if (planDay >= 1 && planDay <= endDay) {
						sb.append("<input type='checkbox' name='volunteer_idx_arr' value='"+volunteer.getVolunteer_idx()+"'>");
						sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + volunteer.getVolunteer_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
						sb.append("[" + volunteer.getCode_name() + "]<br>");
						if(volunteer.getHomepage_id().equals("h50")) {
							sb.append("" + use_time + "<br>");
						}else {
							sb.append("" + volunteer.getStart_time() + "" + "~" + "" + volunteer.getEnd_time() + "<br>");
						}
						if (volunteer.getApply_yn().equals("Y")) {
							if (calendarDay >= to_day) {
								sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + volunteer.getVolunteer_idx() + "\" keyValue2=\"" + volunteer.getStart_date() + "\" keyValue3=\"" + volunteer.getStart_time() + "\" keyValue4=\"" + volunteer.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
							} else {
								sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
							}
						} else if (volunteer.getApply_yn().equals("N")) {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
						if (plan_date.equals(volunteer.getStart_date())) {
							sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + volunteer.getVolunteer_idx() + "\" id=\"check_apply\" keyValue=\"" + volunteer.getVolunteer_idx() + "\" keyValue2=\"" + volunteer.getStart_date() +  "\" keyValue3=\"" + volunteer.getUse_time() + "\" keyValue4=\"" + volunteer.getStart_time() + "\" keyValue5=\"" + volunteer.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + volunteer.getApply_count() + ")</span></a>");
						}

						sb.append("<ul class=\"schedule\">");
						sb.append("</ul>");
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

	public List<Volunteer> getVolunteerList() {
		if (volunteerList != null) {
			List<Volunteer> arrayList = new ArrayList<Volunteer>();
			arrayList.addAll(this.volunteerList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setVolunteerList(List<Volunteer> volunteerList) {
		if (volunteerList != null) {
			this.volunteerList = new ArrayList<Volunteer>();
			this.volunteerList.addAll(volunteerList);
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

}
