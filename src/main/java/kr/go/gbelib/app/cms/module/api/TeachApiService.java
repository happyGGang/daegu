package kr.go.gbelib.app.cms.module.api;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.teach.student.StudentService;

@Service
public class TeachApiService extends BaseService{
	
	@Autowired
	private TeachService teachService;
	
	@Autowired
	private StudentService studentService;

	public Map<String, Object> getData(Teach teach, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		
		List<Teach> teachList = teachService.getTeachApiList(teach);
		List<Map<String, Object>> teachMapList = new ArrayList<Map<String, Object>>();
		
		int code = 0; // 0 성공 1 실패
		String msg = "";
		
		int teachCount = teachList.size();
		
		if (StringUtils.isEmpty(teach.getHomepage_id())) {
			code = 1;
			msg = "잘못된 homepage_id 파라미터";	
		} else if (teachCount == 0) {
			code = 1;
			msg = "조회된 데이터가 없습니다.";	
		} 
		
		map.put("code", code);
		map.put("msg", msg);
		map.put("SEARCH_COUNT", teachCount);
		
		for(Teach obj: teachList) {
			teachMapList.add(toMap(obj));
		}
		
		map.put("data", teachMapList);
		
		
		return map;
	}
	
	public Map<String, Object> getData2(Student student, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		
		List<Student> studentList = studentService.getTeachStudentApiList(student);
		List<Map<String, Object>> studentMapList = new ArrayList<Map<String, Object>>();
		
		int code = 0; // 0 성공 1 실패
		String msg = "성공";
		
		int studentCount = studentList.size();
		
		if (StringUtils.isEmpty(student.getHomepage_id()) &&student.getGroup_idx() == 0 && student.getTeach_idx() == 0) {
			code = 1;
			msg = "잘못된 homepage_id,group_idx,teach_idx 파라미터";	
		} else if (StringUtils.isEmpty(student.getHomepage_id())) {
			code = 1;
			msg = "잘못된 homepage_id 파라미터";	
		} else if (student.getGroup_idx() == 0) {
			code = 1;
			msg = "잘못된 group_idx 파라미터";	
		} else if (student.getTeach_idx() == 0) {
			code = 1;
			msg = "잘못된 teach_idx 파라미터";
		} else if (studentCount == 0) {
			code = 1;
			msg = "조회된 데이터가 없습니다.";	
		}
		
		map.put("code", code);
		map.put("msg", msg);
		map.put("SEARCH_COUNT", studentCount);
		
		for(Student obj: studentList) {
			studentMapList.add(toMap2(obj));
		}
		
		map.put("data", studentMapList);
		
		
		return map;
	}
	
	public Map<String, Object> toMap(Teach teach) {
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("TITLE", defaultString(teach.getTeach_name()));												// 강좌명
		map.put("TARGET", defaultString(teach.getTeach_target()));											// 강좌대상
		map.put("ONTARGETCNT", teach.getTeach_join_count());												// 온라인 현재접수인원
		map.put("ONLIMITCNT", teach.getTeach_limit_count());												// 온라인접수가능인원
		map.put("OFFTARGETCNT", teach.getTeach_off_join_count());											// 오프라인 현재접수인원
		map.put("OFFLIMITCNT", teach.getTeach_offline_count());												// 오프라인접수가능인원
		map.put("TARGETHUBOCNT", teach.getTeach_backup_join_count());										// 현재 후보자인원
		map.put("HUBOLIMITCNT", teach.getTeach_backup_count());												// 후보자 접수가능인원
		map.put("LECTUREDATE", defaultString(teach.getStart_date() + " ~ " + teach.getEnd_date()));			// 강의기간
		map.put("LECTURETIME", defaultString(teach.getStart_time() + " ~ " + teach.getEnd_time()));			// 강의시작시간
		map.put("LIB_NAME", defaultString(teach.getHomepage_name()));										// 도서관명
		map.put("DESCRIPTION", defaultString(teach.getTeach_desc()));										// 내용 or 설명
		map.put("TEACHER_NAME", defaultString(teach.getTeacher_name()));									// 강사명
		map.put("TEACHWEEK", defaultString(teach.getTeach_day_txt()));										// 요일
		map.put("TEACH_IDX", teach.getTeach_idx());															// 강좌코드
		map.put("GROUP_IDX", teach.getGroup_idx());															// 그룹코드
		
		return map;
	}
	
	public Map<String, Object> toMap2(Student student) {
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		
		map.put("NAME", defaultString(student.getApplicant_name()));										// 신청자명
		map.put("ID", defaultString(student.getMember_id()));												// 신청자아이디
		map.put("BIRTHDAY", defaultString(student.getApplicant_birth()));									// 신청자생일	
		map.put("HANDPHONE", defaultString(student.getApplicant_cell_phone()));								// 신청자전화번호
		map.put("ADD_DATE", defaultString(student.getAdd_date()));											// 신청일자
		
		return map;
	}
	
	private String defaultString(String s) {
		if(s == null) return "";
		else return s;
	}
}
