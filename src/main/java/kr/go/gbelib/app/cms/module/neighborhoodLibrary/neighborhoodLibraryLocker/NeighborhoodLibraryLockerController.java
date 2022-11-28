package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryLocker;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibrary;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibraryService;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice.NeighborhoodLibraryDevice;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice.NeighborhoodLibraryDeviceService;

/**
 * @author ttkaz
 * 2022. 10. 12.
 *
 */
@Controller
@RequestMapping(value = {"/cms/module/neighborhoodLibraryLocker"})
public class NeighborhoodLibraryLockerController extends BaseController {

private final String basePath = "/cms/module/neighborhoodLibrary/neighborhoodLibraryLocker/";
	
	
	@Autowired
	private NeighborhoodLibraryLockerService service;
	
	@Autowired
	private NeighborhoodLibraryService neighborhoodLibraryService;
	
	@Autowired
	private NeighborhoodLibraryDeviceService neighborhoodLibraryDeviceService; 
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, NeighborhoodLibraryLocker neighborhoodLibraryLocker, HttpServletRequest request) {
		//개별 사물함 불러오기
		List<NeighborhoodLibraryLocker> lockerOneList = service.getNeighborhoodLibraryLockerEachOneList(neighborhoodLibraryLocker);
		NeighborhoodLibraryLocker lockerOne = service.getNeighborhoodLibraryLockerOne(neighborhoodLibraryLocker);
		
		//
		NeighborhoodLibrary neigborhoodLibrary = new NeighborhoodLibrary();
		neigborhoodLibrary.setDevice_idx(neighborhoodLibraryLocker.getDevice_idx());
		List<NeighborhoodLibrary> neighborhoodLibraryList = neighborhoodLibraryService.getNeighborhoodLibraryList(neigborhoodLibrary);
		int count = neighborhoodLibraryList.size();
		
		//사물함 정보
		model.addAttribute("locker", neighborhoodLibraryLocker);
		model.addAttribute("lockerOne", lockerOne);
		model.addAttribute("lockerOneList", lockerOneList);
		//대출 정보
		model.addAttribute("neighborhoodLibraryList", neighborhoodLibraryList);
		model.addAttribute("neighborhoodLibraryCount", count);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, NeighborhoodLibraryLocker neighborhoodLibraryLocker, HttpServletRequest request) {
		
		model.addAttribute("locker", neighborhoodLibraryLocker);
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/use_edit.*"})
	public String use_edit(Model model, NeighborhoodLibraryLocker neighborhoodLibraryLocker, HttpServletRequest request) {
		NeighborhoodLibraryDevice neighborhoodLibraryDevice = new NeighborhoodLibraryDevice();
		neighborhoodLibraryDevice.setDevice_idx(neighborhoodLibraryLocker.getDevice_idx());
		neighborhoodLibraryDevice = neighborhoodLibraryDeviceService.getNeighborhoodLibraryDeviceOne(neighborhoodLibraryDevice);
		model.addAttribute("locker", neighborhoodLibraryLocker);
		model.addAttribute("device", neighborhoodLibraryDevice);
		return basePath + "use_edit_ajax";
	}
	
	@RequestMapping(value = {"/detail.*"})
	public String detail(Model model, NeighborhoodLibraryLocker neighborhoodLibraryLocker, HttpServletRequest request) {
		
		if(neighborhoodLibraryLocker.getDevice_idx() > 0) {
			neighborhoodLibraryLocker = service.getNeighborhoodLibraryLockerOne(neighborhoodLibraryLocker);
		}
		model.addAttribute("locker", neighborhoodLibraryLocker);
		return basePath + "detail_ajax";
	}
	
	@RequestMapping(value = {"/save.*"})
	public @ResponseBody JsonResponse save(Model model, NeighborhoodLibraryLocker neighborhoodLibraryLocker, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(neighborhoodLibraryLocker.getEditMode().equals("ADD") || neighborhoodLibraryLocker.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "device_idx", "장비번호를 가져오는데 실패하였습니다.");
			ValidationUtils.rejectIfEmpty(result, "device_code", "장비코드를 가져오는데 실패하였습니다.");
			ValidationUtils.rejectIfEmpty(result, "device_name", "장비명을 가져오는데 실패하였습니다.");
//			ValidationUtils.rejectIfEmpty(result, "col_no", "사물함 열을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "row_no", "사물함 행을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "return_machine_yn", "반납기 여부를 선택하세요.");
//			ValidationUtils.rejectIfEmpty(result, "monitor_position", "모니터가 위치한 열을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "add_row_no", "모니터 열에 존재하는 사물함 갯수를 입력하세요.");
		}

		
		if (!result.hasErrors()) {
			if (neighborhoodLibraryLocker.getEditMode().equals("ADD")) {
				if(service.getNeighborhoodLibraryLockerCount(neighborhoodLibraryLocker) > 0) {
					res.setValid(false);
					res.setMessage("등록된 사물함이 존재합니다.");
					return res;
				}
				service.addNeighborhoodLibraryLocker(neighborhoodLibraryLocker);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (neighborhoodLibraryLocker.getEditMode().equals("MODIFY")) {
//				service.modifyNeighborhoodLibraryLocker(neighborhoodLibraryLocker);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}else if(neighborhoodLibraryLocker.getEditMode().equals("DELETE")) {
//				service.deleteNeighborhoodLibraryLocker(neighborhoodLibraryLocker);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/locker_each_edit.*"})
	public @ResponseBody JsonResponse locker_edit(Model model, NeighborhoodLibraryLocker neighborhoodLibraryLocker, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "locker_idx", "사물함IDX를 가져오는데 실패하였습니다.");
		ValidationUtils.rejectIfEmpty(result, "use_yn", "사물함 사용값을 가져오는데 실패하였습니다.");
		
		if (!result.hasErrors()) {			
			service.modifyNeighborhoodLibraryLocker(neighborhoodLibraryLocker);
			res.setValid(true);
			res.setMessage("사물함 설정이 완료되었습니다.");
			
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
}
