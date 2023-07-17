package kr.go.gbelib.app.cms.module.circlesRoom;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping(value={"/cms/circlesRoom"})
public class CirclesRoomController extends BaseController {
	
	private final String basePath = "/cms/module/circlesRoom/";
	
	@Autowired
	private CirclesRoomService service;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, CirclesRoom circlesRoom, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		circlesRoom.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.getCirclesRoomCount(circlesRoom), circlesRoom);
		model.addAttribute("circlesRoom", circlesRoom);
		model.addAttribute("circlesRoomList", service.getCirclesRoomList(circlesRoom));
		model.addAttribute("reqTimeCode", codeService.getCode("CMS", "C0018")); // 사용시간
		model.addAttribute("circlesDivCode", codeService.getCode(circlesRoom.getHomepage_id(), "H0006")); // 도서관 구분

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, CirclesRoom circlesRoom, HttpServletRequest request) throws AuthException {
		checkAuth("C", model, request);
		circlesRoom.setHomepage_id(getAsideHomepageId(request));
		
		Member member = getSessionMemberInfo(request);
		if(member != null) {
			circlesRoom.setUser_id(member.getMember_id());
		}
		
		model.addAttribute("circlesRoom", circlesRoom);
		model.addAttribute("reqTimeCode", codeService.getCode("CMS", "C0018")); // 사용시간
		model.addAttribute("circlesDivCode", codeService.getCode(circlesRoom.getHomepage_id(), "H0006")); // 도서관 구분
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, CirclesRoom circlesRoom, BindingResult result, HttpServletRequest request) throws AuthException  {
		JsonResponse res = new JsonResponse(request);
		String editMode = circlesRoom.getEditMode();
		if(!circlesRoom.getEditMode().equals("DELETE")) {
//			ValidationUtils.rejectIfEmpty(result, "visit_date", "사용희망일을 입력하세요.");
		}
		
		circlesRoom.setUser_ci("admin");
		circlesRoom.setIp(request.getRemoteAddr());
		circlesRoom.setVisit_time(StringUtils.join(circlesRoom.getVisit_time_list(), ","));
		
		//check중복시간
		List<CirclesRoom> chk_arr = service.getCirclesRoomReqView(circlesRoom);
		for (String value_arr : circlesRoom.getVisit_time_list()) {
			for(int i=0; i<chk_arr.size(); i++) {
				if(value_arr.equals(chk_arr.get(i).getVisit_time())) {
					res.setValid(false);
					res.setMessage("이용시간이 이미 신청되었습니다.");
					return res;
				}
			}
		}

		
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				if(circlesRoom.getCircles_file() != null) {
					circlesRoom = service.addCirclesFile(circlesRoom);
					if(circlesRoom.getServer_file_name() == null) {
						res.setValid(false);
						res.setMessage("잘못된 파일 입니다.");
						return res;
					}
				}

				circlesRoom.setAdd_id(getSessionMemberId(request));
				service.addCirclesRoom(circlesRoom);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/modifyStatus.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modifyStatus(CirclesRoom circlesRoom, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
			circlesRoom.setModify_id(getSessionMemberId(request));
			int resNum = service.modifyStatus(circlesRoom);
			if(resNum > 0) {
				res.setValid(true);
				res.setReload(true);
				res.setMessage("신청상태가 수정되었습니다.");

				Member sessionMemberInfo = getSessionMemberInfo(request);
				CirclesRoom circlesRoomInfo = service.getCirclesRoomUserInfo(circlesRoom);
				circlesRoom.setCircles_title(circlesRoomInfo.getCircles_title());
				circlesRoom.setRec_key(circlesRoomInfo.getRec_key());
				// 문자 전송
				service.getSendSms(circlesRoom, sessionMemberInfo, request);

			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/delSelect.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delSelect(CirclesRoom circlesRoom, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
			List<CirclesRoom> list = service.getCirclesRoomList(circlesRoom);
			int resNum = service.deleteCirclesRoomList(circlesRoom);

			if(resNum > 0) {
				for (CirclesRoom room : list) {
					if(room.getOrigin_file_name() != null) {
						service.getDeleteFile(room); // 파일삭제
					}
				}

				res.setValid(true);
				res.setReload(true);
				res.setMessage("선택한 목록이 삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"})
	public CirclesRoomExcelView excel(Model model, CirclesRoom circlesRoom, HttpServletRequest request, HttpServletResponse response) throws Exception{
		checkAuth("R", model, request);
		circlesRoom.setHomepage_id(getAsideHomepageId(request));
		circlesRoom.setRowCount(99999);
		
		service.setPaging(model, service.getCirclesRoomCount(circlesRoom), circlesRoom);
		model.addAttribute("circlesRoom", circlesRoom);
		model.addAttribute("circlesRoomList", service.getCirclesRoomList(circlesRoom));
		model.addAttribute("reqTimeCode", codeService.getCode("CMS", "C0018")); // 사용시간
		model.addAttribute("circlesDivCode", codeService.getCode(circlesRoom.getHomepage_id(), "H0006")); // 도서관 구분

		return new CirclesRoomExcelView();
	}

	@RequestMapping(value = "/documentDownload.*")
	@ResponseBody
	public byte[] getFile(CirclesRoom circlesRoom, HttpServletRequest request, HttpServletResponse response) throws Exception {
		circlesRoom = service.getCirclesRoomOne(circlesRoom);
		String filePath = service.getRootPath() + "/" + circlesRoom.getHomepage_id() +  "/"+ circlesRoom.getServer_file_name();
		File file = new File(filePath);

		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		String fileName = circlesRoom.getOrigin_file_name() + "." +circlesRoom.getFile_extension();

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", "application/octet-stream");

		return bytes;
	}

}
