package kr.go.gbelib.app.cms.module.teachSetting;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.category.Category;
import kr.go.gbelib.app.cms.module.category.CategoryService;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroup;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroupService;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.teach.student.StudentService;

@Service
public class TeachSettingService extends BaseService{

	@Autowired
	private StudentService studentService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private CategoryGroupService categoryGroupService;
	
	@Autowired
	private TeachSettingDao dao;
	
	public TeachSetting getTeachSettingOne(TeachSetting teachSetting) {
		return dao.getTeachSettingOne(teachSetting);
	}
	
	public int mergeTeachSetting(TeachSetting teachSetting) {
		return dao.mergeTeachSetting(teachSetting);
	}

	public String checkTeachSetting(TeachSetting ts) {
		
		TeachSetting tsOne = getTeachSettingOne(ts);
		
		if (tsOne == null || !StringUtils.equals(tsOne.getUse_yn(), "Y")) {
			return null;
		}
		
		String startDate = "";
		String endDate = "";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String currDate = sdf.format(new Date());//20170427
		String currYear = currDate.substring(0,4);
		Calendar cal = Calendar.getInstance();
		int currMonth = cal.get(Calendar.MONTH)+1 ;
		
		if (tsOne.getTerm_type().equals("1")) {//1년

			startDate = currYear + "0101";
			endDate = currYear + "1231";
			
		} else if (tsOne.getTerm_type().equals("6")) {//6개월

			if (currMonth < 7) {
				startDate = currYear + "0101";
				endDate = currYear + "0630";
			} else {
				startDate = currYear + "0701";
				endDate = currYear + "1231";
			}
			
		} else if (tsOne.getTerm_type().equals("3")) {//3개월
			
			if (currMonth < 4) {
				startDate = currYear + "0101";
				endDate = currYear + "0331";
			} else if (currMonth < 7) {
				startDate = currYear + "0401";
				endDate = currYear + "0630";
			} else if (currMonth < 10) {
				startDate = currYear + "0701";
				endDate = currYear + "0930";
			} else {
				startDate = currYear + "1001";
				endDate = currYear + "1231";
			}
			
		}
		
		try {
			ts.setFromDate(sdf.parse(startDate));
			ts.setToDate(sdf.parse(endDate));
		}
		catch ( ParseException e ) {
		}
		
		//신청한 수
		int applyCount = studentService.checkStudentSetting(ts);
		 
		if (tsOne.getTerm_count() <= applyCount) {
			return "1인당 "+tsOne.getTerm_count()+"강좌 초과하여 신청 할 수 없습니다.";
		}
		
		
		return null;
	}
	
	public String checkTeachSettingCategoryGroup(Student student) {
		
//		TeachSetting tsOne = getTeachSettingOne(student);
		CategoryGroup tmp = new CategoryGroup();
		if(student.getHomepage_id() == null || student.getLarge_category_idx() == 0) {
			return String.format("일시적 오류입니다. 도서관에 문의해주시기 바랍니다.");
		}
		tmp.setHomepage_id(student.getHomepage_id());
		tmp.setGroup_idx(student.getGroup_idx());
//		tmp.setCategory_idx(student.getCategory_idx());
		tmp.setLarge_category_idx(student.getLarge_category_idx());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@ Homepage_id : " + student.getHomepage_id());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@ Group_idx : " + student.getGroup_idx());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@ Large_category_idx : " + student.getLarge_category_idx());
		CategoryGroup categoryGroup = categoryGroupService.getCategoryGroupOne(tmp);
		
		if (categoryGroup == null || !StringUtils.equals(categoryGroup.getReq_limit_yn(), "Y")) {
			return null;
		} else {
			String startDate = "";
			String endDate = "";
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String currDate = sdf.format(new Date());//20170427
			String currYear = currDate.substring(0,4);
			Calendar cal = Calendar.getInstance();
			int currMonth = cal.get(Calendar.MONTH)+1 ;
			
			if (categoryGroup.getReq_limit_type().equals("1")) {//1년
				
				startDate = currYear + "0101";
				endDate = (Integer.parseInt(currYear)+1) + "0101";
				
			} else if (categoryGroup.getReq_limit_type().equals("6")) {//6개월
				
				if (currMonth < 7) {
					startDate = currYear + "0101";
					endDate = currYear + "0630";
				} else {
					startDate = currYear + "0701";
					endDate = currYear + "1231";
				}
				
			} else if (categoryGroup.getReq_limit_type().equals("3")) {//3개월
				
				if (currMonth < 4) {
					startDate = currYear + "0101";
					endDate = currYear + "0331";
				} else if (currMonth < 7) {
					startDate = currYear + "0401";
					endDate = currYear + "0630";
				} else if (currMonth < 10) {
					startDate = currYear + "0701";
					endDate = currYear + "0930";
				} else {
					startDate = currYear + "1001";
					endDate = currYear + "1231";
				}
				
			}
			
			try {
				student.setFromDate(sdf.parse(startDate));
				student.setToDate(sdf.parse(endDate));
				student.setFromDateStr(startDate);
				student.setToDateStr(endDate);
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@ startDate : " + startDate);
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@ endDate : " + endDate);
			}
			catch ( ParseException e ) {
			}
			
			//신청한 수
			int applyCount = studentService.checkStudentSetting3(student);
			
			if (categoryGroup.getReq_limit_count() <= applyCount) {
				return String.format("%s 분류의 강좌는 1인당 %s회 까지 신청 가능합니다.", categoryGroup.getGroup_name(), categoryGroup.getReq_limit_count());
			}
			return null;
		}
	}
	
	public String checkTeachSettingCategory(Student student) {
		
//		TeachSetting tsOne = getTeachSettingOne(student);
		Category tmp = new Category();
		if(student.getHomepage_id() == null || student.getLarge_category_idx() == 0) {
			return String.format("일시적 오류입니다. 도서관에 문의해주시기 바랍니다.");
		}
		tmp.setHomepage_id(student.getHomepage_id());
		tmp.setGroup_idx(student.getGroup_idx());
		tmp.setCategory_idx(student.getCategory_idx());
		tmp.setLarge_category_idx(student.getLarge_category_idx());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@ Homepage_id : " + student.getHomepage_id());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@ Group_idx : " + student.getGroup_idx());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@ Category_idx : " + student.getCategory_idx());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@ Large_category_idx : " + student.getLarge_category_idx());
		Category category = categoryService.getCategoryOne(tmp);
		
		if (category == null || !StringUtils.equals(category.getReq_limit_yn(), "Y")) {
			return null;
		} else {
			String startDate = "";
			String endDate = "";
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String currDate = sdf.format(new Date());//20170427
			String currYear = currDate.substring(0,4);
			Calendar cal = Calendar.getInstance();
			int currMonth = cal.get(Calendar.MONTH)+1 ;
			
			if (category.getReq_limit_type().equals("1")) {//1년
				
				startDate = currYear + "0101";
				endDate = (Integer.parseInt(currYear)+1) + "0101";
				
			} else if (category.getReq_limit_type().equals("6")) {//6개월
				
				if (currMonth < 7) {
					startDate = currYear + "0101";
					endDate = currYear + "0630";
				} else {
					startDate = currYear + "0701";
					endDate = currYear + "1231";
				}
				
			} else if (category.getReq_limit_type().equals("3")) {//3개월
				
				if (currMonth < 4) {
					startDate = currYear + "0101";
					endDate = currYear + "0331";
				} else if (currMonth < 7) {
					startDate = currYear + "0401";
					endDate = currYear + "0630";
				} else if (currMonth < 10) {
					startDate = currYear + "0701";
					endDate = currYear + "0930";
				} else {
					startDate = currYear + "1001";
					endDate = currYear + "1231";
				}
				
			}
			
			try {
				student.setFromDate(sdf.parse(startDate));
				student.setToDate(sdf.parse(endDate));
				student.setFromDateStr(startDate);
				student.setToDateStr(endDate);
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@ startDate : " + startDate);
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@ endDate : " + endDate);
			}
			catch ( ParseException e ) {
			}
			
			//신청한 수
			int applyCount = studentService.checkStudentSetting2(student);
			
			if (category.getReq_limit_count() <= applyCount) {
				return String.format("%s 분류의 강좌는 1인당 %s회 까지 신청 가능합니다.", category.getGroup_name(), category.getReq_limit_count());
			}
			return null;
		}
	}
	
}
