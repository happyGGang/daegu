package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import com.google.gson.Gson;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfo;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfoService;
import kr.go.gbelib.app.cms.module.lecture.lectureRequest.dto.CourseId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = {"/cms/module/lecture/lectureRequest"})
public class LectureRequestController extends BaseController {

    private final String basePath = "/cms/module/lecture/lectureRequest/";

    @Autowired
    public LectureRequestService lectureRequestService;

    @Autowired
    public LectureInfoService lectureInfoService;

    /**
     * cms 수강신청 목록 페이지
     * */
    @RequestMapping(value = {"/index.*"})
    private String index(Model model, LectureRequest lectureRequest, HttpServletRequest request) throws Exception {
        checkAuth("R", model, request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));
        lectureRequestService.setSearchingData(lectureRequest);

        int lectureRequestCount = lectureRequestService.getLectureRequestCount(lectureRequest);
        lectureRequestService.setPaging(model, lectureRequestCount, lectureRequest);

        model.addAttribute("lectureRequest", lectureRequest);
        model.addAttribute("lectureRequestCount", lectureRequestCount);
        model.addAttribute("lectureRequestList", lectureRequestService.lectureRequestList(lectureRequest));
        model.addAttribute("courseInfoList", lectureRequestService.courseInfoIdList(lectureRequest.getHomepage_id()));
        model.addAttribute("lectureInfoList", lectureRequestService.lectureInfoList(lectureRequest));

        return basePath + "index";
    }

    /**
     * cms 수강신청 등록, 수정 페이지
     * */
    @RequestMapping(value = {"/edit.*"})
    private String edit(Model model, LectureRequest lectureRequest, HttpServletRequest request) throws Exception {

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        if(request.getParameter("editMode").equals("ADD")) { // 추가 모드
            checkAuth("C", model, request);

            lectureRequestService.setDefaultCourse(lectureRequest);
            model.addAttribute("lectureRequest", lectureRequest);

            model.addAttribute("courseInfoList", lectureRequestService.courseInfoIdList(lectureRequest.getHomepage_id()));
            model.addAttribute("lectureInfoList", lectureRequestService.lectureInfoList(lectureRequest));

        } else if(request.getParameter("editMode").equals("UPDATE")) { // 수정 모드
            checkAuth("U", model, request);

            LectureRequest lectureRequestEntity = lectureRequestService.lectureRequestOne(request.getParameter("request_id"));

            if(lectureRequestEntity != null){
                lectureRequestEntity.setEditMode("UPDATE");
                lectureRequestEntity.setHomepage_id(getAsideHomepageId(request));
            }
            model.addAttribute("lectureRequest", lectureRequestEntity);
            model.addAttribute("courseInfoList", lectureRequestService.courseInfoIdList(lectureRequestEntity.getHomepage_id()));
            model.addAttribute("lectureInfoList", lectureRequestService.lectureInfoList(lectureRequestEntity));
        }

        return basePath + "edit_ajax";
    }

    /**
     * cms 수강신청 한개 확인 페이지
     * */
    @RequestMapping(value = {"/view.*"})
    private String view(Model model, LectureRequest lectureRequest, HttpServletRequest request) throws Exception {
        checkAuth("R", model, request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        model.addAttribute("lectureRequest", lectureRequestService.lectureRequestOne(lectureRequest.getRequest_id()));

        return basePath + "view";
    }

    /**
     * 등록, 수정 페이지 강좌 목록 변경
     * */
    @RequestMapping (value = {"/lectureInfoList.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse lectureInfoList(LectureRequest lectureRequest, BindingResult result,
                                                      @RequestBody String course_id, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);
        Gson gson = new Gson();

        CourseId courseId = gson.fromJson(course_id, CourseId.class);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        List<LectureInfo> lectureInfoList = lectureRequestService.lectureInfoList(lectureRequest.getHomepage_id(), courseId.getCourse_id());

        String json = gson.toJson(lectureInfoList);

        res.setValid(true);
        res.setData(json);

        return res;
    }

    /**
     * 수강신청 등록,수정 api
     * */

    @RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse save(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));     // 홈페이지 아이디 set

        validationChk(result, lectureRequest);                          // 유효성 체크
        if(hasValidErrors(res, result)) return res;                     // 유효성 에러가 있으면 return

        if(lectureRequest.getEditMode().equals("ADD")) {                // 강좌 정보 추가

            lectureRequest.setAdd_id(getSessionMemberId(request));      // add_id set
            lectureRequest.setAdd_ip(request.getRemoteAddr());          // add_ip set

            if(!setStatus(lectureRequest, res)) return res;              // 신청 불가 상태면 return

            lectureRequestService.addLectureRequest(lectureRequest, getSessionMemberId(request), request.getRemoteAddr());    // 수강신청 추가

            res.setValid(true);
            res.setMessage("수강신청 되었습니다.");
            res.setUrl("index.do");

        } else if(lectureRequest.getEditMode().equals("UPDATE")) {      // 강좌 정보 수정

            lectureRequest.setAdd_id(getSessionMemberId(request));
            lectureRequestService.updateLectureRequest(lectureRequest, getSessionMemberId(request), request.getRemoteAddr());
            res.setValid(true);
            res.setMessage("수정되었습니다.");
            res.setUrl("index.do");

        } else {
            res.setValid(false);
            res.setResult("잘못된 접근입니다.");
        }

        return res;
    }

    /**
     * 강과 과정 삭제 api
     * */

    @RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse cancel(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        if (!result.hasErrors()) {
            if (lectureRequest.getEditMode().equals("DELETE")) {
                lectureRequestService.cancelLectureRequest(lectureRequest, getSessionMemberId(request), request.getRemoteAddr());
                res.setValid(true);
                res.setMessage("취소되었습니다.");
                res.setUrl("index.do");
            }
        } else {
            res.setValid(false);
            res.setResult(result.getAllErrors());
        }

        return res;
    }

    /**
     * 유효성 체크
     * */
    private void validationChk(BindingResult result, LectureRequest lectureRequest) {
        // 공백 불가
        ValidationUtils.rejectIfEmpty(result, "request_name", "신청자 이름을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "birthday", "생일을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "gender", "성별을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "phone_number", "휴대폰번호를 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "complete_yn", "수료여부를 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "cancel_yn", "취소여부를 입력하세요.");

        // 형식 체크
        ValidationUtils.rejectIfNotDate(result, "birthday", "생년월일 형식이 올바르지 않습니다.");
        ValidationUtils.rejectPhone(result, "phone_number", "휴대폰번호 형식이 올바르지 않습니다.");
        if( lectureRequest.getEmail() != null) {
            ValidationUtils.rejectNotFullEmailType(result, "email", "이메일 형식이 올바르지 않습니다.");
        }

        // 길이 체크
        ValidationUtils.rejectIfStringLength(result, "request_name", 20, "강좌명");
        if(lectureRequest.getAddress1() != null) {
            ValidationUtils.rejectIfStringLength(result, "address1", 400, "강좌명");
        }
        if(lectureRequest.getAddress2() != null) {
            ValidationUtils.rejectIfStringLength(result, "address2", 400, "강좌명");
        }
        if(lectureRequest.getRequest_status() != null) {
            ValidationUtils.rejectIfStringLength(result, "request_status", 20, "강좌명");
        }
    }

    /**
     * 예약 상태 저장
     * */
    private boolean setStatus(LectureRequest lectureRequest, JsonResponse res) {
        LectureInfo lectureInfoOne = lectureInfoService.lectureInfoOne(lectureRequest.getLecture_id()); //  강좌 정보 조회

        if(!lectureInfoOne.getLecture_status1().equals("모집중")) {
            res.setValid(false);
            res.setMessage("모집중인 수강신청이 아닙니다.");

            return false;
        } else if(lectureRequest.getRequest_type().equals("온라인") && lectureRequestService.getMyLectureRequestCount(lectureRequest) > 0 ) {

            res.setValid(false);
            res.setMessage("이미 수강신청된 강좌입니다.");

            return false;
        }/* else if(lectureRequestService.getDuplicateRequestCount(lectureInfoOne) > 0) {
            res.setValid(false);
            res.setMessage("해당 기간 내 1개 강좌만 수강신청 가능합니다.");

            return res;
        }*/
        else {
            if(lectureInfoOne.getRequest_type().equals("선착순")) {
                if(lectureRequest.getRequest_type().equals("오프라인")){
                    if(lectureRequestService.getLectureRequestOfflinePersonCount(lectureRequest) <= 0) {  // 오프라인 정원 확인
                        if(lectureRequestService.getLectureRequestWaitPersonCount(lectureRequest) <= 0) { // 대기 정원 확인
                            res.setValid(false);
                            res.setMessage("오프라인 신청 정원이 마감된 강좌입니다.");

                            return false;
                        } else {
                            lectureRequest.setRequest_status("예약대기");
                        }
                    } else {
                        lectureRequest.setRequest_status("예약완료");
                    }
                } else {
                    if(lectureRequestService.getLectureRequestOnlinePersonCount(lectureRequest) <= 0) { // 온라인 정원 확인
                        if(lectureRequestService.getLectureRequestWaitPersonCount(lectureRequest) <= 0) { // 대기 정원 확인
                            res.setValid(false);
                            res.setMessage("온라인 신청 정원이 마감된 강좌입니다.");

                            return false;
                        } else {
                            lectureRequest.setRequest_status("예약대기");
                        }
                    } else {
                        lectureRequest.setRequest_status("예약완료");
                    }
                }

            } else if(lectureInfoOne.getRequest_type().equals("추첨제")) {
                if(lectureRequest.getRequest_type().equals("오프라인")){
                    if(lectureRequestService.getLectureRequestOfflinePersonCount(lectureRequest) <= 0) {    // 오프라인 정원 확인
                        if(lectureRequestService.getLectureRequestWaitPersonCount(lectureRequest) <= 0) {   // 대기 정원 확인
                            res.setValid(false);
                            res.setMessage("오프라인 신청 정원이 마감된 강좌입니다.");

                            return false;
                        } else {
                            lectureRequest.setRequest_status("추첨대기");
                        }
                    } else {
                        lectureRequest.setRequest_status("예약완료");
                    }
                } else {
                    if(lectureRequestService.getLectureRequestOnlinePersonCount(lectureRequest) <= 0) {     // 온라인 정원 확인
                        if(lectureRequestService.getLectureRequestWaitPersonCount(lectureRequest) <= 0) {   // 대기 정원 확인
                            res.setValid(false);
                            res.setMessage("온라인 신청 정원이 마감된 강좌입니다.");

                            return false;
                        } else {
                            lectureRequest.setRequest_status("추첨대기");
                        }
                    } else {
                        lectureRequest.setRequest_status("예약완료");
                    }
                }

            }

            return true;
        }
    }

    /**
     * 유효성 에러 있는지 검사
     * */
    private Boolean hasValidErrors(JsonResponse res, BindingResult result) {
        if(result.hasErrors()) {
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return true;
        }
        return false;
    }

}
