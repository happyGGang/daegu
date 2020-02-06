package kr.go.gbelib.app.module.calendarManage;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.excursions.apply.ApplyService;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReqService;
import kr.go.gbelib.app.cms.module.teach.TeachService;

@Controller(value="userCalendarManage")
@RequestMapping(value = {"/{homepagePath}/module/calendarManage"})
public class CalendarManageController extends BaseController {

	private String basePath = "/homepage/%s/module/calendarManage/";

	@Autowired
	private CalendarManageService service;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private TeachService teachService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private FacilityReqService facilityReqService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private RecommendSiteService recommendSiteService;


	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, CalendarManage calendarManage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		calendarManage.setHomepage_id(homepage.getHomepage_id());

		if(calendarManage.getPlan_date() == null || calendarManage.getPlan_date().equals("")) {
			calendarManage.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		Board board = new Board();
		board.setHomepage_id(homepage.getHomepage_id());
		board.setImsi_v_1(calendarManage.getPlan_date());

		model.addAttribute("moveList", boardService.getBoardMovie(board));
		model.addAttribute("calendarList", service.getCalendar(calendarManage));
		model.addAttribute("calendarManage", calendarManage);
		model.addAttribute("calendarManageList", service.getCalendarManage(calendarManage));
		model.addAttribute("okApplyList", applyService.getOkApply(calendarManage));
		model.addAttribute("teachList", teachService.getTeachListForCalendar(calendarManage));
		model.addAttribute("facilityReqList",facilityReqService.getFacilityReqCalendar(calendarManage));
		model.addAttribute("dateTypeList", codeService.getCode(calendarManage.getHomepage_id(), "C0001"));

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value = {"/index_list.*"})
	public String indexList(Model model, CalendarManage calendarManage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		calendarManage.setHomepage_id(homepage.getHomepage_id());

		if(calendarManage.getPlan_date() == null || calendarManage.getPlan_date().equals("")) {
			calendarManage.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		Board board = new Board();
		board.setHomepage_id(homepage.getHomepage_id());
		board.setImsi_v_1(calendarManage.getPlan_date());

		model.addAttribute("moveList", boardService.getBoardMovie(board));
		model.addAttribute("calendarList", service.getCalendar(calendarManage));
		model.addAttribute("calendarListType", service.getCalendarListType(calendarManage));
		model.addAttribute("calendarManage", calendarManage);
		model.addAttribute("calendarManageList", service.getCalendarManage(calendarManage));
		model.addAttribute("okApplyList", applyService.getOkApply(calendarManage));
		model.addAttribute("teachList", teachService.getTeachListForCalendar(calendarManage));
		model.addAttribute("facilityReqList",facilityReqService.getFacilityReqCalendar(calendarManage));
		model.addAttribute("dateTypeList", codeService.getCode(calendarManage.getHomepage_id(), "C0001"));

		return String.format(basePath, homepage.getFolder()) + "index_list";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, CalendarManage calendarManage, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		calendarManage.setHomepage_id(homepage.getHomepage_id());
		if(calendarManage.getEditMode().equals("MODIFY")) {
			model.addAttribute("calendarManage", service.copyObjectPaging(calendarManage, service.getCalendarManageOne(calendarManage)));
		} else {
			model.addAttribute("calendarManage", calendarManage);
		}

		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping(value = {"/detail.*"})
	public String detail(Model model, CalendarManage calendarManage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		calendarManage.setHomepage_id(homepage.getHomepage_id());

		int menu_idx = calendarManage.getMenu_idx();

		calendarManage = service.getCalendarManageOne(calendarManage);
		if ( calendarManage == null ) {
			service.alertMessage("해당일정을 조회할수 없습니다.", request, response);
			return null;
		}

		calendarManage.setMenu_idx(menu_idx);
		calendarManage.setContents(StringUtils.defaultString(calendarManage.getContents()).replaceAll("\r", "<br/>"));
		model.addAttribute("calendarManage", calendarManage);

		return String.format(basePath, homepage.getFolder()) + "detail";
	}

}
