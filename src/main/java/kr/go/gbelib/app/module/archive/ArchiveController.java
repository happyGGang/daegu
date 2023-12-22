package kr.go.gbelib.app.module.archive;

import java.io.File;
import java.text.ParseException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.archive.Archive;
import kr.go.gbelib.app.cms.module.archive.ArchiveService;
import kr.go.gbelib.app.cms.module.archive.archiveCategory.ArchiveCategory;

@Controller(value="userArchive")
@RequestMapping(value = {"/{homepagePath}/module/archive"})
public class ArchiveController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/archive/";

	@Autowired
	private ArchiveService service;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, Archive archive, ArchiveCategory archiveCategory, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if (archive.getSortField().equals("TITLE")) {
			archive.setSortField("add_date");
		}
		
		if (StringUtils.isEmpty(archive.getView_mode())) {
			archive.setView_mode("list");
		}
		
		if (!StringUtils.isEmpty(archive.getProduct_year_start()) && StringUtils.isEmpty(archive.getProduct_year_end())) {
			Calendar calendar = Calendar.getInstance();
			archive.setProduct_year_end(String.valueOf(calendar.get(Calendar.YEAR)));
		}
		
		if (archive.getView_mode().equals("list")) {
			int count = service.getArchiveListCount(archive);
			service.setPaging(model, count, archive);
			List<Archive> archiveList = service.getArchiveList(archive);
			
			model.addAttribute("archive", archive);
			model.addAttribute("archiveList", archiveList);
			model.addAttribute("archiveCnt", count);
			return String.format(basePath, homepage.getFolder()) + "index_list";
		} else {
			int count = service.getArchiveListCount(archive);
			service.setPagingArchiveThumbnail(model, count, archive);
			List<Archive> archiveList = service.getArchiveList(archive);
			
			model.addAttribute("archive", archive);
			model.addAttribute("archiveList", archiveList);
			model.addAttribute("archiveCnt", count);
			return String.format(basePath, homepage.getFolder()) + "index_thumbnail";
		}
	}
	
	@RequestMapping(value = { "/go.*" }, method = RequestMethod.GET)
	public void go(Model model, Archive archive, ArchiveCategory archiveCategory, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Menu menu = new Menu();
		menu.setMenu_url_param(archive.getMenu_url_param());
		String menu_idx = menuService.getMenuIdxByUrlParam(menu);
		if (menu_idx != null) {
			service.redirectUrl("/archive/module/archive/index.do?"+archive.getMenu_url_param()+"&menu_idx="+menu_idx, request, response);
		} else {
			service.redirectUrl("/archive/module/archive/index.do?"+archive.getMenu_url_param(), request, response);
		}
		return;
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);
		String editMode = archive.getEditMode();
		if ( editMode.equals("VIEW")) {
			ValidationUtils.rejectIfEmpty(result, "large_code", "1차 카테고리를 선택해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "book_idx", "아카이브 자료를 선택해 주세요.");
//
//			ValidationUtils.rejectIfStringLength(result, "title", 100, "제목");
//			ValidationUtils.rejectIfStringLength(result, "description", 1000, "설명");
			
//			ValidationUtils.rejectExceptNumber(result, "product_year", "생산연도는 숫자만 입력 가능합니다.");
			
		}

		if ( !result.hasErrors() ) {
			if ( editMode.equals("VIEW") ) {

				int viewResult = service.addViewCount(archive);
				if ( viewResult > 0 ) {
					res.setValid(true);
				} else {
					result.reject("열람에 실패하였습니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = "/download/{large_code}/{mid_code}/{small_code}/{book_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public byte[] getFile(@PathVariable("large_code") String large_code, @PathVariable("mid_code") String mid_code, @PathVariable("small_code") String small_code, @PathVariable("book_idx") int book_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Archive archive = service.getArchiveOne(new Archive(large_code, mid_code, small_code, book_idx));
		String filePath = service.getRootPath() + "/" + archive.getFile_name();
		File file = new File(filePath);

		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

//		String fileName = "";
		String fileName = archive.getFile_name();

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.setHeader("Content-Type", "application/octet-stream");

	    return bytes;
    }
}
