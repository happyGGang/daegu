package kr.go.gbelib.app.cms.module.teachBook;

import java.util.ArrayList;
import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.teach.student.StudentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TeachBookService extends BaseService {
	
	@Autowired
	private TeachBookDao dao;
	
	@Autowired
	private StudentService studentService;

	public List<TeachBook> getTeachBookList(TeachBook teachBook) {
		return dao.getTeachBookList(teachBook);
	}
	
	public int addTeachBook(TeachBook teachBook) {
		return dao.addTeachBook(teachBook);
	}
	
	public int checkTeachBookStudentByDate(TeachBook teachBook) {
		return dao.checkTeachBookStudentByDate(teachBook);
	}
	
	public int modifyTeachBook(TeachBook teachBook) {
		return dao.modifyTeachBook(teachBook);
	}
	
	public int mergeTeachBook(TeachBook teachBook) {
		return dao.mergeTeachBook(teachBook);
	}
	
	
	
	
	
	
	public List<TeachBook> getTeachBookDateList(TeachBook teachBook) {
		return dao.getTeachBookDateList(teachBook);
	}
	
	public List<TeachBook> getTeachBookDetailByDate(TeachBook teachBook) {
		return dao.getTeachBookDetailByDate(teachBook);
	}
	
	public int addTeachBookTime(TeachBook teachBook) {
		return dao.addTeachBookTime(teachBook);
	}
	
	public int deleteTeachBookDetail(TeachBook teachBook) {
		return dao.deleteTeachBookDetail(teachBook);
	}
	
	@Transactional
	public int addTeachBookDetail(TeachBook teachBook) {
		if (teachBook.getStudentList() != null || teachBook.getStudentList().length > 0) {
			int index = 0;
			for (String info : teachBook.getStudentList()) {
				teachBook.setStudent_idx(Integer.parseInt(info.split("//")[0]));
				teachBook.setStatus(info.split("//")[1]);
				teachBook.setPay1(teachBook.getPay1List()[index]);
				teachBook.setPay2(teachBook.getPay2List()[index]);
				teachBook.setPay3(teachBook.getPay3List()[index]);
				dao.addTeachBookDetail(teachBook);
				index += 1;
			}
		}
		
		return 1;
	}
	
	@Transactional
	public int deleteTeachBookTimeByTeach(Teach teach) {
		List<TeachBook> teachBookList = dao.getTeachBookDateList(new TeachBook(teach.getHomepage_id(), teach.getGroup_idx(), teach.getCategory_idx(), teach.getTeach_idx()));
		
		for (TeachBook info : teachBookList) {
			dao.deleteTeachBookTime(info.getTeach_book_time_idx());	// 출석부 시간 삭제
			info.setStudent_idx(0);
			dao.deleteTeachBookDetail(info); // 출석기록 삭제
		}
		
		return 1;
	}
	
	
	// 출석부 출력
	public List<List<String>> getTeachBookViewInfo(TeachBook teachBook) {
		List<List<String>> list = new ArrayList<List<String>> ();
		
		List<Student> studentList 		= studentService.getStudentListAll(new Student(teachBook.getHomepage_id(), teachBook.getGroup_idx(), teachBook.getCategory_idx(), teachBook.getTeach_idx(), "1"));
		List<TeachBook> dateList 		= dao.getTeachBookDateList(teachBook);
		List<TeachBook> teachBookInfo 	= dao.getTeachBookViewInfo(teachBook);
		
		Boolean isFirst = true;
		for (Student studentInfo : studentList) {
			if (isFirst) {
				List<String> firstList = new ArrayList<String>();
				firstList.add("이름");
				for (TeachBook dateInfo : dateList) {
					firstList.add(dateInfo.getTeach_date());
				}
				list.add(firstList);
				isFirst = false;
			}
			
			int student_idx = studentInfo.getStudent_idx();
			List<String> attendInfoList = new ArrayList<String>();
			attendInfoList.add(studentInfo.getStudent_name());
			for (TeachBook dateInfo : dateList) {
				int teach_book_time_idx = dateInfo.getTeach_book_time_idx();
				String status = null;
				String pay1 = "";
				String pay2 = "";
				String pay3 = "";
				for (TeachBook attendInfo : teachBookInfo) {
					if (attendInfo.getStudent_idx() == student_idx && attendInfo.getTeach_book_time_idx() == teach_book_time_idx) {
						status = attendInfo.getStatus();
						pay1 = attendInfo.getPay1();
						pay2 = attendInfo.getPay2();
						pay3 = attendInfo.getPay3();
						break;
					}
				}
				attendInfoList.add(status);
				attendInfoList.add(pay1);
				attendInfoList.add(pay2);
				attendInfoList.add(pay3);
			}
			list.add(attendInfoList);
		}
		
		return list;
	}
	
	public int deleteTeachBook(TeachBook teachBook) {
		return dao.deleteTeachBook(teachBook);
	}

	public int modifyStudentPay(TeachBook teachBook) {
		return dao.modifyStudentPay(teachBook);
	}
}