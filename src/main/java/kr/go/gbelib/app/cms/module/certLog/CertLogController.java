package kr.go.gbelib.app.cms.module.certLog;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AES128;

@Controller
@RequestMapping(value={"/cms/certLog"})
public class CertLogController extends BaseController {
	
	private final String basePath = "/cms/module/certLog/";
	
	@Autowired
	private CertLogService service;
	
	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, CertLog certLog, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		List<CertLog> certLogList = service.getCertLogList();
		for(CertLog log: certLogList) {
			try {
				log.setName(StringUtils.defaultString(AES128.decrypt(log.getName()), log.getName()));
				log.setBirthday(StringUtils.defaultString(AES128.decrypt(log.getBirthday()), log.getBirthday()));
				log.setCell_phone(StringUtils.defaultString(AES128.decrypt(log.getCell_phone()), log.getCell_phone()));
				log.setCi(StringUtils.defaultString(AES128.decrypt(log.getCi()), log.getCi()));
				log.setMsg(StringUtils.defaultString(AES128.decrypt(log.getMsg()), log.getMsg()).replaceAll("\\n", "<br>"));
			} catch(Exception e) {
				
			}
		}
		
		model.addAttribute("certLog", certLog);
		model.addAttribute("certLogList", certLogList);
		return basePath + "index";
	}

}
