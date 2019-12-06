package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.apache.commons.lang.StringUtils;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReq;
import kr.go.gbelib.app.cms.module.teach.Teach;

public class CalendarManageProgram extends BodyTagSupport {
	
	private static final long serialVersionUID = 1L;
	
	private List<CalendarManage> calendarManageList;
	private List<Teach> teachList;
	private List<Apply> okApplyList;
	private String plan_date;
	private List<FacilityReq> facilityReqList;
	private List<Board> moveList;
	private String	mode;
	private int dayCode;
	
	@Override
	public int doEndTag() throws JspException {
		
		StringBuffer sb = new StringBuffer();
		boolean isHolyDay = false;
		if (mode.equals("admin")) {
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
							sb.append("<a href=\"#\" class=\"modify\" type=\"calendar\" keyValue=\""+cm.getCm_idx()+"\" keyValue2=\""+cm.getDate_type()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+cm.getTitle()+"</span></a>");
							sb.append("<ul class=\"schedule\">");
							sb.append("</ul>");
							isHolyDay = StringUtils.equals(cm.getDate_type(), "1");//휴관일로 지정된 경우
						}
						
					}
					if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
						if(planDay >= 1 && planDay <= endDay) {
							sb.append("<a href=\"#\" class=\"modify\" type=\"calendar\" keyValue=\""+cm.getCm_idx()+"\" keyValue2=\""+cm.getDate_type()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+cm.getTitle()+"</span></a>");
							sb.append("<ul class=\"schedule\">");
							sb.append("</ul>");
							isHolyDay = StringUtils.equals(cm.getDate_type(), "1");//휴관일로 지정된 경우
						}
					}
					if (planDay >= startDay && planDay <= endDay) {
						sb.append("<a href=\"#\" class=\"modify\" type=\"calendar\" keyValue=\""+cm.getCm_idx()+"\" keyValue2=\""+cm.getDate_type()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+cm.getTitle()+"</span></a>");
						sb.append("<ul class=\"schedule\">");
						sb.append("</ul>");
						isHolyDay = StringUtils.equals(cm.getDate_type(), "1");//휴관일로 지정된 경우
					} 
				
			}
		
			if (!isHolyDay) {
				//도서관 견학
				if(okApplyList != null) {
    				for(int i=0; i<okApplyList.size(); i++) {
    					Apply apply = okApplyList.get(i);
    					String planMonth = plan_date.substring(0,7);
    					String startMonth = apply.getStart_date().substring(0,7);
    					String endMonth = apply.getEnd_date().substring(0,7);
    					int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
    					int startDay = Integer.parseInt(apply.getStart_date().substring(apply.getStart_date().lastIndexOf("-")+1));
    					int endDay = Integer.parseInt(apply.getEnd_date().substring(apply.getEnd_date().lastIndexOf("-")+1));
    					if(planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
    						if(planDay >= startDay && planDay <= 31) {
    							sb.append("<a href=\"#\" class=\"modify\" type=\"excursions\" keyValue=\""+apply.getApply_id()+"\" keyValue2=\""+apply.getExcursions_idx()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+apply.getAgency_name()+"(도서관 견학)</span></a>");
    							sb.append("<ul class=\"schedule\">");
    							sb.append("</ul>");
    						}
    					}
    					if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
    						if(planDay >= 1 && planDay <= endDay) {
    							sb.append("<a href=\"#\" class=\"modify\" type=\"excursions\" keyValue=\""+apply.getApply_id()+"\" keyValue2=\""+apply.getExcursions_idx()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+apply.getAgency_name()+"(도서관 견학)</span></a>");
    							sb.append("<ul class=\"schedule\">");
    							sb.append("</ul>");
    						}
    					}
    					if (planDay >= startDay && planDay <= endDay) {
    						sb.append("<a href=\"#\" class=\"modify\" type=\"excursions\" keyValue=\""+apply.getExcursions_idx()+"\" keyValue2=\""+apply.getStart_date()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+apply.getAgency_name()+"(도서관 견학)</span></a>");
    						sb.append("<ul class=\"schedule\">");
    						sb.append("</ul>");
    					} 
    					
    				}
				}
				//강좌
				if(teachList != null) {
    				for(int i=0; i<teachList.size(); i++) {
    					Teach teach = teachList.get(i);
    					String start_date = teach.getStart_date();
    					String end_date = teach.getEnd_date();
    					/*String planMonth = plan_date.substring(0,7);
    				String startMonth = teach.getStart_date().substring(0,7);
    				String endMonth = teach.getEnd_date().substring(0,7);
    				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
    				int startDay = Integer.parseInt(teach.getStart_date().substring(teach.getStart_date().lastIndexOf("-")+1));
    				int endDay = Integer.parseInt(teach.getEnd_date().substring(teach.getEnd_date().lastIndexOf("-")+1));*/
    					
    					for (String day : teach.getTeach_day_arr()) {
    						if ( dayCode == Integer.parseInt(day) ) {
    							if (start_date.compareTo(plan_date) <= 0 && end_date.compareTo(plan_date) >= 0) {
    								String statusName = "[강좌]";
    								
    								if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
    									for ( String holiday : teach.getHolidays() ) {
    										if (StringUtils.equals(plan_date, holiday)) {
    											statusName = "[휴강]";
    										}
    									}
    								}
    								
    								
    								sb.append("<a href=\"#\" class=\"modify\" type=\"teach\" keyValue3=\"" + teach.getGroup_idx()+"\" keyValue=\""+teach.getCategory_idx()+"\" keyValue2=\""+teach.getTeach_idx()+"\"><span style=\"margin-left : 5px; font-size:13px;\">"+statusName+""+teach.getTeach_name()+"</span></a>");
    								sb.append("<ul class=\"schedule\">");
    								sb.append("</ul>");	
    							}
    							
    							/*if((planMonth.equals(startMonth) && !planMonth.equals(endMonth)) && (!planMonth.equals(startMonth) && planMonth.equals(endMonth))) {
    							if(planDay >= startDay && planDay <= 31) {
    								sb.append("<a href=\"#\" class=\"modify\"><span style=\"margin-left : 5px; font-size:13px;\">"+teach.getTeach_name()+"(강좌)</span></a>");
    								sb.append("<ul class=\"schedule\">");
    								sb.append("</ul>");	
    							}
    							else if (planDay >= startDay && planDay <= endDay) {
    								sb.append("<a href=\"#\" class=\"modify\"><span style=\"margin-left : 5px; font-size:13px;\">"+teach.getTeach_name()+"(강좌)</span></a>");
    								sb.append("<ul class=\"schedule\">");
    								sb.append("</ul>");
    							} 
    						} else if (!planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
    							if (planDay >= 1 && planDay <= 31) {
    								sb.append("<a href=\"#\" class=\"modify\"><span style=\"margin-left : 5px; font-size:13px;\">"+teach.getTeach_name()+"(강좌)</span></a>");
    								sb.append("<ul class=\"schedule\">");
    								sb.append("</ul>");
    							}
    						}
    						else {
    							if(planDay >= startDay && planDay <= endDay) {
    								sb.append("<a href=\"#\" class=\"modify\"><span style=\"margin-left : 5px; font-size:13px;\">"+teach.getTeach_name()+"(강좌)</span></a>");
    								sb.append("<ul class=\"schedule\">");
    								sb.append("</ul>");
    							}
    						}*/
    						}
    					}
    				}
				}
				
				//시설물 이용 내역
				if(facilityReqList != null) {
    				for(int i=0; i<facilityReqList.size(); i++) {
    					FacilityReq facilityReq = facilityReqList.get(i);
    					
    					if ( plan_date.equals(facilityReq.getUse_date()) ) {
    						sb.append("<a href=\"#\" type=\"facility\"><span style=\"margin-left : 5px; font-size:13px;\">"+facilityReq.getFacility_name()+"("+facilityReq.getApply_name()+")"+"</span></a>");
    						sb.append("<ul class=\"schedule\">");
    						sb.append("</ul>");	
    					}
    					
    					/*int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
    				int startDay = Integer.parseInt(facilityReq.getStart_date().substring(facilityReq.getStart_date().lastIndexOf("-")+1));
    				int endDay = Integer.parseInt(facilityReq.getEnd_date().substring(facilityReq.getEnd_date().lastIndexOf("-")+1));
    				
    				if(planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
    					if(planDay >= startDay && planDay <= 31) {
    						sb.append("<a href=\"#\" type=\"facility\"><span style=\"margin-left : 5px; font-size:13px;\">"+facilityReq.getFacility_name()+"("+facilityReq.getReq_name()+")"+"</span></a>");
    						sb.append("<ul class=\"schedule\">");
    						sb.append("</ul>");
    					}
    				}
    				if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
    					if(planDay >= 1 && planDay <= endDay) {
    						sb.append("<a href=\"#\" type=\"facility\"><span style=\"margin-left : 5px; font-size:13px;\">"+facilityReq.getFacility_name()+"("+facilityReq.getReq_name()+")"+"</span></a>");
    						sb.append("<ul class=\"schedule\">");
    						sb.append("</ul>");
    					}
    				}
    				if (planDay >= startDay && planDay <= endDay) {
    					sb.append("<a href=\"#\" type=\"facility\"><span style=\"margin-left : 5px; font-size:13px;\">"+facilityReq.getFacility_name()+"("+facilityReq.getReq_name()+")"+"</span></a>");
    					sb.append("<ul class=\"schedule\">");
    					sb.append("</ul>");
    				} */
    				}
				}
				
				//영화상영내역
				if(moveList != null) {
    				for(int i=0; i<moveList.size(); i++) {
    					Board board = moveList.get(i);
    					String planMonth = plan_date.substring(0,7);
    					String startMonth = board.getImsi_v_1().substring(0,7);
    					String endMonth = board.getImsi_v_1().substring(0,7);
    					int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
    					int startDay = Integer.parseInt(board.getImsi_v_2());
    					int endDay = Integer.parseInt(board.getImsi_v_2());
    					
    					if(planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
    						if(planDay >= startDay && planDay <= 31) {
    							sb.append("<a href=\"#\" class=\"modify\" type=\"move\" keyValue=\""+board.getManage_idx()+"\" keyValue2=\""+board.getBoard_idx()+"\"><span style=\"margin-left : 5px; font-size:13px;\">[영화]"+board.getTitle()+"</span></a>");
    							sb.append("<ul class=\"schedule\">");
    							sb.append("</ul>");
    						}
    					}
    					if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
    						if(planDay >= 1 && planDay <= endDay) {
    							sb.append("<a href=\"#\" class=\"modify\" type=\"move\" keyValue=\""+board.getManage_idx()+"\" keyValue2=\""+board.getBoard_idx()+"\"><span style=\"margin-left : 5px; font-size:13px;\">[영화]"+board.getTitle()+"</span></a>");
    							sb.append("<ul class=\"schedule\">");
    							sb.append("</ul>");
    						}
    					}
    					if (planDay >= startDay && planDay <= endDay) {
    						sb.append("<a href=\"#\" class=\"modify\" type=\"move\" keyValue=\""+board.getManage_idx()+"\" keyValue2=\""+board.getBoard_idx()+"\"><span style=\"margin-left : 5px; font-size:13px;\">[영화]"+board.getTitle()+"</span></a>");
    						sb.append("<ul class=\"schedule\">");
    						sb.append("</ul>");
    					} 
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

	public List<Apply> getOkApplyList() {
		if(okApplyList != null) {
			List<Apply> arrayList = new ArrayList<Apply>();
			arrayList.addAll(this.okApplyList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setOkApplyList(List<Apply> okApplyList) {
		if(okApplyList != null) {
			this.okApplyList = new ArrayList<Apply>();
			this.okApplyList.addAll(okApplyList);
		}
	}

	public List<Teach> getTeachList() {
		if(teachList != null) {
			List<Teach> arrayList = new ArrayList<Teach>();
			arrayList.addAll(this.teachList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setTeachList(List<Teach> teachList) {
		if(teachList != null) {
			this.teachList = new ArrayList<Teach>();
			this.teachList.addAll(teachList);
		}
	}

	public int getDayCode() {
		return dayCode;
	}

	public void setDayCode(int dayCode) {
		this.dayCode = dayCode;
	}

	public List<FacilityReq> getFacilityReqList() {
		if(facilityReqList != null) {
			List<FacilityReq> arrayList = new ArrayList<FacilityReq>();
			arrayList.addAll(this.facilityReqList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setFacilityReqList(List<FacilityReq> facilityReqList) {
		if(facilityReqList != null) {
			this.facilityReqList = new ArrayList<FacilityReq>();
			this.facilityReqList.addAll(facilityReqList);
		}
	}

	public List<Board> getMoveList() {
		if(moveList != null) {
			List<Board> arrayList = new ArrayList<Board>();
			arrayList.addAll(this.moveList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setMoveList(List<Board> moveList) {
		if(moveList != null) {
			this.moveList = new ArrayList<Board>();
			this.moveList.addAll(moveList);
		}
	}
	
}
