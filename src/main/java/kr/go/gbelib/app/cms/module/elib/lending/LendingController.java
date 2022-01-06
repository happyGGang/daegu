package kr.go.gbelib.app.cms.module.elib.lending;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.elib.code.ElibCode;
import kr.go.gbelib.app.cms.module.elib.code.ElibCodeService;

@Controller
@RequestMapping(value = {"/cms/module/elib/lending/{menu}"})
public class LendingController extends BaseController {
	
	private final String basePath = "/cms/module/elib/lending/";

	@Autowired
	private LendingService service;
	
	@Autowired
	private ElibCategoryService elibCategoryService;
	
	@Autowired
	private ElibCodeService elibCodeService;
	
	@RequestMapping(value = {"/index.*"})
	public String book_index(Model model, @PathVariable String menu, Lending lending, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		if ( !getSessionIsAdmin(request) ) {
			lending.setHomepage_id(getAsideHomepageId(request));	
		}
		
		if ( StringUtils.isEmpty(lending.getLibrary_code())) {
			lending.setLibrary_code("10000009");
		}
		
		if("LEND".equals(menu)) {
			if(StringUtils.equals(lending.getSortField(), "TITLE")) lending.setSortField("lend_dt");
		} else if("RESERVE".equals(menu)) {
			lending.setIsReserve("Y");
			if(StringUtils.equals(lending.getSortField(), "TITLE")) lending.setSortField("reserve_dt");
		} else {
			if(StringUtils.equals(lending.getSortField(), "TITLE")) lending.setSortField("lend_dt");
		}
		
		int count = 0;
		
		if("Y".equals(lending.getIsReserve())) {
			count = service.getReserveMemberListCnt(lending);
		} else {
			count = service.getLendMemberListCnt(lending);
		}
		
		service.setPaging(model, count, lending);
		List<Lending> lendingList = null;
		
		if("Y".equals(lending.getIsReserve())) {
			lendingList = service.getReserveMemberList(lending);
		} else {
			lendingList = service.getLendMemberList(lending);
		}
		
		model.addAttribute("lending", lending);
		model.addAttribute("obj", lending);
		model.addAttribute("lendingListCnt", count);
		model.addAttribute("lendingList", lendingList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(lending.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(lending.getType())));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public LendingExcelView excel(Model model, Lending lending, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("lending", lending);
		if("Y".equals(lending.getIsReserve())) {
			if(StringUtils.equals(lending.getSortField(), "TITLE")) lending.setSortField("reserve_dt");
			model.addAttribute("lendingList", service.getReserveMemberListAll(lending));
		} else {
			if(StringUtils.equals(lending.getSortField(), "TITLE")) lending.setSortField("lend_dt");
			model.addAttribute("lendingList", service.getLendMemberListAll(lending));
		}

		return new LendingExcelView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Lending lending, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Lending> lendingList = null;
		if("Y".equals(lending.getIsReserve())) {
			if(StringUtils.equals(lending.getSortField(), "TITLE")) lending.setSortField("reserve_dt");
			lendingList = service.getReserveMemberListAll(lending);
		} else {
			if(StringUtils.equals(lending.getSortField(), "TITLE")) lending.setSortField("lend_dt");
			lendingList = service.getLendMemberListAll(lending);
		}

		new LendingXlsToCsv(lending, lendingList, request, response);
	}

}
