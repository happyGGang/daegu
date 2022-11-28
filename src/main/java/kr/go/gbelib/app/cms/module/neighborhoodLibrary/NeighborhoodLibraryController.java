package kr.go.gbelib.app.cms.module.neighborhoodLibrary;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice.NeighborhoodLibraryDevice;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice.NeighborhoodLibraryDeviceService;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryLocker.NeighborhoodLibraryLocker;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryLocker.NeighborhoodLibraryLockerService;

/**
 * @author ttkaz
 * 2022. 9. 27.
 *
 */

@Controller
@RequestMapping(value = {"/cms/module/neighborhoodLibrary"})
public class NeighborhoodLibraryController extends BaseController {

	private final String basePath = "/cms/module/neighborhoodLibrary/";
	
	
	@Autowired
	private NeighborhoodLibraryService service;
	
	@Autowired
	private NeighborhoodLibraryDeviceService deviceService;
	
	@Autowired
	private NeighborhoodLibraryLockerService lockerService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, NeighborhoodLibrary neighborhoodLibrary, HttpServletRequest request)throws AuthException  {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
//			teach.setHomepage_id(getAsideHomepageId(request));
//		}
		NeighborhoodLibraryDevice neighborhoodLibraryDevice = new NeighborhoodLibraryDevice();
		List<NeighborhoodLibraryDevice> deviceList = deviceService.getNeighborhoodLibraryDeviceList(neighborhoodLibraryDevice);
		if(neighborhoodLibrary.getDevice_idx() == 0) {
			if(deviceList.size() > 0) {
				neighborhoodLibrary.setDevice_idx(deviceList.get(0).getDevice_idx());
			}
			
		}
//		List<NeighborhoodLibraryLocker> lockerOneList = lockerService.getNeighborhoodLibraryLockerEachOneList(neighborhoodLibraryLocker);//사물함 번호&갯수 가져오기		
//		List<NeighborhoodLibrary> usedLockerList = service.getNeighborhoodLibraryList(neighborhoodLibrary); //사물함을 사용하는 예약 내역만 가져오기 
		
		List<NeighborhoodLibrary> reserveList = service.getNeighborhoodLibraryListAll(neighborhoodLibrary);
		int count = service.getNeighborhoodLibraryCount(neighborhoodLibrary);
		service.setPaging(model, count , neighborhoodLibrary);
		
		//개별 사물함 불러오기
		NeighborhoodLibraryLocker neighborhoodLibraryLocker = new NeighborhoodLibraryLocker();
		neighborhoodLibraryLocker.setDevice_idx(neighborhoodLibrary.getDevice_idx());
		int lockerOneList = lockerService.getNeighborhoodLibraryLockerEachOneListCount(neighborhoodLibraryLocker); //현재 선택된 장비에 등록된 사물함리스트
		List<NeighborhoodLibrary> useList = service.getNeighborhoodLibraryList(neighborhoodLibrary); //현재 선택된 장비를 쓰고있는 예약리스트
		int nowLocker = lockerOneList - useList.size();
		
		neighborhoodLibraryDevice.setTotalDataCount(count);
		model.addAttribute("nowLocker", nowLocker);
		model.addAttribute("deviceList", deviceList);
		model.addAttribute("reserveList", reserveList);		
		model.addAttribute("neighborhoodLibrary", neighborhoodLibrary);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/delete.*"})
	public String edit(Model model, NeighborhoodLibrary neighborhoodLibrary, HttpServletRequest request) {
		
		model.addAttribute("neighborhoodLibrary", neighborhoodLibrary);
		return basePath + "delete_ajax";
	}

	@RequestMapping(value = {"/save.*"})
	public @ResponseBody JsonResponse save(Model model, NeighborhoodLibrary neighborhoodLibrary, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "reserve_status", "상태값 정보를 가져오지 못했습니다.");
		ValidationUtils.rejectIfEmpty(result, "reserve_idx", "예약번호를 가져오지 못했습니다.");
		
		if (!result.hasErrors()) {
				service.updateNeighborhoodLibrary(neighborhoodLibrary, request);
				res.setValid(true);
				if("2".equals(neighborhoodLibrary.getReserve_status())) {
					res.setMessage("예약확정 되었습니다.");
				}else if("3".equals(neighborhoodLibrary.getReserve_status())) {
					res.setMessage("사물함 투입 상태로 변경 되었습니다.");
				}else if("4".equals(neighborhoodLibrary.getReserve_status())) {
					res.setMessage("대출 상태로 변경 되었습니다.");
				}else if("5".equals(neighborhoodLibrary.getReserve_status())) {
					res.setMessage("회수대기 상태로 변경 되었습니다.");
				}else if("6".equals(neighborhoodLibrary.getReserve_status())) {
					res.setMessage("회수중 상태로 변경 되었습니다.");
				}else if("7".equals(neighborhoodLibrary.getReserve_status())) {
					res.setMessage("회수완료 상태로 변경 되었습니다.");
				}else if("8".equals(neighborhoodLibrary.getReserve_status())) {
					res.setMessage("해당 예약이 취소 되었습니다.");
				}
			
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}
