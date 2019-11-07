package kr.go.gbelib.app.cms.module.teacherReqManage;

import java.util.List;

import kr.go.gbelib.app.cms.module.teacher.Teacher;

public interface TeacherReqManageDao  {

	public List<TeacherReqManage> getTeacherList(TeacherReqManage teacherReqManage);
	
	public List<TeacherReqManage> getTeacherApplyList(TeacherReqManage teacherReqManage);
	
	public List<TeacherReqManage> getTeacherListAll(TeacherReqManage teacherReqManage);
	
	public int getTeacherListCount(TeacherReqManage teacherReqManage);
	
	public int getTeacherApplyListCount(TeacherReqManage teacherReqManage);
	
	public TeacherReqManage getTeacherOne(TeacherReqManage teacherReqManage);
	
	public TeacherReqManage getTeacherApplyOne(TeacherReqManage teacherReqManage);
	
	public int addTeacher(TeacherReqManage teacherReqManage);
	
	public int modifyTeacher(TeacherReqManage teacherReqManage);
	
	public int deleteTeacher(TeacherReqManage teacherReqManage);
	
	// teacher_idx 반환.
	public TeacherReqManage checkTeacher(TeacherReqManage teacherReqManage);

	public List<TeacherReqManage> getHistoryList(TeacherReqManage teacherReqManage);
	
	public int confirmTeacher(TeacherReqManage teacherReqManage);
	
	public int modifyManageHistory(Teacher teacher);
}