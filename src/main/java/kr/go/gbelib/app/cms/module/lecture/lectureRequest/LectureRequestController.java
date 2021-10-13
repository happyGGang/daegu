package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfo;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

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
        model.addAttribute("lectureRequestList", lectureRequestService.lectureRequestList(lectureRequest));
        model.addAttribute("courseInfoList", lectureRequestService.courseInfoIdList(lectureRequest.getHomepage_id()));
        model.addAttribute("lectureInfoList", lectureRequestService.lectureInfoList(lectureRequest, "오프라인"));

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

            String course_id = request.getParameter("search_course_id");
            lectureRequest.setCourse_id(course_id);

            model.addAttribute("lectureRequest", lectureRequest);
            model.addAttribute("courseInfoList", lectureRequestService.courseInfoIdList(lectureRequest.getHomepage_id()));
            model.addAttribute("lectureInfoList", lectureRequestService.lectureInfoList(lectureRequest, "오프라인"));

        } else if(request.getParameter("editMode").equals("UPDATE")) { // 수정 모드
            checkAuth("U", model, request);

            LectureRequest lectureRequestEntity = lectureRequestService.lectureRequestOne(request.getParameter("request_id"));

            lectureRequestEntity.setEditMode("UPDATE");
            lectureRequestEntity.setHomepage_id(getAsideHomepageId(request));

            model.addAttribute("lectureRequest", lectureRequestEntity);
            model.addAttribute("courseInfoList", lectureRequestService.courseInfoIdList(lectureRequestEntity.getHomepage_id()));
            model.addAttribute("lectureInfoList", lectureRequestService.lectureInfoList(lectureRequestEntity, "오프라인"));
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
     * 오프라인 신청 추가
     * */
    @RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse save(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        validationChk(result, lectureRequest);                          // 유효성 체크

        if (result.hasErrors()) {                   // 오류가 있으면 return
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return res;
        }

        if (lectureRequest.getEditMode().equals("ADD")) {

            lectureRequest.setCancel_yn("N");                           // 취소여부 set
            lectureRequest.setAdd_id(null);                             // 오프라인 등록일때는 id값 x
            lectureRequest.setAdd_ip(request.getRemoteAddr());          // add_ip set
            lectureRequest.setRequest_type("오프라인");                  // 오프라인 등록

            if(!setStatus(lectureRequest, res)) return res;             // 신청 불가 상태면 return

            lectureRequestService.addLectureRequest(lectureRequest);    // 수강신청 추가

        } else if (lectureRequest.getEditMode().equals("UPDATE")) {
            lectureRequestService.updateLectureRequest(lectureRequest);
        } else {
            res.setValid(false);
            res.setMessage("잘못된 접근입니다.\n관리자에게 문의하세요.");
            return res;
        }

        res.setValid(true);
        res.setMessage("수강신청 되었습니다.");
        res.setUrl("index.do");

        return res;
    }

    /**
     * 수강 신청 취소 api
     * */
    @RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse cancel(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        if (result.hasErrors()) {                   // 오류가 있으면 return
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return res;
        }

        if (lectureRequest.getEditMode().equals("DELETE")) {
            lectureRequestService.cancelLectureRequest(lectureRequest, getSessionMemberId(request), request.getRemoteAddr());
            res.setValid(true);
            res.setMessage("취소되었습니다.");
            res.setUrl("index.do");
        } else {
            res.setValid(false);
            res.setResult("잘못된 접근입니다.");
        }

        return res;
    }

    /**
     * 예약 상태 변경
     * */
    @RequestMapping (value = {"/changeStatus.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse changeStatus(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        if (result.hasErrors()) {
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return res;
        }

        if (!lectureRequest.getEditMode().equals("UPDATE")) {
            res.setValid(false);
            res.setMessage("잘못된 접근입니다.\n관리자에게 문의하세요.");
            return res;
        }

        if (lectureRequest.getRequest_status().equals("예약완료")) {    // 예약 완료로 변경

            if(lectureRequestService.getLectureRequestOnlinePersonCount(lectureRequest) <= 0) {
                res.setValid(false);
                res.setMessage("모집중인 온라인 정원이 마감되었습니다.");
                return res;
            }

        } else {    // 예약대기로 변경
            LectureInfo lectureInfoOne = lectureInfoService.lectureInfoOne(lectureRequest.getLecture_id(), "온라인"); //  강좌 정보 조회

            if(lectureRequestService.getLectureRequestWaitPersonCount(lectureRequest) <= 0) {
                res.setValid(false);
                res.setMessage("모집중인 대기 정원이 마감되었습니다.");
                return res;
            }

            if(lectureInfoOne.getRequest_type().equals("추첨제"))
                lectureRequest.setRequest_type("추첨대기");
        }

        lectureRequestService.changeStatus(lectureRequest); // 상태 변경

        res.setValid(true);
        res.setMessage("예약상태가 변경되었습니다.");
        res.setUrl("index.do");

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

        // 형식 체크
        ValidationUtils.rejectIfNotDate(result, "birthday", "생년월일 형식이 올바르지 않습니다.");
        ValidationUtils.rejectPhone(result, "phone_number", "휴대폰번호 형식이 올바르지 않습니다.");
        if( lectureRequest.getEmail() != null && !lectureRequest.getEmail().equals("")) {
            ValidationUtils.rejectNotFullEmailType(result, "email", "이메일 형식이 올바르지 않습니다.");
        }
    }

    /**
     * 신청 상태 저장
     * */
    private boolean setStatus(LectureRequest lectureRequest, JsonResponse res) {
        LectureInfo lectureInfoOne = lectureInfoService.lectureInfoOne(lectureRequest.getLecture_id(), "오프라인"); //  강좌 정보 조회
        if (lectureRequestService.getLectureRequestOfflinePersonCount(lectureRequest) <= 0) {
            res.setValid(false);
            res.setMessage("오프라인 신청 정원이 마감되었습니다.");
            return false;

        } else if(!lectureInfoOne.getLecture_status1().equals("모집중") && !lectureInfoOne.getLecture_status1().equals("정원마감")) {
            res.setValid(false);
            res.setMessage("모집중인 수강신청이 아닙니다.");

            return false;
        } else {
            lectureRequest.setRequest_status("예약완료");
            return true;
        }
    }

    /**
     * 추첨 저장
     * */
    @RequestMapping (value = {"/saveRaffle.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse saveRaffle(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        if (result.hasErrors()) {                   // 오류가 있으면 return
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return res;
        }

        if (lectureRequest.getEditMode().equals("UPDATE")) {

            if(!lectureRequestService.saveRaffleLectureRequest(lectureRequest)) {
                res.setValid(false);
                res.setMessage("추첨대기 인원이 없거나\n남아있는 온라인모집 인원이 없습니다.");
                return res;
            }

            res.setValid(true);
            res.setMessage("추첨이 완료되었습니다.\n추첨자 정보는 온라인 모집인원에서 확인하세요.");
            res.setUrl("index.do");

        } else {
            res.setValid(false);
            res.setResult("잘못된 접근입니다.\n관리자에게 문의하세요.");
        }

        return res;
    }

    /**
     * 등록, 수정 페이지 강좌 목록 변경
     * */
    /*@RequestMapping (value = {"/lectureInfoList.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse lectureInfoList(LectureRequest lectureRequest, BindingResult result,
                                                      @RequestBody String course_id, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);
        Gson gson = new Gson();

        CourseId courseId = gson.fromJson(course_id, CourseId.class);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        List<LectureInfo> lectureInfoList = lectureRequestService.lectureInfoList(lectureRequest.getHomepage_id(), courseId.getCourse_id(), null);

        String json = gson.toJson(lectureInfoList);

        res.setValid(true);
        res.setData(json);

        return res;
    }*/

    /**
     * 수강신청 등록,수정 api
     * */
    /*@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse save(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));     // 홈페이지 아이디 set

        setMemberData(lectureRequest, request);                         // 온라인 신청이면 회원 정보 저장

        validationChk(result, lectureRequest);                          // 유효성 체크
        if(hasValidErrors(res, result)) return res;                     // 유효성 에러가 있으면 return

        if(lectureRequest.getEditMode().equals("ADD")) {                // 강좌 정보 추가

            lectureRequest.setCancel_yn("N");                           // 취소여부 set
            lectureRequest.setAdd_id(getSessionMemberId(request));      // add_id set
            lectureRequest.setAdd_ip(request.getRemoteAddr());          // add_ip set

            if(!setStatus(lectureRequest, res)) return res;              // 신청 불가 상태면 return

            lectureRequestService.addLectureRequest(lectureRequest, getSessionMemberId(request), request.getRemoteAddr());    // 수강신청 추가

            res.setValid(true);
            res.setMessage("수강신청 되었습니다.");
            res.setUrl("index.do");

        } else if(lectureRequest.getEditMode().equals("UPDATE")) {      // 강좌 정보 수정

            lectureRequestService.updateLectureRequest(lectureRequest);
            res.setValid(true);
            res.setMessage("수정되었습니다.");
            res.setUrl("index.do");

        } else {
            res.setValid(false);
            res.setResult("잘못된 접근입니다.");
        }

        return res;
    }*/


    /**
     * 강좌 재신청 api
     * */
    /*@RequestMapping (value = {"/reapply.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse reapply(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        if (!result.hasErrors()) {
            if (lectureRequest.getEditMode().equals("UPDATE")) {

                if(!setStatus(lectureRequest, res)) return res;
                lectureRequest.setCancel_yn("N");

                lectureRequestService.reapplyRequest(lectureRequest);

                res.setValid(true);
                res.setMessage("재신청되었습니다.");
                res.setUrl("index.do");
            } else {
                res.setValid(false);
                res.setResult("잘못된 접근입니다.");
            }
        } else {
            res.setValid(false);
            res.setResult(result.getAllErrors());
        }

        return res;
    }*/

    /**
     * 예약 상태 저장
     * */
    /*private boolean setStatus(LectureRequest lectureRequest, JsonResponse res) {
        LectureInfo lectureInfoOne = lectureInfoService.lectureInfoOne(lectureRequest.getLecture_id(), lectureRequest.getRequest_type()); //  강좌 정보 조회

        if(!lectureInfoOne.getLecture_status1().equals("모집중")) {
            res.setValid(false);
            res.setMessage("모집중인 수강신청이 아닙니다.");

            return false;
        } else if(lectureRequest.getRequest_type().equals("온라인") && lectureRequestService.getMyLectureRequestCount(lectureRequest) > 0 ) { // 수강신청 중복검사

            res.setValid(false);
            res.setMessage("이미 수강신청된 강좌입니다.");

            return false;
        } else {
            if(leftRequestCount(lectureRequest) <= 0) {  // 남은 신청 정원 확인
                if(lectureRequestService.getLectureRequestWaitPersonCount(lectureRequest) <= 0) { // 대기 정원 확인
                    res.setValid(false);
                    res.setMessage(lectureRequest.getRequest_type()+" 신청 정원이 마감된 강좌입니다.");

                    return false;
                } else {
                    lectureRequest.setRequest_status(successWait(lectureInfoOne));
                }
            } else {
                lectureRequest.setRequest_status("예약완료");
            }

            return true;
        }
    }*/

    /**
     * 유효성 에러 있는지 검사
     * */
    /*private Boolean hasValidErrors(JsonResponse res, BindingResult result) {
        if(result.hasErrors()) {
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return true;
        }
        return false;
    }*/

    /**
     * 온라인 신청일때 맴버 데이터 가져오기
     * */
    /*private void setMemberData(LectureRequest lectureRequest, HttpServletRequest request) {
        if(lectureRequest.getRequest_type() != null && lectureRequest.getRequest_type().equals("온라인")) {
            Member member = (Member)request.getSession().getAttribute(StaticVariables.MEMBER);
            lectureRequest.setRequest_name(member.getMember_name());
            lectureRequest.setEmail(member.getEmail());
            lectureRequest.setPhone_number("010-1234-1234");
            lectureRequest.setBirthday("1990-08-15");
            lectureRequest.setGender('0');
            lectureRequest.setComplete_yn("N");
            lectureRequest.setCancel_yn("N");
        }
    }*/

    /**
     * 대기 성공 메세지 리턴
     * */
    /*private String successWait(LectureInfo lectureInfoOne) {
        if(lectureInfoOne.getRequest_type().equals("선착순")) {
            return "예약대기";
        }
        return "추첨대기";
    }*/

    /**
     * 남은 신청 정원 리턴
     * */
    /*private int leftRequestCount(LectureRequest lectureRequest) {
        if(lectureRequest.getRequest_type().equals("오프라인")){                    // 오프라인 신청
            return lectureRequestService.getLectureRequestOfflinePersonCount(lectureRequest);
        }
        return lectureRequestService.getLectureRequestOnlinePersonCount(lectureRequest); // 온라인 신청
    }*/
}