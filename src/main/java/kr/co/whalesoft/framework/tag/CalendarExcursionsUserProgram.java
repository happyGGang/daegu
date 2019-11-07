package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.lang.time.DateUtils;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.excursions.Excursions;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;

public class CalendarExcursionsUserProgram extends BodyTagSupport {
	
	private static final long serialVersionUID = 1L;
	
	private List<Excursions> excursionsList;
	private List<CalendarManage> calendarManageList;
	private List<Apply> applyList;
	private int countApply;
	private String plan_date;
	private String mode;

	@Override
	public int doEndTag() throws JspException{
		StringBuffer sb = new StringBuffer();
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Date planDate = null;
        try {
			planDate = sf.parse(plan_date);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
		if (mode.equals("admin")) {
			for(int i=0; i<excursionsList.size(); i++) {
				Excursions excursions = excursionsList.get(i);
				String planMonth = plan_date.substring(0,7);
				String startMonth = excursions.getStart_date().substring(0,7);
				String endMonth = excursions.getEnd_date().substring(0,7);
				
				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
				int startDay = Integer.parseInt(excursions.getStart_date().substring(excursions.getStart_date().lastIndexOf("-")+1));
				int endDay = Integer.parseInt(excursions.getEnd_date().substring(excursions.getEnd_date().lastIndexOf("-")+1));
				
				Date now = new Date();
				
				//int toDay = 0;/*Integer.parseInt(toDate.substring(toDate.lastIndexOf("-")+1));*/
				
				int maxApplyCount = excursions.getMax_apply();
				int curApplyCount = excursions.getApply_count();
				
				if(planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
					sb.append("<li title=\""+excursions.getCode_name()+"\">");																								
					sb.append("["+excursions.getCode_name()+"]<br>");
					sb.append(""+ excursions.getStart_time()+""+"~"+""+excursions.getEnd_time()+"<br>");
					
					boolean flag = true; 
					for(int j=0;  j < applyList.size(); j++) {
						Apply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-")+1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-")+1));

						if(apply.getExcursions_idx() == excursions.getExcursions_idx()) {
							if(planDay >= startReqDay && planDay <= endReqDay) {
								if(apply.getApply_state().equals("3")) {
									sb.append("<span class=\"type-r\"><i></i><em>승인완료("+apply.getAgency_name()+")</em></span><br>");
								} else if(apply.getApply_state().equals("2")) {
									sb.append("<span class=\"type-e\"><i></i><em>승인불가("+apply.getAgency_name()+")</em></span><br>");
								} else if(apply.getApply_state().equals("1")) {
									sb.append("<span class=\"type-h\"><i></i><em>승인대기("+apply.getAgency_name()+")</em></span><br>");
								}
								flag = false;
							}
						} 
					}
					if ( flag ) {
						if(excursions.getApply_yn().equals("Y") && excursions.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if ( maxApplyCount == 0 ) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\""+excursions.getExcursions_idx()+"\" keyValue2=\""+plan_date+"\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");	
							}
							else {
								if ( maxApplyCount > curApplyCount ) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\""+excursions.getExcursions_idx()+"\" keyValue2=\""+plan_date+"\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");	
								}
								else {
									sb.append("<a href=\"#\">신청 정원 마감</a>");
								}
							}
						}
					}
					sb.append("</li>");
				} else if (planDay >= startDay && planDay <= endDay) {
					sb.append("<li title=\""+excursions.getCode_name()+"\">");																								
					sb.append("["+excursions.getCode_name()+"]<br>");
					sb.append(""+ excursions.getStart_time()+""+"~"+""+excursions.getEnd_time()+"<br>");
					
					boolean flag = true; 
					for(int j=0;  j < applyList.size(); j++) {
						Apply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-")+1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-")+1));

						if(apply.getExcursions_idx() == excursions.getExcursions_idx()) {
							if(planDay >= startReqDay && planDay <= endReqDay) {
								if(apply.getApply_state().equals("3")) {
									sb.append("<span class=\"type-r\"><i></i><em>승인완료("+apply.getAgency_name()+")</em></span><br>");
								} else if(apply.getApply_state().equals("2")) {
									sb.append("<span class=\"type-e\"><i></i><em>승인불가("+apply.getAgency_name()+")</em></span><br>");
								} else if(apply.getApply_state().equals("1")) {
									sb.append("<span class=\"type-h\"><i></i><em>승인대기("+apply.getAgency_name()+")</em></span><br>");
								}
								flag = false;
							}
						} 
					}
					if ( flag ) {
						if(excursions.getApply_yn().equals("Y") && excursions.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if ( maxApplyCount == 0 ) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\""+excursions.getExcursions_idx()+"\" keyValue2=\""+plan_date+"\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");	
							}
							else {
								if ( maxApplyCount > curApplyCount ) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\""+excursions.getExcursions_idx()+"\" keyValue2=\""+plan_date+"\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");	
								}
								else {
									sb.append("<a href=\"#\">신청 정원 마감</a>");
								}
							}
						}
					}
					sb.append("</li>");
				} else if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
					sb.append("<li title=\""+excursions.getCode_name()+"\">");																								
					sb.append("["+excursions.getCode_name()+"]<br>");
					sb.append(""+ excursions.getStart_time()+""+"~"+""+excursions.getEnd_time()+"<br>");
					
					boolean flag = true; 
					for(int j=0;  j < applyList.size(); j++) {
						Apply apply = applyList.get(j);
						int startReqDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-")+1));
						int endReqDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-")+1));

						if(apply.getExcursions_idx() == excursions.getExcursions_idx()) {
							if(planDay >= startReqDay && planDay <= endReqDay) {
								if(apply.getApply_state().equals("3")) {
									sb.append("<span class=\"type-r\"><i></i><em>승인완료("+apply.getAgency_name()+")</em></span><br>");
								} else if(apply.getApply_state().equals("2")) {
									sb.append("<span class=\"type-e\"><i></i><em>승인불가("+apply.getAgency_name()+")</em></span><br>");
								} else if(apply.getApply_state().equals("1")) {
									sb.append("<span class=\"type-h\"><i></i><em>승인대기("+apply.getAgency_name()+")</em></span><br>");
								}
								flag = false;
							}
						} 
					}
					if ( flag ) {
						if(excursions.getApply_yn().equals("Y") && excursions.getClosed_day() == 0 && (now.compareTo(planDate) <= 0 || DateUtils.isSameDay(now, planDate))) {
							if ( maxApplyCount == 0 ) {
								sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\""+excursions.getExcursions_idx()+"\" keyValue2=\""+plan_date+"\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");	
							}
							else {
								if ( maxApplyCount > curApplyCount ) {
									sb.append("<a href=\"\" class=\"\" id=\"apply\" keyValue=\""+excursions.getExcursions_idx()+"\" keyValue2=\""+plan_date+"\"><span style=\"type-r\"><i></i><em>신청하기</em></span></a><br>");	
								}
								else {
									sb.append("<a href=\"#\">신청 정원 마감</a>");
								}
							}
						}
					}
					sb.append("</li>");
				}
			}
			
			//도서관일정
			for(int i=0; i<calendarManageList.size(); i++) {
				CalendarManage cm = calendarManageList.get(i);
				String planMonth = plan_date.substring(0,7);
				String startMonth = cm.getStart_date().substring(0,7);
				String endMonth = cm.getEnd_date().substring(0,7);
				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
				int startDay = Integer.parseInt(cm.getStart_date().substring(cm.getStart_date().lastIndexOf("-")+1));
				int endDay = Integer.parseInt(cm.getEnd_date().substring(cm.getEnd_date().lastIndexOf("-")+1));
					if(planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
						if(planDay >= startDay && planDay <= 31) {
							if(cm.getDate_type().equals("1")) {
								sb.append("<li title=\""+cm.getTitle()+"\">");
								sb.append("<span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span>");
								sb.append("</li>");
							} else {
								sb.append("<li title=\""+cm.getTitle()+"\">");
								sb.append("<span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span>");
								sb.append("</li>");
							}
						}
					}					
					if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
						if(planDay >= 1 && planDay <= endDay) {
							if(cm.getDate_type().equals("1")) {
								sb.append("<li title=\""+cm.getTitle()+"\">");
								sb.append("<span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span>");
								sb.append("</li>");
							} else {
								sb.append("<li title=\""+cm.getTitle()+"\">");
								sb.append("<span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span>");
								sb.append("</li>");
							}
						}
					}
					if (planDay >= startDay && planDay <= endDay) {
						if(cm.getDate_type().equals("1")) {
							sb.append("<li title=\""+cm.getTitle()+"\">");
							sb.append("<span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span>");
							sb.append("</li>");
						} else {
							sb.append("<li title=\""+cm.getTitle()+"\">");
							sb.append("<span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span>");
							sb.append("</li>");
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

	public List<Excursions> getExcursionsList() {
		if(excursionsList != null) {
			List<Excursions> arrayList = new ArrayList<Excursions>();
			arrayList.addAll(this.excursionsList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setExcursionsList(List<Excursions> excursionsList) {
		if(excursionsList != null) {
			this.excursionsList = new ArrayList<Excursions>();
			this.excursionsList.addAll(excursionsList);
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

	public int getCountApply() {
		return countApply;
	}

	public void setCountApply(int countApply) {
		this.countApply = countApply;
	}

	public List<Apply> getApplyList() {
		if(applyList != null) {
			List<Apply> arrayList = new ArrayList<Apply>();
			arrayList.addAll(this.applyList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setApplyList(List<Apply> applyList) {
		if(applyList != null) {
			this.applyList = new ArrayList<Apply>();
			this.applyList.addAll(applyList);
		}
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

}
