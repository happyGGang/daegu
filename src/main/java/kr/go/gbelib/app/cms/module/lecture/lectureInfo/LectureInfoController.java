package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import com.google.gson.Gson;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.file.LectureInfoFile;
import kr.go.gbelib.app.cms.module.lecture.lectureRequest.LectureRequest;
import kr.go.gbelib.app.cms.module.lecture.lectureRequest.LectureRequestService;
import org.apache.commons.lang3.StringUtils;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.ParseException;
import java.util.List;

@Controller
@RequestMapping(value = {"/cms/module/lecture/lectureInfo"})
public class LectureInfoController extends BaseController {

    private final String basePath = "/cms/module/lecture/lectureInfo/";

    @Autowired
    private LectureInfoService lectureInfoService;

    @Autowired
    private LectureRequestService lectureRequestService;

    @Autowired
    private HomepageService homepageService;

    /**
     * 강좌 정보 메인 페이지
     * */
    @RequestMapping(value = {"/index.*"})
    private String index(Model model, LectureInfo lectureInfo, HttpServletRequest request) throws Exception {
        checkAuth("R", model, request);

        lectureInfo.setHomepage_id(getAsideHomepageId(request));
        lectureInfoService.setSearchingData(lectureInfo);
        lectureInfoService.setPaging(model, lectureInfoService.lectureInfoCount(lectureInfo), lectureInfo);

        List<LectureInfo> lectureInfos = lectureInfoService.lectureInfoList(lectureInfo);

        model.addAttribute("lectureInfo", lectureInfo);
        model.addAttribute("lectureInfoList", lectureInfos);
        model.addAttribute("courseInfoList", lectureInfoService.courseInfoIdList(lectureInfo.getHomepage_id()));

        return basePath + "index";
    }

    /**
     * 강좌 정보 추가, 수정 페이지
     * */
    @RequestMapping(value = {"/edit.*"})
    private String edit(Model model, LectureInfo lectureInfo, HttpServletRequest request) throws Exception {

        lectureInfo.setHomepage_id(getAsideHomepageId(request));

        if(request.getParameter("editMode").equals("ADD")) { // 추가 모드
            checkAuth("C", model, request);

            lectureInfo.setCourse_id(request.getParameter("course_id"));

            model.addAttribute("lectureInfo", lectureInfo);

        } else if(request.getParameter("editMode").equals("UPDATE")) { // 수정 모드
            checkAuth("U", model, request);

            LectureInfo lectureInfoEntity = lectureInfoService.lectureInfoOne(request.getParameter("lecture_id"));

            if(lectureInfoEntity != null){
                lectureInfoEntity.setEditMode("UPDATE");
                lectureInfoEntity.setHomepage_id(getAsideHomepageId(request));
            }

            model.addAttribute("lectureInfo", lectureInfoEntity);
            model.addAttribute("file", lectureInfoService.lectureInfoFile(lectureInfo));
        }

        model.addAttribute("courseInfoList", lectureInfoService.courseInfoIdList(lectureInfo.getHomepage_id()));

        return basePath + "edit_ajax";
    }

    /**
     * 신청자 추첨 페이지
     * */
    /*@RequestMapping(value = {"/raffle.*"})
    private String raffle(Model model, LectureInfo lectureInfo, HttpServletRequest request) throws Exception {
        Gson gson = new Gson();
        checkAuth("R", model, request);

        lectureInfo.setHomepage_id(getAsideHomepageId(request));

        String lecture_id = request.getParameter("lecture_id");
        lectureInfo.setLecture_id(lecture_id);

        String jsonArrayString = gson.toJson(lectureRequestService.getRaffleLectureRequestList(lecture_id));

        model.addAttribute("lectureInfo", lectureInfoService.lectureInfoOne(lectureInfo.getLecture_id()));
        model.addAttribute("raffleLectureRequestList", jsonArrayString);

        return basePath + "raffle_ajax";
    }*/

    /**
     * 강좌 정보 페이지
     * */
    @RequestMapping(value = {"/view.*"})
    private String view(Model model, LectureInfo lectureInfo, HttpServletRequest request) throws Exception {
        checkAuth("R", model, request);

        lectureInfo.setHomepage_id(getAsideHomepageId(request));

        LectureInfo lectureInfoEntity = lectureInfoService.lectureInfoOne(lectureInfo.getLecture_id());
        lectureInfoEntity.setViewPage(lectureInfo.getViewPage());
        lectureInfoEntity.setSearching_course_id(lectureInfo.getSearching_course_id());
        lectureInfoEntity.setSearching_reservation(lectureInfo.getSearching_reservation());
        lectureInfoEntity.setSearching_edu_status(lectureInfo.getSearching_edu_status());
        lectureInfoEntity.setSearch_type(lectureInfo.getSearch_type());
        lectureInfoEntity.setStart_period(lectureInfo.getStart_period());
        lectureInfoEntity.setEnd_period(lectureInfo.getEnd_period());
        lectureInfoEntity.setSearch_text(lectureInfo.getSearch_text());
        lectureInfoEntity.setRowCount(lectureInfo.getRowCount());

        model.addAttribute("lectureInfo", lectureInfoEntity);
        model.addAttribute("file", lectureInfoService.lectureInfoFile(lectureInfo));
        return basePath + "view";
    }

    /**
     * 신청자 확인 페이지
     * */
    @RequestMapping(value = {"/applicant.*"})
    private String applicant(Model model, LectureRequest lectureRequest, HttpServletRequest request) throws Exception {
        Gson gson = new Gson();

        checkAuth("R", model, request);

        lectureRequest.setHomepage_id(getAsideHomepageId(request));

        String lecture_id = request.getParameter("lecture_id");
        String applicant_type = request.getParameter("applicant_type");

        List<LectureRequest> lectureRequestList = lectureRequestService.getLectureRequestListForApplicant(lectureRequest.getHomepage_id(), lecture_id, applicant_type);

        model.addAttribute("lectureInfo", lectureInfoService.lectureInfoOne(lecture_id));
        model.addAttribute("applicant_type", applicant_type);
        model.addAttribute("lectureRequestList", gson.toJson(lectureRequestList));

        return basePath + "applicant_ajax";
    }

    /**
     * 강좌 정보 등록, 수정 api
     * */
    @RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse save(LectureInfo lectureInfo, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
        JsonResponse res = new JsonResponse(request);

        lectureInfo.setHomepage_id(getAsideHomepageId(request));

        validationChk(result, lectureInfo); // 유효성 체크

        if(result.hasErrors()) {  // 오류가 있으면 return
            res.setValid(false);
            res.setResult(result.getAllErrors());
            return res;
        }

        if(lectureInfo.getEditMode().equals("ADD")) { // 강좌 정보 추가

            lectureInfo.setAdd_id(getSessionMemberId(request));
            lectureInfoService.addLectureInfo(lectureInfo, getSessionMemberId(request), request.getRemoteAddr(), mpRequest);
            res.setValid(true);
            res.setMessage("저장되었습니다.");
            res.setUrl("index.do");

        } else if(lectureInfo.getEditMode().equals("UPDATE")) { // 강좌 정보 수정

            LectureInfo lectureInfoOne = lectureInfoService.lectureInfoOne(lectureInfo.getLecture_id());

            // 현재모집되어 있는 인원보다 작은 수의 모집인원을 설정했을 때 수정 불가능
            if (lectureInfoOne.getOnline_request_count() > lectureInfo.getOnline_person_count()
                    || lectureInfoOne.getWait_request_count() > lectureInfo.getWait_person_count()
                    || lectureInfoOne.getOffline_request_count() > lectureInfo.getOffline_person_count()) {

                res.setValid(false);
                res.setMessage("모집인원을 현재 신청된 인원보다 작게 설정할 수 없습니다.\n" +
                        "새로고침하여 신청자 수를 확인해주세요.");
                return res;
            }

            lectureInfo.setAdd_id(getSessionMemberId(request));
            lectureInfoService.updateLectureInfo(lectureInfo, mpRequest);
            res.setValid(true);
            res.setMessage("수정되었습니다.");
            res.setUrl("index.do");

        } else {
            res.setValid(false);
            res.setMessage("잘못된 접근입니다.");
        }

        return res;
    }

    /**
     * 강좌 과정 삭제 api
     * */
    @RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse delete(LectureInfo lectureInfo, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        lectureInfo.setHomepage_id(getAsideHomepageId(request));

        if (!result.hasErrors()) {
            if (lectureInfo.getEditMode().equals("DELETE")) {

                if(lectureInfoService.isRequestInLecture(lectureInfo)) { // 강좌에 신청된 인원이 있으면
                    res.setValid(false);
                    res.setMessage("해당 강좌에 연결된 인원이 있어 삭제가 불가능 합니다.");
                    return res;
                }

                lectureInfoService.deleteLectureInfo(lectureInfo);
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
     * 첨부파일 삭제 api
     * */
    @RequestMapping(value = { "/deleteFile.*" }, method = RequestMethod.POST)
    public @ResponseBody JsonResponse deleteFile(Model model, LectureInfo lectureInfo, BindingResult result, HttpServletRequest request) throws ParseException {
        JsonResponse res = new JsonResponse(request);

        lectureInfoService.deleteFile(lectureInfo);
        res.setValid(true);
        res.setMessage("파일을 삭제 했습니다.");

        return res;
    }

    /**
     * 유효성 체크
     * */
    private void validationChk(BindingResult result, LectureInfo lectureInfo) {
        // 공백 불가
        ValidationUtils.rejectIfEmpty(result, "course_id", "과정을 선택하세요.");
        ValidationUtils.rejectIfEmpty(result, "lecture_title", "강좌명을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "request_start_date", "접수기간 시작일을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "request_end_date", "접수기간 종료일을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "request_type", "접수방법을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "online_person_count", "온라인 모집인원을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "offline_person_count", "오프라인 모집인원을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "wait_person_count", "대기자 모집인원을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "edu_start_date", "교육기간 시작일을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "edu_end_date", "교육기간 종료일을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "edu_start_time", "교육 시작 시간을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "edu_end_time", "교육 종료 시간을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "teacher_name", "강사명을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "supporter_name", "담당자를 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "teacher_tel", "담당자 연락처를 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "edu_school", "교육장을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "edu_address_1", "주소를 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "edu_address_2", "상세주소를 입력하세요.");

        ValidationUtils.rejectIfNotDate(result, "request_start_date", "접수기간시작일 형식이 올바르지 않습니다.");
        ValidationUtils.rejectIfNotDate(result, "request_end_date", "접수기간종료일 형식이 올바르지 않습니다.");
        ValidationUtils.rejectIfNotDate(result, "edu_start_date", "교육기간시작일 형식이 올바르지 않습니다.");
        ValidationUtils.rejectIfNotDate(result, "edu_end_date", "교육기간종료일 형식이 올바르지 않습니다.");
        ValidationUtils.rejectExceptNumber(result, "online_person_count", "온라인 모집인원 형식이 올바르지 않습니다.");
        ValidationUtils.rejectExceptNumber(result, "offline_person_count", "오프라인 모집인원 형식이 올바르지 않습니다.");
        ValidationUtils.rejectExceptNumber(result, "wait_person_count", "대기자 모집인원 형식이 올바르지 않습니다.");
        ValidationUtils.rejectPhone2(result, "supporter_tel", "담당자연락처 형식이 올바르지 않습니다..");
        if (StringUtils.isNotEmpty(lectureInfo.getTeacher_tel())) {
            ValidationUtils.rejectPhone2(result, "teacher_tel", "강사연락처 형식이 올바르지 않습니다.");
        }

        ValidationUtils.rejectExceptNumber(result, "online_person_count", 1,4, "온라인모집 최대인원을 초과 했습니다.");
        ValidationUtils.rejectExceptNumber(result, "offline_person_count", 1,4, "오프라인모집인원 최대인원을 초과 했습니다.");
        ValidationUtils.rejectExceptNumber(result, "wait_person_count", 1,4, "대기자모집인원 최대인원을 초과 했습니다.");
    }

    // 엑셀 다운로드
    @RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
    public LectureInfoSearchView excel(Model model, LectureInfo lectureInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        lectureInfo.setHomepage_id(getAsideHomepageId(request));
        lectureInfoService.setSearchingData(lectureInfo);
        lectureInfoService.setPaging(model, lectureInfoService.lectureInfoCount(lectureInfo), lectureInfo);

        model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(lectureInfo.getHomepage_id())));
        model.addAttribute("lectureInfo", lectureInfo);
        model.addAttribute("lectureInfoList", lectureInfoService.lectureInfoList(lectureInfo));
        return new LectureInfoSearchView();
    }

    // csv 다운로드
    @RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
    public void csv(Model model, LectureInfo lectureInfo, HttpServletRequest request, HttpServletResponse response) {
        lectureInfo.setHomepage_id(getAsideHomepageId(request));
        lectureInfoService.setSearchingData(lectureInfo);
        lectureInfoService.setPaging(model, lectureInfoService.lectureInfoCount(lectureInfo), lectureInfo);

        List<LectureInfo> lectureInfoList = lectureInfoService.lectureInfoList(lectureInfo);
        Homepage homepage = homepageService.getHomepageOne(new Homepage(lectureInfo.getHomepage_id()));

        model.addAttribute("lectureInfo", lectureInfo);
        model.addAttribute("lectureInfoList", lectureInfoList);

        new LectureInfoXlsToCsv(lectureInfoList, "LectureInfo.csv", homepage, request, response);
    }
}
