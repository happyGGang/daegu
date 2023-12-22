package kr.go.gbelib.app.cms.module.archive;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.POIXMLException;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.archive.archiveCategory.ArchiveCategory;
import kr.go.gbelib.app.cms.module.archive.archiveCategory.ArchiveCategoryService;
import kr.go.gbelib.app.cms.module.elib.book.Book;

@Controller
@RequestMapping(value = {"/cms/module/archive"})
public class ArchiveController extends BaseController {

	private final String basePath = "/cms/module/archive/";
	
	@Autowired
	private ArchiveService service;
	
	@Autowired
	private ArchiveCategoryService archiveCategoryService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, Archive archive, ArchiveCategory archiveCategory, HttpServletRequest request, HttpServletResponse response) throws AuthException {
		checkAuth("R", model, request);
		
		int count = service.getArchiveListCmsCount(archive);
		service.setPaging(model, count, archive);
		List<Archive> archiveList = service.getArchiveListCms(archive);
		
		model.addAttribute("largeCategoryList", archiveCategoryService.getLargeCategoryList());
		model.addAttribute("midCategoryList", archiveCategoryService.getMidCategoryList(archiveCategory));
		model.addAttribute("smallCategoryList", archiveCategoryService.getSmallCategoryList(archiveCategory));
		
		model.addAttribute("producerNameList", codeService.getCode("CMS", "A0001"));
		model.addAttribute("originalOwnerList", codeService.getCode("CMS", "A0002"));
		model.addAttribute("regionList", codeService.getCode("CMS", "A0003"));
		model.addAttribute("personList", codeService.getCode("CMS", "A0004"));
		model.addAttribute("typeList", codeService.getCode("CMS", "A0005"));
		model.addAttribute("dataTypeList", codeService.getCode("CMS", "A0006"));
		model.addAttribute("eraList", codeService.getCode("CMS", "A0007"));
		
		model.addAttribute("archive", archive);
		model.addAttribute("archiveList", archiveList);
		model.addAttribute("archiveCnt", count);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, Archive archive, ArchiveCategory archiveCategory, HttpServletRequest request, HttpServletResponse response) throws AuthException {
		
		if ( StringUtils.isEmpty(archiveCategory.getLarge_code()) ) {
			List<ArchiveCategory> archiveCategoryList = archiveCategoryService.getLargeCategoryList();
			if( archiveCategoryList.size() != 0) {
				archiveCategory.setLarge_code(archiveCategoryList.get(0).getLarge_code());
			}
		}
		
		if ( StringUtils.isEmpty(archiveCategory.getMid_code()) ) {
			List<ArchiveCategory> archiveCategoryList = archiveCategoryService.getMidCategoryList(archiveCategory);
			if (archiveCategoryList.size() != 0) {
				archiveCategory.setMid_code(archiveCategoryList.get(0).getMid_code());
			}
		}
		
		if ( StringUtils.isEmpty(archiveCategory.getSmall_code()) ) {
			List<ArchiveCategory> archiveCategoryList = archiveCategoryService.getSmallCategoryList(archiveCategory);
			if (archiveCategoryList.size() != 0) {
				archiveCategory.setSmall_code(archiveCategoryList.get(0).getSmall_code());
			}
		}
		
		model.addAttribute("largeCategoryList", archiveCategoryService.getLargeCategoryList());
		model.addAttribute("midCategoryList", archiveCategoryService.getMidCategoryList(archiveCategory));
		model.addAttribute("smallCategoryList", archiveCategoryService.getSmallCategoryList(archiveCategory));
		
		model.addAttribute("producerNameCode", codeService.getCode("CMS", "A0001"));
		model.addAttribute("originalOwnerCode", codeService.getCode("CMS", "A0002"));
		model.addAttribute("regionCode", codeService.getCode("CMS", "A0003"));
		model.addAttribute("personCode", codeService.getCode("CMS", "A0004"));
		model.addAttribute("typeCode", codeService.getCode("CMS", "A0005"));
		model.addAttribute("dataTypeCode", codeService.getCode("CMS", "A0006"));
		model.addAttribute("eraCode", codeService.getCode("CMS", "A0007"));
		
		if (archive.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("archive", service.copyObjectPaging(archive, service.getArchiveOne(archive)));
		} else {
			checkAuth("C", model, request);
			archive.setPublic_yn("Y");
			archive.setAddle_data_yn("N");
			model.addAttribute("archive", archive);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);
		String editMode = archive.getEditMode();
		if ( editMode.equals("ADD") || editMode.equals("MODIFY") ) {
			ValidationUtils.rejectIfEmpty(result, "large_code", "1차 카테고리를 선택해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "public_yn", "공개여부를 선택해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "addle_data_yn", "애뜰자료여부를 선택해 주세요.");
		}

		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {

				archive.setAdd_id(getSessionMemberId(request));
				int addResult = service.addArchive(archive);
				if ( addResult > 0 ) {
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				} else if ( addResult == 0 ) {
					result.reject("이미 동일한 자료(파일)명이 존재합니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				} else if ( addResult == -1 ) {
					result.reject("이미 동일한 이미지(썸네일)명이 존재합니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				} else if ( addResult == -2 ) {
					result.reject("이미 동일한 제목이 존재합니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				}
			} else if ( editMode.equals("MODIFY") ) {
				archive.setModify_id(getSessionMemberId(request));
				int modifyResult = service.modifyArchive(archive);
				if( modifyResult > 0 ) {
					res.setValid(true);
					res.setMessage("수정 되었습니다.");
				} else if ( modifyResult == 0 ) {
					result.reject("이미 동일한 자료(파일)명이 존재합니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				} else if ( modifyResult == -1 ) {
					result.reject("이미 동일한 이미지(썸네일)명이 존재합니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				} else if ( modifyResult == -2 ) {
					result.reject("이미 동일한 제목이 존재합니다.");
					res.setValid(false);
					res.setResult(result.getAllErrors());
				}
			} else if ( editMode.equals("DELETE") ) {
				archive.setDelete_id(getSessionMemberId(request));
				service.deleteArchive(archive);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public ArchiveSearchView excel(Model model, Archive archive, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("archive", archive);
		model.addAttribute("archiveResult", service.getArchiveListCmsAll(archive));
		return new ArchiveSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Archive archive, HttpServletRequest request, HttpServletResponse response) {
		List<Archive> archiveList = service.getArchiveListCmsAll(archive);

		model.addAttribute("archive", archive);
		model.addAttribute("archiveResult", archiveList);

		new ArchiveXlsToCsv(archiveList, "Archive.csv", request, response);
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

		String fileName = archive.getFile_name();

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.setHeader("Content-Type", "application/octet-stream");

	    return bytes;
    }
	
	@RequestMapping(value = { "/deleteFile.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		service.deleteFile(archive);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}

	@RequestMapping(value = { "/deleteImage.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteImage(Model model, Archive archive, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		service.deleteImage(archive);
		res.setValid(true);
		res.setMessage("이미지를 삭제 했습니다.");

		return res;
	}
	
	@RequestMapping(value = {"/upload_index.*"})
	public String upload_index(Model model, Archive archive, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		return basePath + "upload_index";
	}
	
	@RequestMapping(value = {"/result.*"})
	public String result(Model model, Book book, MultipartHttpServletRequest request, HttpServletResponse response) throws AuthException, IOException {
		checkAuth("C", model, request);
		
		Map<String, Object> result = upload(model, request, response);
		
		if(result.get("marcUrlList") == null) {
			model.addAttribute("logs", result.get("logs"));
			return basePath + "result";
		} else {
			model.addAttribute("marcUrlList", result.get("marcUrlList"));
			model.addAttribute("marcUrlsCount", result.get("marcUrlsCount"));
			
			String fileName = "마크URL_" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + ".xls";
			
			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType(AttachmentUtils.getContentType("xls"));
			
			return basePath + "xls_ajax";
		}
	}
	
	private String getStringCellValue(Row row, int col) {
		Cell cell = row.getCell(col, Row.RETURN_BLANK_AS_NULL);
		DataFormatter formatter = new DataFormatter();
		SimpleDateFormat DtFormat = new SimpleDateFormat("yyyy-MM-dd");

        if(cell == null) {
        	return "";
        } else if(cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA) {
	            switch(cell.getCachedFormulaResultType()) {
	            case HSSFCell.CELL_TYPE_NUMERIC:
	            	if(HSSFDateUtil.isCellDateFormatted(cell)) {
	            		Date date = cell.getDateCellValue();
	            		return StringUtils.trimToEmpty(DtFormat.format(date).toString());
	            	} else {
	            		return StringUtils.trimToEmpty(formatter.formatCellValue(cell));
	            	}
	            case HSSFCell.CELL_TYPE_STRING:
	            	return StringUtils.trimToEmpty(cell.getRichStringCellValue().getString());
	            default:
	            	return StringUtils.trimToEmpty(formatter.formatCellValue(cell));
	        }
        } else if(cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC && HSSFDateUtil.isCellDateFormatted(cell)) {
            	Date date = cell.getDateCellValue();
            	return StringUtils.trimToEmpty(DtFormat.format(date).toString());
        } else {
        	return StringUtils.trimToEmpty(formatter.formatCellValue(cell));
        }
	}
	
	public Map<String, Object> upload(Model model, MultipartHttpServletRequest request, HttpServletResponse response) throws AuthException, IOException {
		
		MultipartFile mfile = request.getFileMap().get("mfile");
		String operation = StringUtils.trimToEmpty(request.getParameter("operation"));
		String run_mode = StringUtils.defaultString(request.getParameter("run_mode"));
		List<Archive> archiveList = new ArrayList<Archive>();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("insertCount", "0");
		result.put("updateCount", "0");
		result.put("deleteCount", "0");
		result.put("notExistCount", "0");
		result.put("insertIds", "없음");
		result.put("updateIds", "없음");
		result.put("deleteIds", "없음");
		result.put("notExistIds", "없음");
		int rowNum = 0;
		
		List<String> out = new ArrayList<String>();
		
		response.setContentType("text/plain; charset=UTF-8");

		if(mfile == null) {
			out.add("파일을 선택해주세요.");
			result.put("logs", out);
			return result;
		}
		
		DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
		out.add(dtf.print(new DateTime()) + " 시작");
		out.add("작업자: " + getSessionMemberId(request));
		out.add("파일명: " + mfile.getOriginalFilename());
		if("I".equals(operation)) {
			out.add("작업 종류: Insert / Update");
		} else if("D".equals(operation)) {
			out.add("작업 종류: Delete");
		}
		
		try {
			
//			Get the workbook instance for XLS file 
			XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
//			Get first sheet from the workbook
			XSSFSheet sheet = workbook.getSheetAt(0);
			int rowStart = 1;
			int rowEnd = sheet.getLastRowNum();
			for (rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
				Row row = sheet.getRow(rowNum);
				if (row == null) {
					out.add("" + rowNum + "번째 줄은 비어서 패스");
					continue;
				}
				
				Archive archive = new Archive();
				archive.setDelete_yn("N");
				
				Code code = new Code();
				ArchiveCategory archiveCategory = new ArchiveCategory();
				
				String large_code_name = getStringCellValue(row, 1);
				String title = getStringCellValue(row, 4);
				String producer_name = getStringCellValue(row, 7);
				String original_owner = getStringCellValue(row, 8);
				String region = getStringCellValue(row, 9);
				String person = getStringCellValue(row, 10);
				String type = getStringCellValue(row, 12);
				String data_type = getStringCellValue(row, 13);
				String public_yn = getStringCellValue(row, 15);
				String addle_data_yn = getStringCellValue(row, 16);
				String image_file_name = getStringCellValue(row, 17);
				String image_file_path = getStringCellValue(row, 18);
				String file_name = getStringCellValue(row, 19);
				String file_path = getStringCellValue(row, 20);
				String view_file_path = getStringCellValue(row, 21);
				String era = getStringCellValue(row, 23);
				
				if (StringUtils.trimToNull(large_code_name) == null) {
					out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (1차 카테고리를 입력해주세요.)");
					break;
				} else {
					archiveCategory.setCode_name(large_code_name);
					String large_code = archiveCategoryService.getLargeCategoryCodeId(archiveCategory);
					
					archiveCategory.setLarge_code(large_code);
					if (archiveCategoryService.getLargeCategoryCnt(archiveCategory) < 1) {
						out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (등록된 1차 카테고리가 없습니다. 아카이브 카테고리 관리에서 1차 카테고리를 추가해주세요.");
						break;
					} else {
						archive.setLarge_code(large_code);
						archive.setOriginal_large_code(large_code);
					}
				}
				
				if (StringUtils.trimToNull(title) == null) {
					out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (제목을 입력해주세요.)");
					break;
				} else {
					archive.setTitle(title);
				}
			
				if (StringUtils.trimToNull(producer_name) == null) {
					archive.setProducer_name("0000");
				} else {
					code.setHomepage_id("CMS");
					code.setGroup_id("A0001");
					code.setCode_name(producer_name);
					
					String codeId = codeService.getCodeId(code);
					
					if (StringUtils.isEmpty(codeId)) {
						out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (해당 생산자명은 존재하지 않습니다.)");
						break;
					} else {
						archive.setProducer_name(codeId);
						code = new Code();
					}
				}
				
				if (StringUtils.trimToNull(original_owner) == null) {
					archive.setOriginal_owner("0000");
				} else {
					code.setHomepage_id("CMS");
					code.setGroup_id("A0002");
					code.setCode_name(original_owner);
					
					String codeId = codeService.getCodeId(code);
					
					if (StringUtils.isEmpty(codeId)) {
						out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (해당 원본소장처는 존재하지 않습니다.)");
						break;
					} else {
						archive.setOriginal_owner(codeId);
						code = new Code();
					}
				}
				
				if (StringUtils.trimToNull(region) == null) {
					archive.setRegion("0000");
				} else {
					code.setHomepage_id("CMS");
					code.setGroup_id("A0003");
					code.setCode_name(region);
					
					String codeId = codeService.getCodeId(code);
					
					if (StringUtils.isEmpty(codeId)) {
						out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (해당 지역은 존재하지 않습니다.)");
						break;
					} else {
						archive.setRegion(codeId);
						code = new Code();
					}
				}
				
				if (StringUtils.trimToNull(person) == null) {
					archive.setPerson("0000");
				} else {
					code.setHomepage_id("CMS");
					code.setGroup_id("A0004");
					code.setCode_name(person);
					
					String codeId = codeService.getCodeId(code);
					
					if (StringUtils.isEmpty(codeId)) {
						out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (해당 인물은 존재하지 않습니다.)");
						break;
					} else {
						archive.setPerson(codeId);
						code = new Code();
					}
				}
				
				if (StringUtils.trimToNull(type) == null) {
					archive.setType("0000");
				} else {
					code.setHomepage_id("CMS");
					code.setGroup_id("A0005");
					code.setCode_name(type);
					
					String codeId = codeService.getCodeId(code);
					
					if (StringUtils.isEmpty(codeId)) {
						out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (해당 유형은 존재하지 않습니다.)");
						break;
					} else {
						archive.setType(codeId);
						code = new Code();
					}
				}
				
				if (StringUtils.trimToNull(data_type) == null) {
					archive.setData_type("0000");
				} else {
					code.setHomepage_id("CMS");
					code.setGroup_id("A0006");
					code.setCode_name(data_type);
					
					String codeId = codeService.getCodeId(code);
					
					if (StringUtils.isEmpty(codeId)) {
						out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (해당 형태는 존재하지 않습니다.)");
						break;
					} else {
						archive.setData_type(codeId);
						code = new Code();
					}
				}
				
				if (StringUtils.trimToNull(era) == null) {
					archive.setProducer_name("0000");
				} else {
					code.setHomepage_id("CMS");
					code.setGroup_id("A0007");
					code.setCode_name(era);
					
					String codeId = codeService.getCodeId(code);
					
					if (StringUtils.isEmpty(codeId)) {
						out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (해당 시대명은 존재하지 않습니다.)");
						break;
					} else {
						archive.setEra(codeId);
						code = new Code();
					}
				}
				
				if (StringUtils.trimToNull(public_yn) == null || (!"공개".equals(public_yn) && !"비공개".equals(public_yn)) ) {
					out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (공개여부에는 공개 또는 비공개를 입력해 주세요.)");
					break;
				} else {
					if ("공개".equals(public_yn)) {
						archive.setPublic_yn("Y");
					} else if ("비공개".equals(public_yn)) {
						archive.setPublic_yn("N");
					}
				}
				
				if (StringUtils.trimToNull(addle_data_yn) == null || (!"Y".equals(addle_data_yn) && !"N".equals(addle_data_yn))) {
					out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (애뜰자료여부에는 Y 또는 N을 입력해 주세요.)");
					break;
				} else {
					if ("Y".equals(addle_data_yn)) {
						archive.setAddle_data_yn("Y");
					} else if ("N".equals(addle_data_yn)) {
						archive.setAddle_data_yn("N");
					}
				}
				
				archive.setImage_file_name(image_file_name);
				
				if (StringUtils.trimToNull(image_file_path) == null) {
					//out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (이미지(썸네일) 파일경로를 입력해주세요.)");
					//break;
					archive.setImage_file_path("/data/archive/img/");
				} else {
					archive.setImage_file_path(image_file_path);
				}
				
				archive.setFile_name(file_name);
				
				if (StringUtils.trimToNull(file_path) == null) {
					//out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (아카이브 파일경로를 입력해주세요.)");
					//break;
					archive.setFile_path("/data/archive/");
				} else {
					archive.setFile_path(file_path);
				}
				
				archive.setView_file_path(view_file_path);
				/*if (StringUtils.trimToNull(view_file_path) == null) {
					out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료 (뷰어 파일 경로를 입력해주세요.)");
					break;
				} else {
					archive.setView_file_path(view_file_path);
				}*/

				if("I".equals(operation)) {
					archive.setManage_num(getStringCellValue(row, 2));
					archive.setRelated_number(getStringCellValue(row, 3));
					archive.setProduct_year(getStringCellValue(row, 5));
					String product_date = getStringCellValue(row, 6);
					archive.setProduct_date(product_date);
					archive.setDescription(getStringCellValue(row, 11));
					archive.setProvide_method(getStringCellValue(row, 12));
					archive.setAdd_id(getSessionMemberId(request));
					archive.setArchive_link(getStringCellValue(row, 22));
					archive.setCopyright(getStringCellValue(row, 24));
					archive.setInformation_ment(getStringCellValue(row, 25));
				} else if ("D".equals(operation)) {
					
					archive.setDelete_id(getSessionMemberId(request));
				}
				
				archiveList.add(archive);
			}
			
//			file.close();
		} catch(POIXMLException e) {
			e.printStackTrace();
			out.add(".xlsx 형식의 파일을 업로드 해주세요. (.xls 이용 불가)");
			result.put("logs", out);
			return result;
		} catch(NumberFormatException e) {
			e.printStackTrace();
			out.add("" + rowNum + "번째 줄에서 숫자 형식에 맞지 않는 입력 발견: " + e.getMessage());
			result.put("logs", out);
			return result;
		} catch(Exception e) {
			e.printStackTrace();
			out.add("" + rowNum + "번째 줄에서 오류: " + e.getMessage());
			result.put("logs", out);
			return result;
		}
		
		try {
			Member member = getSessionMemberInfo(request);
			if("I".equals(operation)) {
				result.putAll(service.batchInsertArchiveList(archiveList, out, run_mode, member));
			} else if("D".equals(operation)) {
				result.putAll(service.batchDeleteArchiveList(archiveList, out, run_mode));
			} else {
				throw new IllegalArgumentException("작업 종류를 잘못 선택하셨습니다: " + operation);
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.add(e.getMessage());
			result.put("logs", out);
			return result;
		}
		
		out.add("수정 ID: " + StringUtils.defaultIfEmpty(String.valueOf(result.get("updateIds")), "없음"));
		out.add("삭제 ID: " + StringUtils.defaultIfEmpty(String.valueOf(result.get("deleteIds")), "없음"));
		out.add(String.format("횟수: 삽입: %s | 수정: %s | 삭제: %s | 자료없음: %s", result.get("insertCount"), result.get("updateCount"), result.get("deleteCount"), result.get("notExistCount")));
		out.add(dtf.print(new DateTime()) + " 종료");
		
		result.put("logs", out);
		return result;
	}
	
	@RequestMapping(value = {"/excelDownloadSample.*"}, method = RequestMethod.GET)
	public void ExcelDownloadSample(HttpServletRequest request, HttpServletResponse response) throws Exception {
		XSSFWorkbook xssf = new XSSFWorkbook();
		XSSFSheet sheet = xssf.createSheet("아카이브 업로드 샘플");
		
		sheet.setColumnWidth(0, 5*256); //순번
		sheet.setColumnWidth(1, 15*256); //1차 카테고리
		sheet.setColumnWidth(2, 20*256); //관리번호
		sheet.setColumnWidth(3, 20*256); //관련번호
		sheet.setColumnWidth(4, 20*256); //제목
		sheet.setColumnWidth(5, 10*256); //생산연도
		sheet.setColumnWidth(6, 15*256); //생산일자
		sheet.setColumnWidth(7, 20*256); //생산자명
		sheet.setColumnWidth(8, 20*256); //원본소장처
		sheet.setColumnWidth(9, 20*256); //지역
		sheet.setColumnWidth(10, 20*256); //인물
		sheet.setColumnWidth(11, 60*256); //설명
		sheet.setColumnWidth(12, 20*256); //유형
		sheet.setColumnWidth(13, 20*256); //형태
		sheet.setColumnWidth(14, 20*256); //제공방법
		sheet.setColumnWidth(15, 10*256); //공개여부
		sheet.setColumnWidth(16, 10*256); //애뜰자료여부
		sheet.setColumnWidth(17, 30*256); //이미지(썸네일) 파일명
		sheet.setColumnWidth(18, 30*256); //이미지(썸네일) 파일경로
		sheet.setColumnWidth(19, 30*256); //아카이브 파일명
		sheet.setColumnWidth(20, 30*256); //아카이브 파일경로
		sheet.setColumnWidth(21, 60*256); //뷰어 파일경로
		sheet.setColumnWidth(22, 60*256); //링크
		sheet.setColumnWidth(23, 30*256); //시대
		sheet.setColumnWidth(24, 60*256); //저작권표시
		sheet.setColumnWidth(25, 200*256); //이용안내멘트
		
		//헤더 스타일
		XSSFCellStyle headerStyle = xssf.createCellStyle();
		XSSFFont font = xssf.createFont();
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD); //글자 진하게
		
		headerStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); //행 가운데 정렬
		headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headerStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER); //열 가운데 정렬
		headerStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		headerStyle.setFont(font);
		
		XSSFRow row =null;
		XSSFCell cell = null;
		int rowNo = 0;
		
		row = sheet.createRow(rowNo++);
		row.setHeight((short)2000);
		cell = row.createCell(0);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("순번");
		cell = row.createCell(1);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("1차 카테고리");
		cell = row.createCell(2);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("관리번호");
		cell = row.createCell(3);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("관련번호");
		cell = row.createCell(4);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("제목");
		cell = row.createCell(5);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("생산연도");
		cell = row.createCell(6);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("생산일자");
		cell = row.createCell(7);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("생산자명");
		cell = row.createCell(8);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("원본소장처");
		cell = row.createCell(9);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("지역");
		cell = row.createCell(10);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("인물");
		cell = row.createCell(11);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("설명");
		cell = row.createCell(12);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("유형");
		cell = row.createCell(13);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("형태");
		cell = row.createCell(14);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("제공방법");
		cell = row.createCell(15);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("공개여부");
		cell = row.createCell(16);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("애뜰자료여부");
		cell = row.createCell(17);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("이미지(썸네일) 파일명");
		cell = row.createCell(18);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("이미지(썸네일) 파일경로");
		cell = row.createCell(19);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("아카이브 파일명");
		cell = row.createCell(20);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("아카이브 파일경로");
		cell = row.createCell(21);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("뷰어 파일 경로");
		cell = row.createCell(22);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("링크");
		cell = row.createCell(23);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("시대");
		cell = row.createCell(24);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("저작권표시");
		cell = row.createCell(25);
		cell.setCellStyle(headerStyle);
		cell.setCellValue("이용안내멘트");
		
		row = sheet.createRow(rowNo++);
		cell = row.createCell(0); //순번
		cell.setCellValue("1");
		cell = row.createCell(1); //1차 카테고리
		cell.setCellValue("부산학아카이브");
		cell = row.createCell(2); //관리번호
		cell.setCellValue("");
		cell = row.createCell(3); //관련번호
		cell.setCellValue("");
		cell = row.createCell(4); //제목
		cell.setCellValue("『부산시사』제1권(1989.12)");
		cell = row.createCell(5); //생산연도
		cell.setCellValue("2000"); 
		cell = row.createCell(6); //생산일자
		cell.setCellValue("2000-12-31");
		cell = row.createCell(7); //생산자명
		cell.setCellValue("부산연구원");
		cell = row.createCell(8); //원본소장처
		cell.setCellValue("부산연구원");
		cell = row.createCell(9); //지역
		cell.setCellValue("");
		cell = row.createCell(10); //인물
		cell.setCellValue("");
		cell = row.createCell(11); //설명
		cell.setCellValue(" 지세, 지질, 기후 등 부산의 자연환경과 신석기 및 청동기시대의 부산의 역사");
		cell = row.createCell(12); //유형
		cell.setCellValue("간행물");
		cell = row.createCell(13); //형태
		cell.setCellValue("PDF");
		cell = row.createCell(14); //제공방법
		cell.setCellValue("");
		cell = row.createCell(15); //공개여부
		cell.setCellValue("공개");
		cell = row.createCell(16); //애뜰자료여부
		cell.setCellValue("N");
		cell = row.createCell(17); //이미지(썸네일) 파일명
		cell.setCellValue("01.png");
		cell = row.createCell(18); //이미지(썸네일) 파일경로
		cell.setCellValue("/data/archive/img/");
		cell = row.createCell(19); //아카이브 파일명
		cell.setCellValue("『부산시사』제1권(1989.12).pdf");
		cell = row.createCell(20); //아카이브 파일경로
		cell.setCellValue("/data/archive/");
		cell = row.createCell(21); //뷰어파일경로
		cell.setCellValue("/data/archive/view/『부산시사』제1권(1989.12)");
		cell = row.createCell(22); //링크
		cell.setCellValue("");
		cell = row.createCell(23); //시대
		cell.setCellValue("현대");
		cell = row.createCell(24); //저작권표시
		cell.setCellValue("공공누리 4유형 이미지");
		cell = row.createCell(25); //이용안내멘트
		cell.setCellValue("해당 기록은 공공누리 제4유형으로 \"출처표시+상업용금지+변경금지\" 조건에 따라 이용할 수 있으며, 그 외 이용은 원본소장처로 문의하시기 바랍니다.");
		
		String fileName = "아카이브 업로드 샘플" + ".xlsx";

		response.setContentType("application/download;charset=utf-8");
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary;");
		
		OutputStream os = null;
		try {
			os = response.getOutputStream();
			xssf.write(os);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(os != null) {
				try {
					os.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
