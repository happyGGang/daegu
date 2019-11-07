package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.support.Support;
import kr.co.whalesoft.app.cms.module.supportManage.SupportManage;

public class CalendarSupportUserProgram extends BodyTagSupport {
	
	private static final long serialVersionUID = 1L;
	
	private List<Support> supportList;
	private List<CalendarManage> calendarManageList;
	private String memberid;
	private String plan_date;
	private String mode;
	
	private Map<String, SupportManage> supportManageRep;
	
	@Override
	public int doEndTag() throws JspException{
		
		StringBuffer sb = new StringBuffer();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();
        String toDay = format.format(calendar.getTime());
		
        int calendarDay = Integer.parseInt(plan_date.replaceAll("-", ""));
        int to_day = Integer.parseInt(toDay);
        int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
        
        Map<Integer, CalendarManage> closedDay = new HashMap<Integer, CalendarManage>();
        
		if (mode.equals("admin")) {
			for(int i=0; i<calendarManageList.size(); i++) {
				CalendarManage cm = calendarManageList.get(i);
//				String planMonth = plan_date.substring(0,7);
//				String startMonth = cm.getStart_date().substring(0,7);
//				String endMonth = cm.getEnd_date().substring(0,7);				
				int startDay = Integer.parseInt(cm.getStart_date().substring(cm.getStart_date().lastIndexOf("-")+1));
				int endDay = Integer.parseInt(cm.getEnd_date().substring(cm.getEnd_date().lastIndexOf("-")+1));
				
				if (planDay >= startDay && planDay <= endDay) {
					closedDay.put(planDay, cm);	
				}
			}
			
			//휴관일
			/*for(int i=0; i<calendarManageList.size(); i++) {
				CalendarManage cm = calendarManageList.get(i);
//				String planMonth = plan_date.substring(0,7);
//				String startMonth = cm.getStart_date().substring(0,7);
//				String endMonth = cm.getEnd_date().substring(0,7);				
				int startDay = Integer.parseInt(cm.getStart_date().substring(cm.getStart_date().lastIndexOf("-")+1));
				int endDay = Integer.parseInt(cm.getEnd_date().substring(cm.getEnd_date().lastIndexOf("-")+1));
				
				if (planDay >= startDay && planDay <= endDay) {
					closedDay.put(planDay, null);					
					if(cm.getDate_type().equals("1")) {
						sb.append("<li title=\""+cm.getTitle()+"\">");
						sb.append("<span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span>");
						sb.append("</li>");
					}
				}
			}*/
			
			if ( closedDay.containsKey(planDay) ) {
				if(closedDay.get(planDay).getDate_type().equals("1")) {
					sb.append("<li title=\""+closedDay.get(planDay).getTitle()+"\">");
					sb.append("<span class=\"type-e\"><i></i><em>"+closedDay.get(planDay).getTitle()+"</em></span>");
					sb.append("</li>");
				}
			}
			else {
				if ( getSupportManageRep().containsKey(plan_date) ) {
					sb.append("<li>");
					sb.append("<a href=\"#\" class=\"\" id=\"add\" keyValue=\""+plan_date+"\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");
					sb.append("<li>");	
				}
			}
			
			for(int i=0; i<supportList.size(); i++) {
				Support support = supportList.get(i);
				String planMonth = plan_date.substring(0,7);				
				String startMonth = support.getHope_req_dt().substring(0,7);
				String endMonth = support.getHope_req_dt().substring(0,7);				
				int startDay = Integer.parseInt(support.getHope_req_dt().substring(support.getHope_req_dt().lastIndexOf("-")+1));
				int endDay = Integer.parseInt(support.getHope_req_dt().substring(support.getHope_req_dt().lastIndexOf("-")+1));		
				
				if (planDay >= startDay && planDay <= endDay) {
					sb.append("<li title=\""+support.getReq_name()+"\">");
					sb.append(support.getReq_name());
					sb.append("</br>");
					if(support.getReq_id().equals(memberid)) {
						if(support.getClosed_day() == 0) {
							if(support.getProcess_state().equals("Y")) {
								sb.append("<a href=\"\" class=\"\" id=\"result\" keyValue=\""+support.getSeq()+"\"><span class=\"type-r\"><i></i><em>신청완료("+support.getRequer_name()+")</em></span></a><br>");
							} else if(support.getProcess_state().equals("N")) {
								sb.append("<a href=\"\" class=\"\" id=\"modify\" keyValue=\""+support.getSeq()+"\"><span class=\"type-h\"><i></i><em>승인접수("+support.getRequer_name()+")</em></span></a><br>");
							}
						} else {
							sb.append("<span class=\"type-e\"><i></i><em>신청불가</em></span><br>");
						}
					}
					
					sb.append("</li>");
				}
			}
		}
		
		try {
			pageContext.getOut().println(sb.toString());
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		
		return EVAL_PAGE;
	}
	
	public List<Support> getSupportList() {
		if(supportList != null) {
			List<Support> arrayList = new ArrayList<Support>();
			arrayList.addAll(this.supportList);
			return arrayList;
		} else {
			return null;
		}
	}
	public void setSupportList(List<Support> supportList) {
		if(supportList != null) {
			this.supportList = new ArrayList<Support>();
			this.supportList.addAll(supportList);
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
	public List<CalendarManage> getCalendarManageList() {
		if(calendarManageList != null) {
			List<CalendarManage> arrayList = new ArrayList<CalendarManage>();
			arrayList.addAll(this.calendarManageList);
			return arrayList;
		} else {
			return null;
		}
	}
	public void setCalendarManageList(List<CalendarManage> calendarManageList) {
		if(calendarManageList != null) {
			this.calendarManageList = new ArrayList<CalendarManage>();
			this.calendarManageList.addAll(calendarManageList);
		}
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public Map<String, SupportManage> getSupportManageRep() {
		return supportManageRep;
	}

	public void setSupportManageRep(Map<String, SupportManage> supportManageRep) {
		this.supportManageRep = supportManageRep;
	}
	

}
