package kr.go.gbelib.app.module.walkingThru;

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
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruBlackList.WalkingThruBlackList;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruBlackList.WalkingThruBlackListService;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruPenalty.WalkingThruPenaltyService;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruRecord.WalkingThruRecord;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruRecord.WalkingThruRecordService;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting.WalkingThruSetting;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting.WalkingThruSettingService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.intro.search.LibrarySearchService;

@Controller(value="walkingThru")
@RequestMapping(value = {"/{homepagePath}/module/walkingThru"})
public class WalkingThruController extends BaseController {

	private String basePath = "/homepage/%s/module/walkingThru/";
	
	@Autowired
	private LibrarySearchService service;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private WalkingThruRecordService walkingThruRecordService;
	
	@Autowired
	private WalkingThruSettingService walkingThruSettingService;
	
	@Autowired
	private WalkingThruBlackListService walkingThruBlackListService;
	
	@Autowired
	private WalkingThruPenaltyService walkingThruPenaltyService;

	@RequestMapping(value = {"/index.*"})
	public String myUntactBookResve(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, WalkingThruRecord walkingThruRecord, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		walkingThruRecord.setHomepage_id(homepage.getHomepage_id());
		walkingThruRecord.setMember_id(member.getMember_id());
		
		int count = walkingThruRecordService.getWalkingThruRecordInfoCount(walkingThruRecord);
		walkingThruRecordService.setPaging(model, count, walkingThruRecord);
		walkingThruRecord.setTotalDataCount(count);
		
		model.addAttribute("walkingThruRecord", walkingThruRecord);
		model.addAttribute("walkingThruRecordCount", count);
		model.addAttribute("walkingThruRecordList", walkingThruRecordService.getWalkingThruRecordInfo(walkingThruRecord));
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/cancelReserve.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse cancelReserve(LibrarySearch librarySearch, WalkingThruRecord walkingThruRecord, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		
		JsonResponse res = new JsonResponse(request);
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			walkingThruRecord.setHomepage_id(homepage.getHomepage_id());
			walkingThruRecord.setCancel_ip(request.getRemoteAddr());
			List<WalkingThruRecord> walkingThruRecordList = walkingThruRecordService.getReservationList(walkingThruRecord);
			
			String request_number = String.valueOf(walkingThruRecordList.get(0).getRequest_number());
			
			Map<String, Object> resultList = LibSearchAPI.getReserveList(member.getRec_key());
			List<Map<String, Object>> list = null;
			if(resultList != null && !resultList.isEmpty() && resultList.get("LIST_DATA") != null){
				list = LibSearchAPI.getListData(resultList);
				String reckey = String.valueOf(list.get(0).get("PK"));
				librarySearch.setUserkey(member.getRec_key());
				librarySearch.setBookkey(reckey);
				ApiResponse apiResult = LibSearchAPI.cancelReservation2(librarySearch);
				
				if (apiResult.getStatus()) {
					walkingThruRecord.setRequest_number(Integer.parseInt(request_number));
					walkingThruRecord.setMember_id(member.getMember_id());
					walkingThruRecordService.cancelReserve(walkingThruRecord);
					res.setValid(true);
					res.setMessage("취소 되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("예약취소에 실패하였습니다.\nKLAS API 예약취소 오류 입니다. : " + apiResult.getMessage());
				}
			}
			
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = { "/form.*" }, method = RequestMethod.POST)
	public String untactBookForm(Model model, LibrarySearch librarySearch, WalkingThruSetting walkingThruSetting, WalkingThruRecord walkingThruRecord, WalkingThruBlackList walkingThruBlackList, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		Member member = getSessionMemberInfo(request);
		
		walkingThruRecord.setHomepage_id(homepage.getHomepage_id());
		walkingThruRecord.setMember_id(member.getMember_id());

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (librarySearch.getBooktype() == null) {
			librarySearch.setBooktype("BO");
		}
		
		walkingThruSetting = walkingThruSettingService.getWalkingThruSettingOne(homepage.getHomepage_id());
		
		if(walkingThruSetting == null) {
			service.alertMessage("워킹스루 도서대출이 불가능한 도서관입니다.", request, response);
			return null;
		}
		
		if (walkingThruSettingService.checkReserveTime(walkingThruSetting) == 0) {
			service.alertMessage("예약가능시간이 아닙니다.\\n예약가능시간은" + walkingThruSetting.getReservation_time() + " 입니다.", request, response);
			return null;
		}
		
		String penaltyEndDate = walkingThruPenaltyService.getEndDate(homepage.getHomepage_id());
		
		//페널티 초과 회원 예약 불가
		if(walkingThruBlackListService.getPenaltyCount(walkingThruBlackList) > 0 && walkingThruPenaltyService.getPenaltyCount(homepage.getHomepage_id()) > 0) {
			if (walkingThruBlackListService.getPenaltyCount(walkingThruBlackList) >= walkingThruPenaltyService.getPenaltyCount(homepage.getHomepage_id())) {
				service.alertMessage("현재 이용자님 께서는 관리자에 의해\\n\\n" + penaltyEndDate + "일 까지 워킹스루 도서대출 이용이 제한되어 있습니다.", request, response);
				return null; 
			}
		}
		
		Map<String, Object> result = LibSearchAPI.getBookInfo(librarySearch);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);
		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if (count > 0) {
			list = LibSearchAPI.getListData(result);
			model.addAttribute("detail", list.get(0));
		}

		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("termsList", walkingThruSettingService.getWalkingThruSettingTerms(homepage.getHomepage_id()));
		model.addAttribute("walkingThruSetting", walkingThruSetting);

		return String.format(basePath, homepage.getFolder()) + "form";
	}
	
	@RequestMapping(value = {"/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveUntactBook(Model model, LibrarySearch librarySearch, WalkingThruRecord walkingThruRecord, WalkingThruBlackList walkingThruBlackList, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		Member member = getSessionMemberInfo(request);

		JsonResponse res = new JsonResponse(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			res.setValid(false);
			res.setMessage("로그인 후 이용가능합니다.");
			return res;
		}
		
		if (!result.hasErrors()) {
			// 정회원만 가능
			if (!StringUtils.equals(member.getMember_class(), "0")) {
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}
			walkingThruRecord.setHomepage_id(homepage.getHomepage_id());
			walkingThruRecord.setMember_id(member.getMember_id());
			walkingThruRecord.setMember_name(member.getMember_name());
			
			walkingThruRecord.setRec_key(member.getUser_no());
			walkingThruRecord.setManage_code(homepage.getManage_code());
			walkingThruRecord.setUser_key(member.getRec_key());
			walkingThruRecord.setReg_no(librarySearch.getReg_no());
			
			librarySearch.setUserkey(walkingThruRecord.getUser_key());
			librarySearch.setManageCode(walkingThruRecord.getManage_code());
			//임시로 예약 만기일수 10일로 설정
			String expire_date = "10";
			librarySearch.setExprire_date_cnt(expire_date);
			
			//비대면도서대출(무인예약API)
			ApiResponse apiResult = LibSearchAPI.untactloanreserve(librarySearch);
			if (apiResult.getStatus()) {
				walkingThruRecordService.addWalkingThruRecord(walkingThruRecord);
				res.setValid(true);
				res.setMessage("예약 되었습니다.");
				
			} else {
				res.setValid(false);
				res.setMessage("[KLAS API 오류]\n" + apiResult.getMessage());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
