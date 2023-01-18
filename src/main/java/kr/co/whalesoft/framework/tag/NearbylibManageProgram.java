package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.apache.commons.lang.StringUtils;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage.NearbyLibManage;

public class NearbylibManageProgram extends BodyTagSupport {
	
	private static final long serialVersionUID = 1L;
	
	private List<NearbyLibManage> nearbyLibManageList;
	private String plan_date;
	private String	mode;
	private int dayCode;
	
	@Override
	public int doEndTag() throws JspException {
		
		StringBuffer sb = new StringBuffer();
		boolean isHolyDay = false;
		if (mode.equals("admin")) {
			for(int i=0; i<nearbyLibManageList.size(); i++) {
				NearbyLibManage cm = nearbyLibManageList.get(i);
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
				
			}
		}
		
		try {
			pageContext.getOut().println(sb.toString());
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return EVAL_PAGE;	
	}

	public List<NearbyLibManage> getNearbyLibManageList() {
		if(nearbyLibManageList != null) {
			List<NearbyLibManage> arrayList = new ArrayList<NearbyLibManage>();
			arrayList.addAll(this.nearbyLibManageList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setNearbyLibManageList(List<NearbyLibManage> nearbyLibManageList) {
		if(nearbyLibManageList != null) {
			this.nearbyLibManageList = new ArrayList<NearbyLibManage>();
			this.nearbyLibManageList.addAll(nearbyLibManageList);
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

	public int getDayCode() {
		return dayCode;
	}

	public void setDayCode(int dayCode) {
		this.dayCode = dayCode;
	}

}
