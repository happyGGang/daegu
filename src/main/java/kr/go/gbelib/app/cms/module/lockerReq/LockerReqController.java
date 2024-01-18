package kr.go.gbelib.app.cms.module.lockerReq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.locker.Locker;
import kr.go.gbelib.app.cms.module.locker.LockerService;
import kr.go.gbelib.app.cms.module.lockerPre.LockerPre;
import kr.go.gbelib.app.cms.module.lockerPre.LockerPreService;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller
@RequestMapping(value = {"/cms/module/lockerReq"})
public class LockerReqController extends BaseController {

	private final String basePath = "/cms/module/lockerReq/";

	@Autowired
	private LockerReqService service;

	@Autowired
	private LockerService lockerService;

	@Autowired
	private LockerPreService lockerPreService;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, LockerReq lockerReq, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			lockerReq.setHomepage_id(getAsideHomepageId(request));
//		}

		// 전체 사물함 설정 리스트 (상단에 셀렉트박스출력)
		List<LockerPre> preList = lockerPreService.getLockerPreAll(new LockerPre(lockerReq.getHomepage_id()));
		int lockerPreList = 0;
		if ( preList != null ) {
			lockerPreList = preList.size();
		}

		// 사물함 기본설정
		LockerPre lockerPre = lockerPreService.getLockerPreOne(new LockerPre(lockerReq.getHomepage_id(), lockerReq.getLocker_pre_idx()));

		// 사물함 기본설정에 따른 사물함 리스트
		List<Locker> lockerList = lockerService.getLocker(new Locker(lockerReq.getHomepage_id(), lockerReq.getLocker_pre_idx()));
		int count = 0 ;
		if (lockerList != null) {
			count = lockerList.size();
		}

		model.addAttribute("lockerReq", lockerReq);
		model.addAttribute("lockerReqCount", count);
		model.addAttribute("lockerReqList", service.getLockerReq(lockerReq));
		model.addAttribute("lockerList", lockerList);
		model.addAttribute("lockerPre", lockerPre);
		model.addAttribute("lockerPreList", preList);
		model.addAttribute("lockerPreCount", lockerPreList);

		return basePath + "index";
	}

	@RequestMapping(value = {"/indexApply.*"})
	public String indexApply(Model model, LockerReq lockerReq, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);

		int count = service.getLockerReqCount(lockerReq);
		LockerPre lockerPre = lockerPreService.getLockerPreOne(new LockerPre(lockerReq.getHomepage_id(), lockerReq.getLocker_pre_idx()));

		model.addAttribute("lockerPre", lockerPre);
		model.addAttribute("lockerReqApply", lockerReq);
		model.addAttribute("lockerReqApplyCount", count);
		model.addAttribute("lockerReqApplyList", service.getLockerReq(lockerReq));

		return basePath + "indexApply_ajax";
	}

	@RequestMapping(value = {"/memberAdd.*"})
	public String memberAdd(Model model, LockerReq lockerReq, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		LockerPre lockerPre = new LockerPre();

		lockerPre.setHomepage_id(lockerReq.getHomepage_id());

		model.addAttribute("lockerReqApply", lockerReq);
		model.addAttribute("lockerReqApplyCount", service.getLockerUnassignReq(lockerReq).size());
		model.addAttribute("lockerReqApplyList", service.getLockerUnassignReq(lockerReq));
		model.addAttribute("lockerPreList", lockerPreService.getLockerPreAll(lockerPre));

		return basePath + "memberAdd_ajax";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, LockerReq lockerReq, HttpServletRequest request) throws AuthException {
		if(lockerReq.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("lockerReq", service.copyObjectPaging(lockerReq, service.getLockerReqOne(lockerReq)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("lockerReq", lockerReq);
		}

		model.addAttribute("cellPhoneCode", codeService.getCode(lockerReq.getHomepage_id(), "C0002"));
		model.addAttribute("phoneCode", codeService.getCode(lockerReq.getHomepage_id(), "C0003"));
		model.addAttribute("lockerList", lockerService.getLockerAll(new Locker(lockerReq.getHomepage_id())));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public LockerPreSearchView excel(Model model, LockerReq lockerReq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("lockerReq", lockerReq);
		model.addAttribute("lockerReqResult", service.getLockerReqListAll(lockerReq));
		return new LockerPreSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(LockerReq lockerReq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<LockerReq> lockerReqResult = service.getLockerReqListAll(lockerReq);

		new LockerReqXlsToCsv(lockerReqResult, request, response);
	}

	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, LockerReq lockerReq, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();

		Member lockerReqMember = new Member();
		lockerReqMember.setUser_id(lockerReq.getApply_id());
//		lockerReqMember.setCheck_certify_type("WEBID");
//		lockerReqMember.setCheck_certify_data(lockerReq.getApply_id());

		Map<String, String> memberInfo = null;
		if ( lockerReq.getSearch_api_type().equals("WEBID") ) {
//			lockerReqMember.setCheck_certify_type("WEBID");
//			lockerReqMember.setCheck_certify_data(lockerReq.getApply_id());
//
//			memberInfo = MemberAPI.getMemberCertify("WEB", lockerReqMember);
//
//			if ( memberInfo == null ) {
//				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
//				return result;
//			}
		} else {
//			memberInfo = MemberAPI.getDupUser("WEB", lockerReqMember, "0002", lockerReq.getApply_id());
//			if ( memberInfo == null ) {
//				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
//				return result;
//			}
		}
		result.put("memberInfo", memberInfo);
		return result;
	}

	@Transactional
	@RequestMapping(value = {"/assignment.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse assignment(Model model, LockerReq lockerReqApply, BindingResult result, HttpServletRequest request) throws AuthException {

		checkAuth("R", model, request);
		
		JsonResponse res = new JsonResponse(request);
		String editMode = lockerReqApply.getEditMode();

		if(!result.hasErrors()) {
			int targetLockerPreIdx = lockerReqApply.getLocker_pre_idx();
			lockerReqApply.setMod_id(getSessionMemberId(request));

			List<Locker> lockerList = lockerService.getLocker(new Locker(lockerReqApply.getHomepage_id(), targetLockerPreIdx));
			List<LockerReq> lockerReqList = service.getLockerReq(lockerReqApply);

			//사물함 상태값 clear
			service.clearLocker(lockerReqApply);
			service.clearLockerReq(lockerReqApply);

			if(editMode.equals("SEQUENCE")) {

				for(int i = 0; i < lockerList.size(); i++) {

					if(lockerReqList.size() > i) {
						LockerReq targetLockerReq = lockerReqList.get(i);
				    	targetLockerReq.setLocker_idx(lockerList.get(i).getLocker_idx());

				    	service.assingLocker(targetLockerReq);
				    	//사물함 상태값 변경
				    	service.modifyLocekr(targetLockerReq);
				    	//PushAPI.sendMessage(lockerReqApply.getHomepage_id(), PushAPI.SMS_TYPE_SMS, lockerReqApply.getCell_phone(), "사물함 배정이 완료 되었습니다.");
					}
			    }

				res.setValid(true);
				res.setMessage("순차 배정되었습니다.");

			} else if(editMode.equals("RANDOM")) {
				Random random = new Random();

				int lockerListCount = lockerList.size();
				for ( int i = 0; i < lockerListCount; i ++ ) {
					Locker targetLocker 		= null;
					LockerReq targetLockerReq 	= null;

					int randomLockerNumber = 0;
					int randomLockerReqNumber = 0;

					if ( lockerList.size() > 0 ) {
						if ( lockerList.size() > 1 ) {
							randomLockerNumber = random.nextInt(lockerList.size() - 1);
							targetLocker = lockerList.get(randomLockerNumber);
						} else {
							targetLocker = lockerList.get(0);
						}

					}

					if ( lockerReqList.size() > 0 ) {

						if ( lockerReqList.size() > 1 ) {
							randomLockerReqNumber = random.nextInt(lockerReqList.size() - 1);
							targetLockerReq = lockerReqList.get(randomLockerReqNumber);
						} else {
							targetLockerReq = lockerReqList.get(0);
						}
					}

					if ( targetLocker != null && targetLockerReq != null ) {
						targetLockerReq.setLocker_idx(targetLocker.getLocker_idx());

						//사용자 사물함 랜덤 배정
				    	service.assingLocker(targetLockerReq);
				    	//사물함 상태값 변경
				    	service.modifyLocekr(targetLockerReq);
				    	lockerList.remove(randomLockerNumber);
				    	lockerReqList.remove(randomLockerReqNumber);
					} else {
						break;
					}
				}



				/*int[] lockerArr = new int[lockerList.size()];
			    int ran=0;
			    boolean cheak;
			    Random random = new Random();

			    for (int i=0; i<lockerArr.length; i++) {
			        ran = random.nextInt(lockerList.size());
			        cheak = true;
			        for (int j=0; j<i; j++) {
			            if(lockerArr[j] == ran) {
			                i--;
			                cheak=false;
			            }
			        }
			        if(cheak)
			        	lockerArr[i] = ran;
			    }

			    int[] lockerReqArr = new int[lockerReqList.size()];
			    int ranReq = 0;
			    boolean checkReq;
			    Random randomReq = new Random();

			    for (int i=0; i<lockerReqArr.length; i++) {
			        ranReq = randomReq.nextInt(lockerReqList.size());
			        checkReq = true;
			        for (int j=0; j<i; j++) {
			            if(lockerReqArr[j] == ranReq) {
			                i--;
			                checkReq = false;
			            }
			        }
			        if(checkReq)
			        	lockerReqArr[i] = ranReq;
			    }


			    for(int i = 0; i < lockerList.size(); i++) {

			    	if(lockerReqList.size() > i) {

			    		int num = lockerArr[i];
			    		int num2 = lockerReqArr[i];

			    		lockerReqApply.setReq_idx(lockerReqList.get(num2).getReq_idx());
			    		lockerReqApply.setApply_id(lockerReqList.get(num2).getApply_id());
			    		lockerReqApply = service.getLockerReqOne(lockerReqApply);
			    		lockerReqApply.setLocker_idx(lockerList.get(num).getLocker_idx());
			    		lockerReqApply.setLocker_pre_idx(targetLockerPreIdx);

			    		//사용자 사물함 랜덤 배정
			    		service.modifyLocekrReq(lockerReqApply);
			    		//사물함 상태값 변경
			    		service.modifyLocekr(lockerReqApply);
			    		PushAPI.sendMessage(lockerReqApply.getHomepage_id(), PushAPI.SMS_TYPE_SMS, lockerReqApply.getCell_phone(), "사물함 배정이 완료 되었습니다.");
			    	}
			    }*/

				res.setValid(true);
				res.setMessage("랜덤 배정되었습니다.");
			} else if(editMode.equals("RAFFLE")) {
				Random random = new Random();
				// 사물함 신청 수가 사물함 수 보다 많으면, 사물함 신청 선착순 중에 랜덤으로 돌린다.
				if ( lockerReqList.size() > lockerList.size() ) {
					int lockerListCount = lockerList.size();
					for ( int i = 0; i < lockerReqList.size(); i ++ ) {
						if ( lockerListCount < lockerReqList.size() ) {
							lockerReqList.remove(lockerReqList.size() - 1);
						}
					}
				}

				int lockerListCount = lockerList.size();
				for ( int i = 0; i < lockerListCount; i ++ ) {
					Locker targetLocker 		= null;
					LockerReq targetLockerReq 	= null;

					int randomLockerNumber = 0;
					int randomLockerReqNumber = 0;

					if ( lockerList.size() > 0 ) {
						if ( lockerList.size() > 1 ) {
							randomLockerNumber = random.nextInt(lockerList.size() - 1);
							targetLocker = lockerList.get(randomLockerNumber);
						} else {
							targetLocker = lockerList.get(0);
						}

					}

					if ( lockerReqList.size() > 0 ) {

						if ( lockerReqList.size() > 1 ) {
							randomLockerReqNumber = random.nextInt(lockerReqList.size() - 1);
							targetLockerReq = lockerReqList.get(randomLockerReqNumber);
						} else {
							targetLockerReq = lockerReqList.get(0);
						}
					}

					if ( targetLocker != null && targetLockerReq != null ) {
						targetLockerReq.setLocker_idx(targetLocker.getLocker_idx());

						//사용자 사물함 랜덤 배정
				    	service.assingLocker(targetLockerReq);
				    	//사물함 상태값 변경
				    	service.modifyLocekr(targetLockerReq);
				    	lockerList.remove(targetLocker);
				    	lockerReqList.remove(targetLockerReq);
					} else {
						break;
					}
				}


				/*int[] lockerArr = new int[lockerList.size()];
			    int ran=0;
			    boolean cheak;
			    Random random = new Random();

			    for (int i=0; i<lockerArr.length; i++) {
			        ran = random.nextInt(lockerList.size());
			        cheak = true;
			        for (int j=0; j<i; j++) {
			            if(lockerArr[j] == ran) {
			                i--;
			                cheak=false;
			            }
			        }
			        if(cheak)
			        	lockerArr[i] = ran;
			    }

			    int[] lockerReqArr = new int[lockerReqList.size()];
			    int ranReq = 0;
			    boolean cheakReq;
			    Random randomReq = new Random();

			    for (int i=0; i<lockerReqArr.length; i++) {
			        ranReq = randomReq.nextInt(lockerReqList.size());
			        cheakReq = true;
			        for (int j=0; j<i; j++) {
			            if(lockerReqArr[j] == ranReq) {
			                i--;
			                cheakReq = false;
			            }
			        }
			        if(cheakReq)
			        	lockerReqArr[i] = ranReq;
			    }


			    for(int i = 0; i < lockerList.size(); i++) {

			    	if(lockerReqList.size() > i) {

			    		int num = lockerArr[i];
			    		int num2 = lockerReqArr[i];
			    		lockerReqApply.setReq_idx(lockerReqList.get(num2).getReq_idx());
			    		lockerReqApply.setApply_id(lockerReqList.get(num2).getApply_id());
			    		lockerReqApply = service.getLockerReqOne(lockerReqApply);
			    		lockerReqApply.setLocker_idx(lockerList.get(num).getLocker_idx());
			    		lockerReqApply.setLocker_pre_idx(targetLockerPreIdx);

			    		//사용자 사물함 랜덤 배정
			    		service.modifyLocekrReq(lockerReqApply);
			    		//사물함 상태값 변경
			    		service.modifyLocekr(lockerReqApply);
			    		PushAPI.sendMessage(lockerReqApply.getHomepage_id(), PushAPI.SMS_TYPE_SMS, lockerReqApply.getCell_phone(), "["+lockerReqList.get(num2).getLocker_pre_name()+"] 사물함 배정이 완료 되었습니다.");
			    	}
			    }*/

				res.setValid(true);
				res.setMessage("추첨 배정되었습니다.");

			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	@RequestMapping(value = {"/assignmentOne.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse assignmentOne(Model model, LockerReq lockerReq, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);
		String editMode = lockerReq.getEditMode();
		if(!result.hasErrors()) {
//			int auth_id = Integer.parseInt(getSessionMemberInfo(request).getAuth_id());
//			if ( auth_id <= 200 || auth_id == 7000) {
				Locker locker = new Locker();
				locker.setHomepage_id(lockerReq.getHomepage_id());
				locker.setLocker_idx(lockerReq.getLocker_idx());
				locker.setLocker_pre_idx(lockerReq.getLocker_pre_idx());
				locker.setMod_id(getSessionMemberId(request));

				if(editMode.equals("ADD")) {
					res.setValid(true);
					locker.setStatus("2");
					service.assingLocker(lockerReq);
					lockerService.updateLockerStatus(locker);
					res.setUrl("index.do?homepage_id="+lockerReq.getHomepage_id()+"&locker_pre_idx="+lockerReq.getLocker_pre_idx());
					res.setMessage("배정되었습니다.");

					LockerReq temp = service.getLockerReqOne(lockerReq);
					if (service.isSmsReceive("USERID", temp.getApply_id())) {
						PushAPI.sendMessage(getHomepageOne(lockerReq.getHomepage_id()), PushAPI.SMS_TYPE_SMS, temp.getCell_phone(), "사물함 배정이 완료 되었습니다.", getHomepageOne(lockerReq.getHomepage_id()).getHomepage_send_tell(), true);
					}

				} else {
					res.setValid(true);
					locker.setStatus("1");
					service.unassingLocker(lockerReq);
					lockerService.updateLockerStatus(locker);
					res.setMessage("배정취소되었습니다.");
				}
//			} else {
//				res.setValid(false);
//				res.setMessage("권한이 없습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, LockerReq lockerReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = lockerReq.getEditMode();

		if(!lockerReq.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "req_name", "신청자명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_id", "신청자ID를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "phone", "전화번호를 입력하세요");
			ValidationUtils.rejectIfEmpty(result, "cell_phone", "휴대전화번호를 입력하세요.");

			if(service.getBlackListCheck(lockerReq) > 0) {
				res.setValid(false);
				res.setMessage("블랙리스트로 등록된 회원입니다.");
				return res;
			}

			if(service.getLockerApplyCheck(lockerReq) > 0 && lockerReq.getEditMode().equals("ADD")) {
				res.setValid(false);
				res.setMessage("이미 사물함 신청된 회원입니다.");
				return res;
			}
		}

		if(!result.hasErrors()) {
			//lockerReq.setHomepage_id(getSessionHomepageId(request));
			if(editMode.equals("ADD")) {
				lockerReq.setAdd_id(getSessionMemberId(request));
				service.addLockerReq(lockerReq, "CMS");
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
				if (service.isSmsReceive(lockerReq.getSearch_api_type(), lockerReq.getApply_id())) {
					PushAPI.sendMessage(getHomepageOne(lockerReq.getHomepage_id()), PushAPI.SMS_TYPE_SMS, lockerReq.getCell_phone(), "사물함신청이 완료 되었습니다.", getHomepageOne(lockerReq.getHomepage_id()).getHomepage_send_tell(), true);
				}
			} else if (editMode.equals("MODIFY")) {
				lockerReq.setMod_id(getSessionMemberId(request));
				service.modifyLocekrReq(lockerReq);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (editMode.equals("DELETE")) {
				service.deleteReqLocker(lockerReq);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
