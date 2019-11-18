package kr.co.whalesoft.app.cms.module.emailSend;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.addressBook.AddressBook;
import kr.co.whalesoft.app.cms.module.addressBook.AddressBookService;
import kr.co.whalesoft.app.cms.module.smsSend.SmsSend;
import kr.co.whalesoft.app.cms.module.smsSend.SmsSendService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PushAPI;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping(value = {"/cms/module/emailSend"})
public class EmailSendController extends BaseController{

	private final String basePath = "/cms/module/emailSend/";

	@Autowired
	private SmsSendService service;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private AddressBookService addressBookService;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, EmailSend emailSend, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			emailSend.setHomepage_id(getAsideHomepageId(request));
//		}

		//2차분류
		if(emailSend.getCodeList_1() != null) {
			if(emailSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_2", service.getTeachCategoryGroup(emailSend.getHomepage_id()));
			}
			if(emailSend.getCodeList_1().equals("2")) {
				emailSend.setCode_type_2(true);
				model.addAttribute("codeList_2", codeService.getCode(emailSend.getHomepage_id(), "H0001"));
			}
			if(emailSend.getCodeList_1().equals("3")) {
				emailSend.setCode_type_2(true);
				model.addAttribute("codeList_2", service.getYearList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("4")) {
				model.addAttribute("codeList_2", service.getFacilityList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("5")) {
				model.addAttribute("codeList_2", service.getLockerPreList(emailSend));
			}
		}

		//3차분류
		if(emailSend.getCodeList_2() != null) {
			if(emailSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_3", service.getTeachCategoryDetail(emailSend));
			}
			if(emailSend.getCodeList_1().equals("2")) {
				emailSend.setCode_type_3(true);
				model.addAttribute("codeList_3", service.getYearList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("3")) {
				emailSend.setCode_type_3(true);
				model.addAttribute("codeList_3", codeService.getCode(emailSend.getHomepage_id(), "C0004"));
			}
		}

		//4차분류
		if(emailSend.getCodeList_3() != null) {
			if(emailSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_4", service.getTeachList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("2")) {
				emailSend.setCode_type_4(true);
				model.addAttribute("codeList_4", codeService.getCode(emailSend.getHomepage_id(), "C0004"));
			}
			if(emailSend.getCodeList_1().equals("3")) {
				model.addAttribute("codeList_4", service.getSupportList(emailSend));
			}
		}

		//5차분류
		if(emailSend.getCodeList_4() != null) {
			if(emailSend.getCodeList_1().equals("2")) {
				model.addAttribute("codeList_5", service.getExcursionsList(emailSend));
			}
		}

		if(emailSend.getStatus() != null) {

			if(emailSend.getCodeList_1().equals("1")) {
				model.addAttribute("applyList", service.getTeachApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("2")) {
				model.addAttribute("applyList", service.getExcursionsApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("3")) {
				model.addAttribute("applyList", service.getSupportApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("4")) {
				model.addAttribute("applyList", service.getFacilityApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("5")) {
				model.addAttribute("applyList", service.getLockerApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("6")) {
				model.addAttribute("applyList", service.getTeacherReqApplyList(emailSend));
			}
		}
		model.addAttribute("menuType", codeService.getCode("CMS", "C0016"));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("emailSend", emailSend);
		return basePath + "index";
	}

	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, EmailSend emailSend, HttpServletRequest request) throws AuthException {

		if (emailSend.getEditMode().equals("ADD")) {
			checkAuth("C", model, request);
			model.addAttribute("emailSendOne", emailSend);
		} else if (emailSend.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("emailSendOne", service.copyObjectPaging(emailSend, service.getSmsSendOne(emailSend)));
		}

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = { "/send.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse send(EmailSend emailSend, BindingResult result, HttpServletRequest request) {

		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

//		ValidationUtils.rejectIfEmpty(result, "caller_cell_phone1", "발신자 번호를 입력해주세요.");
//		ValidationUtils.rejectIfEmpty(result, "caller_cell_phone2", "발신자 번호를 입력해주세요.");
//		ValidationUtils.rejectIfEmpty(result, "caller_cell_phone3", "발신자 번호를 입력해주세요.");
//		ValidationUtils.rejectIfEmpty(result, "caller_cell_phone3", "발신자 번호를 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "content", "메시지 내용을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "user_phone", "수신대상을 선택하세요.");

		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {

			Homepage homepage = new Homepage();

			homepage.setHomepage_id(emailSend.getHomepage_id());

			homepage = homepageService.getHomepageOne(homepage);


			int user_count = emailSend.getUser_phone().split(",").length;
			emailSend.setCaller_cell_phone(emailSend.getCaller_cell_phone().replaceAll("-", ""));

			if(user_count > 1) {
				String emailList[] = emailSend.getUser_phone().split(",");

				for(int i=0; i< emailList.length; i++) {
					emailSend.setUser_phone(emailList[i].replaceAll("-", ""));
//					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_EMAIL, emailSend.getUser_phone(), emailSend.getSend_msg(), emailSend.getCaller_cell_phone(), true);
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_EMAIL, emailList[i], emailSend.getContent(), "gbelib@info.go.kr", false, emailSend.getTitle());
				}
			} else {
				emailSend.setUser_phone(emailSend.getUser_phone().replaceAll("-", ""));
//				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_EMAIL, emailSend.getUser_phone(), emailSend.getSend_msg(), emailSend.getCaller_cell_phone(), true);
				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_EMAIL, emailSend.getUser_phone(), emailSend.getContent(), "gbelib@info.go.kr", false, emailSend.getTitle());
			}

			res.setValid(true);
			res.setMessage("전송 되었습니다.");

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = { "/email.*" })
	public String sms(Model model, EmailSend emailSend, HttpServletRequest request) {
		emailSend.setHomepage_id(getAsideHomepageId(request));

		model.addAttribute("emailSend", emailSend);

		return "/cms/module/email/email";
	}

	@RequestMapping(value = { "/search.*" })
	public String search(Model model, EmailSend emailSend, HttpServletRequest request) {
		Homepage homepage = new Homepage();
		emailSend.setHomepage_id(getAsideHomepageId(request));

		if(emailSend.getHomepage_id() != null) {
			homepage.setHomepage_id(emailSend.getHomepage_id());
			if(homepageService.getHomepageOne(homepage).getHomepage_code() != null) {
				emailSend.setHomepage_code(homepageService.getHomepageOne(homepage).getHomepage_code().substring(0,8));
			}
		}

		//2차분류
		if(emailSend.getCodeList_1() != null) {
			if(emailSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_2", service.getTeachCategoryGroup(emailSend.getHomepage_id()));
			}
			if(emailSend.getCodeList_1().equals("2")) {
				emailSend.setCode_type_2(true);
				model.addAttribute("codeList_2", codeService.getCode(emailSend.getHomepage_id(), "H0001"));
			}
			if(emailSend.getCodeList_1().equals("3")) {
				emailSend.setCode_type_2(true);
				model.addAttribute("codeList_2", service.getYearList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("4")) {
				model.addAttribute("codeList_2", service.getFacilityList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("5")) {
				model.addAttribute("codeList_2", service.getLockerPreList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("7")) {

//				model.addAttribute("codeList_6",MemberAPI.getLasCode("l13"));
//				model.addAttribute("codeList_8",MemberAPI.getLasCode("l12"));
//				model.addAttribute("codeList_9",MemberAPI.getAgencyCode("0001"));
//				model.addAttribute("codeList_10",MemberAPI.getBelongCode("0002",emailSend.getHomepage_code()));

			}
		}

		//3차분류
		if(emailSend.getCodeList_2() != null) {
			if(emailSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_3", service.getTeachCategoryDetail(emailSend));
			}
			if(emailSend.getCodeList_1().equals("2")) {
				emailSend.setCode_type_3(true);
				model.addAttribute("codeList_3", service.getYearList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("3")) {
				emailSend.setCode_type_3(true);
				model.addAttribute("codeList_3", codeService.getCode(emailSend.getHomepage_id(), "C0004"));
			}
		}

		//4차분류
		if(emailSend.getCodeList_3() != null) {
			if(emailSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_4", service.getTeachList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("2")) {
				emailSend.setCode_type_4(true);
				model.addAttribute("codeList_4", codeService.getCode(emailSend.getHomepage_id(), "C0004"));
			}
			if(emailSend.getCodeList_1().equals("3")) {
				model.addAttribute("codeList_4", service.getSupportList(emailSend));
			}
		}

		//5차분류
		if(emailSend.getCodeList_4() != null) {
			if(emailSend.getCodeList_1().equals("2")) {
				model.addAttribute("codeList_5", service.getExcursionsList(emailSend));
			}
		}

		if(emailSend.getStatus() != null && emailSend.getCodeList_1() != null) {
			if(emailSend.getCodeList_1().equals("1")) {
				model.addAttribute("applyList", service.getTeachApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("2")) {
				model.addAttribute("applyList", service.getExcursionsApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("3")) {
				model.addAttribute("applyList", service.getSupportApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("4")) {
				model.addAttribute("applyList", service.getFacilityApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("5")) {
				model.addAttribute("applyList", service.getLockerApplyList(emailSend));
			}
			if(emailSend.getCodeList_1().equals("6")) {
				model.addAttribute("applyList", service.getTeacherReqApplyList(emailSend));
			}
		}

		model.addAttribute("menuType", codeService.getCode("CMS", "C0016"));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("emailSend", emailSend);

		return "/cms/module/email/search_ajax";
	}

	@RequestMapping(value = { "/memberLayer.*" })
	public String memberLayer(Model model, EmailSend emailSend, HttpServletRequest request) {
		return "/cms/module/email/memberLayer_ajax";
	}

	@RequestMapping(value = { "/memberList.*" })
	public String memberList(Model model, EmailSend emailSend, HttpServletRequest request) {
		emailSend.setHomepage_id(getAsideHomepageId(request));

		if(emailSend.getStatus() != null && emailSend.getCodeList_1() != null) {

			List<SmsSend> applyList = null;

			if(emailSend.getCodeList_1().equals("1")) {

				if(!emailSend.getApply_status().equals("4")) {
					applyList = service.getTeachApplyList(emailSend);

					int index = 0;
					for (SmsSend smsSend_temp : applyList) {
						setMemberInfo(smsSend_temp);
						applyList.set(index, smsSend_temp);
						index++;
					}
				} else {
					applyList = service.getTeacherList(emailSend);

					int index = 0;
					for (SmsSend smsSend_temp : applyList) {
						setMemberInfo(smsSend_temp);
						applyList.set(index, smsSend_temp);
						index++;
					}
				}

				model.addAttribute("applyList", applyList);
			}
			if(emailSend.getCodeList_1().equals("2")) {
				applyList = service.getExcursionsApplyList(emailSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isEmailReceive("USERID", smsSend_temp.getMember_key()));
					setMemberInfo(smsSend_temp);
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);

			}
			if(emailSend.getCodeList_1().equals("3")) {

				applyList = service.getSupportApplyList(emailSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isEmailReceive("USERID", smsSend_temp.getMember_key()));
					setMemberInfo(smsSend_temp);
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);

			}
			if(emailSend.getCodeList_1().equals("4")) {
				applyList = service.getFacilityApplyList(emailSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isEmailReceive("USERID", smsSend_temp.getMember_key()));
					setMemberInfo(smsSend_temp);
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);
			}
			if(emailSend.getCodeList_1().equals("5")) {
				applyList = service.getLockerApplyList(emailSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isEmailReceive("USERID", smsSend_temp.getMember_key()));
					setMemberInfo(smsSend_temp);
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);
			}
			if(emailSend.getCodeList_1().equals("6")) {
				applyList = service.getTeacherReqApplyList(emailSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isEmailReceive("USERID", smsSend_temp.getMember_key()));
					smsSend_temp.setMember_email(getMemberEmail("USERID", smsSend_temp.getMember_key()));
					setMemberInfo(smsSend_temp);
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);
			}
			if(emailSend.getCodeList_1().equals("7")) {

				String date = emailSend.getStart_date().replaceAll("-", "") + ":" + emailSend.getEnd_date().replaceAll("-", "");

				String birth_day = null;

				if ( StringUtils.isNotEmpty(emailSend.getStart_age()) && StringUtils.isNotEmpty(emailSend.getEnd_age()) ) {
					birth_day = emailSend.getStart_age() + ":" + emailSend.getEnd_age();
				} else if ( StringUtils.isEmpty(emailSend.getStart_age()) && StringUtils.isNotEmpty(emailSend.getEnd_age()) ) {
					birth_day = "19000101:" + emailSend.getEnd_age();
				} else if ( StringUtils.isNotEmpty(emailSend.getStart_age()) && StringUtils.isEmpty(emailSend.getEnd_age()) ) {
					birth_day = emailSend.getStart_age() + ":99991231";
				}

//				model.addAttribute("applyList", MemberAPI.getLoanMemberList(birth_day, emailSend.getCodeList_8(), emailSend.getHomepage_code(), date, emailSend.getCodeList_6()));

			}
		}

		model.addAttribute("menuType", codeService.getCode("CMS", "C0016"));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("emailSend", emailSend);

		return "/cms/module/email/memberList_ajax";
	}

	private void setMemberInfo(SmsSend smsSend_temp) {
		Member member = new Member();
		member.setUser_id(smsSend_temp.getMember_id());

		Map<String, String> memberMap = MemberAPI.getMember("WEB", member);
		if (memberMap == null) {
			smsSend_temp.setEmail_yn("X");
		} else {
			String emailCheck = StringUtils.isEmpty(memberMap.get("EMAIL")) ? "X" : (StringUtils.isEmpty(memberMap.get("MAIL_CHECK")) ? "N" : memberMap.get("MAIL_CHECK"));
			smsSend_temp.setEmail_yn(emailCheck);
			smsSend_temp.setMember_email(memberMap.get("EMAIL"));
		}

	}

	@RequestMapping(value = { "/emailboxLayer.*" })
	public String smsboxLayer(Model model, EmailSend emailSend, HttpServletRequest request) {
		return "/cms/module/email/emailboxLayer_ajax";
	}

	@RequestMapping(value = { "/emailboxList.*" })
	public String smsboxList(Model model, EmailSend emailSend, HttpServletRequest request) {
		emailSend.setHomepage_id(getAsideHomepageId(request));

		int listCount = service.getSmsBoxList(emailSend).size();
		service.setPaging(model, listCount, emailSend);
		model.addAttribute("emailboxList", service.getSmsBoxList(emailSend));
		model.addAttribute("emailSend", emailSend);

		return "/cms/module/email/smsboxList_ajax";
	}

	@RequestMapping(value = { "/memberLayer2.*" })
	public String memberLayer2(Model model, SmsSend smsSend, HttpServletRequest request) {
		AddressBook ab = new AddressBook();
		ab.setMemberInfo(getSessionMemberInfo(request));
		model.addAttribute("addressBookGroupList", addressBookService.getAddressTreeList(ab));
		return "/cms/module/email/memberList2_ajax";
	}

	@RequestMapping(value="/getItemList.*", method=RequestMethod.GET)
	public @ResponseBody List<AddressBook> getItemList(Model model, AddressBook addressBook, HttpServletRequest request) {
		addressBook.setMemberInfo(getSessionMemberInfo(request));
		return addressBookService.getMyItemList(addressBook);
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

	public String isEmailReceive(String mode, String member_key) {
		Member member = new Member();
		Map<String, String> map = null;
		String result = "X";

//		member.setCheck_certify_type("SEQNO");
//		member.setCheck_certify_data(member_key);

//		map = MemberAPI.getMemberCertify("WEB", member);

//		if(map != null) {
//			if(StringUtils.equals(map.get("MAIL_CHECK"), "Y")) {
//				result = "Y";
//			} else {
//				result = "N";
//			}
//			return result;
//		} else {
//			return result;
//		}

		return null;
	}

	public String getMemberEmail(String mode, String member_key) {
		Member member = new Member();
		Map<String, String> map = null;
		String result = "";

//		member.setCheck_certify_type("SEQNO");
//		member.setCheck_certify_data(member_key);
//
//		map = MemberAPI.getMemberCertify("WEB", member);

//		if(map != null) {
//			result = map.get("EMAIL");
//			return result;
//		} else {
//			return result;
//		}

		return null;
	}

}
