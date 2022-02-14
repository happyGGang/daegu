package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import kr.co.whalesoft.app.cms.module.mediaFactory.MediaFactory;

public class CalendarMediaFactoryProgram extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<MediaFactory> mediaFactoryList;
	private String plan_date;
	private String mode;

	@Override
	public int doEndTag() throws JspException {

		StringBuffer sb = new StringBuffer();

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		String toDay = format.format(calendar.getTime());
		if (mode.equals("admin")) {
			for (int i = 0; i < mediaFactoryList.size(); i++) {
				MediaFactory mediaFactory = mediaFactoryList.get(i);
				String planMonth = plan_date.substring(0, 7);
				String startMonth = mediaFactory.getStart_date().substring(0, 7);
				String endMonth = mediaFactory.getEnd_date().substring(0, 7);
				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-") + 1));
				int startDay = Integer.parseInt(mediaFactory.getStart_date().substring(mediaFactory.getStart_date().lastIndexOf("-") + 1));
				int endDay = Integer.parseInt(mediaFactory.getEnd_date().substring(mediaFactory.getEnd_date().lastIndexOf("-") + 1));

				int calendarDay = Integer.parseInt(plan_date.replaceAll("-", ""));
				int to_day = Integer.parseInt(toDay);
				String use_time = "";
				if("am".equals(mediaFactory.getUse_time())) {
					use_time = "오전";
				}else if("pm".equals(mediaFactory.getUse_time())) {
					use_time = "오후";
				}

				if (planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					if (planDay >= startDay && planDay <= 31) {
						sb.append("<input type='checkbox' name='mediaFactory_idx_arr' value='"+mediaFactory.getMediaFactory_idx()+"'>");
						sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
						sb.append("[" + mediaFactory.getCode_name() + "]<br>");
						sb.append("" + use_time + "<br>");
						if (mediaFactory.getApply_yn().equals("Y")) {
							if (calendarDay >= to_day) {
								sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + mediaFactory.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
							} else {
								sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
							}
						} else if (mediaFactory.getApply_yn().equals("N")) {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
						if (plan_date.equals(mediaFactory.getStart_date())) {
							sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + mediaFactory.getMediaFactory_idx() + "\" id=\"check_apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + mediaFactory.getStart_date() + "\" keyValue3=\"" + mediaFactory.getUse_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + mediaFactory.getApply_count() + ")</span></a>");
						}
						sb.append("<ul class=\"schedule\">");
						sb.append("</ul>");
					}
				} else if (planDay >= startDay && planDay <= endDay) {
					sb.append("<input type='checkbox' name='mediaFactory_idx_arr' value='"+mediaFactory.getMediaFactory_idx()+"'>");
					sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
					sb.append("[" + mediaFactory.getCode_name() + "]<br>");
					sb.append("" + use_time + "<br>");
					if (mediaFactory.getApply_yn().equals("Y")) {
						if (calendarDay >= to_day) {
							sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + mediaFactory.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
						} else {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
					} else if (mediaFactory.getApply_yn().equals("N")) {
						sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
					}
					if (plan_date.equals(mediaFactory.getStart_date())) {
						sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + mediaFactory.getMediaFactory_idx() + "\" id=\"check_apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + mediaFactory.getStart_date() +  "\" keyValue3=\"" + mediaFactory.getUse_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + mediaFactory.getApply_count() + ")</span></a>");
					}
					sb.append("<ul class=\"schedule\">");
					sb.append("</ul>");
				} else if (!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					if (planDay >= 1 && planDay <= endDay) {
						sb.append("<input type='checkbox' name='mediaFactory_idx_arr' value='"+mediaFactory.getMediaFactory_idx()+"'>");
						sb.append("<a href=\"#\" class=\"btn btn1 modify\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\"><span style=\"margin-left : 5px; font-size:13px;\">수정</span></a><br>");
						sb.append("[" + mediaFactory.getCode_name() + "]<br>");
						sb.append("" + use_time + "<br>");
						if (mediaFactory.getApply_yn().equals("Y")) {
							if (calendarDay >= to_day) {
								sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + mediaFactory.getStart_date() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청하기</span></a><br>");
							} else {
								sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
							}
						} else if (mediaFactory.getApply_yn().equals("N")) {
							sb.append("<a href=\"#\" class=\"btn btn5\"><span style=\"margin-left : 5px; font-size:13px;\">신청불가</span></a><br>");
						}
						if (plan_date.equals(mediaFactory.getStart_date())) {
							sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + mediaFactory.getMediaFactory_idx() + "\" id=\"check_apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + mediaFactory.getStart_date() +  "\" keyValue3=\"" + mediaFactory.getUse_time() + "\"><span style=\"margin-left : 5px; font-size:13px;\">신청자확인(" + mediaFactory.getApply_count() + ")</span></a>");
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

	public List<MediaFactory> getMediaFactoryList() {
		if (mediaFactoryList != null) {
			List<MediaFactory> arrayList = new ArrayList<MediaFactory>();
			arrayList.addAll(this.mediaFactoryList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setMediaFactoryList(List<MediaFactory> mediaFactoryList) {
		if (mediaFactoryList != null) {
			this.mediaFactoryList = new ArrayList<MediaFactory>();
			this.mediaFactoryList.addAll(mediaFactoryList);
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
