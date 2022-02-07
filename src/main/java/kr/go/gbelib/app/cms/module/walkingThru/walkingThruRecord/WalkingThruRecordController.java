package kr.go.gbelib.app.cms.module.walkingThru.walkingThruRecord;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting.WalkingThruSetting;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting.WalkingThruSettingService;

@Controller
@RequestMapping(value="/cms/module/walkingThru/walkingThruRecord")
public class WalkingThruRecordController extends BaseController {

	private final String basePath = "/cms/module/walkingThru/walkingThruRecord/";
	
	@Autowired
	private WalkingThruRecordService service;
	
	@Autowired
	private WalkingThruSettingService settingService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, WalkingThruRecord walkingThruRecord, WalkingThruSetting walkingThruSetting, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		int countAll = service.getWalkingThruRecordListAllCount(walkingThruRecord);
		service.setPaging(model, countAll, walkingThruSetting);
		walkingThruSetting.setTotalDataCount(countAll);
		
		walkingThruSetting = settingService.getWalkingThruSettingOne(getAsideHomepageId(request));
		
		model.addAttribute("walkingThruSetting", walkingThruSetting);
		model.addAttribute("walkingThruRecord", walkingThruRecord);
		model.addAttribute("walkingThruRecordListCount", countAll);
		model.addAttribute("walkingThruRecordList", service.getWalkingThruRecordListAll(walkingThruRecord));
		model.addAttribute("walkingThruCodeList", codeService.getCode("CMS", "UT000"));
		
		return basePath + "index";
	}
}
