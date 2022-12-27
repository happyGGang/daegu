package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig;

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
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice.NeighborhoodLibraryDevice;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice.NeighborhoodLibraryDeviceService;

/**
 * @author ttkaz
 * 2022. 10. 17.
 *
 */

@Controller
@RequestMapping(value = {"/cms/module/nearbyLibReserveConfig"})
public class NearbyLibReserveConfigController extends BaseController {

	private final String basePath = "/cms/module/nearbyLib/nearbyLibReserveConfig/";
	
	@Autowired
	private NearbyLibReserveConfigService service;
	
	@RequestMapping(value = {"/index.*"})
	public String reserveConfig_index(Model model,NearbyLibReserveConfig nearbyLibReserveConfig, HttpServletRequest request) throws Exception {		
		List<NearbyLibReserveConfig> reserveConfigList = service.getNeighborhoodLibraryReserveConfigList(nearbyLibReserveConfig); 
		int count = service.getNeighborhoodLibraryReserveConfigCount(nearbyLibReserveConfig);
		service.setPaging(model, count , nearbyLibReserveConfig);
		
		model.addAttribute("reserveConfig", nearbyLibReserveConfig);
		model.addAttribute("reserveConfigList", reserveConfigList);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model,NearbyLibReserveConfig nearbyLibReserveConfig, HttpServletRequest request) throws Exception {		

		model.addAttribute("reserveConfig", nearbyLibReserveConfig);
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"})
	public @ResponseBody JsonResponse save(Model model,NearbyLibReserveConfig nearbyLibReserveConfig, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);	
		nearbyLibReserveConfig.setReserve_start_time(nearbyLibReserveConfig.getReserve_start_time1() + nearbyLibReserveConfig.getReserve_start_time2());
		nearbyLibReserveConfig.setReserve_end_time(nearbyLibReserveConfig.getReserve_end_time1() + nearbyLibReserveConfig.getReserve_end_time2());
		
		if(nearbyLibReserveConfig.getEditMode().equals("ADD") || nearbyLibReserveConfig.getEditMode().equals("MODIFY")) {
			if(nearbyLibReserveConfig.getEditMode().equals("MODIFY")) {
				ValidationUtils.rejectIfEmpty(result, "reserve_config_idx", "예약설정 IDX값을 가져오지 못했습니다. ");
			}
			ValidationUtils.rejectIfEmpty(result, "reserve_start_time", "예약시작 시간을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "reserve_end_time", "예약종료 시간을 선택하세요.");			
			ValidationUtils.rejectIfEmpty(result, "take_term", "취거기간을 입력하세요.");
		}
		int startTime = Integer.parseInt(nearbyLibReserveConfig.getReserve_start_time());
		int endTime = Integer.parseInt(nearbyLibReserveConfig.getReserve_end_time());
		if("Y".equals(nearbyLibReserveConfig.getTomorrow_end_day_yn())) {
			if(startTime < endTime) {
				res.setValid(false);
				res.setMessage("최대 설정 시간은 24시간 입니다. 시작시간과 종료시간이 같은 날이라면 다음날종료여부를 '미사용'으로 선택해주세요.");
				return res;
			}
		}
		if("N".equals(nearbyLibReserveConfig.getTomorrow_end_day_yn())) {
			if(startTime >= endTime) {
				res.setValid(false);
				res.setMessage("다음날종료여부가 '미사용'이라면 시작시간이 종료시간보다 빨라야합니다.");
				return res;
			}
		}
		
		if (!result.hasErrors()) {
			if (nearbyLibReserveConfig.getEditMode().equals("ADD")) {
				nearbyLibReserveConfig.setAdd_id(getSessionMemberId(request));
				service.addNeighborhoodLibraryReserveConfig(nearbyLibReserveConfig);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (nearbyLibReserveConfig.getEditMode().equals("MODIFY")) {
				nearbyLibReserveConfig.setModify_id(getSessionMemberId(request));
				service.modifyNeighborhoodLibraryDevice(nearbyLibReserveConfig);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}else if(nearbyLibReserveConfig.getEditMode().equals("DELETE")) {
//				service.deleteNeighborhoodLibraryDevice(nearbyLibReserveConfig);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;

	}
}
