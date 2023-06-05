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

public class CalendarManageUserProgram extends BodyTagSupport {
	
	private static final long serialVersionUID = 1L;
	
	private List<CalendarManage> calendarManageList;
	private List<Teach> teachList;
	private List<Apply> okApplyList;
	private List<FacilityReq> facilityReqList;
	private List<Board> moveList;
	private String plan_date;
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
							if(cm.getDate_type().equals("1")) {
								sb.append("<li title=\""+cm.getTitle()+"\">");
								sb.append("<span class=\"type-r\"><i></i><em>"+cm.getTitle()+"</em></span>");
								sb.append("</li>");
							} else {
								sb.append("<li title=\""+cm.getTitle()+"\">");
								sb.append("<a href=\"#\" class=\"modify\" linkurl=\""+cm.getLink_url()+"\" type=\"calendar\" keyValue=\""+cm.getMenu_idx()+"\" keyValue2=\""+cm.getCm_idx()+"\" keyValue3=\""+cm.getDate_type()+"\"><span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span></a>");
								sb.append("</li>");
							}
							isHolyDay = StringUtils.equals(cm.getDate_type(), "1");//휴관일로 지정된 경우
						}
					}					
					if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
						if(planDay >= 1 && planDay <= endDay) {
							if(cm.getDate_type().equals("1")) {
								sb.append("<li title=\""+cm.getTitle()+"\">");
								sb.append("<span class=\"type-r\"><i></i><em>"+cm.getTitle()+"</em></span>");
								sb.append("</li>");
							} else {
								sb.append("<li title=\""+cm.getTitle()+"\">");
								sb.append("<a href=\"#\" class=\"modify\" linkurl=\""+cm.getLink_url()+"\" type=\"calendar\" keyValue=\""+cm.getMenu_idx()+"\" keyValue2=\""+cm.getCm_idx()+"\" keyValue3=\""+cm.getDate_type()+"\"><span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span></a>");
								sb.append("</li>");
							}
							isHolyDay = StringUtils.equals(cm.getDate_type(), "1");//휴관일로 지정된 경우
						}
					}
					if (planDay >= startDay && planDay <= endDay) {
						if(cm.getDate_type().equals("1")) {
							sb.append("<li title=\""+cm.getTitle()+"\">");
							sb.append("<span class=\"type-r\"><i></i><em>"+cm.getTitle()+"</em></span>");
							sb.append("</li>");
						} else {
							sb.append("<li title=\""+cm.getTitle()+"\">");
							sb.append("<a href=\"#\" class=\"modify\" linkurl=\""+cm.getLink_url()+"\" type=\"calendar\" keyValue=\""+cm.getMenu_idx()+"\" keyValue2=\""+cm.getCm_idx()+"\" keyValue3=\""+cm.getDate_type()+"\"><span class=\"type-e\"><i></i><em>"+cm.getTitle()+"</em></span></a>");
							sb.append("</li>");
						}
						isHolyDay = StringUtils.equals(cm.getDate_type(), "1");//휴관일로 지정된 경우
					} 
				
			}
			
			//강좌
			if(teachList != null) {
				for(int i=0; i<teachList.size(); i++) {
					Teach teach = teachList.get(i);
					String start_date = teach.getStart_date();
					String end_date = teach.getEnd_date();
					
					for (String day : teach.getTeach_day_arr()) {
						if ( dayCode == Integer.parseInt(day) ) {
							if (start_date.compareTo(plan_date) <= 0 && end_date.compareTo(plan_date) >= 0) {
								String statusName = "[강좌]";
								boolean disableHoli = false;
								
								if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
									for ( String holiday : teach.getHolidays() ) {
										if (StringUtils.equals(plan_date, holiday)) {
											statusName = "<span style=\"color:red;\">[휴강]</span>";
											disableHoli = teach.getDisable_holi().equals("Y") ? true : false;
										}
									}
								}
								if(disableHoli) continue;
								
								//서구통합도서관은 휴관일에 강좌가 표시 안되도록 수정
								if (!isHolyDay && ("h77".equals(teach.getHomepage_id()) || "h49".equals(teach.getHomepage_id()) || "h61".equals(teach.getHomepage_id()) || "h62".equals(teach.getHomepage_id()) || "h63".equals(teach.getHomepage_id()) || "h64".equals(teach.getHomepage_id()) || "h65".equals(teach.getHomepage_id()))) {
									sb.append("<li title=\""+teach.getTeach_name()+"\">");
									sb.append("<a href=\"#\" class=\"modify\" type=\"teach\" keyValue=\""+teach.getCategory_idx()+"\" keyValue2=\""+teach.getTeach_idx()+"\" keyValue3=\""+teach.getGroup_idx()+"\"><span class=\"type-e\"><i></i><em>"+statusName+""+teach.getTeach_name()+"</em></span></a>");
									sb.append("</li>");
								}
							}
						}
					}
				}
			}
		
			//휴관일이 아닌경우에만 출력한다.
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
    							sb.append("<li title=\""+apply.getAgency_name()+"\">");
    							sb.append("<span class=\"type-e\"><i></i><em>"+"["+apply.getCode_name()+"]"+apply.getAgency_name()+"<em></span>");
    							sb.append("</li>");
    						}
    					}
    					if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
    						if(planDay >= 1 && planDay <= endDay) {
    							sb.append("<li title=\""+apply.getAgency_name()+"\">");
    							sb.append("<span class=\"type-e\"><i></i><em>"+"["+apply.getCode_name()+"]"+apply.getAgency_name()+"<em></span>");
    							sb.append("</li>");
    						}
    					}
    					if (planDay >= startDay && planDay <= endDay) {
    						sb.append("<li title=\""+apply.getAgency_name()+"\">");
    						sb.append("<span class=\"type-e\"><i></i><em>"+"["+apply.getCode_name()+"]"+apply.getAgency_name()+"<em></span>");
    						sb.append("</li>");
    					} 
    					
    				}
				}
				
				//시설물 이용 내역
				if(facilityReqList != null) {
    				for(int i=0; i<facilityReqList.size(); i++) {
    					FacilityReq facilityReq = facilityReqList.get(i);
    					
    					if ( plan_date.equals(facilityReq.getUse_date()) ) {
    						sb.append("<li title=\""+facilityReq.getFacility_name()+"\">");
    						sb.append("<span class=\"type-e\"><i></i><em>"+facilityReq.getFacility_name()+"("+facilityReq.getMasking_name()+")"+"<em></span>");
    						sb.append("</li>");	
    					}
    					/*String planMonth = plan_date.substring(0,7);
    				String startMonth = facilityReq.getStart_date().substring(0,7);
    				String endMonth = facilityReq.getEnd_date().substring(0,7);
    				int planDay = Integer.parseInt(plan_date.substring(plan_date.lastIndexOf("-")+1));
    				int startDay = Integer.parseInt(facilityReq.getStart_date().substring(facilityReq.getStart_date().lastIndexOf("-")+1));
    				int endDay = Integer.parseInt(facilityReq.getEnd_date().substring(facilityReq.getEnd_date().lastIndexOf("-")+1));
    				
    				if(planMonth.equals(startMonth) && !planMonth.equals(endMonth)) {
    					if(planDay >= startDay && planDay <= 31) {
    						sb.append("<li title=\""+facilityReq.getFacility_name()+"\">");
    						sb.append("<span class=\"type-e\"><i></i><em>"+facilityReq.getFacility_name()+"("+facilityReq.getMasking_name()+")"+"<em></span>");
    						sb.append("</li>");
    					}
    				}
    				if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
    					if(planDay >= 1 && planDay <= endDay) {
    						sb.append("<li title=\""+facilityReq.getFacility_name()+"\">");
    						sb.append("<span class=\"type-e\"><i></i><em>"+facilityReq.getFacility_name()+"("+facilityReq.getMasking_name()+")"+"<em></span>");
    						sb.append("</li>");
    					}
    				}
    				if (planDay >= startDay && planDay <= endDay) {
    					sb.append("<li title=\""+facilityReq.getFacility_name()+"\">");
    					sb.append("<span class=\"type-e\"><i></i><em>"+facilityReq.getFacility_name()+"("+facilityReq.getMasking_name()+")"+"<em></span>");
    					sb.append("</li>");
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
    							sb.append("<li title=\""+board.getTitle()+"\">");
    							sb.append("<a href=\"#\" class=\"modify\" type=\"move\" keyValue=\""+board.getManage_idx()+"\" keyValue2=\""+board.getBoard_idx()+"\" keyValue3=\""+ board.getMenu_idx()+"\"><span class=\"type-m\"><i></i><em>[영화]"+board.getTitle()+"</em></span></a>");
    							sb.append("</li>");
    						}
    					}
    					if(!planMonth.equals(startMonth) && planMonth.equals(endMonth)) {
    						if(planDay >= 1 && planDay <= endDay) {
    							sb.append("<li title=\""+board.getTitle()+"\">");
    							sb.append("<a href=\"#\" class=\"modify\" type=\"move\" keyValue=\""+board.getManage_idx()+"\" keyValue2=\""+board.getBoard_idx()+"\" keyValue3=\""+ board.getMenu_idx()+"\"><span class=\"type-m\"><i></i><em>[영화]"+board.getTitle()+"</em></span></a>");
    							sb.append("</li>");
    						}
    					}
    					if (planDay >= startDay && planDay <= endDay) {
    						sb.append("<li title=\""+board.getTitle()+"\">");
    						sb.append("<a href=\"#\" class=\"modify\" type=\"move\" keyValue=\""+board.getManage_idx()+"\" keyValue2=\""+board.getBoard_idx()+"\" keyValue3=\""+ board.getMenu_idx()+"\"><span class=\"type-m\"><i></i><em>[영화]"+board.getTitle()+"</em></span></a>");
    						sb.append("</li>");
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
