package kr.co.whalesoft.app.cms.module.addressBook;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.file.Download;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.teach.student.Student;

@Controller
@RequestMapping(value = {"/cms/module/addressBook"})
public class AddressBookController extends BaseController {

	@Autowired
	private AddressBookService service;
	
	private final String basePath = "/cms/module/addressBook/";
	
	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, AddressBook addressBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("addressBook", addressBook);
		return basePath + "index";
	}
	
	
	
	@RequestMapping(value="/getAddressTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<AddressBook> getAddressTreeList(AddressBook addressBook, HttpServletRequest request) {
		addressBook.setMemberInfo(getSessionMemberInfo(request));
		addressBook.getMemberInfo().setHomepage_id(getAsideHomepageId(request));
		return service.getAddressTreeList(addressBook);
	}
	
	@RequestMapping(value="/getAddressOne.*", method=RequestMethod.GET)
	public @ResponseBody AddressBook getAddressBookOne(AddressBook addressBook, HttpServletRequest request) {
		addressBook.setMemberInfo(getSessionMemberInfo(request));
		addressBook.getMemberInfo().setHomepage_id(getAsideHomepageId(request));
		return service.getAddressBookOne(addressBook);
	}
	
	@RequestMapping(value="/getItemList.*", method=RequestMethod.GET)
	public String getItemList(Model model, AddressBook addressBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		addressBook.setMemberInfo(getSessionMemberInfo(request));
		addressBook.getMemberInfo().setHomepage_id(getAsideHomepageId(request));
		model.addAttribute("addressBook", addressBook);
		model.addAttribute("myAddressList", service.getMyItemList(addressBook));
		return basePath + "myItem_ajax";
	}
	

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, AddressBook addressBook, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if ( !addressBook.getEditMode().equals("DELETE") && !addressBook.getEditMode().equals("PARENTMOVE") ) {
			ValidationUtils.rejectIfEmpty(result, "address_book_name", "주소록명을 입력하세요.");
		} 
		
		addressBook.setMemberInfo(getSessionMemberInfo(request));
		addressBook.getMemberInfo().setHomepage_id(getAsideHomepageId(request));
		
		if ( !result.hasErrors() ) {
			if ( addressBook.getEditMode().equals("ADD") ) {
				service.addAddressBookGroup(addressBook);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if ( addressBook.getEditMode().equals("MODIFY") ) {
				service.modifyAddressBookGroup(addressBook);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if ( addressBook.getEditMode().equals("DELETE") ) {
				if ( service.getChildCount(addressBook) > 0 ) {
					res.setValid(false);
					res.setMessage("하위 주소록이 존재하여 삭제할 수 없습니다.");
				} else {
					service.deleteAddressBookGroup(addressBook);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
			} else if ( addressBook.getEditMode().equals("PARENTMOVE") ) {
//				service.moveAddressBookGroup(addressBook); 
//				res.setValid(true);
//				res.setMessage("이동 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/saveAddress.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveAddress(Model model, AddressBook addressBook, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !addressBook.getEditMode().equals("DELETE") && !addressBook.getEditMode().equals("DELETEBATCH") ) {
			ValidationUtils.rejectIfEmpty(result, "address_name", "이름을 입력하세요.");
		} 
		
		addressBook.setMemberInfo(getSessionMemberInfo(request));
		addressBook.getMemberInfo().setHomepage_id(getAsideHomepageId(request));
		
		if ( !result.hasErrors() ) {
			if ( addressBook.getEditMode().equals("ADD") ) {
				service.addAddressBook(addressBook);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if ( addressBook.getEditMode().equals("MODIFY") ) {
				service.modifyAddressBook(addressBook);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if ( addressBook.getEditMode().equals("DELETE") ) {
				service.deleteAddressBook(addressBook);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if ( addressBook.getEditMode().equals("DELETEBATCH") ) {
				service.deleteAddressBookBatch(addressBook);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	

	@RequestMapping(value = { "/excelView.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse view(AddressBook addressBook, BindingResult result, MultipartHttpServletRequest request) throws Exception {
	
		JsonResponse res = new JsonResponse(request);
		
		MultipartFile mFile = request.getFile("uploadFile");
		if(mFile != null) {
			String fileName = mFile.getOriginalFilename();
			String excelExt = fileName.substring(fileName.lastIndexOf(".")+1);
			
			if (excelExt.equals("xls") || excelExt.equals("xlsx")) {
				addressBook.setUploadFile(mFile);
			} else {
				result.reject("엑셀파일만 등록 가능 합니다.");
			}
		} else {
			result.reject("엑셀파일을 첨부해 주세요.");
		}
		
		if (!result.hasErrors()) {
			res.setValid(true);
			res.setData(service.getExcelRows(addressBook));
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = { "/excelSave.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse excelSave(AddressBook addressBook, BindingResult result, MultipartHttpServletRequest request) throws Exception{
		
		JsonResponse res = new JsonResponse(request);
		
		List<AddressBook> list = null;
		MultipartFile uploadFile = request.getFile("uploadFile");		
		if(uploadFile != null) {
			String fileName = uploadFile.getOriginalFilename();
			String excelExt = fileName.substring(fileName.lastIndexOf(".")+1);
			
			if (!(excelExt.equals("xls") || excelExt.equals("xlsx"))) {
				result.reject("엑셀파일만 등록 가능합니다.");
			} else {
				addressBook.setUploadFile(uploadFile);
				list = service.getExcelList(addressBook);
				
				if (list == null || list.size() == 0) {
					result.reject("등록할 데이터를 입력해 주세요.");
				} else if (list != null && list.size() == 1) {
					if (!list.get(0).isFlag()) {
						result.reject(list.get(0).getMsg());
					}
				}
			}
		} else {
			result.reject("엑셀파일을 첨부해 주세요.");
		}
		
		if (!result.hasErrors()) {
			addressBook.setMemberInfo(getSessionMemberInfo(request));
			addressBook.getMemberInfo().setHomepage_id(getAsideHomepageId(request));
			service.addExcelDataList(addressBook, list); 
			res.setValid(true);
			res.setMessage("등록되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	

	@RequestMapping(value = {"/excelDownloadSample.*"}, method = RequestMethod.GET)
	public void excelDownloadSample(Model model, Student student, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Download down = new Download( request, response, "addressBookSample.xls" );
		service.writeExcelDataSample( down.getOutputStream() );
		down.close();
	}
}
