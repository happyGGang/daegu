package kr.go.gbelib.app.cms.module.teacherReqManage;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.go.gbelib.app.cms.module.teacher.Teacher;
import net.sf.classifier4J.util.WFMultiPartPost;

@Service
public class TeacherReqManageService extends BaseService {

	@Autowired
	private TeacherReqManageDao dao;

	@Autowired
	@Qualifier("teachReqManageStorage")
	private FileStorage teachReqManageStorage;

	public List<TeacherReqManage> getTeacherListAll(String homepage_id) {
		TeacherReqManage teacherReqManage = new TeacherReqManage();
		teacherReqManage.setHomepage_id(homepage_id);
		return dao.getTeacherListAll(teacherReqManage);
	}

	public List<TeacherReqManage> getTeacherList(TeacherReqManage teacherReqManage) {
		return dao.getTeacherList(teacherReqManage);
	}

	public int getTeacherListCount(TeacherReqManage teacherReqManage) {
		return dao.getTeacherListCount(teacherReqManage);
	}

	public List<TeacherReqManage> getTeacherApplyList(TeacherReqManage teacherReqManage) {
		return dao.getTeacherApplyList(teacherReqManage);
	}

	public int getTeacherApplyListCount(TeacherReqManage teacherReqManage) {
		return dao.getTeacherApplyListCount(teacherReqManage);
	}

	public TeacherReqManage getTeacherOne(TeacherReqManage teacherReqManage) {
		return dao.getTeacherOne(teacherReqManage);
	}

	public TeacherReqManage getTeacherApplyOne(TeacherReqManage teacherReqManage) {
		return dao.getTeacherApplyOne(teacherReqManage);
	}

	public TeacherReqManage checkTeacher(TeacherReqManage teacherReqManage) {
		return dao.checkTeacher(teacherReqManage);
	}

	public String addTeacher(TeacherReqManage teacherReqManage, HttpServletRequest request) {
		String fileList = "";
		MultipartFile mFile = teacherReqManage.getFile();

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + teacherReqManage.getHomepage_id();

			File f = teachReqManageStorage.addFile(mFile, realFileName, filePath);
			if (StringUtils.isEmpty(fileList)) {
				fileList = f.getPath() + f.getName() + "." + fileExtension;
			} else {
				fileList += "," + f.getPath() + f.getName() + "." + fileExtension;
			}

			teacherReqManage.setReal_file_name(realFileName);
			teacherReqManage.setFile_name(fileName);
			teacherReqManage.setFile_extension(fileExtension);
			teacherReqManage.setFile_size(f.length());
		} else {
			teacherReqManage.setFile_name(null);
		}

		List<MultipartFile> open_files = teacherReqManage.getOpen_file();
		if(open_files != null) {
			ObjectMapper mapper = new ObjectMapper();
			List<Map<String, String>> uploadedFiles = new ArrayList<Map<String, String>>();
			for(MultipartFile file: open_files) {
				Map<String, String> hash = new HashMap<String, String>();
				String dir		 		= "/" + teacherReqManage.getHomepage_id();
				String realFileName 	= teachReqManageStorage.generateUniqueFileName(teachReqManageStorage.getRootPath() + dir);
				String fileExtension 	= FilenameUtils.getExtension(file.getOriginalFilename());
				String fileName 		= file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf("."));

				File f = teachReqManageStorage.addFile(file, realFileName, dir);
				if (StringUtils.isEmpty(fileList)) {
					fileList = f.getPath();
				} else {
					fileList += "," + f.getPath();
				}

				hash.put("real_file_name", realFileName);
				hash.put("file_name", fileName);
				hash.put("file_extension", fileExtension);
				hash.put("file_size", String.valueOf(f.length()));
				hash.put("file_hash", CalculateHashUtils.calculateHash(realFileName).substring(0, 10));

				uploadedFiles.add(hash);
			}

			try {
				teacherReqManage.setTeacher_open_files(mapper.writeValueAsString(uploadedFiles));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		String filterCheck = null;
		try {
			filterCheck = webFilterCheck(teacherReqManage, fileList, request);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (filterCheck != null) {
			return filterCheck;
		}

		dao.addTeacher(teacherReqManage);

		return null;
	}

	public String modifyTeacher(TeacherReqManage teacherReqManage, HttpServletRequest request) {
		String fileList = "";
		MultipartFile mFile = teacherReqManage.getFile();
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + teacherReqManage.getHomepage_id();

			File f = teachReqManageStorage.addFile(mFile, realFileName, filePath);
			if (StringUtils.isEmpty(fileList)) {
				fileList = f.getPath();
			} else {
				fileList += "," + f.getPath();
			}

			teacherReqManage.setReal_file_name(realFileName);
			teacherReqManage.setFile_name(fileName);
			teacherReqManage.setFile_extension(fileExtension);
			teacherReqManage.setFile_size(f.length());
		} else {
			teacherReqManage.setFile_name(null);
		}

		List<MultipartFile> open_files = teacherReqManage.getOpen_file();
		if(open_files != null) {
			ObjectMapper mapper = new ObjectMapper();
			List<Map<String, String>> uploadedFiles = new ArrayList<Map<String, String>>();
			for(MultipartFile file: open_files) {
				Map<String, String> hash = new HashMap<String, String>();
				String dir		 		= "/" + teacherReqManage.getHomepage_id();
				String realFileName 	= teachReqManageStorage.generateUniqueFileName(teachReqManageStorage.getRootPath() + dir);
				String fileExtension 	= FilenameUtils.getExtension(file.getOriginalFilename());
				String fileName 		= file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf("."));

				File f = teachReqManageStorage.addFile(file, realFileName, dir);
				if (StringUtils.isEmpty(fileList)) {
					fileList = f.getPath();
				} else {
					fileList += "," + f.getPath();
				}

				hash.put("real_file_name", realFileName);
				hash.put("file_name", fileName);
				hash.put("file_extension", fileExtension);
				hash.put("file_size", String.valueOf(f.length()));
				hash.put("file_hash", CalculateHashUtils.calculateHash(realFileName).substring(0, 10));

				uploadedFiles.add(hash);
			}

			try {
				teacherReqManage.setTeacher_open_files(mapper.writeValueAsString(uploadedFiles));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		String filterCheck = null;
		try {
			filterCheck = webFilterCheck(teacherReqManage, fileList, request);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (filterCheck != null) {
			return filterCheck;
		}

		dao.modifyTeacher(teacherReqManage);

		return null;
	}

	public int deleteTeacher(TeacherReqManage teacherReqManage) {
		return dao.deleteTeacher(teacherReqManage);
	}

	public List<TeacherReqManage> getHistoryList(TeacherReqManage teacherReqManage) {
		return dao.getHistoryList(teacherReqManage);
	}

	public int confirmTeacher(TeacherReqManage teacherReqManage) {
		return dao.confirmTeacher(teacherReqManage);
	}

	public String getRootPath() {
		return teachReqManageStorage.getRootPath();
	}

	public int modifyManageHistory(Teacher teacher) {
		return dao.modifyManageHistory(teacher);
	}

	private String webFilterCheck(TeacherReqManage teacher, String fileList, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		/*
		 * WFMultiPartPost(웹서버도메인, 웹필터서버아이피, 웹필터서버포트)
		 */
		WFMultiPartPost wfsend = new WFMultiPartPost("gbelib.kr", "117.111.136.240", 80);

		/*
		 * WFMultiPartPost.sendWebFilter(작성자, 제목, 내용, 첨부파일경로)   - 첨부파일이 여러개 존재 시 , 로 구분하여 전송
		 * 웹필터서버 응답  : 	Y = 차단		 N = 등록			B = 바이패스
		 */

		String writer = "";
		if(teacher.getEditMode().equals("ADD")) {
			writer = teacher.getAdd_id();
		} else if(teacher.getEditMode().equals("MODIFY")) {
			writer = teacher.getMod_id();
		}
		String title = "재능기부/강사신청";

		StringBuilder content = new StringBuilder();
		content.append(teacher.getTeacher_subject_name())
		.append(teacher.getTeacher_education())
		.append(teacher.getTeacher_experience())
		.append(teacher.getTeacher_certifications());

		String wfResponse = wfsend.sendWebFilter(writer, title, content.toString(), fileList);
		if(wfResponse.equals("Y")){
			// 차단내용 팝업창 URL 출력
//			res.setValid(true);
//			res.setUrl(wfsend.getDenyURL());
//			res.setTargetOpener(true);

			// 필터에 걸리면 파일 삭제
			for(String path: StringUtils.split(fileList, ",")) {
			    FileUtils.deleteQuietly(new File(path));
			}

			return wfsend.getDenyURL();
		} else if(wfResponse.equals("N")){

			return null;
		} else if(wfResponse.equals("B")){

			return null;
		}
		return null;
	}
}