package kr.go.gbelib.app.cms.module.teach;

import java.util.List;
import java.util.Map;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import org.apache.poi.ss.formula.functions.T;

public interface TeachDao  {

	public List<Teach> getTeachList(Teach teach);

	public List<Teach> getTeachListAll(Teach teach);

	public int getTeachListCount(Teach teach);

	public Teach getTeachOne(Teach teach);

	public int addTeach(Teach teach);

	public int modifyTeach(Teach teach);

	public int deleteTeach(Teach teach);

	public List<Teach> getTeachListForCalendar(CalendarManage calendarManage);

	public List<Teach> getTeachListForUser(Teach teach);

	public List<Teach> getTeachListHomepage(Teach teach);

	public List<Teach> getTeachListForAllHomepage(Teach teach);

	public Teach getTeachDetailForUser(Teach teach);

	public int changeTeachStatus(Teach teach);

	public int mergeBackupMember(Teach teach);

	public List<Teach> getApplyList(Teach teach);

	public int getPrintMaxValue(Teach teach);

	public List<Teach> getTeachListOfStudent(Student student);

	public List<Teach> getSameTeachByName(Teach teach);

	public List<Teach> getMainViewTeachList(Teach teach);

	public List<Teach> getMainViewTeachListForAllHomepage(Teach teach);

	public int deleteFile(Teach teach);

	public int getTeachListForAllHomepageCount(Teach teach);

	public int addTeachHolidays(Teach teach);

	public int getNextTeachIdx(Teach teach);

	public int deleteTeachHolidays(Teach teach);

	public List<String> getHolidays(Teach teach);

	public List<Teach> getHolidaysForUser(Map<String, Object> map);

	public int deleteImage(Teach teach);
	
	public int deleteAttach(Teach teach);

	public List<Teach> getSchaduleTeach();

	public int modifySmsFlag(Teach teach);

	public Map<String, Object> getWaitingNumber(Teach result);

	/**
	 * @author whalesoft YONGJU 2020. 2. 28.
	 * @param result
	 * @return
	 */
	public String getTeacherName(Teach result);

	public int getTeachListForAllHomepageGugunCount(Teach teach);

	public List<Teach> getTeachListForAllHomepageGugun(Teach teach);
	
	// Teach API 쿼리
	public List<Teach> getTeachApiList(Teach teach);

	public List<Teach> getTeachListForAllHomepageRamdom(Teach teach);

	public List<Teach> getTeachListForAllCulture(Teach teach);

	public List<Teach> getTeachListForAllSearchCulture(Teach teach);

	public int getTeachListForAllSearchCultureCount(Teach teach);

	public List<Teach> getApplyListAll(Teach teach);

	public int getApplyListAllCount(Teach teach);
	
}
