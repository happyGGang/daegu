package kr.co.whalesoft.app.cms.module.smsSend;

import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
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

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.addressBook.AddressBook;
import kr.co.whalesoft.app.cms.module.addressBook.AddressBookService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller
@RequestMapping(value = {"/cms/module/smsSend"})
public class SmsSendController extends BaseController{

	private final String basePath = "/cms/module/smsSend/";

	@Autowired
	private SmsSendService service;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private AddressBookService addressBookService;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, SmsSend smsSend, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			smsSend.setHomepage_id(getAsideHomepageId(request));
//		}

		//2차분류
		if(smsSend.getCodeList_1() != null) {
			if(smsSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_2", service.getTeachCategoryGroup(smsSend.getHomepage_id()));
			}
			if(smsSend.getCodeList_1().equals("2")) {
				smsSend.setCode_type_2(true);
				model.addAttribute("codeList_2", codeService.getCode(smsSend.getHomepage_id(), "H0001"));
			}
			if(smsSend.getCodeList_1().equals("3")) {
				smsSend.setCode_type_2(true);
				model.addAttribute("codeList_2", service.getYearList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("4")) {
				model.addAttribute("codeList_2", service.getFacilityList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("5")) {
				model.addAttribute("codeList_2", service.getLockerPreList(smsSend));
			}
		}

		//3차분류
		if(smsSend.getCodeList_2() != null) {
			if(smsSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_3", service.getTeachCategoryDetail(smsSend));
			}
			if(smsSend.getCodeList_1().equals("2")) {
				smsSend.setCode_type_3(true);
				model.addAttribute("codeList_3", service.getYearList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("3")) {
				smsSend.setCode_type_3(true);
				model.addAttribute("codeList_3", codeService.getCode(smsSend.getHomepage_id(), "C0004"));
			}
		}

		//4차분류
		if(smsSend.getCodeList_3() != null) {
			if(smsSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_4", service.getTeachList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("2")) {
				smsSend.setCode_type_4(true);
				model.addAttribute("codeList_4", codeService.getCode(smsSend.getHomepage_id(), "C0004"));
			}
			if(smsSend.getCodeList_1().equals("3")) {
				model.addAttribute("codeList_4", service.getSupportList(smsSend));
			}
		}

		//5차분류
		if(smsSend.getCodeList_4() != null) {
			if(smsSend.getCodeList_1().equals("2")) {
				model.addAttribute("codeList_5", service.getExcursionsList(smsSend));
			}
		}

		if(smsSend.getStatus() != null) {

			if(smsSend.getCodeList_1().equals("1")) {
				model.addAttribute("applyList", service.getTeachApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("2")) {
				model.addAttribute("applyList", service.getExcursionsApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("3")) {
				model.addAttribute("applyList", service.getSupportApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("4")) {
				model.addAttribute("applyList", service.getFacilityApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("5")) {
				model.addAttribute("applyList", service.getLockerApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("6")) {
				model.addAttribute("applyList", service.getTeacherReqApplyList(smsSend));
			}
		}
		model.addAttribute("menuType", codeService.getCode("CMS", "C0016"));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));

		model.addAttribute("smsSend", smsSend);
		return basePath + "index";
	}

	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, SmsSend smsSend, HttpServletRequest request) throws AuthException {

		if (smsSend.getEditMode().equals("ADD")) {
			checkAuth("C", model, request);
			model.addAttribute("smsSendOne", smsSend);
		} else if (smsSend.getEditMode().equals("MODIFY")) {
			checkAuth("Y", model, request);
			model.addAttribute("smsSendOne", service.copyObjectPaging(smsSend, service.getSmsSendOne(smsSend)));
		}

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = { "/send.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse send(SmsSend smsSend, BindingResult result, HttpServletRequest request) {

		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "caller_cell_phone1", "발신자 번호를 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "caller_cell_phone2", "발신자 번호를 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "caller_cell_phone3", "발신자 번호를 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "caller_cell_phone3", "발신자 번호를 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "send_msg", "메시지 내용을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "user_phone", "수신대상을 선택하세요.");

		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {

			Homepage homepage = new Homepage();

			homepage.setHomepage_id(smsSend.getHomepage_id());

			homepage = homepageService.getHomepageOne(homepage);

			FileWriter fileWriter = null;
			BufferedWriter bufferedWriter = null;
			PrintWriter printWriter = null;
			try {
				String member_id = getSessionMemberId(request);
				String path = this.getClass().getClassLoader().getResource("").getPath();
				String filename = path + "sendSms" + new DateTime().toString("yyyy-MM-dd") + ".log";
			    fileWriter = new FileWriter(filename, true);
			    bufferedWriter = new BufferedWriter(fileWriter);
			    printWriter = new PrintWriter(bufferedWriter);
			    printWriter.printf("%s: %s %s %s\n", new DateTime().toString("yyyy-MM-dd HH:mm:ss"), member_id, homepage.getManage_code(), smsSend);
			} catch (FileNotFoundException e2) {

			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try { if(printWriter != null) printWriter.close(); } catch(Exception e) { }
				try { if(bufferedWriter != null) bufferedWriter.close(); } catch(Exception e) { }
				try { if(fileWriter != null) fileWriter.close(); } catch(Exception e) { }
			}

			int user_count = smsSend.getUser_phone().split(",").length;
			smsSend.setCaller_cell_phone(smsSend.getCaller_cell_phone().replaceAll("-", ""));

			if(user_count > 1) {
				String phone[] = smsSend.getUser_phone().split(",");

				for(int i=0; i< phone.length; i++) {
					smsSend.setUser_phone(phone[i].replaceAll("-", ""));
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, smsSend.getUser_phone(), smsSend.getSend_msg(), smsSend.getCaller_cell_phone(), true);
				}
			} else {
				smsSend.setUser_phone(smsSend.getUser_phone().replaceAll("-", ""));
				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, smsSend.getUser_phone(), smsSend.getSend_msg(), smsSend.getCaller_cell_phone(), true);
			}

			res.setValid(true);
			res.setMessage("전송 되었습니다.");

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = { "/sms.*" })
	public String sms(Model model, SmsSend smsSend, HttpServletRequest request) {
		smsSend.setHomepage_id(getAsideHomepageId(request));

		try {
			String fromTel = homepageService.getHomepageOne(new Homepage(smsSend.getHomepage_id())).getHomepage_send_tell();
			if (StringUtils.isNotEmpty(fromTel)) {
				String[] fromTelArr = fromTel.split("-");
				smsSend.setCaller_cell_phone1(fromTelArr[0]);
				smsSend.setCaller_cell_phone2(fromTelArr[1]);
				smsSend.setCaller_cell_phone3(fromTelArr[2]);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		model.addAttribute("smsSend", smsSend);

		return "/cms/module/sms/sms";
	}

	@RequestMapping(value = { "/search.*" })
	public String search(Model model, SmsSend smsSend, HttpServletRequest request) {
		Homepage homepage = new Homepage();
		smsSend.setHomepage_id(getAsideHomepageId(request));

		if(smsSend.getHomepage_id() != null) {
			homepage.setHomepage_id(smsSend.getHomepage_id());

			if(homepageService.getHomepageOne(homepage).getLib_code() != null) {
				smsSend.setHomepage_code(homepageService.getHomepageOne(homepage).getLib_code().substring(0,8));
			}

		}

		//2차분류
		if(smsSend.getCodeList_1() != null) {
			if(smsSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_2", service.getTeachCategoryGroup(smsSend.getHomepage_id()));
			}
			if(smsSend.getCodeList_1().equals("2")) {
				smsSend.setCode_type_2(true);
				model.addAttribute("codeList_2", codeService.getCode(smsSend.getHomepage_id(), "H0001"));
			}
			if(smsSend.getCodeList_1().equals("3")) {
				smsSend.setCode_type_2(true);
				model.addAttribute("codeList_2", service.getYearList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("4")) {
				model.addAttribute("codeList_2", service.getFacilityList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("5")) {
				model.addAttribute("codeList_2", service.getLockerPreList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("7")) {

//				model.addAttribute("codeList_6",MemberAPI.getLasCode("l13"));
//				model.addAttribute("codeList_8",MemberAPI.getLasCode("l12"));
//				model.addAttribute("codeList_9",MemberAPI.getAgencyCode("0001"));
//				model.addAttribute("codeList_10",MemberAPI.getBelongCode("0002",smsSend.getHomepage_code()));

			}
		}

		//3차분류
		if(smsSend.getCodeList_2() != null) {
			if(smsSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_3", service.getTeachCategoryDetail(smsSend));
			}
			if(smsSend.getCodeList_1().equals("2")) {
				smsSend.setCode_type_3(true);
				model.addAttribute("codeList_3", service.getYearList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("3")) {
				smsSend.setCode_type_3(true);
				model.addAttribute("codeList_3", codeService.getCode(smsSend.getHomepage_id(), "C0004"));
			}
		}

		//4차분류
		if(smsSend.getCodeList_3() != null) {
			if(smsSend.getCodeList_1().equals("1")) {
				model.addAttribute("codeList_4", service.getTeachList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("2")) {
				smsSend.setCode_type_4(true);
				model.addAttribute("codeList_4", codeService.getCode(smsSend.getHomepage_id(), "C0004"));
			}
			if(smsSend.getCodeList_1().equals("3")) {
				model.addAttribute("codeList_4", service.getSupportList(smsSend));
			}
		}

		//5차분류
		if(smsSend.getCodeList_4() != null) {
			if(smsSend.getCodeList_1().equals("2")) {
				model.addAttribute("codeList_5", service.getExcursionsList(smsSend));
			}
		}

		if(smsSend.getStatus() != null && smsSend.getCodeList_1() != null) {
			if(smsSend.getCodeList_1().equals("1")) {
				model.addAttribute("applyList", service.getTeachApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("2")) {
				model.addAttribute("applyList", service.getExcursionsApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("3")) {
				model.addAttribute("applyList", service.getSupportApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("4")) {
				model.addAttribute("applyList", service.getFacilityApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("5")) {
				model.addAttribute("applyList", service.getLockerApplyList(smsSend));
			}
			if(smsSend.getCodeList_1().equals("6")) {
				model.addAttribute("applyList", service.getTeacherReqApplyList(smsSend));
			}
		}

		model.addAttribute("menuType", codeService.getCode("CMS", "C0016"));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));

		try {
			Homepage home = homepageService.getHomepageOne(homepage);
			String fromTel = home.getHomepage_send_tell();
			if (StringUtils.isNotEmpty(fromTel)) {
				String[] fromTelArr = fromTel.split("-");
				smsSend.setCaller_cell_phone1(fromTelArr[0]);
				smsSend.setCaller_cell_phone2(fromTelArr[1]);
				smsSend.setCaller_cell_phone3(fromTelArr[2]);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		model.addAttribute("smsSend", smsSend);

		return "/cms/module/sms/search_ajax";
	}

	@RequestMapping(value = { "/memberLayer.*" })
	public String memberLayer(Model model, SmsSend smsSend, HttpServletRequest request) {
		return "/cms/module/sms/memberLayer_ajax";
	}

	@RequestMapping(value = { "/memberLayer2.*" })
	public String memberLayer2(Model model, SmsSend smsSend, HttpServletRequest request) {
		AddressBook ab = new AddressBook();
		ab.setMemberInfo(getSessionMemberInfo(request));
		model.addAttribute("addressBookGroupList", addressBookService.getAddressTreeList(ab));
		return "/cms/module/sms/memberList2_ajax";
	}

	@RequestMapping(value="/getItemList.*", method=RequestMethod.GET)
	public @ResponseBody List<AddressBook> getItemList(Model model, AddressBook addressBook, HttpServletRequest request) {
		addressBook.setMemberInfo(getSessionMemberInfo(request));
		return addressBookService.getMyItemList(addressBook);
	}

	@RequestMapping(value = { "/memberList.*" })
	public String memberList(Model model, SmsSend smsSend, HttpServletRequest request) {
		smsSend.setHomepage_id(getAsideHomepageId(request));

		if(smsSend.getStatus() != null && smsSend.getCodeList_1() != null) {

			List<SmsSend> applyList = null;

			if(smsSend.getCodeList_1().equals("1")) {

				if(!smsSend.getApply_status().equals("4")) {
					applyList = service.getTeachApplyList(smsSend);

					int index = 0;
					for (SmsSend smsSend_temp : applyList) {
						smsSend_temp.setSms_yn(isSmsReceive("USERID", smsSend_temp.getMember_key()));
						applyList.set(index, smsSend_temp);
						index++;
					}
				} else {
					applyList = service.getTeacherList(smsSend);

					int index = 0;
					for (SmsSend smsSend_temp : applyList) {
						smsSend_temp.setSms_yn("Y");
						applyList.set(index, smsSend_temp);
						index++;
					}
				}

				model.addAttribute("applyList", applyList);
			}
			if(smsSend.getCodeList_1().equals("2")) {
				applyList = service.getExcursionsApplyList(smsSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isSmsReceive("USERID", smsSend_temp.getMember_key()));
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);

			}
			if(smsSend.getCodeList_1().equals("3")) {

				applyList = service.getSupportApplyList(smsSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isSmsReceive("USERID", smsSend_temp.getMember_key()));
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);

			}
			if(smsSend.getCodeList_1().equals("4")) {
				applyList = service.getFacilityApplyList(smsSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isSmsReceive("USERID", smsSend_temp.getMember_key()));
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);
			}
			if(smsSend.getCodeList_1().equals("5")) {
				applyList = service.getLockerApplyList(smsSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isSmsReceive("USERID", smsSend_temp.getMember_key()));
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);
			}
			if(smsSend.getCodeList_1().equals("6")) {
				applyList = service.getTeacherReqApplyList(smsSend);

				int index = 0;
				for (SmsSend smsSend_temp : applyList) {
					smsSend_temp.setSms_yn(isSmsReceive("USERID", smsSend_temp.getMember_key()));
					applyList.set(index, smsSend_temp);
					index++;
				}
				model.addAttribute("applyList", applyList);
			}
			if(smsSend.getCodeList_1().equals("7")) {

				String date = StringUtils.defaultString(smsSend.getStart_date()).replaceAll("-", "") + ":" + StringUtils.defaultString(smsSend.getEnd_date()).replaceAll("-", "");

				String birth_day = null;

				if ( StringUtils.isNotEmpty(smsSend.getStart_age()) && StringUtils.isNotEmpty(smsSend.getEnd_age()) ) {
					birth_day = smsSend.getStart_age() + ":" + smsSend.getEnd_age();
				} else if ( StringUtils.isEmpty(smsSend.getStart_age()) && StringUtils.isNotEmpty(smsSend.getEnd_age()) ) {
					birth_day = "19000101:" + smsSend.getEnd_age();
				} else if ( StringUtils.isNotEmpty(smsSend.getStart_age()) && StringUtils.isEmpty(smsSend.getEnd_age()) ) {
					birth_day = smsSend.getStart_age() + ":99991231";
				}

//				model.addAttribute("applyList", MemberAPI.getLoanMemberList(birth_day, smsSend.getCodeList_8(), smsSend.getHomepage_code(), date, smsSend.getCodeList_6()));

			}
		}

		model.addAttribute("menuType", codeService.getCode("CMS", "C0016"));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("smsSend", smsSend);

		return "/cms/module/sms/memberList_ajax";
	}

	@RequestMapping(value = { "/smsboxLayer.*" })
	public String smsboxLayer(Model model, SmsSend smsSend, HttpServletRequest request) {
		return "/cms/module/sms/smsboxLayer_ajax";
	}

	@RequestMapping(value = { "/smsboxList.*" })
	public String smsboxList(Model model, SmsSend smsSend, HttpServletRequest request) {
		smsSend.setHomepage_id(getAsideHomepageId(request));

		int listCount = service.getSmsBoxCnt(smsSend);
		service.setPaging(model, listCount, smsSend);
		model.addAttribute("smsBoxCnt", listCount);
		model.addAttribute("smsboxList", service.getSmsBoxList(smsSend));
		model.addAttribute("smsSend", smsSend);

		return "/cms/module/sms/smsboxList_ajax";
	}

	public String isSmsReceive(String mode, String member_key) {
		Member member = new Member();
		Map<String, String> map = null;
		String result = "X";

//		member.setCheck_certify_type("SEQNO");
//		member.setCheck_certify_data(member_key);

//		map = MemberAPI.getMemberCertify("WEB", member);

		if(map != null) {
			if(StringUtils.equals(map.get("SMS_CHECK"), "Y")) {
				result = "Y";
			} else {
				result = "N";
			}
			return result;
		} else {
			return result;
		}
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
}
