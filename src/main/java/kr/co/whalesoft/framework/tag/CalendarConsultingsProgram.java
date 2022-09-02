package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.module.consultings.Consultings;

public class CalendarConsultingsProgram extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<Consultings> consultingsList;
	private String plan_date;
	private String mode;

	@Override
	public int doEndTag() throws JspException {

		StringBuffer sb = new StringBuffer();

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		String toDay = format.format(calendar.getTime());
		if (mode.equals("admin")) {
			for (int i = 0; i < consultingsList.size(); i++) {
				Consultings consultings = consultingsList.get(i);
				String planMonth = plan_date.substring(0, 7);
				String startMonth = consultings.getStart_date().substring(0, 7);
				String endMonth = consultings.getEnd_date().substring(0, 7);
				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-") + 1));
				int startDay = Integer.parseInt(consultings.getStart_date().substring(consultings.getStart_date().lastIndexOf("-") + 1));
				int endDay = Integer.parseInt(consultings.getEnd_date().substring(consultings.getEnd_date().lastIndexOf("-") + 1));

				int calendarDay = Integer.parseInt(plan_date.replaceAll("-", ""));
				int to_day = Integer.parseInt(toDay);

				if (planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					if (planDay >= startDay && planDay <= 31) {
						sb.append("<input type='checkbox' name='consultings_idx_arr' value='"+consultings.getConsultings_idx()+"'>");
						sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + consultings.getConsultings_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
						sb.append("[" + consultings.getCode_name() + "]<br>");
						sb.append("" + consultings.getStart_time() + "" + "~" + "" + consultings.getEnd_time() + "<br>");
						if (consultings.getApply_yn().equals("Y")) {
							if (calendarDay >= to_day) {
								sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + consultings.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
							} else {
								sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
							}
						} else if (consultings.getApply_yn().equals("N")) {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
						if (plan_date.equals(consultings.getStart_date())) {
							sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + consultings.getConsultings_idx() + "\" id=\"check_apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + consultings.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + consultings.getApply_count() + ")</span></a>");
						}
						sb.append("<ul class=\"schedule\">");
						sb.append("</ul>");
					}
				} else if (planDay >= startDay && planDay <= endDay) {
					sb.append("<input type='checkbox' name='consultings_idx_arr' value='"+consultings.getConsultings_idx()+"'>");
					sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + consultings.getConsultings_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
					sb.append("[" + consultings.getCode_name() + "]<br>");
					sb.append("" + consultings.getStart_time() + "" + "~" + "" + consultings.getEnd_time() + "<br>");
					if (consultings.getApply_yn().equals("Y")) {
						if (calendarDay >= to_day) {
							sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + consultings.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
						} else {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
					} else if (consultings.getApply_yn().equals("N")) {
						sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
					}
					if (plan_date.equals(consultings.getStart_date())) {
						sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + consultings.getConsultings_idx() + "\" id=\"check_apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + consultings.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + consultings.getApply_count() + ")</span></a>");
					}
					sb.append("<ul class=\"schedule\">");
					sb.append("</ul>");
				} else if (!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					if (planDay >= 1 && planDay <= endDay) {
						sb.append("<input type='checkbox' name='consultings_idx_arr' value='"+consultings.getConsultings_idx()+"'>");
						sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + consultings.getConsultings_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
						sb.append("[" + consultings.getCode_name() + "]<br>");
						sb.append("" + consultings.getStart_time() + "" + "~" + "" + consultings.getEnd_time() + "<br>");
						if (consultings.getApply_yn().equals("Y")) {
							if (calendarDay >= to_day) {
								sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + consultings.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
							} else {
								sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
							}
						} else if (consultings.getApply_yn().equals("N")) {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
						if (plan_date.equals(consultings.getStart_date())) {
							sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + consultings.getConsultings_idx() + "\" id=\"check_apply\" keyValue=\"" + consultings.getConsultings_idx() + "\" keyValue2=\"" + consultings.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + consultings.getApply_count() + ")</span></a>");
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

}
