package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibrary;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibraryService;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryLocker.NeighborhoodLibraryLocker;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryLocker.NeighborhoodLibraryLockerService;

/**
 * @author ttkaz
 * 2022. 9. 29.
 *
 */

@Controller
@RequestMapping(value = {"/cms/module/neighborhoodLibraryDevice"})
public class NeighborhoodLibraryDeviceController extends BaseController {

private final String basePath = "/cms/module/neighborhoodLibrary/neighborhoodLibraryDevice/";
	
	@Autowired
	private NeighborhoodLibraryDeviceService service;
	
	@Autowired
	private NeighborhoodLibraryLockerService lockerService;
	
	@Autowired
	private NeighborhoodLibraryService reserveService;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model,NeighborhoodLibraryDevice neighborhoodLibraryDevice, HttpServletRequest request) throws Exception {	
		int count = service.getNeighborhoodLibraryDeviceCount(neighborhoodLibraryDevice);
		List<NeighborhoodLibraryDevice> deviceList = service.getNeighborhoodLibraryDeviceAll(neighborhoodLibraryDevice);		
		NeighborhoodLibraryLocker searchDevice = new NeighborhoodLibraryLocker();
		int num = 0;
		for(NeighborhoodLibraryDevice deviceNewList : deviceList) {
			int device_idx = deviceNewList.getDevice_idx();
			searchDevice.setDevice_idx(device_idx);			
			if(lockerService.getNeighborhoodLibraryLockerCount(searchDevice) > 0) {			
				deviceList.get(num).setDevice_add_yn("Y");
			}else {
				deviceList.get(num).setDevice_add_yn("N");
			}
			num++;
		}
		
		service.setPaging(model, count , neighborhoodLibraryDevice);
		neighborhoodLibraryDevice.setTotalDataCount(count);
		model.addAttribute("device", neighborhoodLibraryDevice);
		model.addAttribute("homepageList", homepageService.getNormalHomepage());
		model.addAttribute("deviceList", deviceList);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model,NeighborhoodLibraryDevice neighborhoodLibraryDevice, HttpServletRequest request) throws Exception {		
		
		model.addAttribute("device", neighborhoodLibraryDevice);
		if(neighborhoodLibraryDevice.getEditMode().equals("MODIFY")) {
			neighborhoodLibraryDevice = service.getNeighborhoodLibraryDeviceOne(neighborhoodLibraryDevice);
		}
		
		model.addAttribute("neighborhoodLibraryDevice", neighborhoodLibraryDevice);
		return basePath + "edit_ajax";
	}
		
	
	@RequestMapping(value = {"/save.*"})
	public @ResponseBody JsonResponse save(Model model,NeighborhoodLibraryDevice neighborhoodLibraryDevice, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		
		if(neighborhoodLibraryDevice.getEditMode().equals("ADD") || neighborhoodLibraryDevice.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "device_name", "장비명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "device_place", "장비장소를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "device_area", "장비위치를 입력하세요.");
		}

		
		if (!result.hasErrors()) {
			if (neighborhoodLibraryDevice.getEditMode().equals("ADD")) {
				neighborhoodLibraryDevice.setAdd_id(getSessionMemberId(request));
				service.addNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (neighborhoodLibraryDevice.getEditMode().equals("MODIFY")) {
				neighborhoodLibraryDevice.setModify_id(getSessionMemberId(request));
				service.modifyNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}else if(neighborhoodLibraryDevice.getEditMode().equals("DELETE")) {
				NeighborhoodLibrary neighborhoodLibrary = new NeighborhoodLibrary();
				neighborhoodLibrary.setDevice_idx(neighborhoodLibraryDevice.getDevice_idx());
				List<NeighborhoodLibrary> neighborhoodLibraryList = reserveService.getNeighborhoodLibraryList(neighborhoodLibrary);
				if(neighborhoodLibraryList.size() == 0 ) {
					neighborhoodLibraryDevice.setDelete_id(getSessionMemberId(request));
					neighborhoodLibraryDevice.setDelete_ip(request.getRemoteAddr());
					service.deleteNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
					res.setValid(true);
					res.setMessage("삭제되었습니다.");
				}else {
					res.setValid(false);
					res.setMessage("현재 장비를 사용중인 대출내역이 존재합니다. 사물함이 모두 비워져 있을경우 삭제가 가능합니다.");
					return res;
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;

	}
}
