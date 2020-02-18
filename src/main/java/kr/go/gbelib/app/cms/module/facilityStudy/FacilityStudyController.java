/**
 *
 */
package kr.go.gbelib.app.cms.module.facilityStudy;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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

/**
 * @author whaleesoft YONGJU 2020. 2. 17.
 *
 */
@Controller
@RequestMapping(value = {"/cms/module/facilityStudy"})
public class FacilityStudyController extends BaseController {

	private final String basePath = "/cms/module/facilityStudy/";

	@Autowired
	private FacilityStudyService service;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, FacilityStudy facilityStudy, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		facilityStudy.setHomepage_id(getAsideHomepageId(request));

		if ( StringUtils.isEmpty(facilityStudy.getPlan_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			facilityStudy.setPlan_date(sf.format(new Date()));
		}

		service.setPaging(model, service.getFacilityStudyCount(facilityStudy), facilityStudy);
		model.addAttribute("facilityStudy", facilityStudy);
		model.addAttribute("facilityStudyList", service.getFacilityStudyList(facilityStudy));
		return basePath + "index";
	}

	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, FacilityStudy facilityStudy, HttpServletRequest request) {
		facilityStudy.setHomepage_id(getAsideHomepageId(request));

		if (facilityStudy.getEditMode().equals("ADD")) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			facilityStudy.setStudy_date(sf.format(new Date()));
			model.addAttribute("facilityStudy", facilityStudy);
		} else {
			model.addAttribute("facilityStudy", service.copyObjectPaging(facilityStudy, service.getFacilityStudyOne(facilityStudy)));
		}

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(FacilityStudy facilityStudy, BindingResult result, HttpServletRequest request) {
		facilityStudy.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			if (facilityStudy.getEditMode().equals("DELETE")) {
				service.deleteFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if (facilityStudy.getEditMode().equals("APPROVE")) {
				service.approveFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("승인되었습니다.");
			} else if (facilityStudy.getEditMode().equals("CANCEL")) {
				service.cancelFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("취소되었습니다.");
			} else if (facilityStudy.getEditMode().equals("READY")) {
				service.readyFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("변경되었습니다.");
			} else if (facilityStudy.getEditMode().equals("ADD")) {
				if (service.isAlready(facilityStudy)) {
					res.setValid(false);
					res.setMessage("해당 시간으로 등록 불가합니다.");
				} else {
					service.addFacilityStudy(facilityStudy);
					res.setValid(true);
					res.setMessage("등록되었습니다.");

				}
			} else if (facilityStudy.getEditMode().equals("MODIFY")) {
				if (service.isAlready(facilityStudy)) {
					res.setValid(false);
					res.setMessage("해당 시간으로 변경 불가합니다.");
				} else {
					service.modifyFacilityStudy(facilityStudy);
					res.setValid(true);
					res.setMessage("변경되었습니다.");
				}

			} else {

			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
