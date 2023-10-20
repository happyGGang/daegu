package kr.go.gbelib.app.cms.module.teach;

import com.google.common.collect.Maps;
import java.io.File;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.xml.bind.annotation.XmlElement;

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
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

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
			if (StringUtils.isEmpty(teachOne.getTeacher_name())) {
				teachOne.setTeacher_name(dao.getTeacherName(teachOne));
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
			if (StringUtils.isEmpty(result.getTeacher_name())) {
				result.setTeacher_name(dao.getTeacherName(result));
			}
			String[] start_join_time = divideTime(result.getStart_join_time());
			String[] end_join_time = divideTime(result.getEnd_join_time());
			String[] start_cancle_time = divideTime(result.getStart_cancle_time());
			String[] end_cancle_time = divideTime(result.getEnd_cancle_time());
			String[] start_time = divideTime(result.getStart_time());
			String[] end_time = divideTime(result.getEnd_time());

			if (start_join_time != null) {
				result.setStart_join_time1(start_join_time[0]);
				result.setStart_join_time2(start_join_time[1]);
			}
			if (end_join_time != null) {
				result.setEnd_join_time1(end_join_time[0]);
				result.setEnd_join_time2(end_join_time[1]);
			}
			if (start_cancle_time != null) {
				result.setStart_cancle_time1(start_cancle_time[0]);
				result.setStart_cancle_time2(start_cancle_time[1]);
			}
			if (end_cancle_time != null) {
				result.setEnd_cancle_time1(end_cancle_time[0]);
				result.setEnd_cancle_time2(end_cancle_time[1]);
			}
			if (start_time != null) {
				result.setStart_time1(start_time[0]);
				result.setStart_time2(start_time[1]);
			}
			if (end_time != null) {
				result.setEnd_time1(end_time[0]);
				result.setEnd_time2(end_time[1]);
			}
		}

		return result;
	}

	private String[] divideTime(String s) {
		if (StringUtils.isBlank(s)) {
			return null;
		} else {
			return s.split("\\:");
		}
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
		
		mFile = teach.getAttach_file();
		if(mFile != null) {
			String realFileName = Long.toString(System.currentTimeMillis());
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/" + teach.getHomepage_id();
			
			File f = teachStorage.addFile(mFile, realFileName, filePath);
			
			teach.setAttach_server_file_name(realFileName);
			teach.setAttach_org_file_name(fileName);
			teach.setAttach_file_extension(fileExtension);
			teach.setAttach_file_size(f.length());
		}

		teach.setTeach_idx(dao.getNextTeachIdx(teach));
		if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
			for ( String str : teach.getHolidays() ) {
				if(StringUtils.isNotEmpty(str)) {
    				teach.setHoliday(str);
    				dao.addTeachHolidays(teach);
				}
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

		mFile = teach.getAttach_file();
		if(mFile != null) {
			String realFileName = Long.toString(System.currentTimeMillis());
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/" + teach.getHomepage_id();
			
			File f = teachStorage.addFile(mFile, realFileName, filePath);
			
			teach.setAttach_server_file_name(realFileName);
			teach.setAttach_org_file_name(fileName);
			teach.setAttach_file_extension(fileExtension);
			teach.setAttach_file_size(f.length());
		}
		
		Teach beforeTeach 		= dao.getTeachOne(teach);
		int beforeLimitCount 	= beforeTeach.getTeach_limit_count();
		int afterLimitCount 	= teach.getTeach_limit_count();

		dao.deleteTeachHolidays(teach);
		if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
			for ( String str : teach.getHolidays() ) {
				if(StringUtils.isNotEmpty(str)) {
					teach.setHoliday(str);
					dao.addTeachHolidays(teach);
				}
			}
		}

		if (teach.getProgram_age_div_arr() != null && teach.getProgram_age_div_arr().size() > 0) {
			teach.setProgram_age_div(StringUtils.join(teach.getProgram_age_div_arr(), ","));
		}

		int result = dao.modifyTeach(teach);


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

		List<Teach> teachListForUser = dao.getTeachListForUser(teach);

		if (teachListForUser != null && teachListForUser.size() > 0) {
			final List<Integer> teachIdxs = teachListForUser.stream()
				.map(Teach::getTeach_idx)
				.collect(Collectors.toList());

			final Map<String, Object> teachIdxMap = Maps.newHashMap();
			teachIdxMap.put("teachIdxs", teachIdxs);
			final List<Teach> holidaysForUser = dao.getHolidaysForUser(teachIdxMap);

			for (Teach result : teachListForUser) {
				result.setTeach_day_arr(result.getTeach_day().split(","));

				final List<String> holidays = holidaysForUser.stream()
					.filter(holiday -> holiday.getTeach_idx() == result.getTeach_idx())
					.map(Teach::getHoliday)
					.collect(Collectors.toList());

				result.setHolidays(holidays);

			}
		}
		return teachListForUser;
	}
	public List<Teach> getTeachListHomepage(Teach teach) {
		teach.setSearchCate1(numbersOnly(teach.getSearchCate1()));
		teach.setSearchCate2(numbersOnly(teach.getSearchCate2()));
		teach.setSearchCate3(numbersOnly(teach.getSearchCate3()));
		teach.setGroup_idx_list(numbersOnly(teach.getGroup_idx_list()));

		List<Teach>	getTeatchList = Optional.ofNullable(dao.getTeachListHomepage(teach))
										   .orElseGet(Collections::emptyList)
										   .stream()
										   .filter(teachItem -> !teach.getHomepage_id().equals("h77") || !teachItem.getTeach_status().equals("9"))
										   .collect(Collectors.toList());

		if (getTeatchList.size() > 0) {
			for (Teach result : getTeatchList) {
				result.setTeach_day_arr(result.getTeach_day().split(","));
				result.setHolidays(dao.getHolidays(result));
				if (StringUtils.isEmpty(result.getTeacher_name())) {
					result.setTeacher_name(dao.getTeacherName(result));
				}
			}
		}
		return getTeatchList;
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
				m.setMenu_url_param("searchCate1="+result.getLarge_category_idx());
				result.setMenu_idx(menuService.getMenuIdxByProgramIdx(m));
				if (StringUtils.isNotEmpty(result.getProgram_age_div())) {
					result.setProgram_age_div_arr(Arrays.asList(result.getProgram_age_div().split(",")));
				}
				if (StringUtils.isEmpty(result.getTeacher_name())) {
					result.setTeacher_name(dao.getTeacherName(result));
				}
			}
		}
		return list;
	}

	public List<Teach> getTeachListForAllCulture(Teach teach, String view_yn) {
		teach.setCulture_view_yn(view_yn);
		if (StringUtils.isNotEmpty(teach.getCulture_view_yn()) && "Y".equals(teach.getCulture_view_yn())) {
			teach.setEndRowNum(20);
		}
		List<Teach> list = dao.getTeachListForAllCulture(teach);

		if (list != null && list.size() > 0) {
			for (Teach result : list) {
				Homepage homepage = homepageService.getHomepageOne2(new Homepage(result.getHomepage_id()));
				result.setContext_path(homepage.getContext_path());
				result.setTeach_day_arr(result.getTeach_day().split(","));
				result.setHolidays(dao.getHolidays(result));
				Menu m = new Menu();
				m.setHomepage_id(homepage.getHomepage_id());
				m.setMenu_idx(97);
				m.setMenu_url_param("searchCate1="+result.getLarge_category_idx());
				result.setMenu_idx(menuService.getMenuIdxByProgramIdx3(m));
				if (StringUtils.isNotEmpty(result.getProgram_age_div())) {
					result.setProgram_age_div_arr(Arrays.asList(result.getProgram_age_div().split(",")));
				}
				if (StringUtils.isEmpty(result.getTeacher_name())) {
					result.setTeacher_name(dao.getTeacherName(result));
				}
			}
		}

		return list;
	}

	private Teach getSearchDate(Teach teach) {
		if (StringUtils.isNotEmpty(teach.getSearch_yy()) && StringUtils.isNotEmpty(teach.getSearch_mm())) {

			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(teach.getSearch_yy()), Integer.parseInt(teach.getSearch_mm()) - 1, 1); //월은 -1해줘야 해당월로 인식

			String yy = teach.getSearch_yy();
			String mm = teach.getSearch_mm();

			teach.setSearch_start_date(yy + mm + String.format("%02d", 1));
			teach.setSearch_end_date(yy + mm + cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		}

		return teach;
	}

	public List<Teach> getTeachListForAllSearchCulture(Teach teach) {

		teach = getSearchDate(teach);

		List<Teach> list = dao.getTeachListForAllSearchCulture(teach);

		if (list != null && list.size() > 0) {
			for (Teach result : list) {
				Homepage homepage = homepageService.getHomepageOne2(new Homepage(result.getHomepage_id()));
				result.setContext_path(homepage.getContext_path());
				result.setTeach_day_arr(result.getTeach_day().split(","));
				result.setHolidays(dao.getHolidays(result));
				Menu m = new Menu();
				m.setHomepage_id(homepage.getHomepage_id());
				m.setMenu_idx(97);
				m.setMenu_url_param("searchCate1="+result.getLarge_category_idx());
				result.setMenu_idx(menuService.getMenuIdxByProgramIdx3(m));
				if (StringUtils.isNotEmpty(result.getProgram_age_div())) {
					result.setProgram_age_div_arr(Arrays.asList(result.getProgram_age_div().split(",")));
				}
				if (StringUtils.isEmpty(result.getTeacher_name())) {
					result.setTeacher_name(dao.getTeacherName(result));
				}
			}
		}
		return list;
	}

	public int getTeachListForAllSearchCultureCount(Teach teach) {
		teach = getSearchDate(teach);

		return dao.getTeachListForAllSearchCultureCount(teach);
	}

	public List<Teach> getTeachListForAllHomepageRamdom(Teach teach) {
		List<Teach> list = dao.getTeachListForAllHomepageRamdom(teach);
		if (list != null && list.size() > 0) {
			for (Teach result : list) {
				Homepage homepage = homepageService.getHomepageOne(new Homepage(result.getHomepage_id()));
				result.setContext_path(homepage.getContext_path());
				result.setTeach_day_arr(result.getTeach_day().split(","));
				result.setHolidays(dao.getHolidays(result));
				Menu m = new Menu();
				m.setHomepage_id(homepage.getHomepage_id());
				m.setMenu_idx(97);
				m.setMenu_url_param("searchCate1="+result.getLarge_category_idx());
				result.setMenu_idx(menuService.getMenuIdxByProgramIdx(m));
				if (StringUtils.isNotEmpty(result.getProgram_age_div())) {
					result.setProgram_age_div_arr(Arrays.asList(result.getProgram_age_div().split(",")));
				}
				if (StringUtils.isEmpty(result.getTeacher_name())) {
					result.setTeacher_name(dao.getTeacherName(result));
				}
			}
		}
		return list;
	}

	public List<Teach> getTeachListForAllHomepageGugun(Teach teach) {
		List<Teach> list = dao.getTeachListForAllHomepageGugun(teach);
		if (list != null && list.size() > 0) {
			for (Teach result : list) {
				Homepage homepage = homepageService.getHomepageOne(new Homepage(result.getHomepage_id()));
				result.setHomepage_name(homepage.getHomepage_name());
				if (!homepage.getHomepage_group().equals("ALL")) {
					homepage = homepageService.getHomepageOne(new Homepage(homepage.getHomepage_group()));
				}
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
				if (StringUtils.isEmpty(result.getTeacher_name())) {
					result.setTeacher_name(dao.getTeacherName(result));
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

	public int getTeachListForAllHomepageGugunCount(Teach teach) {
		teach.setLogicFunction1(sanitizeLogicFunction(teach.getLogicFunction1()));
		teach.setLogicFunction2(sanitizeLogicFunction(teach.getLogicFunction2()));
		teach.setLogicFunction3(sanitizeLogicFunction(teach.getLogicFunction3()));
		teach.setLogicFunction4(sanitizeLogicFunction(teach.getLogicFunction4()));
		return dao.getTeachListForAllHomepageGugunCount(teach);
	}

	public Teach getTeachDetailForUser(Teach teach) {
		teach = dao.getTeachDetailForUser(teach);
		if ( teach != null ) {
			teach.setTeach_day_arr(teach.getTeach_day().split(","));
			teach.setHolidays(dao.getHolidays(teach));
			if (StringUtils.isNotEmpty(teach.getProgram_age_div())) {
				teach.setProgram_age_div_arr(Arrays.asList(teach.getProgram_age_div().split(",")));
			}
			if (StringUtils.isEmpty(teach.getTeacher_name())) {
				teach.setTeacher_name(dao.getTeacherName(teach));
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
				
				if(StringUtils.isEmpty(teach.getMember_key())) {
					result.setApply_name(teach.getApply_name());
					result.setApply_password(teach.getApply_password());
				}
				
				result.setMember_key(teach.getMember_key());
				Map<String, Object> waitNumber = dao.getWaitingNumber(result);
				if(waitNumber != null) {
					result.setStatus(String.valueOf(waitNumber.get("APPLY_STATUS")));
					result.setWait_num(Integer.parseInt(String.valueOf(waitNumber.get("WAIT_NUM"))));
				}
				
				if(teach.getHomepage_id().equals("h32")) {
					Homepage homepage = homepageService.getHomepageOne(new Homepage(result.getHomepage_id()));
					result.setContext_path(homepage.getContext_path());
					result.setHomepage_alias(homepage.getHomepage_alias());
					
					Menu m = new Menu();
					m.setHomepage_id(homepage.getHomepage_id());
					m.setMenu_idx(93);
					result.setMenu_idx(menuService.getMenuIdxByProgramIdx(m));
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
	
	public int deleteAttach(Teach teach) {
		teach = dao.getTeachOne(teach);
		String fileName = teach.getAttach_server_file_name();
		String filePath = teach.getHomepage_id();
		teachStorage.deleteFile(fileName, filePath);
		return dao.deleteAttach(teach);
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
	
	// Teach API 쿼리
	public List<Teach> getTeachApiList(Teach teach) {
		return dao.getTeachApiList(teach);
	}

	public List<Teach> getApplyListAll(Teach teach) {
		return dao.getApplyListAll(teach);
	}

	public int getApplyListAllCount(Teach teach) {
		return dao.getApplyListAllCount(teach);
	}

	public int getCultureViewCount(Teach teach) {
		return dao.getCultureViewCount(teach);
	}

	public List<Teach> getKioskTeachListForUser(Teach teach) {
		teach.setSearchCate1(numbersOnly(teach.getSearchCate1()));
		teach.setSearchCate2(numbersOnly(teach.getSearchCate2()));
		teach.setSearchCate3(numbersOnly(teach.getSearchCate3()));
		teach.setGroup_idx_list(numbersOnly(teach.getGroup_idx_list()));

		List<Teach> teachListForUser = dao.getKioskTeachListForUser(teach);

		if (teachListForUser != null && teachListForUser.size() > 0) {
			final List<Integer> teachIdxs = teachListForUser.stream()
															.map(Teach::getTeach_idx)
															.collect(Collectors.toList());

			final Map<String, Object> teachIdxMap = Maps.newHashMap();
			teachIdxMap.put("teachIdxs", teachIdxs);
			final List<Teach> holidaysForUser = dao.getHolidaysForUser(teachIdxMap);

			for (Teach result : teachListForUser) {
				result.setTeach_day_arr(result.getTeach_day().split(","));

				final List<String> holidays = holidaysForUser.stream()
															 .filter(holiday -> holiday.getTeach_idx() == result.getTeach_idx())
															 .map(Teach::getHoliday)
															 .collect(Collectors.toList());

				result.setHolidays(holidays);

			}
		}
		return teachListForUser;
	}

	@XmlElement(name = "test")
	public List<Teach> getInternationalDataRoomList(Teach teach) {
		return dao.getInternationalDataRoomList(teach);
	}
}
