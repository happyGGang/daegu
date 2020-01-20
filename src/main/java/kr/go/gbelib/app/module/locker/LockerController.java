package kr.go.gbelib.app.module.locker;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.blackList.BlackList;
import kr.go.gbelib.app.cms.module.blackList.BlackListService;
import kr.go.gbelib.app.cms.module.locker.Locker;
import kr.go.gbelib.app.cms.module.locker.LockerService;
import kr.go.gbelib.app.cms.module.lockerPre.LockerPre;
import kr.go.gbelib.app.cms.module.lockerPre.LockerPreService;
import kr.go.gbelib.app.cms.module.lockerReq.LockerReq;
import kr.go.gbelib.app.cms.module.lockerReq.LockerReqService;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller(value="userLocker")
@RequestMapping(value = {"/{homepagePath}/module/locker"})
public class LockerController extends BaseController {

	private String basePath = "/homepage/%s/module/locker/";

	@Autowired
	private LockerService service;

	@Autowired
	private LockerPreService lockerPreService;

	@Autowired
	private LockerReqService lockerReqService;

	@Autowired
	private BlackListService blackListService;

	@Autowired
	private TermsService termsService;

	@Autowired
	private RecommendSiteService recommendSiteService;

	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Locker locker, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		int maxLockerPreIdx = lockerPreService.getMaxIdxOfLockerPre(new LockerPre(homepage.getHomepage_id()));
		locker.setLocker_pre_idx(maxLockerPreIdx);
		LockerPre lockerPre = lockerPreService.getLockerPreOne(new LockerPre(homepage.getHomepage_id(), maxLockerPreIdx));

		Member member = getSessionMemberInfo(request);
		locker.setHomepage_id(homepage.getHomepage_id());
		locker.setMember_key(member.getSeq_no());

		Locker lockerMember = service.getLockerAddFlag(locker);

		if ( lockerPre != null ) {
			String[] pattern = {"yyyy-MM-dd HH:mm"};

			Date applyStartDate = DateUtils.parseDate(String.format("%s %s", lockerPre.getApply_start_date(), StringUtils.isEmpty(lockerPre.getApply_start_time()) ? "00:00" : lockerPre.getApply_start_time()), pattern);
			Date applyEndDate = DateUtils.parseDate(String.format("%s %s", lockerPre.getApply_end_date(), StringUtils.isEmpty(lockerPre.getApply_end_time()) ? "00:00" : lockerPre.getApply_end_time()), pattern);
			Date now = new Date();
			if ( applyStartDate.before(now) && applyEndDate.after(now) ) {
				if(lockerMember != null) {
					locker.setEditMode("MODIFY");
				}
				else {
					locker.setEditMode("ADD");
				}
			}
			else {
				locker.setEditMode("END");
			}
		}
		else {
			locker.setEditMode("END");
		}


		List<Locker> lockerList = service.getLocker(locker);
		int count = lockerList.size();

		model.addAttribute("lockerMember", lockerMember);
		model.addAttribute("locker", locker);
		model.addAttribute("lockerPre", lockerPre);
		model.addAttribute("lockerReqList", lockerReqService.getLockerReq(new LockerReq(homepage.getHomepage_id(), maxLockerPreIdx)));
		model.addAttribute("lockerList", lockerList);
		model.addAttribute("lockerListCount", count);

		//model.addAttribute("blackList", blackListService.getBlackListOne(new BlackList(homepage.getHomepage_id(), member.getSeq_no())));
		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, LockerReq lockerReq, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		lockerReq.setHomepage_id(homepage.getHomepage_id());
		Member member = getSessionMemberInfo(request);
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			lockerReq.setBefore_url(String.format("http://www.gbelib.kr/%s/module/locker/index.do?menu_idx=%s", homepage.getContext_path(), lockerReq.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), lockerReq.getMenu_idx(), lockerReq.getBefore_url()), request, response);
			return null;
	    }

		if ( blackListService.checkBlackList(new BlackList(homepage.getHomepage_id(), getSessionMemberId(request)), "20")) {
			service.alertMessage("신청이 불가능합니다.\\n도서관에 문의해주세요.", request, response);
			return null;
		}

		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(menuOne.getManage_idx())));

		if(lockerReq.getEditMode().equals("MODIFY")) {
			model.addAttribute("lockerReq", lockerReq);
			model.addAttribute("locker", service.copyObjectPaging(lockerReq, lockerReqService.getLockerReqOne(lockerReq)));
		} else {
			lockerReq.setReq_name(member.getMember_name());
			lockerReq.setApply_id(getSessionMemberId(request));
			lockerReq.setCell_phone1(member.getCell_phone1());
			lockerReq.setCell_phone2(member.getCell_phone2());
			lockerReq.setCell_phone3(member.getCell_phone3());
			lockerReq.setCell_phone(member.getCell_phone1()+member.getCell_phone2()+member.getCell_phone3()+"");
			lockerReq.setPhone1(member.getPhone1());
			lockerReq.setPhone2(member.getPhone2());
			lockerReq.setPhone3(member.getPhone3());
			lockerReq.setPhone(member.getPhone1()+member.getPhone2()+member.getPhone3()+"");

			model.addAttribute("locker", lockerReq);
			model.addAttribute("lockerReq", lockerReq);
		}
//		model.addAttribute("prtcNotice",MemberAPI.getPrtcNoticeList("WEB"));
		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, LockerReq lockerReq, BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		JsonResponse res = new JsonResponse(request);
		String editMode = lockerReq.getEditMode();

		if(!lockerReq.getEditMode().equals("DELETE")) {
			if ( !"Y".equals(lockerReq.getSelf_info_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}
			if (StringUtils.isEmpty(lockerReq.getCell_phone()) && StringUtils.isEmpty(lockerReq.getPhone())) {
				result.rejectValue("phone", "휴대전화번호 또는 전화번호 중 하나는 반드시 입력하여야 합니다.");
			}
			if (StringUtils.isNotEmpty(lockerReq.getCell_phone())) {
				ValidationUtils.rejectPhone(result, "cell_phone", "휴대전화번호가 올바르지 않습니다.");
			}
		}

		if(!result.hasErrors()) {

			lockerReq.setApply_id(getSessionMemberId(request));
			lockerReq.setMember_key(getSessionMemberInfo(request).getSeq_no());

			if(editMode.equals("ADD")) {

				LockerPre lockerPre = lockerPreService.getLockerPreOne(new LockerPre(lockerReq.getHomepage_id(), lockerReq.getLocker_pre_idx()));
				int limitApplyCount = lockerPre.getLocker_count() + lockerPre.getApply_backup_count();
				if ( limitApplyCount <= lockerPre.getApply_count() ) {
					res.setValid(false);
					res.setMessage("신청가능인원이 가득찼습니다.");
					return res;
				}

				if ( "SELECT".equals(lockerReq.getLocker_pre_type()) ) {
					if  ( service.checkLockerStatus(new Locker(lockerReq.getHomepage_id(), lockerReq.getLocker_pre_idx(), lockerReq.getLocker_idx())) != 1 ) {
						res.setValid(false);
						res.setMessage("이미 배정된 사물함 입니다.");
						return res;
					}
				}
				lockerReq.setAdd_id(getSessionMemberId(request));
				lockerReqService.addLockerReq(lockerReq,"HOMEPAGE");
				res.setValid(true);
				res.setMessage("신청 되었습니다.");
				res.setUrl("index.do?menu_idx=" + lockerReq.getMenu_idx());
				if (StringUtils.equals(getSessionMemberInfo(request).getSms_service_yn(), "Y")) {
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, lockerReq.getCell_phone(), "사물함 배정이 완료 되었습니다.", homepage.getHomepage_send_tell(), true);
				}
			}	else if(editMode.equals("MODIFY")) {
				lockerReq.setMod_id(getSessionMemberId(request));
				lockerReqService.modifyLocekrReq(lockerReq);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
				res.setUrl("index.do?menu_idx=" + lockerReq.getMenu_idx());
			} else if(editMode.equals("DELETE")) {
				lockerReqService.deleteReqLocker(lockerReq);
				res.setValid(true);
				res.setReload(true);
				res.setMessage("배정 취소 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/blackCheck.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse blackCheck(Model model, LockerReq lockerReq, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			lockerReq.setHomepage_id(homepage.getHomepage_id());
			lockerReq.setMember_key(getSessionMemberId(request));
//			if(lockerReqService.getBlackListCheck(lockerReq) > 0) {
//				res.setValid(false);
//				res.setMessage("신청이 불가능 합니다.\n관리자에게 문의바랍니다..");
//			} else {
				res.setValid(true);
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/history.*"})
	public String history(Model model, Locker locker, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Member member = getSessionMemberInfo(request);

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			locker.setBefore_url(String.format("http://www.gbelib.kr/%s/module/locker/history.do?menu_idx=%s", homepage.getContext_path(), locker.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), locker.getMenu_idx(), locker.getBefore_url()), request, response);
			return null;
	    }

		model.addAttribute("historyList", lockerReqService.getHistoryOfLockerReq(new LockerReq(homepage.getHomepage_id(), member.getSeq_no())));

		return String.format(basePath, homepage.getFolder()) + "history";
	}
}
