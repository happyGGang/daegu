package kr.co.whalesoft.framework.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teachBook.TeachBook;

public class CalendarTeachBook extends BodyTagSupport {
	
	private static final long serialVersionUID = 1L;
	
	private List<TeachBook> teachBookTimeList;
	private String plan_date;
	private Teach teachOne;
	
	@Override
	public int doEndTag() throws JspException{
		
		StringBuffer sb = new StringBuffer();
		
		String start_date = "";
		String end_date = "";
		
		if (teachOne != null) {
			start_date = teachOne.getStart_date();
			end_date = teachOne.getEnd_date();
		}
		Boolean check = false;
		int teach_book_time_idx = 0;
		if (start_date.compareTo(plan_date) <= 0 && end_date.compareTo(plan_date) >= 0) {
			for (TeachBook teachBook : teachBookTimeList) {
				if (teachBook.getTeach_date().equals(plan_date)) {
					check = true;
					teach_book_time_idx =  teachBook.getTeach_book_time_idx();
				}
			}
			
			if (check) {
				sb.append("<div><a href=\"\" class=\"si1 edit\" style=\"display: inline-block;\" keyValue=\"" + plan_date + "\" teach_book_time_idx=\"" + teach_book_time_idx +"\"><i class=\"fa fa-cog\"></i>설정</a>");
				sb.append("<a href=\"\" class=\"delete\" style=\"display: inline-block;  color: #000;\" keyValue=\""+plan_date+"\" teach_book_time_idx=\"" + teach_book_time_idx + "\"><i class=\"fa fa-minus\"></i>삭제</a></div>");
			} else {
				sb.append("<div><a href=\"\" class=\"si3 add\" style=\"display: inline-block;\" keyValue=\""+plan_date+"\"><i class=\"fa fa-plus\"></i>추가</a></div>");
			}
		} else {
			sb.append("<div><a href=\"javascript:void(0);\" class=\"si2\" style=\"cursor:default; display: inline-block;\"><i class=\"fa fa-close\"></i></a></div>");
		}
				
		try {
			pageContext.getOut().println(sb.toString());
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		
		return EVAL_PAGE;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public Teach getTeachOne() {
		return teachOne;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public void setTeachOne(Teach teachOne) {
		this.teachOne = teachOne;
	}

	public List<TeachBook> getTeachBookTimeList() {
		if(teachBookTimeList != null) {
			List<TeachBook> arrayList = new ArrayList<TeachBook>();
			arrayList.addAll(this.teachBookTimeList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setTeachBookTimeList(List<TeachBook> teachBookTimeList) {
		if(teachBookTimeList != null) {
			this.teachBookTimeList = new ArrayList<TeachBook>();
			this.teachBookTimeList.addAll(teachBookTimeList);
		}
	}

}
