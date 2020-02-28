package kr.go.gbelib.app.cms.module.facilityBook;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.bookPackage.BookPackage;
import kr.go.gbelib.app.cms.module.bookPackage.BookPackageView;

@Controller
@RequestMapping(value = {"/cms/module/facilityBook"})
public class FacilityBookController extends BaseController {
	
	private final String basePath = "/cms/module/facilityBook/";
	
	@Autowired
	private FacilityBookService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, FacilityBook facilityBook, HttpServletRequest request) throws AuthException {
		checkAuth("C", model, request);

		facilityBook.setHomepage_id(getAsideHomepageId(request));

		if ( StringUtils.isEmpty(facilityBook.getPlan_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
			facilityBook.setPlan_date(sf.format(new Date()));
		}
		
		model.addAttribute("calendarList", service.getCalendar(facilityBook));
		model.addAttribute("applyList", service.convertToRepo(service.getApplyList(facilityBook)));
		model.addAttribute("closeList", service.getFacilityBookClose(facilityBook));
		model.addAttribute("facilityBook", facilityBook);

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, FacilityBook facilityBook, HttpServletRequest request) throws Exception {
		
		if(facilityBook.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			
			facilityBook = (FacilityBook)service.copyObjectPaging(facilityBook, service.getFacilityBookOne(facilityBook));
			if(facilityBook.getPhone() != null) {
				String[] phone = facilityBook.getPhone().split("-");
				facilityBook.setPhone1(phone[0]);
				facilityBook.setPhone2(phone[1]);
				facilityBook.setPhone3(phone[2]);
			}
			
			if(facilityBook.getSub_phone() != null) {
				String[] sub_phone = facilityBook.getSub_phone().split("-");
				facilityBook.setSub_phone1(sub_phone[0]);
				facilityBook.setSub_phone2(sub_phone[1]);
				facilityBook.setSub_phone3(sub_phone[2]);
			}
			
		} else if(facilityBook.getEditMode().equals("ADD")) {
			checkAuth("C", model, request);
			facilityBook.setApply_date(facilityBook.getPlan_date());
			facilityBook.setFacility_book_name("1");
		}
		model.addAttribute("facilityBook", facilityBook);
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/close.*"}, method = RequestMethod.GET)
	public String close(Model model, FacilityBook facilityBook, HttpServletRequest request) {
		model.addAttribute("facilityBook", facilityBook);
		
		return basePath + "close_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(FacilityBook facilityBook, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(facilityBook.getEditMode().equals("ADD") || facilityBook.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "apply_name", "신청인을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "phone1", "신청자 연락처를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "phone2", "신청자 연락처를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "phone3", "신청자 연락처를 입력하세요.");
			ValidationUtils.rejectPhone(result, "phone", "신청자 연락처 형식이 올바르지 않습니다.");
			ValidationUtils.rejectIfEmpty(result, "sub_phone1", "참여인원 연락처를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "sub_phone2", "참여인원 연락처를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "sub_phone3", "참여인원 연락처를 입력하세요.");
			ValidationUtils.rejectPhone(result, "sub_phone", "참여인원 연락처 형식이 올바르지 않습니다.");
			ValidationUtils.rejectIfEmpty(result, "apply_date", "이용시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "curcles_name", "모임명을 입력하세요.");
			
			if(facilityBook.getMan_count() == 0 && facilityBook.getWoman_count() == 0) {
				result.rejectValue("man_count", "참여인원을 입력하세요.");
			}
			ValidationUtils.rejectIfEmpty(result, "attend_list", "참가자 명단을 입력하세요.");
			
			String[] date_arr = facilityBook.getApply_date().split("-");

			DateTime reference = new DateTime(Integer.parseInt(date_arr[0]), Integer.parseInt(date_arr[1]), 20, 0, 0);
			long ref = reference.plusMonths(-1).getMillis();
			DateTime today = new DateTime();

			if (ref > today.getMillis()) {
				result.reject("20일 이후 신청 가능합니다.");
			}
		}
		
		if(facilityBook.getEditMode().equals("ADD") || facilityBook.getEditMode().equals("CLOSE")) {
			if(facilityBook.getEditMode().equals("CLOSE")) {
				facilityBook.setApply_date(facilityBook.getClose_date());
				facilityBook.setApply_time_code(facilityBook.getClose_time());
			}
			
			String[] apply_time_arr = facilityBook.getApply_time_code().split(",");
			
			for (String time : apply_time_arr) {
				facilityBook.setApply_time_code(time);
				
				int duplChk = service.getFacilityBookDuplCheck(facilityBook);
				if(duplChk > 0) {
					result.reject("해당 시설은 이미 신청자가 있습니다.");
				}
				
				int closeDuplChk = service.getCloseDuplCheck(facilityBook);
				if(closeDuplChk > 0) {
					result.reject("해당 시설은 휴관입니다.");
				}
			}
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (facilityBook.getEditMode().equals("ADD")) {
				facilityBook.setAdd_id(getSessionMemberId(request));
				service.addFacilityBook(facilityBook);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (facilityBook.getEditMode().equals("MODIFY")) {
				facilityBook.setModify_id(getSessionMemberId(request));
				service.modifyFacilityBook(facilityBook);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (facilityBook.getEditMode().equals("CLOSE")) {
				facilityBook.setAdd_id(getSessionMemberId(request));
				
				String[] apply_time_arr = facilityBook.getClose_time().split(",");
				for (String time : apply_time_arr) {
					facilityBook.setClose_time(time);
					service.addFacilityBookClose(facilityBook);
				}
				res.setValid(true);
				res.setMessage("휴관일 등록되었습니다.");
			} else if(facilityBook.getEditMode().equals("STATUS") || facilityBook.getEditMode().equals("STATUS_CHK")) {
				service.changeStatus(facilityBook);
				res.setValid(true);
//				res.setUrl("applyList.do");
//				res.setData("viewPage="+facilityBook.getViewPage());
				res.setMessage("상태 변경되었습니다.");
			} else if(facilityBook.getEditMode().equals("DELETE_REQ")) {
				service.deleteFacilityBook(facilityBook);
				res.setValid(true);
				res.setMessage("선택 삭제되었습니다.");
//				res.setUrl("index.do");
//				res.setData("viewPage=1");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/applyList.*"}, method = RequestMethod.GET)
	public String apply(Model model, FacilityBook facilityBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		facilityBook.setHomepage_id(getAsideHomepageId(request));
		service.setPaging(model, service.getFacilityBookCount(facilityBook), facilityBook);
		
		model.addAttribute("facilityBook", facilityBook);
		model.addAttribute("applyList", service.getFacilityBookAll(facilityBook));

		return basePath + "applyList_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public FacilityBookView excel(Model model, FacilityBook facilityBook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<FacilityBook> facilityBookList = service.getApplyList(facilityBook);
		
		model.addAttribute("bookPackage", facilityBook);
		model.addAttribute("facilityBookList", facilityBookList);

		return new FacilityBookView();
	}
	
}
