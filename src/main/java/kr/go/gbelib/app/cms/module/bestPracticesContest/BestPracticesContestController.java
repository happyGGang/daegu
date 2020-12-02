package kr.go.gbelib.app.cms.module.bestPracticesContest;

import java.io.File;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/bestPracticesContest"})
public class BestPracticesContestController extends BaseController {
	
	private final String basePath = "/cms/module/bestPracticesContest/";

	@Autowired
	private BestPracticesContestService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bestPracticesContest.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.bestPracticesContestCount(bestPracticesContest), bestPracticesContest);
		
		model.addAttribute("bestPracticesContest", bestPracticesContest);
		model.addAttribute("bestPracticesContestList", service.bestPracticesContestList(bestPracticesContest));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bestPracticesContest.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("bestPracticesContest", bestPracticesContest);
		model.addAttribute("getBestPracticesContest", service.getBestPracticesContest(bestPracticesContest));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request) throws Exception {
		
		if(bestPracticesContest.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("bestPracticesContest", service.copyObjectPaging(bestPracticesContest, service.getBestPracticesContest(bestPracticesContest)));
			return basePath + "edit";
		} else {
			bestPracticesContest.setHomepage_id(getAsideHomepageId(request));
			
			checkAuth("C", model, request);
			model.addAttribute("bestPracticesContest", bestPracticesContest);
			return basePath + "edit_ajax";
			
		}
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BestPracticesContest bestPracticesContest,  BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		if(bestPracticesContest.getEditMode().equals("ADD") || bestPracticesContest.getEditMode().equals("MODIFY") ) {
			ValidationUtils.rejectIfEmpty(result, "contest_field", "공모분야를 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_name", "작성자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "password", "비밀번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_email", "이메일을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_address", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "contents", "내용을 입력하세요.");

    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		if (bestPracticesContest.getUser_email() != null && bestPracticesContest.getUser_email() != "") {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "user_name", 20, "이름");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "user_address", 1000, "주소");
    		ValidationUtils.rejectIfStringLength(result, "title", 500, "제목");
    		ValidationUtils.rejectIfStringLength(result, "contents", 40000, "내용");
		}
		
		if (!result.hasErrors()) {
			if (bestPracticesContest.getEditMode().equals("ADD")) {
				bestPracticesContest.setAdd_id(getSessionMemberId(request));
				service.addBestPracticesContest(bestPracticesContest, mpRequest);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
				res.setUrl("index.do");
			} else if (bestPracticesContest.getEditMode().equals("MODIFY")) {
				bestPracticesContest.setModify_id(getSessionMemberId(request));
				service.modifyBestPracticesContest(bestPracticesContest, mpRequest);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
				res.setUrl("index.do");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bestPracticesContest.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (bestPracticesContest.getEditMode().equals("DELETE")) {
				service.deleteBestPracticesContest(bestPracticesContest);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
				res.setUrl("index.do");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}	
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BestPracticesContestSearchView excel(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("bestPracticesContest", bestPracticesContest);
		model.addAttribute("bestPracticesContestResult", service.getExcelList(bestPracticesContest));
		
		return new BestPracticesContestSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request, HttpServletResponse response) {
		List<BestPracticesContest> bestPracticesContestList = service.getExcelList(bestPracticesContest);
		
		new BestPracticesContestXlsToCsv(bestPracticesContestList, "독서릴레이 우수 사례 공모 리스트.csv", request, response);
	}
	
	@RequestMapping(value = "/download/{homepage_id}/{best_practices_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public byte[] getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("best_practices_idx") int best_practices_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BestPracticesContest bestPracticesContest = service.getBestPracticesContest(new BestPracticesContest(homepage_id, best_practices_idx));
		
		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + bestPracticesContest.getServer_file_name();
		File file = new File(filePath);
		System.out.println(filePath);
		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		String fileName = String.format("%s.%s", bestPracticesContest.getOrg_file_name(),bestPracticesContest.getFile_extension() );

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.setHeader("Content-Type", "application/octet-stream");
	    
	    return bytes;
    }
	
	@RequestMapping(value = "/download/{homepage_id}/{best_practices_idx}2.*", method = RequestMethod.GET)
	@ResponseBody
	public byte[] getFile2(@PathVariable("homepage_id") String homepage_id, @PathVariable("best_practices_idx") int best_practices_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BestPracticesContest bestPracticesContest = service.getBestPracticesContest(new BestPracticesContest(homepage_id, best_practices_idx));
		
		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + bestPracticesContest.getServer_file_name2();
		File file = new File(filePath);
		System.out.println(filePath);
		byte[] bytes = null;
		
		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		
		String fileName = String.format("%s.%s", bestPracticesContest.getOrg_file_name2(),bestPracticesContest.getFile_extension2() );
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", "application/octet-stream");
		
		return bytes;
	}
	
	@RequestMapping(value = "/download/{homepage_id}/{best_practices_idx}3.*", method = RequestMethod.GET)
	@ResponseBody
	public byte[] getFile3(@PathVariable("homepage_id") String homepage_id, @PathVariable("best_practices_idx") int best_practices_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BestPracticesContest bestPracticesContest = service.getBestPracticesContest(new BestPracticesContest(homepage_id, best_practices_idx));
		
		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + bestPracticesContest.getServer_file_name3();
		File file = new File(filePath);
		System.out.println(filePath);
		byte[] bytes = null;
		
		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		
		String fileName = String.format("%s.%s", bestPracticesContest.getOrg_file_name3(),bestPracticesContest.getFile_extension3() );
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", "application/octet-stream");
		
		return bytes;
	}

	@RequestMapping(value = { "/deleteFile.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile(Model model, BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		service.deleteFile(bestPracticesContest);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}

	@RequestMapping(value = { "/deleteFile2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile2(Model model, BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		service.deleteFile2(bestPracticesContest);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}

	@RequestMapping(value = { "/deleteFile3.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile3(Model model, BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		service.deleteFile3(bestPracticesContest);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}
	
}
