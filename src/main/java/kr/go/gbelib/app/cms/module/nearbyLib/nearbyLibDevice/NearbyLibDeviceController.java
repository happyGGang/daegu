package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibDevice;

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
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLib;
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLibService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibLocker.NearbyLibLocker;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibLocker.NearbyLibLockerService;

/**
 * @author ttkaz
 * 2022. 9. 29.
 *
 */

@Controller
@RequestMapping(value = {"/cms/module/nearbyLibDevice"})
public class NearbyLibDeviceController extends BaseController {

private final String basePath = "/cms/module/nearbyLib/nearbyLibDevice/";
	
	@Autowired
	private NearbyLibDeviceService service;
	
	@Autowired
	private NearbyLibLockerService lockerService;
	
	@Autowired
	private NearbyLibService reserveService;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model,NearbyLibDevice nearbyLibDevice, HttpServletRequest request) throws Exception {	
		int count = service.getNeighborhoodLibraryDeviceCount(nearbyLibDevice);
		List<NearbyLibDevice> deviceList = service.getNeighborhoodLibraryDeviceAll(nearbyLibDevice);		
		NearbyLibLocker searchDevice = new NearbyLibLocker();
		int num = 0;
		for(NearbyLibDevice deviceNewList : deviceList) {
			int device_idx = deviceNewList.getDevice_idx();
			searchDevice.setDevice_idx(device_idx);			
			if(lockerService.getNeighborhoodLibraryLockerCount(device_idx) > 0) {			
				deviceList.get(num).setDevice_add_yn("Y");
			}else {
				deviceList.get(num).setDevice_add_yn("N");
			}
			num++;
		}
		
		service.setPaging(model, count , nearbyLibDevice);
		nearbyLibDevice.setTotalDataCount(count);
		model.addAttribute("device", nearbyLibDevice);
		model.addAttribute("homepageList", homepageService.getNormalHomepage());
		model.addAttribute("deviceList", deviceList);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, NearbyLibDevice nearbyLibDevice, HttpServletRequest request) throws Exception {		
		checkAuth("U", model, request);
		NearbyLibDevice nearbyLibDeviceOne = new NearbyLibDevice();
		if(nearbyLibDevice.getEditMode().equals("MODIFY")) { 
			nearbyLibDeviceOne = service.getNeighborhoodLibraryDeviceOne(nearbyLibDevice);
		}
		
		model.addAttribute("device", nearbyLibDevice);
		model.addAttribute("nearbyLibDevice", nearbyLibDeviceOne);
		return basePath + "edit_ajax";
	}
		
	
	@RequestMapping(value = {"/save.*"})
	public @ResponseBody JsonResponse save(Model model,NearbyLibDevice nearbyLibDevice, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		
		if(nearbyLibDevice.getEditMode().equals("ADD") || nearbyLibDevice.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "device_name", "장비명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "device_place", "장비장소를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "device_area", "장비위치를 입력하세요.");
		}

		
		if (!result.hasErrors()) {
			if (nearbyLibDevice.getEditMode().equals("ADD")) {
				nearbyLibDevice.setAdd_id(getSessionMemberId(request));
				service.addNeighborhoodLibraryDevice(nearbyLibDevice);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (nearbyLibDevice.getEditMode().equals("MODIFY")) {
				nearbyLibDevice.setModify_id(getSessionMemberId(request));
				service.modifyNeighborhoodLibraryDevice(nearbyLibDevice);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}else if(nearbyLibDevice.getEditMode().equals("DELETE")) {
				NearbyLib neighborhoodLibrary = new NearbyLib();
				neighborhoodLibrary.setDevice_idx(nearbyLibDevice.getDevice_idx());
				List<NearbyLib> neighborhoodLibraryList = reserveService.getNeighborhoodLibraryList(neighborhoodLibrary);
				if(neighborhoodLibraryList.size() == 0 ) {
					nearbyLibDevice.setDelete_id(getSessionMemberId(request));
					nearbyLibDevice.setDelete_ip(request.getRemoteAddr());
					service.deleteNeighborhoodLibraryDevice(nearbyLibDevice);
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
