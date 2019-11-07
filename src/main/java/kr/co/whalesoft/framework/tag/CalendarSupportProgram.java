package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.module.support.Support;

public class CalendarSupportProgram extends BodyTagSupport {
	
private static final long serialVersionUID = 1L;
	
	private List<Support> supportList;
	private String plan_date;
	private String mode;
	
	@Override
	public int doEndTag() throws JspException{
		
		StringBuffer sb = new StringBuffer();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();
        String toDay = format.format(calendar.getTime());
		
		if (mode.equals("admin")) {
			for(int i=0; i<supportList.size(); i++) {
				Support support = supportList.get(i);
				String planMonth = plan_date.substring(0,7);				
				String startMonth = support.getHope_req_dt().substring(0,7);
				String endMonth = support.getHope_req_dt().substring(0,7);
				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
				int startDay = Integer.parseInt(support.getHope_req_dt().substring(support.getHope_req_dt().lastIndexOf("-")+1));
				int endDay = Integer.parseInt(support.getHope_req_dt().substring(support.getHope_req_dt().lastIndexOf("-")+1));		
				
				int calendarDay = Integer.parseInt(plan_date.replaceAll("-", ""));
				int to_day = Integer.parseInt(toDay);
				
				if(planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					if(planDay >= startDay && planDay <= 31) {
						if(support.getProcess_state().equals("N")) {
							sb.append("<a href=\"#\" class=\"modify\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+support.getReq_name()+"</span></a><br>");
							sb.append("<a href=\"#\" class=\"btn btn1 result\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">접수</span></a>");
						} else {
							sb.append("<a href=\"javascript:alert('접수완료된 현장지원은 수정이 불가합니다.')\"><span style=\"margin-left : 5px; font-size:13px;\">"+support.getReq_name()+"</span></a><br>");
							sb.append("<a href=\"#\" class=\"btn btn2 result\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">완료</span></a>");
						}
						sb.append("<ul class=\"schedule\">");
						sb.append("</ul>");
					}
				} else if (planDay >= startDay && planDay <= endDay) {
					if(support.getProcess_state().equals("N")) {
						sb.append("<a href=\"#\" class=\"modify\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+support.getReq_name()+"</span></a><br>");
						sb.append("<a href=\"#\" class=\"btn btn1 result\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">접수</span></a>");
					} else {
						sb.append("<a href=\"javascript:alert('접수완료된 현장지원은 수정이 불가합니다.')\"><span style=\"margin-left : 5px; font-size:13px;\">"+support.getReq_name()+"</span></a><br>");
						sb.append("<a href=\"#\" class=\"btn btn2 result\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">완료</span></a>");
					}
					sb.append("<ul class=\"schedule\">");
					sb.append("</ul>");
				} else if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					if(planDay >= 1 && planDay <= endDay) {
						if(support.getProcess_state().equals("N")) {
							sb.append("<a href=\"#\" class=\"modify\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+support.getReq_name()+"</span></a><br>");
							sb.append("<a href=\"#\" class=\"btn btn1 result\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">접수</span></a>");
						} else {
							sb.append("<a href=\"javascript:alert('접수완료된 현장지원은 수정이 불가합니다.')\"><span style=\"margin-left : 5px; font-size:13px;\">"+support.getReq_name()+"</span></a><br>");
							sb.append("<a href=\"#\" class=\"btn btn2 result\" keyValue=\""+support.getSeq()+"\"><span style=\"margin-left : 5px; font-size:13px;\">완료</span></a>");
						}
						sb.append("<ul class=\"schedule\">");
						sb.append("</ul>");
					}
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
}
