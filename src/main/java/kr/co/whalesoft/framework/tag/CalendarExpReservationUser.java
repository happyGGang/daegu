package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.go.gbelib.app.cms.module.expReservation.ExpReservation;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApply;

public class CalendarExpReservationUser extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<ExpReservation> expReservationList;
	private List<CalendarManage> calendarManageList;
	private List<ExpReservationApply> expApplyList;
	private String plan_date;
	private String mode;

	@Override
	public int doEndTag() throws JspException {

		StringBuffer sb = new StringBuffer();
		
		if (expReservationList != null && expReservationList.size() > 0) {
			for (int i = 0; i < expReservationList.size(); i++) {
				ExpReservation exp = expReservationList.get(i);
				String today = plan_date.replaceAll("-", "");
				
				Date planDate = null;
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				try {
					planDate = sf.parse(exp.getReservation_date());
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				Date now = new Date();
				int aTagAddResult = 0;
				
				if ( today.equals(exp.getReservation_date())) {
					sb.append("<li title=\"" + exp.getProgram_name() + "\">");
					sb.append("<span Style=\"font-weight: bold;\">" + exp.getProgram_name() + "</span><br/>");
					sb.append(exp.getUse_time() + "<br/>");
					if(exp.getMember_yn().equals("Y")) {
						sb.append("비회원 신청가능" + "<br/>");
					}
					if(now.compareTo(planDate) < 0) { //현재 날짜가 프로그램 날짜보다 이후면
						if(expApplyList != null && expApplyList.size() > 0) { //사용자 신청 리스트가 있으면
							for(int j = 0; j < expApplyList.size(); j++) {
								ExpReservationApply expApply = expApplyList.get(j);
								if(expApply.getReservation_date().equals(exp.getReservation_date())) {
									sb.append("<a href=\"#\" class=\"btn btn3\" id=\"apply_edit\" keyValue=\"" + exp.getProgram_list_idx() + "\" keyValue2=\"" + exp.getReservation_date() + "\"><span>신청완료</span></a>");
									aTagAddResult += 1; //해당 프로그램에 로그인한 사용자가 등록되어있음
								}
							}
						}
						if(exp.getReservation_type().equals("team")) {
							if(exp.getEnable_number_of_team() <= exp.getApply_count()) {
								if(aTagAddResult == 0) { //로그인한 사용자가 등록되어있지 않음
									sb.append("<span class=\"btn btn5\">정원마감</span>");
								}
							}else {
								if(exp.getTotal_people() <= exp.getApply_people_count()) {
									if(aTagAddResult == 0) {
										sb.append("<span class=\"btn btn5\">정원마감</span>");
									}
								}else {
									if(aTagAddResult == 0) {
										sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + exp.getProgram_list_idx() + "\" keyValue2=\"" + exp.getReservation_date() + "\"><span>신청</span></a>");
									}
								}
							}
						}else if(exp.getReservation_type().equals("individual")) {
							if(expApplyList != null && expApplyList.size() > 0) {
								for(int j = 0; j < expApplyList.size(); j++) {
									ExpReservationApply expApply = expApplyList.get(j);
									if(expApply.getReservation_date().equals(exp.getReservation_date())) {
										sb.append("<a href=\"#\" class=\"btn btn3\" id=\"apply_edit\" keyValue=\"" + exp.getProgram_list_idx() + "\" keyValue2=\"" + exp.getReservation_date() + "\"><span>신청완료</span></a>");
										aTagAddResult += 1;
									}
								}
							}
							if(exp.getTotal_people() <= exp.getApply_count()) {
								if(aTagAddResult == 0) {
									sb.append("<span class=\"btn btn5\">정원마감</span>");
								}
							}else {
								if(expApplyList != null && expApplyList.size() > 0) {
									if(aTagAddResult == 0) {
										sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + exp.getProgram_list_idx() + "\" keyValue2=\"" + exp.getReservation_date() + "\"><span>신청</span></a>");
									}
								}
							}
						}
						
					} else {
						sb.append("<span class=\"btn btn5\">신청마감</span>");
					}
					
					sb.append("</li><br/>");
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
	public List<ExpReservation> getExpReservationList() {
		if (expReservationList != null) {
			List<ExpReservation> arrayList = new ArrayList<ExpReservation>();
			arrayList.addAll(this.expReservationList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setExpReservationList(List<ExpReservation> expReservationList) {
		if (expReservationList != null) {
			this.expReservationList = new ArrayList<ExpReservation>();
			this.expReservationList.addAll(expReservationList);
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

	public List<ExpReservationApply> getExpApplyList() {
		if (expApplyList != null) {
			List<ExpReservationApply> arrayList = new ArrayList<ExpReservationApply>();
			arrayList.addAll(this.expApplyList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setExpApplyList(List<ExpReservationApply> expApplyList) {
		if (expApplyList != null) {
			this.expApplyList = new ArrayList<ExpReservationApply>();
			this.expApplyList.addAll(expApplyList);
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
