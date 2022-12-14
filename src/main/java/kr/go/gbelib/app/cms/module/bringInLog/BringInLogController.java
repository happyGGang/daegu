package kr.go.gbelib.app.cms.module.bringInLog;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value={"/cms/bringInLog"})
public class BringInLogController extends BaseController {
	
	private final String basePath = "/cms/module/bringInLog/";
	
	@Autowired
	private BringInLogService service;
	
	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, BringInLog certLog, HttpServletRequest request) throws AuthException {
//		checkAuth("R", model, request);
//		
//		List<BringInLog> certLogList = service.getCertLogList();
//		for(BringInLog log: certLogList) {
//			try {
//				log.setName(StringUtils.defaultString(AES128.decrypt(log.getName()), log.getName()));
//				log.setBirthday(StringUtils.defaultString(AES128.decrypt(log.getBirthday()), log.getBirthday()));
//				log.setCell_phone(StringUtils.defaultString(AES128.decrypt(log.getCell_phone()), log.getCell_phone()));
//				log.setCi(StringUtils.defaultString(AES128.decrypt(log.getCi()), log.getCi()));
//				log.setMsg(StringUtils.defaultString(AES128.decrypt(log.getMsg()), log.getMsg()).replaceAll("\\n", "<br>"));
//			} catch(Exception e) {
//				
//			}
//		}
//		
//		model.addAttribute("certLog", certLog);
//		model.addAttribute("certLogList", certLogList);
		return basePath + "index";
	}

}
