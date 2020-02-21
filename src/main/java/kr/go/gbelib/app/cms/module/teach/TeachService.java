package kr.go.gbelib.app.cms.module.teach;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.binding.BindingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.teach.student.StudentDao;
import kr.go.gbelib.app.common.api.PushAPI;

@Service
public class TeachService extends BaseService {

	@Autowired
	@Qualifier("teachStorage")
	private FileStorage teachStorage;

	@Autowired
	private TeachDao dao;

	@Autowired
	private StudentDao studentDao;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MenuService menuService;

	public List<Teach> getTeachListAll(Teach teach) {
		return dao.getTeachListAll(teach);
	}

	public List<Teach> getTeachList(Teach teach) {
		List<Teach> list = dao.getTeachList(teach);

		for (Teach teachOne : list) {
			String teach_day = teachOne.getTeach_day();
			teachOne.setTeach_day_arr(teach_day.split("\\,"));
			teachOne.setHolidays(dao.getHolidays(teachOne));
			if (StringUtils.isNotEmpty(teachOne.getProgram_age_div())) {
				teachOne.setProgram_age_div_arr(Arrays.asList(teachOne.getProgram_age_div().split(",")));
			}
		}
		return list;
	}

	public int getTeachListCount(Teach teach) {
		return dao.getTeachListCount(teach);
	}

	public Teach getTeachOne(Teach teach) {
		Teach result = dao.getTeachOne(teach);
		if (result != null) {
			if (StringUtils.isNotEmpty(result.getProgram_age_div())) {
				result.setProgram_age_div_arr(Arrays.asList(result.getProgram_age_div().split(",")));
			}
			result.setTeach_day_arr(result.getTeach_day().split("\\,"));
			result.setHolidays(dao.getHolidays(result));
		}

		return result;
	}

	@Transactional
	public int addTeach(Teach teach) {
		MultipartFile mFile = teach.getPlan_file();

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + teach.getHomepage_id();

			File f = teachStorage.addFile(mFile, realFileName, filePath);

			teach.setServer_file_name(realFileName);
			teach.setOrg_file_name(fileName);
			teach.setFile_extension(fileExtension);
			teach.setFile_size(f.length());
		}

		mFile = teach.getImage_plan_file();

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + teach.getHomepage_id()+"/img";

			File f = teachStorage.addFile(mFile, realFileName, filePath);

			teach.setImage_server_file_name(realFileName);
			teach.setImage_org_file_name(fileName);
			teach.setImage_file_extension(fileExtension);
			teach.setImage_file_size(f.length());
		}

		teach.setTeach_idx(dao.getNextTeachIdx(teach));
		if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
			for ( String str : teach.getHolidays() ) {
				teach.setHoliday(str);
				dao.addTeachHolidays(teach);
			}
		}

		if (teach.getProgram_age_div_arr() != null && teach.getProgram_age_div_arr().size() > 0) {
			teach.setProgram_age_div(StringUtils.join(teach.getProgram_age_div_arr(), ","));
		}

		return dao.addTeach(teach);
	}

	@Transactional
	public int modifyTeach(Teach teach) {
		MultipartFile mFile = teach.getPlan_file();

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + teach.getHomepage_id();

			File f = teachStorage.addFile(mFile, realFileName, filePath);

			teach.setServer_file_name(realFileName);
			teach.setOrg_file_name(fileName);
			teach.setFile_extension(fileExtension);
			teach.setFile_size(f.length());
		}

		mFile = teach.getImage_plan_file();
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + teach.getHomepage_id()+"/img";

			File f = teachStorage.addFile(mFile, realFileName, filePath);

			teach.setImage_server_file_name(realFileName);
			teach.setImage_org_file_name(fileName);
			teach.setImage_file_extension(fileExtension);
			teach.setImage_file_size(f.length());
		}

		Teach beforeTeach 		= dao.getTeachOne(teach);
		int beforeLimitCount 	= beforeTeach.getTeach_limit_count();
		int afterLimitCount 	= teach.getTeach_limit_count();

		if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
			dao.deleteTeachHolidays(teach);
			for ( String str : teach.getHolidays() ) {
				teach.setHoliday(str);
				dao.addTeachHolidays(teach);
			}
		}

		if (teach.getProgram_age_div_arr() != null && teach.getProgram_age_div_arr().size() > 0) {
			teach.setProgram_age_div(StringUtils.join(teach.getProgram_age_div_arr(), ","));
		}

		int result 				= dao.modifyTeach(teach);


		if ( result > 0 ) {
			if ( afterLimitCount > beforeLimitCount ) {
				List<Student> backupStudentList = studentDao.getBackupMemberList(teach);
				for ( int i = 0; i < (afterLimitCount - beforeLimitCount); i ++ ) {
					if ( i < backupStudentList.size() ) {
						Student backupStudent = backupStudentList.get(i);
						backupStudent.setApply_status("1");
						studentDao.modifyStudentStatus(backupStudent);

						Homepage homepage = homepageService.getHomepageOne(new Homepage(backupStudent.getHomepage_id()));
						PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, backupStudent.getApplicant_cell_phone(), String.format("[%s] 정상 참여 되었습니다.", teach.getTeach_name()), homepage.getHomepage_send_tell(), true);

					}
				}

			}
		}

		return result;
	}

	@Transactional
	public int deleteTeach(Teach teach) {
		int result = dao.deleteTeach(teach);
		if ( result > 0) {
			if (studentDao.deleteStudent(new Student(teach.getHomepage_id(), teach.getGroup_idx(), teach.getCategory_idx(), teach.getTeach_idx())) > 0) {
				dao.deleteTeachHolidays(teach);
			}
		}

		return result;
	}

	public List<Teach> getTeachListForCalendar(CalendarManage calendarManage) {
		List<Teach> list = dao.getTeachListForCalendar(calendarManage);
		for (Teach teach : list) {
			teach.setTeach_day_arr(teach.getTeach_day().split("\\,"));
			teach.setHolidays(dao.getHolidays(teach));
		}
		return list;
	}

	private String numbersOnly(String s) {
		if(s == null) {
			return null;
		} else {
			return s.replaceAll("[^,0-9]", "");
		}
	}

	public List<Teach> getTeachListForUser(Teach teach) {
		teach.setSearchCate1(numbersOnly(teach.getSearchCate1()));
		teach.setSearchCate2(numbersOnly(teach.getSearchCate2()));
		teach.setSearchCate3(numbersOnly(teach.getSearchCate3()));
		teach.setGroup_idx_list(numbersOnly(teach.getGroup_idx_list()));

		List<Teach> list = dao.getTeachListForUser(teach);
		if (list != null && list.size() > 0) {
			for (Teach result : list) {
				result.setTeach_day_arr(result.getTeach_day().split(","));
				result.setHolidays(dao.getHolidays(result));
			}
		}
		return list;
	}

	public List<Teach> getTeachListForAllHomepage(Teach teach) {
		List<Teach> list = dao.getTeachListForAllHomepage(teach);
		if (list != null && list.size() > 0) {
			for (Teach result : list) {
				Homepage homepage = homepageService.getHomepageOne(new Homepage(result.getHomepage_id()));
				result.setContext_path(homepage.getContext_path());
				result.setTeach_day_arr(result.getTeach_day().split(","));
				result.setHolidays(dao.getHolidays(result));
				Menu m = new Menu();
				m.setHomepage_id(homepage.getHomepage_id());
				m.setMenu_idx(97);
				result.setMenu_idx(menuService.getMenuIdxByProgramIdx(m));
				if (StringUtils.isNotEmpty(result.getProgram_age_div())) {
					result.setProgram_age_div_arr(Arrays.asList(result.getProgram_age_div().split(",")));
				}
			}
		}
		return list;
	}

	private String sanitizeLogicFunction(String logicFunction) {
		if(StringUtils.equals(logicFunction, "AND")) {
			return logicFunction;
		} else if(StringUtils.equals(logicFunction, "OR")) {
			return logicFunction;
		} else if(StringUtils.equals(logicFunction, "NOT")) {
			return logicFunction;
		} else {
			return null;
		}
	}

	public int getTeachListForAllHomepageCount(Teach teach) {
		teach.setLogicFunction1(sanitizeLogicFunction(teach.getLogicFunction1()));
		teach.setLogicFunction2(sanitizeLogicFunction(teach.getLogicFunction2()));
		teach.setLogicFunction3(sanitizeLogicFunction(teach.getLogicFunction3()));
		teach.setLogicFunction4(sanitizeLogicFunction(teach.getLogicFunction4()));
		return dao.getTeachListForAllHomepageCount(teach);
	}

	public Teach getTeachDetailForUser(Teach teach) {
		teach = dao.getTeachDetailForUser(teach);
		if ( teach != null ) {
			teach.setTeach_day_arr(teach.getTeach_day().split(","));
			teach.setHolidays(dao.getHolidays(teach));
			if (StringUtils.isNotEmpty(teach.getProgram_age_div())) {
				teach.setProgram_age_div_arr(Arrays.asList(teach.getProgram_age_div().split(",")));
			}
		}

		return teach;
	}

	public List<Teach> getApplyList(Teach teach) {
		List<Teach> list = dao.getApplyList(teach);
		if (list != null && list.size() > 0) {
			for (Teach result : list) {
				result.setTeach_day_arr(result.getTeach_day().split(","));
				result.setHolidays(dao.getHolidays(result));
				if (StringUtils.isNotEmpty(result.getProgram_age_div())) {
					result.setProgram_age_div_arr(Arrays.asList(result.getProgram_age_div().split(",")));
				}
				if(result.getTeach_status().equals("3")) {
					try {
						result.setMember_key(teach.getMember_key());
						result.setWait_num(dao.getWaitingNumber(result));
					} catch(BindingException be) {
						result.setWait_num(0);
					}
				}
			}
		}
		return list;
	}

	public int getPrintMaxValue(Teach teach) {
		return dao.getPrintMaxValue(teach);
	}

	public String getRootPath() {
		return teachStorage.getRootPath();
	}

	public List<Teach> getSameTeachByName(Teach teach) {
		return dao.getSameTeachByName(teach);
	}

	public List<Teach> getMainViewTeachList(Teach teach) {
		return dao.getMainViewTeachList(teach);
	}

	public List<Teach> getMainViewTeachListForAllHomepage(Teach teach) {
		return dao.getMainViewTeachListForAllHomepage(teach);
	}

	public int deleteFile(Teach teach) {
		teach = dao.getTeachOne(teach);
		String fileName = teach.getServer_file_name();
		String filePath = teach.getHomepage_id();
		teachStorage.deleteFile(fileName, filePath);
		return dao.deleteFile(teach);

	}

	public int deleteImage(Teach teach) {
		teach = dao.getTeachOne(teach);
		String fileName = teach.getImage_server_file_name();
		String filePath = teach.getHomepage_id();
		teachStorage.deleteFile(fileName, filePath);
		return dao.deleteImage(teach);
	}

	public void sendSmsTeachCancle() {

		// homewas2_homepage3 컨테이너에서만 실행
		if(StringUtils.equals(System.getProperty("whalesoft.container"), "homewas2_homepage3")) {
			List<Teach> teachList = dao.getSchaduleTeach();

			if(teachList != null) {
				for(Teach teach : teachList) {

					if(teach.getSms_flag() == 1) {
						continue;
					}

					Homepage homepage = homepageService.getHomepageOne(new Homepage(teach.getHomepage_id()));
					String message = teach.getCancle_guid();

					Student student = new Student();
					student.setTeach_idx(teach.getTeach_idx());
					List<Student> studentList = studentDao.sendSmsTeachCancle(student);

					for(Student one : studentList) {
						if (isSmsReceive("USERID", one.getMember_id())) {
							PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, one.getApplicant_cell_phone(), message, homepage.getHomepage_send_tell(), true);
						}
					}
				}
			}
		}

	}

}