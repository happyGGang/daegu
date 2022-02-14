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
import kr.co.whalesoft.app.cms.module.mediaFactory.MediaFactory;
import kr.co.whalesoft.app.cms.module.mediaFactory.apply.MediaFactoryApply;

public class CalendarMediaFactoryUserProgram extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<MediaFactory> mediaFactoryList;
	private List<CalendarManage> calendarManageList;
	private List<MediaFactoryApply> applyList;
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
			for (int i = 0; i < mediaFactoryList.size(); i++) {
				MediaFactory mediaFactory = mediaFactoryList.get(i);
				String planMonth = plan_date.substring(0, 7);
				String startMonth = mediaFactory.getStart_date().substring(0, 7);
				String endMonth = mediaFactory.getEnd_date().substring(0, 7);

				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-") + 1));
				int startDay = Integer.parseInt(mediaFactory.getStart_date().substring(mediaFactory.getStart_date().lastIndexOf("-") + 1));
				int endDay = Integer.parseInt(mediaFactory.getEnd_date().substring(mediaFactory.getEnd_date().lastIndexOf("-") + 1));

				Date now = new Date();

				// int toDay = 0;/*Integer.parseInt(toDate.substring(toDate.lastIndexOf("-")+1));*/
				
				
				int maxApplyCount = mediaFactory.getMax_apply();
				int curApplyCount = mediaFactory.getApply_count();
				String use_time = "";
				if("am".equals(mediaFactory.getUse_time())) {
					use_time = "- 오전";
				}else if("pm".equals(mediaFactory.getUse_time())) {
					use_time = "- 오후";
				}

				if (planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					sb.append("<li title=\"" + mediaFactory.getCode_name() + "\">");
					sb.append("[" + mediaFactory.getCode_name() + "]<br>");
					sb.append("" + use_time + "<br>");

					boolean flag = true;
					for (int j = 0; j < applyList.size(); j++) {
						MediaFactoryApply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-") + 1));

						if (apply.getMediaFactory_idx() == mediaFactory.getMediaFactory_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if(member_id.equals(apply.getApplicant_member_id())) {
									if (apply.getApply_state().equals("3")) {
										sb.append("<span class=\"type-r\"><i></i><em><strong>승인완료</strong>(" + apply.getAgency_name() + ")</em></span><br>");
									} else if (apply.getApply_state().equals("2")) {
										sb.append("<span class=\"type-e\"><i></i><em>승인불가(" + apply.getAgency_name() + ")</em></span><br>");
									} else if (apply.getApply_state().equals("1")) {
										sb.append("<span class=\"type-h\"><i></i><em>승인대기(" + apply.getAgency_name() + ")</em></span><br>");
									}
									flag = false;
								}
							}
						}
					}
					if (flag) {
						if (mediaFactory.getApply_yn().equals("Y") && mediaFactory.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
								} else {
									sb.append("<a href=\"#\">신청 정원 마감</a>");
								}
							}
						}
					}
					sb.append("</li>");
				} else if (planDay >= startDay && planDay <= endDay) {
					sb.append("<li title=\"" + mediaFactory.getCode_name() + "\">");
					sb.append("[" + mediaFactory.getCode_name() + "]<br>");
					sb.append("" + use_time + "<br>");

					boolean flag = true;
					for (int j = 0; j < applyList.size(); j++) {
						MediaFactoryApply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-") + 1));

						if (apply.getMediaFactory_idx() == mediaFactory.getMediaFactory_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if(member_id.equals(apply.getApplicant_member_id())) {
									if (apply.getApply_state().equals("3")) {
										sb.append("<span class=\"type-r\"><i></i><em><strong>승인완료</strong>(" + apply.getAgency_name() + ")</em></span><br>");
									} else if (apply.getApply_state().equals("2")) {
										sb.append("<span class=\"type-e\"><i></i><em>승인불가(" + apply.getAgency_name() + ")</em></span><br>");
									} else if (apply.getApply_state().equals("1")) {
										sb.append("<span class=\"type-h\"><i></i><em>승인대기(" + apply.getAgency_name() + ")</em></span><br>");
									}
									flag = false;
								}
							}
						}
					}
					if (flag) {
						if (mediaFactory.getApply_yn().equals("Y") && mediaFactory.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
								} else {
									sb.append("<a href=\"#\">신청 정원 마감</a>");
								}
							}
						}
					}
					sb.append("</li>");
				} else if (!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					sb.append("<li title=\"" + mediaFactory.getCode_name() + "\">");
					sb.append("[" + mediaFactory.getCode_name() + "]<br>");
					sb.append("" + use_time + "<br>");

					boolean flag = true;
					for (int j = 0; j < applyList.size(); j++) {
						MediaFactoryApply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-") + 1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-") + 1));

						if (apply.getMediaFactory_idx() == mediaFactory.getMediaFactory_idx()) {
							if (planDay >= startReqDay && planDay <= endReqDay) {
								if(member_id.equals(apply.getApplicant_member_id())) {
									if (apply.getApply_state().equals("3")) {
										sb.append("<span class=\"type-r\"><i></i><em><strong>승인완료</strong>(" + apply.getAgency_name() + ")</em></span><br>");
									} else if (apply.getApply_state().equals("2")) {
										sb.append("<span class=\"type-e\"><i></i><em>승인불가(" + apply.getAgency_name() + ")</em></span><br>");
									} else if (apply.getApply_state().equals("1")) {
										sb.append("<span class=\"type-h\"><i></i><em>승인대기(" + apply.getAgency_name() + ")</em></span><br>");
									}
									flag = false;
								}
							}
						}
					}
					if (flag) {
						if (mediaFactory.getApply_yn().equals("Y") && mediaFactory.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if (maxApplyCount == 0) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
							} else {
								if (maxApplyCount > curApplyCount) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\"" + mediaFactory.getMediaFactory_idx() + "\" keyValue2=\"" + plan_date + "\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
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

	public List<MediaFactoryApply> getApplyList() {
		if (applyList != null) {
			List<MediaFactoryApply> arrayList = new ArrayList<MediaFactoryApply>();
			arrayList.addAll(this.applyList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setApplyList(List<MediaFactoryApply> applyList) {
		if (applyList != null) {
			this.applyList = new ArrayList<MediaFactoryApply>();
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

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

}
