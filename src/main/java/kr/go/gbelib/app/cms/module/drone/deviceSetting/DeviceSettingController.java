package kr.go.gbelib.app.cms.module.drone.deviceSetting;

import javax.servlet.http.HttpServletRequest;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = {"/cms/module/drone/deviceSetting/"})
public class DeviceSettingController extends BaseController {

    private final String basePath = "/cms/module/drone/deviceSetting/";

    @Autowired
    private DeviceSettingService service;

    @RequestMapping(value = {"/index.*"})
    public String index(Model model, DeviceSetting deviceSetting, HttpServletRequest request) throws AuthException {
        checkAuth("R", model, request);

        return basePath + "index";
    }
}
