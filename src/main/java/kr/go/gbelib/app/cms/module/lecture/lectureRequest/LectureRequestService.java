package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfo;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfoDao;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfo;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.List;

@Service
public class LectureRequestService extends BaseService {

    @Autowired
    private CourseInfoDao courseInfoDao;

    @Autowired
    private LectureRequestDao lectureRequestDao;

    @Autowired
    private LectureInfoDao lectureInfoDao;

    /**
     * 과정 목록 가져오기
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="수강신청 페이지에서 과정 목록 조회", type="P")
    public List<CourseInfo> courseInfoIdList(String homepage_id) {
        return courseInfoDao.getCourseInfoListNoPaging(homepage_id);
    }

    /**
     * 검색을 위한 준비
     * */
    @WorkingLogger(comment="수강신청 페이지에서 선택한 강좌과정이 없으면 조회", type="P")
    public void setSearchingData(LectureRequest lectureRequest) {
        // 과정을 선택하지 않았다면
        if(lectureRequest.getSearch_course_id() == null || lectureRequest.getSearch_course_id().equals("")){
            CourseInfo courseInfo = courseInfoDao.getLatestCourseInfo(lectureRequest.getHomepage_id());
            if(courseInfo != null) {
                lectureRequest.setSearch_course_id(courseInfo.getCourse_id());
            }
        }

        // 취소여부를 선택하지 않았다면
        if(lectureRequest.getSearch_cancel_yn() == null || lectureRequest.getSearch_cancel_yn().equals("")){
            lectureRequest.setSearch_cancel_yn("N");
        }
    }

    /**
     * 수강신청 개수 가져오기
     * */
    @WorkingLogger(comment="수강신청 페이지에서 과정 목록 조회", type="P")
    @Transactional(readOnly = true)
    public int getLectureRequestCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestCount(lectureRequest);
    }

    /**
     * 수강신청 목록 조회
     * */
    @WorkingLogger(comment="수강신청 목록 조회", type="P")
    public List<LectureRequest> lectureRequestList(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestList(lectureRequest);
    }

    /**
     * 과정에대한 강좌 목록 조회
     * */
    @WorkingLogger(comment="수강신청 페이지에서 강좌 목록 조회", type="P")
    public List<LectureInfo> lectureInfoList(LectureRequest lectureRequest) {
        if(lectureRequest.getSearch_course_id() != null && !lectureRequest.getSearch_course_id().equals("")){
            return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(lectureRequest.getHomepage_id(), lectureRequest.getSearch_course_id());
        }
        return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(lectureRequest.getHomepage_id(), lectureRequest.getCourse_id());
    }

    /**
     * 과정에대한 강좌 목록 조회
     * */
    @WorkingLogger(comment="수강신청 페이지에서 강좌 목록 조회", type="P")
    public List<LectureInfo> lectureInfoList(String homepage_id, String course_id) {
        return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(homepage_id, course_id);
    }

    /**
     * 수강 신청 하나 조회
     * */
    @WorkingLogger(comment="수강신청 페이지에서 수강신청 하나 조회", type="P")
    public LectureRequest lectureRequestOne(String request_id) {
        return lectureRequestDao.getLectureRequestOne(request_id);
    }

    /**
     * 최신 course_id set
     * */
    @WorkingLogger(comment="수강신청 페이지에서 과정 조회", type="P")
    public void setDefaultCourse(LectureRequest lectureRequest) {
        CourseInfo courseInfo = courseInfoDao.getLatestCourseInfo(lectureRequest.getHomepage_id());
        if(courseInfo != null) {
            lectureRequest.setCourse_id(courseInfo.getCourse_id());
        }
    }

    /**
     * 수강신청 추가
     * */
    @WorkingLogger(comment="수강신청 페이지에서 과정 조회", type="P")
    public void addLectureRequest(LectureRequest lectureRequest, String sessionMemberId, String remoteAddr) {
        if(lectureRequest.getRequest_type().equals("오프라인")){
            lectureRequest.setAdd_id("");
        }

        lectureRequestDao.addLectureRequest(lectureRequest);
    }

    /**
     * 수강신청 수정
     * */
    @WorkingLogger(comment="수강신청 수정", type="P")
    @Transactional
    public void updateLectureRequest(LectureRequest lectureRequest, String sessionMemberId, String remoteAddr) {
        LectureRequest lectureRequestEntity = lectureRequestDao.getLectureRequestOne(lectureRequest.getRequest_id());
        if(lectureRequest.getCancel_yn() != null && lectureRequest.getCancel_yn().equals("Y")
                && !lectureRequest.getCancel_yn().equals(lectureRequestEntity.getCancel_yn()) ){
            lectureRequest.setCancel_id(sessionMemberId);
            lectureRequest.setCancel_ip(remoteAddr);
            lectureRequest.setCancel_date(Calendar.getInstance().getTime());
        }else {
            lectureRequest.setCancel_id("");
            lectureRequest.setCancel_ip("");
            lectureRequest.setCancel_date(null);
        }
        lectureRequestDao.updateLectureRequest(lectureRequest);
    }

    /**
     * 수강신청 취소
     * */
    @WorkingLogger(comment="수강신청 취소", type="P")
    public void cancelLectureRequest(LectureRequest lectureRequest, String add_id, String add_ip) {
        lectureRequest.setCancel_yn("Y");
        lectureRequest.setCancel_id(add_id);
        lectureRequest.setCancel_ip(add_ip);
        lectureRequestDao.cancelLectureRequest(lectureRequest);
    }

    /**
     *
     * */

    public int getMyLectureRequestCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getMyLectureRequestCount(lectureRequest);
    }

    public int getLectureRequestOnlinePersonCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestOnlinePersonCount(lectureRequest);
    }

    public int getLectureRequestOfflinePersonCount(LectureRequest lectureRequest) {
        int count = lectureRequestDao.getLectureRequestOfflinePersonCount(lectureRequest);
        return count;
    }

    public int getLectureRequestWaitPersonCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestWaitPersonCount(lectureRequest);
    }
}
