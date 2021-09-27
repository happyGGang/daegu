package kr.go.gbelib.app.cms.module.lecture.courseInfo;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
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
@RequestMapping(value = {"/cms/module/lecture/courseInfo"})
public class CourseInfoController extends BaseController {

    private final String basePath = "/cms/module/lecture/courseInfo/";

    @Autowired
    private CourseInfoService courseInfoService;

    @Autowired
    private LectureInfoService lectureInfoService;

    /**
     * 강과 과정 메인 페이지
    * */
    @RequestMapping (value = {"/index.*"})
    public String index(Model model, CourseInfo courseInfo, HttpServletRequest request) throws Exception {
        checkAuth("R", model, request);

        courseInfo.setHomepage_id(getAsideHomepageId(request));

        courseInfoService.setPaging(model, courseInfoService.courseInfoCount(courseInfo), courseInfo);

        model.addAttribute("courseInfo", courseInfo);
        model.addAttribute("courseInfoList", courseInfoService.courseInfoList(courseInfo));

        return basePath + "index";
    }

    /**
     * 강과 과정 등록, 수정 페이지
     * */
    @RequestMapping (value = {"/edit.*"})
    public String edit(Model model, CourseInfo courseInfo, HttpServletRequest request) throws Exception {
        checkAuth("C", model, request);

        courseInfo.setHomepage_id(getAsideHomepageId(request));

        String editMode = request.getParameter("editMode");
        String course_id = request.getParameter("course_id");

        // 수정 모드일 때 courseInfo 가져오기
        if(editMode != null && editMode.equals("UPDATE")) {
            courseInfo = courseInfoService.setCourseInfo(course_id);
            courseInfo.setEditMode("UPDATE");
        }

        model.addAttribute("courseInfo", courseInfo);

        return basePath + "edit_ajax";
    }

    /**
     * 강과 과정 등록 api
     * */
    @RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse save(CourseInfo courseInfo, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        courseInfo.setHomepage_id(getAsideHomepageId(request));

        if(courseInfo.getEditMode().equals("ADD")) {
            validationChk(result); // 유효성 체크

            if (!result.hasErrors()) {
                courseInfo.setAdd_id(getSessionMemberId(request));
                courseInfoService.addCourseInfo(courseInfo, getSessionMemberId(request), request.getRemoteAddr());
                res.setValid(true);
                res.setMessage("저장되었습니다.");
                res.setUrl("index.do");
            } else {
                res.setValid(false);
                res.setResult(result.getAllErrors());
            }

        } else if(courseInfo.getEditMode().equals("UPDATE")) {
            validationChk(result); // 유효성 체크

            if (!result.hasErrors()) {
                courseInfo.setAdd_id(getSessionMemberId(request));
                courseInfoService.updateCourse(courseInfo);
                res.setValid(true);
                res.setMessage("수정되었습니다.");
                res.setUrl("index.do");
            } else {
                res.setValid(false);
                res.setResult(result.getAllErrors());
            }
        } else {
            // 오류 날림
        }

        return res;
    }

    /**
     * 강과 과정 삭제 api
     * */
    @RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse delete(CourseInfo courseInfo, BindingResult result, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        courseInfo.setHomepage_id(getAsideHomepageId(request));

        if(lectureInfoService.lectureInfoCount(courseInfo.getHomepage_id(), courseInfo.getCourse_id()) != 0) {
            result.reject("과정에 등록된 강좌가 존재하기 때문에 삭제가 불가능 합니다.");
        }

        if (!result.hasErrors()) {
            if (courseInfo.getEditMode().equals("DELETE")) {
                courseInfoService.deleteCourseInfo(courseInfo);
                res.setValid(true);
                res.setMessage("삭제되었습니다.");
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
    private void validationChk(BindingResult result) {
        ValidationUtils.rejectIfEmpty(result, "course_title", "과정명을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "view_start_date", "과정노출시작기간을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "view_end_date", "과정노출종료시작기간을 입력하세요.");
        ValidationUtils.rejectIfEmpty(result, "use_yn", "사용여부를 입력하세요.");

        ValidationUtils.rejectIfNotDate(result, "view_start_date", "시작시간 날짜 형식이 올바르지 않습니다.");
        ValidationUtils.rejectIfNotDate(result, "view_end_date", "종료시간 날짜 형식이 올바르지 않습니다.");
        ValidationUtils.rejectYN(result, "use_yn", "사용여부형식이 올바르지 않습니다.");

        ValidationUtils.rejectIfStringLength(result, "course_title", 20, "과정명");
    }

}
