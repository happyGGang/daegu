package kr.go.gbelib.app.cms.module.teacher;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import net.sf.jxls.transformer.XLSTransformer;

@Service
public class TeacherService extends BaseService {

	@Autowired
	private TeacherDao dao;

	@Autowired
	@Qualifier("teacherStorage")
	private FileStorage teacherStorage;

	public List<Teacher> getTeacherListAll(String homepage_id) {
		Teacher teacher = new Teacher();
		teacher.setHomepage_id(homepage_id);
		return dao.getTeacherListAll(teacher);
	}
	
	@WorkingLogger(comment="강사관리 조회", type="P")
	public List<Teacher> getTeacherList(Teacher teacher) {
		return dao.getTeacherList(teacher);
	}

	public int getTeacherListCount(Teacher teacher) {
		return dao.getTeacherListCount(teacher);
	}
	
	@WorkingLogger(comment="강사관리 1건 조회", type="P")
	public Teacher getTeacherOne(Teacher teacher) {
		return dao.getTeacherOne(teacher);
	}

	public Teacher checkTeacher(Teacher teacher) {
		return dao.checkTeacher(teacher);
	}

	public Teacher checkTeacher2(Teacher teacher) {
		return dao.checkTeacher2(teacher);
	}

	public int addTeacher(Teacher teacher) {
		MultipartFile mFile = teacher.getFile();
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + teacher.getHomepage_id();

			File f = teacherStorage.addFile(mFile, realFileName, filePath);

			teacher.setServer_file_name(realFileName);
			teacher.setOrg_file_name(fileName);
			teacher.setFile_extension(fileExtension);
			teacher.setFile_size(f.length());
		} else {
			teacher.setOrg_file_name(null);
		}

		return dao.addTeacher(teacher);
	}

	@WorkingLogger(comment="강사관리 1건 수정", type="P")
	public int modifyTeacher(Teacher teacher) {
		MultipartFile mFile = teacher.getFile();
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + teacher.getHomepage_id();

			File f = teacherStorage.addFile(mFile, realFileName, filePath);

			teacher.setServer_file_name(realFileName);
			teacher.setOrg_file_name(fileName);
			teacher.setFile_extension(fileExtension);
			teacher.setFile_size(f.length());
		} else {
			teacher.setOrg_file_name(null);
		}

		return dao.modifyTeacher(teacher);
	}

	@WorkingLogger(comment="강사관리 1건 삭제", type="P")
	public int deleteTeacher(Teacher teacher) {
		return dao.deleteTeacher(teacher);
	}

	public List<Teacher> getExcelList(Teacher teacher) {
		return dao.getExcelList(teacher);
	}

	public List<Teacher> getHistoryList(Teacher teacher) {
		return dao.getHistoryList(teacher);
	}

	public int confirmTeacher(Teacher teacher) {
		return dao.confirmTeacher(teacher);
	}

	public int getCertSeq() {
		return dao.getCertSeq();
	}

	public void writeExcelData(Teacher teacher, OutputStream outputStream, HttpServletRequest request) throws Exception {
		String sampleFilePath = request.getSession().getServletContext().getRealPath("/") + "/resources/module/teacher/teacherCert.xls";
		Workbook workbook = null;

		teacher = dao.getTeacherOne(teacher);
		teacher.setCert_seq_num(dao.getCertSeq());
		List<Teacher> historyList = dao.getHistoryList(teacher);

		int limitRowCount = 13;
		if ( historyList.size() > limitRowCount ) {
			while ( historyList.size() != limitRowCount ) {
				historyList.remove(historyList.remove(0));
			}
		}
		else if ( historyList.size() < limitRowCount ) {
			while ( historyList.size() != limitRowCount ) {
				historyList.add(new Teacher());
			}
		}

		int sum_total_time = 0;
		for ( Teacher one : historyList ) {
			sum_total_time = sum_total_time + one.getTotal_time();
		}
		teacher.setSum_total_time(sum_total_time);

		SimpleDateFormat sfYear = new SimpleDateFormat("yyyy-MM-dd");

		Date now = new Date();
		String[] nows = sfYear.format(now).split("-");

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("curYear", nows[0]);
		dataMap.put("curMonth", nows[1]);
		dataMap.put("curDay", nows[2]);
		dataMap.put("teacher", teacher);
		dataMap.put("historyList", historyList);
		dataMap.put("homepageName", teacher.getHomepage_name());
		workbook = new XLSTransformer().transformXLS(new BufferedInputStream(new FileInputStream(new File(sampleFilePath))), dataMap);

		workbook.write(outputStream);
	}

	public int modifyManageHistory(Teacher teacher) {
		return dao.modifyManageHistory(teacher);
	}

	public String getRootPath() {
		return teacherStorage.getRootPath();
	}

	public Teacher getTeacherAgreeOne(Teacher teacher) {
		return dao.getTeacherAgreeOne(teacher);
	}

	public int addTeacherAgree(Teacher teacher) {
		return dao.addTeacherAgree(teacher);
	}

	public int deleteTeacherAgree(Teacher teacher) {
		return dao.deleteTeacherAgree(teacher);
	}

}