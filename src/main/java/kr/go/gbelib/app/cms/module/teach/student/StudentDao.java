package kr.go.gbelib.app.cms.module.teach.student;

import java.util.List;

import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teachSetting.TeachSetting;

public interface StudentDao  {

	public List<Student> getStudentListAll(Student student);
	
	public List<Student> getStudentList(Student student);
	
	public int getStudentListCount(Student student);
	
	public Student getStudentOne(Student student);
	
	public int addStudent(Student student);
	
	public int getStudentIdx(Student student);
	
	public int modifyStudent(Student student);
	
	public int deleteStudent(Student student);
	
	public Student getCertificateInfo(Student student);
	
	public int checkStudent(Student student);
	
	public int checkStudentSameTeach(Student student);
	
	public int cancelStudent(Student student);
	
	public List<Student> getTeachCertificateList(Student student);

	public Student getFirstBackupMember(Teach teach);
	
	public int updateJoinToBackupMember(Student student);
	
	public List<Student> getCertificateListByDate(Student student);

	public int checkStudentSetting(TeachSetting ts);

	public int checkStudentSetting2(Student student);

	public List<Student> getBackupMemberList(Teach teach);
	
	public int modifyStudentStatus(Student student);

	public List<Student> getCertificateListByDate2(Teach teach);

	public int checkStudentSetting3(Student student);

	public List<Student> sendSmsTeachCancle(Student student);

	public int addStudentFile(Student student);

	public Student getStudentFileOne(Student student);
	
	// Teach Student
	public List<Student> getTeachStudentApiList(Student student);

	public int updateStudent(Student student);
}