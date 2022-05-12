package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import kr.co.whalesoft.app.cms.module.showPerformance.ShowPerformance;

public class CalendarShowPerformanceProgram extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<ShowPerformance> showPerformanceList;
	private String plan_date;
	private String mode;

	@Override
	public int doEndTag() throws JspException {

		StringBuffer sb = new StringBuffer();

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		String toDay = format.format(calendar.getTime());
		if (mode.equals("admin")) {
			for (int i = 0; i < showPerformanceList.size(); i++) {
				ShowPerformance showPerformance = showPerformanceList.get(i);
				String planMonth = plan_date.substring(0, 7);
				String startMonth = showPerformance.getStart_date().substring(0, 7);
				String endMonth = showPerformance.getEnd_date().substring(0, 7);
				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-") + 1));
				int startDay = Integer.parseInt(showPerformance.getStart_date().substring(showPerformance.getStart_date().lastIndexOf("-") + 1));
				int endDay = Integer.parseInt(showPerformance.getEnd_date().substring(showPerformance.getEnd_date().lastIndexOf("-") + 1));

				int calendarDay = Integer.parseInt(plan_date.replaceAll("-", ""));
				int to_day = Integer.parseInt(toDay);
				
				if (planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					if (planDay >= startDay && planDay <= 31) {
						sb.append("<input type='checkbox' name='showPerformance_idx_arr' value='" + showPerformance.getShowPerformance_idx() + "'>");
						sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
						/*sb.append("[" + showPerformance.getCode_name() + "]<br>");*/
						sb.append("" + showPerformance.getStart_time() + "" + "~" + "" + showPerformance.getEnd_time() + "<br>");
						
						if (showPerformance.getApply_yn().equals("Y")) {
							if (calendarDay >= to_day) {
								sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
								/*sb.append("<a href=\"#\" class=\"btn btn4\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">비회원신청</span></a><br>");*/
							} else {
								sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
							}
						} else if (showPerformance.getApply_yn().equals("N")) {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
						if (plan_date.equals(showPerformance.getStart_date())) {
							sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + showPerformance.getShowPerformance_idx() + "\" id=\"check_apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + showPerformance.getApply_count() + ")</span></a>");
						}
						sb.append("<ul class=\"schedule\">");
						sb.append("</ul>");
					}
				} else if (planDay >= startDay && planDay <= endDay) {
					sb.append("<input type='checkbox' name='showPerformance_idx_arr' value='"+showPerformance.getShowPerformance_idx()+"'>");
					sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
					/*sb.append("[" + showPerformance.getCode_name() + "]<br>");*/
					sb.append("" + showPerformance.getStart_time() + "" + "~" + "" + showPerformance.getEnd_time() + "<br>");
					
					if (showPerformance.getApply_yn().equals("Y")) {
						if (calendarDay >= to_day) {
							sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
							/*sb.append("<a href=\"#\" class=\"btn btn4\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">비회원신청</span></a><br>");*/
						} else {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
					} else if (showPerformance.getApply_yn().equals("N")) {
						sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
					}
					if (plan_date.equals(showPerformance.getStart_date())) {
						sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + showPerformance.getShowPerformance_idx() + "\" id=\"check_apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + showPerformance.getApply_count() + ")</span></a>");
					}
					sb.append("<ul class=\"schedule\">");
					sb.append("</ul>");
				} else if (!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					if (planDay >= 1 && planDay <= endDay) {
						sb.append("<input type='checkbox' name='showPerformance_idx_arr' value='"+showPerformance.getShowPerformance_idx()+"'>");
						sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
						/*sb.append("[" + showPerformance.getCode_name() + "]<br>");*/
						sb.append("" + showPerformance.getStart_time() + "" + "~" + "" + showPerformance.getEnd_time() + "<br>");
						if (showPerformance.getApply_yn().equals("Y")) {
							if (calendarDay >= to_day) {
								sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
								/*sb.append("<a href=\"#\" class=\"btn btn4\" id=\"noMemberApply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">비회원신청</span></a><br>");*/
							} else {
								sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
							}
						} else if (showPerformance.getApply_yn().equals("N")) {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
						if (plan_date.equals(showPerformance.getStart_date())) {
							sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + showPerformance.getShowPerformance_idx() + "\" id=\"check_apply\" keyValue=\"" + showPerformance.getShowPerformance_idx() + "\" keyValue2=\"" + showPerformance.getStart_date() + "\" keyValue3=\"" + showPerformance.getStart_time() + "\" keyValue4=\"" + showPerformance.getEnd_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + showPerformance.getApply_count() + ")</span></a>");
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

}
