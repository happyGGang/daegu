package kr.go.gbelib.app.module.lecture;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfo;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfoService;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.file.LectureInfoFile;
import kr.go.gbelib.app.cms.module.lecture.lectureRequest.LectureRequest;
import kr.go.gbelib.app.cms.module.lecture.lectureRequest.LectureRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/lecture"})
public class LectureController extends BaseController {
    private String basePath = "/homepage/%s/module/lecture/";

    @Autowired
    private LectureInfoService lectureInfoService;

    @Autowired
    private LectureRequestService lectureRequestService;

    @Autowired
    private LoginService loginService;

    /**
     * 강좌 목록 페이지
     * */
    @RequestMapping(value = {"/index.*"})
    private String index(Model model, LectureInfo lectureInfo, HttpServletRequest request) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        lectureInfo.setHomepage_id(homepage.getHomepage_id());

        lectureInfoService.setPaging(model, lectureInfoService.getOngoingCourseLectureInfoCount(lectureInfo), lectureInfo);

        List<LectureInfo> lectureInfos = lectureInfoService.getOngoingCourseLectureInfoList(lectureInfo);

        model.addAttribute("lectureInfo", lectureInfo);
        model.addAttribute("lectureInfoList", lectureInfos);

        return String.format(basePath, homepage.getFolder()) + "index";
    }

    /**
     * 강좌 뷰 페이지
     * */
    @RequestMapping(value = {"/view.*"})
    private String view(Model model, LectureInfo lectureInfo, HttpServletRequest request) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        lectureInfo.setHomepage_id(homepage.getHomepage_id());

        LectureInfo lectureInfoOne = lectureInfoService.lectureInfoOne(lectureInfo.getLecture_id());

        model.addAttribute("lectureInfo", lectureInfoOne);
        model.addAttribute("file", lectureInfoService.lectureInfoFile(lectureInfo));
        model.addAttribute("homepage", homepage);

        return String.format(basePath, homepage.getFolder()) + "view";
    }

    /**
     * 마이페이지 (수강신청 강좌 목록 확인)
     * */
    @RequestMapping(value = {"/myPage.*"})
    private String myPage(Model model, LectureInfo lectureInfo, HttpServletRequest request) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        lectureInfo.setHomepage_id(homepage.getHomepage_id());
        lectureInfo.setRequest_add_id(getSessionMemberId(request));

        model.addAttribute("lectureInfo", lectureInfo);
        model.addAttribute("lectureInfoList", lectureInfoService.getMyLectureInfoList(lectureInfo));
        model.addAttribute("sessionId", getSessionMemberId(request));

        return String.format(basePath, homepage.getFolder()) + "myPage";
    }

    /**
     * 수강신청 정보 입력 페이지
     * */
    @RequestMapping(value = {"/edit.*"})
    private String edit(Model model, LectureRequest lectureRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Member member = loginService.getSessionMember(request);
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        String lecture_id = request.getParameter("lecture_id");
        String request_type = request.getParameter("request_type");

        if(lecture_id == null || lecture_id.equals("")) {  // 잘못된 접근
            lectureInfoService.alertMessageAndUrl("강좌 고유번호가 전달되지 않았습니다.\n관리자에게 문의하세요.", String.format("/%s/module/lecture/index.do", homepage.getContext_path()), request, response);
            return null;
        }

        lectureRequest.setHomepage_id(homepage.getHomepage_id());

        lectureRequest.setLecture_id(lecture_id);
        lectureRequest.setRequest_type(request_type);

        if(member.isLogin()) {
            lectureRequest.setAdd_id(member.getMember_id());
            lectureRequest.setRequest_name(member.getMember_name());
            lectureRequest.setBirthday(member.getBirth_day());
            lectureRequest.setPhone_number(member.getPhone());
            lectureRequest.setGender(member.getSex().equals("0") ? '0' : '1');
            lectureRequest.setEmail(member.getEmail());
            lectureRequest.setZip_code(member.getZipcode());
            lectureRequest.setAddress1(member.getAddress1());
            lectureRequest.setAddress2(member.getAddress2());
        }

        model.addAttribute("lectureInfo", lectureInfoService.lectureInfoOne(lecture_id));
        model.addAttribute("lectureRequest", lectureRequest);

        return String.format(basePath, homepage.getFolder()) + "edit_ajax";
    }

    /**
     * 온라인 신청 추가
     * */
    @RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse save(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        Homepage homepage = (Homepage)request.getAttribute("homepage");

        lectureRequest.setHomepage_id(homepage.getHomepage_id());

        validationChk(result, lectureRequest);                          // 유효성 체크

        if (result.hasErrors()) {                   // 오류가 있으면 return
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return res;
        }

        if (lectureRequest.getEditMode().equals("ADD")) {

            lectureRequest.setCancel_yn("N");                           // 취소여부 set
            lectureRequest.setAdd_ip(request.getRemoteAddr());          // add_ip set
            lectureRequest.setRequest_type("온라인");                    // 온라인 등록

            if (lectureRequest.getAdd_id() != null && !lectureRequest.getAdd_id().equals("")) {  // 회원 수강신청일때만 확인
                if(lectureRequestService.getMyLeftLectureRequestCount(lectureRequest) <= 0) {  // 신청가능한 강좌 수 확인
                    res.setValid(false);
                    res.setMessage("강좌 신청에 실패했습니다.\n현재 진행중인 과정에서 신청할 수 있는\n강좌의 수를 초과하였습니다.");
                    return res;
                }
            }

            if(!setStatus(lectureRequest, res)) return res;             // 신청 불가 상태면 return

            lectureRequestService.addLectureRequest(lectureRequest);    // 수강신청 추가

            res.setValid(true);
            res.setMessage("수강신청 되었습니다.");
            res.setUrl("index.do");
        } else {
            res.setValid(false);
            res.setResult("잘못된 접근입니다.\n관리자에게 문의하세요.");
        }

        return res;
    }

    /**
     * 신청 상태 저장
     * */
    private boolean setStatus(LectureRequest lectureRequest, JsonResponse res) {
        LectureInfo lectureInfoOne = lectureInfoService.lectureInfoOne(lectureRequest.getLecture_id()); //  강좌 정보 조회

        if (lectureInfoOne.getLecture_status1().equals("정원마감")){
            res.setValid(false);
            res.setMessage("온라인 신청 정원이 마감되었습니다.");

            return false;
        } else if(!lectureInfoOne.getLecture_status1().equals("모집중")) {
            res.setValid(false);
            res.setMessage("모집중인 수강신청이 아닙니다.");

            return false;
        } else if(lectureRequest.getAdd_id() != null && !lectureRequest.getAdd_id().equals("") // 회원 수강신청일때만 확인
                && lectureRequestService.getMyLectureRequestCountOfLectureInfo(lectureRequest) > 0) { // 강좌 중복 신청 확인
            res.setValid(false);
            res.setMessage("이미 수강신청된 강좌입니다.");

            return false;
        } else if(lectureInfoOne.getRequest_type().equals("추첨제")){
            lectureRequest.setRequest_status("추첨대기");
            return true;
        } else if(lectureRequestService.getLectureRequestOnlinePersonCount(lectureRequest) > 0){
            lectureRequest.setRequest_status("예약완료");
            return true;
        } else {
            lectureRequest.setRequest_status("예약대기");
            return true;
        }
    }

    /**
     * 수강 신청 취소 api
     * */
    @RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse cancel(LectureRequest lectureRequest, BindingResult result, HttpServletRequest request) {
        Homepage homepage = (Homepage)request.getAttribute("homepage");
        JsonResponse res = new JsonResponse(request);

        lectureRequest.setHomepage_id(homepage.getHomepage_id());

        if (result.hasErrors()) {                   // 오류가 있으면 return
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return res;
        }

        if (lectureRequest.getEditMode().equals("DELETE")) {
            LectureRequest lectureRequestOne = lectureRequestService.lectureRequestOne(lectureRequest.getRequest_id());
            LectureInfo lectureInfo = lectureInfoService.lectureInfoOne(lectureRequestOne.getLecture_id());

            if(lectureInfo.getLecture_status1().equals("모집마감")) {
                res.setValid(false);
                res.setMessage("모집이 마감되어 취소할 수 없습니다.\n강좌 담당자에게 문의하세요.");
                return res;
            }

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
     * 첨부파일 다운로드 api
     * */
    @RequestMapping(value = "/download/{homepage_id}/{server_file_name}.*", method = RequestMethod.GET)
    @ResponseBody
    public byte[] getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("server_file_name") String server_file_name, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LectureInfoFile lectureInfoFile = lectureInfoService.lectureInfoFile(server_file_name);

        if(lectureInfoFile == null) {
            response.setHeader("Content-type", "text/html");
            lectureInfoService.alertMessage("파일이 DB에 존재하지 않습니다.", request, response);
            return null;
        }

        String filePath = lectureInfoService.getRootPath()+ "/" + homepage_id + "/" + lectureInfoFile.getFile_server_name();
        File file = new File(filePath);
        System.out.println(filePath);
        byte[] bytes = null;

        if(file.length() > 0) {
            bytes = FileCopyUtils.copyToByteArray(file);
        } else {
            response.setHeader("Content-type", "text/html");
            lectureInfoService.alertMessage("파일이 존재하지 않습니다.", request, response);
            return null;
        }

        String fileName = String.format("%s", lectureInfoFile.getFile_server_name() );

        response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
        response.setHeader("Content-Length", Long.toString(file.length()));
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Content-Type", "application/octet-stream");

        return bytes;
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

        // 형식 체크
        ValidationUtils.rejectIfNotDate(result, "birthday", "생년월일 형식이 올바르지 않습니다.");
        ValidationUtils.rejectPhone(result, "phone_number", "휴대폰번호 형식이 올바르지 않습니다.");
        if( lectureRequest.getEmail() != null) {
            ValidationUtils.rejectNotFullEmailType(result, "email", "이메일 형식이 올바르지 않습니다.");
        }
    }

    /**
     * 강좌 목록 페이지
     * */
    @RequestMapping(value = {"/test.*"})
    private String test(Model model, LectureInfo lectureInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Homepage homepage = (Homepage)request.getAttribute("homepage");

        lectureInfoService.alertMessageAndUrl("강좌 고유번호가 전달되지 않았습니다.\n관리자에게 문의하세요.", String.format("/%s/module/lecture/index.do", homepage.getContext_path()), request, response);

        return null;
    }
}
