package kr.go.gbelib.app.cms.module.teacher;

import java.util.List;

public interface TeacherDao  {

	public List<Teacher> getTeacherList(Teacher teacher);
	
	public List<Teacher> getTeacherListAll(Teacher teacher);
	
	public int getTeacherListCount(Teacher teacher);
	
	public Teacher getTeacherOne(Teacher teacher);
	
	public int addTeacher(Teacher teacher);
	
	public int modifyTeacher(Teacher teacher);
	
	public int deleteTeacher(Teacher teacher);
	
	// teacher_idx 반환.
	public Teacher checkTeacher(Teacher teacher);

	public List<Teacher> getExcelList(Teacher teacher);
	
	public List<Teacher> getHistoryList(Teacher teacher);
	
	public int getCertSeq();
	
	public int confirmTeacher(Teacher teacher);
	
	public int modifyManageHistory(Teacher teacher);

	public Teacher checkTeacher2(Teacher teacher);

	public Teacher getTeacherAgreeOne(Teacher teacher);

	public int addTeacherAgree(Teacher teacher);

	public int deleteTeacherAgree(Teacher teacher);
}