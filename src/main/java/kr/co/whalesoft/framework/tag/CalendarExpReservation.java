package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.go.gbelib.app.cms.module.expReservation.ExpReservation;

public class CalendarExpReservation extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<ExpReservation> expReservationList;
	private String plan_date;//ex)2020-08-13

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
					e1.printStackTrace();
				}
				Date now = new Date();
				
				if ( today.equals(exp.getReservation_date())) {
					sb.append("<a href=\"#\" class=\"modify\" keyValue=\"" + exp.getProgram_list_idx()+"\"><span Style=\"font-weight: bold;\">" + exp.getProgram_name() + "</span></a>&nbsp;");
					sb.append("<span>" + exp.getUse_time() + "</span><br/>");
					
					if(now.compareTo(planDate) < 0) {
						sb.append("<a href=\"#\" class=\"btn btn4\" id=\"apply\" keyValue=\"" + exp.getProgram_list_idx() + "\" keyValue2=\"" + exp.getReservation_date() + "\"><span>신청</span></a>");
					} else {
						sb.append("<span class=\"btn btn5\">신청마감</span>");
					}
					
					sb.append("<a href=\"#\" class=\"btn btn1 check_apply_" + exp.getProgram_list_idx() + "\" id=\"check_apply\" keyValue=\"" + exp.getProgram_list_idx() + "\" keyValue2=\"" + exp.getReservation_date() + "\"><span>신청현황(" + exp.getApply_count() + ")</span></a><br/><br/>");
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


}
