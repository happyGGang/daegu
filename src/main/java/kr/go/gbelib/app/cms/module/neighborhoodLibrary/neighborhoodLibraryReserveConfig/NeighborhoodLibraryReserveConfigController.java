package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryReserveConfig;

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
@RequestMapping(value = {"/cms/module/neighborhoodLibraryReserveConfig"})
public class NeighborhoodLibraryReserveConfigController extends BaseController {

	private final String basePath = "/cms/module/neighborhoodLibrary/neighborhoodLibraryReserveConfig/";
	
	@Autowired
	private NeighborhoodLibraryReserveConfigService service;
	
	@RequestMapping(value = {"/index.*"})
	public String reserveConfig_index(Model model,NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig, HttpServletRequest request) throws Exception {		
		List<NeighborhoodLibraryReserveConfig> reserveConfigList = service.getNeighborhoodLibraryReserveConfigList(neighborhoodLibraryReserveConfig); 
		int count = service.getNeighborhoodLibraryReserveConfigCount(neighborhoodLibraryReserveConfig);
		service.setPaging(model, count , neighborhoodLibraryReserveConfig);
		
		model.addAttribute("reserveConfig", neighborhoodLibraryReserveConfig);
		model.addAttribute("reserveConfigList", reserveConfigList);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model,NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig, HttpServletRequest request) throws Exception {		

		model.addAttribute("reserveConfig", neighborhoodLibraryReserveConfig);
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"})
	public @ResponseBody JsonResponse save(Model model,NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);	
		neighborhoodLibraryReserveConfig.setReserve_start_time(neighborhoodLibraryReserveConfig.getReserve_start_time1() + neighborhoodLibraryReserveConfig.getReserve_start_time2());
		neighborhoodLibraryReserveConfig.setReserve_end_time(neighborhoodLibraryReserveConfig.getReserve_end_time1() + neighborhoodLibraryReserveConfig.getReserve_end_time2());
		
		if(neighborhoodLibraryReserveConfig.getEditMode().equals("ADD") || neighborhoodLibraryReserveConfig.getEditMode().equals("MODIFY")) {
			if(neighborhoodLibraryReserveConfig.getEditMode().equals("MODIFY")) {
				ValidationUtils.rejectIfEmpty(result, "reserve_config_idx", "예약설정 IDX값을 가져오지 못했습니다. ");
			}
			ValidationUtils.rejectIfEmpty(result, "reserve_start_time", "예약시작 시간을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "reserve_end_time", "예약종료 시간을 선택하세요.");			
			ValidationUtils.rejectIfEmpty(result, "take_term", "취거기간을 입력하세요.");
		}
		int startTime = Integer.parseInt(neighborhoodLibraryReserveConfig.getReserve_start_time());
		int endTime = Integer.parseInt(neighborhoodLibraryReserveConfig.getReserve_end_time());
		if("Y".equals(neighborhoodLibraryReserveConfig.getTomorrow_end_day_yn())) {
			if(startTime < endTime) {
				res.setValid(false);
				res.setMessage("최대 설정 시간은 24시간 입니다. 시작시간과 종료시간이 같은 날이라면 다음날종료여부를 '미사용'으로 선택해주세요.");
				return res;
			}
		}
		if("N".equals(neighborhoodLibraryReserveConfig.getTomorrow_end_day_yn())) {
			if(startTime >= endTime) {
				res.setValid(false);
				res.setMessage("다음날종료여부가 '미사용'이라면 시작시간이 종료시간보다 빨라야합니다.");
				return res;
			}
		}
		
		if (!result.hasErrors()) {
			if (neighborhoodLibraryReserveConfig.getEditMode().equals("ADD")) {
				neighborhoodLibraryReserveConfig.setAdd_id(getSessionMemberId(request));
				service.addNeighborhoodLibraryReserveConfig(neighborhoodLibraryReserveConfig);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (neighborhoodLibraryReserveConfig.getEditMode().equals("MODIFY")) {
				neighborhoodLibraryReserveConfig.setModify_id(getSessionMemberId(request));
				service.modifyNeighborhoodLibraryDevice(neighborhoodLibraryReserveConfig);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}else if(neighborhoodLibraryReserveConfig.getEditMode().equals("DELETE")) {
//				service.deleteNeighborhoodLibraryDevice(neighborhoodLibraryReserveConfig);
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
