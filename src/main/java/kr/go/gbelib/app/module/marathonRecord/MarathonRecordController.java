package kr.go.gbelib.app.module.marathonRecord;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.marathon.Marathon;
import kr.go.gbelib.app.cms.module.marathon.MarathonService;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicant;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicantService;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecord;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecordService;
import kr.go.gbelib.app.cms.module.marathonType.MarathonTypeService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller(value= "userMarathonRecord")
@RequestMapping(value = {"/{homepagePath}/module/marathonRecord"})
public class MarathonRecordController extends BaseController{

	private final String basePath = "/homepage/%s/module/marathonRecord/";

	@Autowired
	private MarathonRecordService service;
	
	@Autowired
	private MarathonService marathonService;

	@Autowired
	private MarathonApplicantService marathonApplicantService;
	
	@Autowired
	private MenuService menuService;

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, MarathonRecord marathonRecord, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			marathonRecord.setBefore_url(String.format("/%s/module/marathonRecord/index.do?menu_idx=%s", homepage.getContext_path(), marathonRecord.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), marathonRecord.getMenu_idx(), marathonRecord.getBefore_url()), request, response);
		}else {
			Marathon marathonUseOne = new Marathon();
			marathonUseOne.setHomepage_id(homepage.getHomepage_id());
			marathonUseOne = marathonService.getMarathonUseOne(marathonUseOne);
			model.addAttribute("ing", marathonUseOne != null);
			if(marathonUseOne != null) {
				String contest_start_day = marathonUseOne.getContest_start_day();
				String contest_end_day = marathonUseOne.getContest_end_day();
				
				Date date = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date contest_start_date = dateFormat.parse(contest_start_day);
				Date contest_end_date = dateFormat.parse(contest_end_day);

				Calendar cal = Calendar.getInstance();
				cal.setTime(contest_end_date);
				cal.add(Calendar.DATE, 1);

				model.addAttribute("checkNoStart", contest_start_date.compareTo(date) > 0);
				model.addAttribute("checkEnd", date.compareTo(cal.getTime()) > 0);
				
				MarathonApplicant marathonApplicant = new MarathonApplicant();
				marathonApplicant.setHomepage_id(homepage.getHomepage_id());
				marathonApplicant.setContest_idx(marathonUseOne.getContest_idx());
				marathonApplicant.setMember_id(getSessionMemberId(request));

				marathonApplicant = marathonApplicantService.getMarathonApplicantOneById(marathonApplicant);
				if(marathonApplicant != null) {
					marathonRecord.setHomepage_id(homepage.getHomepage_id());
					marathonRecord.setContest_idx(marathonUseOne.getContest_idx());
					marathonRecord.setMember_id(getSessionMemberId(request));
					marathonRecord.setApplicant_idx(marathonApplicant.getApplicant_idx());
					marathonRecord.setContest_type_idx(marathonApplicant.getContest_type_idx());

					service.setPaging(model, service.getMarathonRecordCount(marathonRecord), marathonRecord);
					model.addAttribute("marathonRecord", marathonRecord);
					model.addAttribute("marathonRecordList", service.getMarathonRecordList(marathonRecord));

					return String.format(basePath, homepage.getFolder()) + "index";
				}else {
					service.alertMessageAndUrl("독서마라톤대회에 참가 신청하지 않았습니다. 참가 신청 페이지로 이동합니다.", String.format("/%s/module/marathonApplicant/edit.do?menu_idx=105", homepage.getContext_path()), request, response);
					return null;
				}
			}else {
				service.alertMessage("독서마라톤대회가 없습니다.", request, response);
				return null;
			}
		}
		return null;
	}
	
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, MarathonRecord marathonRecord, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
		marathonRecord.setBefore_url(String.format("/%s/module/marathonRecord/index.do?menu_idx=%s", homepage.getContext_path(), marathonRecord.getMenu_idx()));
		service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), marathonRecord.getMenu_idx(), marathonRecord.getBefore_url()), request, response);
		} else {
			MarathonApplicant marathonApplicant = new MarathonApplicant(); //신청자 정보
			marathonApplicant.setHomepage_id(homepage.getHomepage_id());
			marathonApplicant.setContest_idx(marathonRecord.getContest_idx());
			marathonApplicant.setContest_type_idx(marathonRecord.getContest_type_idx());
			marathonApplicant.setMember_id(getSessionMemberId(request));
			int applicant_idx = marathonApplicantService.getMarathonApplicantIdx(marathonApplicant);
			marathonApplicant.setApplicant_idx(applicant_idx);
			marathonRecord.setApplicant_idx(applicant_idx);
			marathonRecord.setMember_id(getSessionMemberId(request));

			marathonApplicant = marathonApplicantService.getMarathonApplicantOne(marathonApplicant);
			List<MarathonRecord> recordList = service.getMarathonRecordList(marathonRecord);
			int page_count_total = 0;
			if(recordList.size() != 0) {
				page_count_total = service.getTotalPageCount(marathonRecord);
			}
			
			if(marathonRecord.getEditMode().equals("ADD")) {
				marathonRecord.setRecord_date(new Date());
				model.addAttribute("marathonRecord", marathonRecord);
			}else if(marathonRecord.getEditMode().equals("MODIFY")) {
				model.addAttribute("marathonRecord", service.copyObjectPaging(marathonRecord, service.getMarathonRecordOne(marathonRecord)));
			}
			model.addAttribute("marathonApplicant", marathonApplicant);
			model.addAttribute("page_count_total", page_count_total);
			return String.format(basePath, homepage.getFolder()) + "edit";
		}
		return null;
	}
	
	@RequestMapping(value = {"/loan/history.*"})
	public String myLoan(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
			librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
		}
		if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
			librarySearch.setSearch_end_date(sdf.format(new Date()));
		}

		librarySearch.setUserkey(member.getRec_key());
		Map<String, Object> result = LibSearchAPI.getBookLoanHistory(librarySearch);

		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);
		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
			list = LibSearchAPI.getListData(result);
		}

		int minIndex;
		for (int i = 0; i < list.size() - 1; i++) {
			minIndex = i;
			for (int j = i + 1; j < list.size(); j++) {
				String a = (String) list.get(minIndex).get("LOAN_DATE");
				a = a.replaceAll("/", "-");
				Date firstDate = sdf.parse(a);
				String b = (String) list.get(j).get("LOAN_DATE");
				b = b.replaceAll("/", "-");
				Date secondDate = sdf.parse(b);
				int compare = firstDate.compareTo(secondDate);
				if (compare < 0) {
					minIndex = j;
				}
			}
			Map<String, Object> temp = list.get(minIndex);
			list.set(minIndex, list.get(i));
			list.set(i, temp);
		}
		model.addAttribute("loanList", list);
		
		return String.format(basePath, homepage.getFolder()) + "loan/history_ajax";
	}


	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(MarathonRecord marathonRecord, BindingResult result, HttpServletRequest request) throws Exception{
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		marathonRecord.setHomepage_id(homepage.getHomepage_id());
		/* 유효성 검증 >>>>>>>>>>>>>>> */
		if(marathonRecord.getEditMode().equals("ADD") || marathonRecord.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "contest_idx", "대회명을 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_idx", "신청자 번호를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "book_name", "도서명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "read_page_count", "읽은 쪽수를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "book_resources", "대출/구입처를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "book_get_date", "대출/구입 날짜를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "book_type", "분류번호를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "book_author", "저자를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "publisher", "출판사를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "book_journals", "독서감상문을 입력해 주세요.");
			
			if(!validationDate(marathonRecord.getBook_get_date())) {
				result.reject("대출/구입 날짜 형식이 맞지 않습니다.");
			}
			if(marathonRecord.getContest_type_idx() == 1) {
				if (marathonRecord.getBook_journals().length() < 30) {
					result.reject("독서감상문은 띄어쓰기 빈칸을 포함하여 30자 이상 기록하여야 합니다.");
				}
			} else {
				if (marathonRecord.getBook_journals().length() < 50) {
					result.reject("독서감상문은 띄어쓰기 빈칸을 포함하여 50자 이상 기록하여야 합니다.");
				}
			}
			
			if(getSessionMemberId(request) != null) {
				if(!getSessionMemberLoginType(request).equals("HOMEPAGE")) {
					result.reject("올바른 홈페이지에 접속해 주세요.");
				}
			}else {
				result.reject("로그인 유지 시간이 끝났습니다. 재로그인 후 저장해 주세요.");
			}
			
			MarathonApplicant marathonApplicant = new MarathonApplicant();
			marathonApplicant.setHomepage_id(homepage.getHomepage_id());
			marathonApplicant.setContest_idx(marathonRecord.getContest_idx());
			marathonApplicant.setMember_id(getSessionMemberId(request));

			marathonApplicant = marathonApplicantService.getMarathonApplicantOneById(marathonApplicant);
			if(marathonApplicant == null) {
				result.reject("독서마라톤대회에 참가신청하지 않았습니다.");
			}
		}
		/* <<<<<<<<<<<<<<<< 유효성 검증 */
		if(!result.hasErrors()) {
			MarathonApplicant marathonApplicant = new MarathonApplicant();
			marathonApplicant.setHomepage_id(marathonRecord.getHomepage_id());
			marathonApplicant.setContest_idx(marathonRecord.getContest_idx());
			marathonApplicant.setContest_type_idx(marathonRecord.getContest_type_idx());
			marathonApplicant.setApplicant_idx(marathonRecord.getApplicant_idx());
			int read_page_count_total = marathonApplicantService.getReadPageCountTotal(marathonApplicant);

			if(marathonRecord.getEditMode().equals("ADD")) {
				marathonApplicant.setMember_id(getSessionMemberId(request));
				read_page_count_total += marathonRecord.getRead_page_count();
				marathonApplicant.setRead_page_count_total(read_page_count_total);

				marathonRecord.setMember_id(getSessionMemberId(request));
				marathonRecord.setMember_name(marathonApplicantService.getMarathonApplicantName(marathonApplicant));
				int addResult = service.addMarathonRecord(marathonRecord, marathonApplicant);
				if(addResult > 0) {
					res.setValid(true);
					res.setMessage("등록되었습니다.");
					res.setUrl("index.do?menu_idx=108");
				}else {
					result.reject("등록에 실패하였습니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				}
			}else if(marathonRecord.getEditMode().equals("MODIFY")) {
				read_page_count_total = read_page_count_total - marathonRecord.getRead_page_count_beforeChange() + marathonRecord.getRead_page_count();
				marathonApplicant.setRead_page_count_total(read_page_count_total);
				int modifyRecordResult = service.modifyMarathonRecord(marathonRecord, marathonApplicant);
				if(modifyRecordResult > 0) {
					res.setValid(true);
					res.setMessage("수정되었습니다.");
					res.setUrl("index.do?menu_idx=108");
				}else {
					result.reject("수정에 실패하였습니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				}
			}else if(marathonRecord.getEditMode().equals("DELETE")) {
				for(int i = 0; i < marathonRecord.getRead_page_count_arr().length; i++) {
					read_page_count_total = read_page_count_total - marathonRecord.getRead_page_count_arr()[i];
				}
				marathonApplicant.setRead_page_count_total(read_page_count_total);
				int deleteResult = service.deleteMarathonRecord(marathonRecord, marathonApplicant);
				if(deleteResult > 0) {
					res.setValid(true);
					res.setMessage("삭제하였습니다.");
					res.setUrl("index.do?menu_idx=108");
				}else {
					result.reject("삭제에 실패하였습니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				}
			}
		}else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	private boolean validationDate(String checkDate) {
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			dateFormat.setLenient(false);
			dateFormat.parse(checkDate);
			return true;
		}catch(ParseException e) {
			return false;
		}
	}
}
