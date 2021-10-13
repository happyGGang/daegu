package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import com.google.gson.Gson;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfo;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfoDao;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfo;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.Collections;
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
    public List<LectureInfo> lectureInfoList(LectureRequest lectureRequest, String connect_type) {
        if(lectureRequest.getSearch_course_id() != null && !lectureRequest.getSearch_course_id().equals("")){
            return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(lectureRequest.getHomepage_id(), lectureRequest.getSearch_course_id(), connect_type);
        }
        return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(lectureRequest.getHomepage_id(), lectureRequest.getCourse_id(), connect_type);
    }

    /**
     * 과정에대한 강좌 목록 조회
     * */
    @WorkingLogger(comment="수강신청 페이지에서 강좌 목록 조회", type="P")
    public List<LectureInfo> lectureInfoList(String homepage_id, String course_id, String connect_type) {
        return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(homepage_id, course_id, connect_type);
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
    public void addLectureRequest(LectureRequest lectureRequest) {
        lectureRequestDao.addLectureRequest(lectureRequest);
    }

    /**
     * 수강신청 수정
     * */
    @WorkingLogger(comment="수강신청 수정", type="P")
    @Transactional
    public void updateLectureRequest(LectureRequest lectureRequest) {
        lectureRequestDao.updateLectureRequest(lectureRequest);
    }

    /**
     * 수강신청 취소
     * */
    @WorkingLogger(comment="수강신청 취소", type="P")
    @Transactional
    public void cancelLectureRequest(LectureRequest lectureRequest, String member_id, String session_ip) {
        LectureRequest cancelLectureRequest = lectureRequestDao.getLectureRequestOne(lectureRequest.getRequest_id());
        String status = cancelLectureRequest.getRequest_status();

        // 예약 취소
        lectureRequest.setCancel_id(member_id);
        lectureRequest.setCancel_ip(session_ip);
        lectureRequest.setCancel_yn("Y");
        lectureRequest.setRequest_status("예약취소");
        lectureRequestDao.cancelLectureRequest(lectureRequest);

        if(status.equals("예약완료")){
            // 대기자 자동 신청 승인
            LectureRequest lectureRequestEntity = lectureRequestDao.getLectureRequestOne(lectureRequest.getRequest_id());
            lectureRequestDao.changeLatestWait(lectureRequestEntity);
        }

    }

    /**
     * 이미 수강 신청했는지 확인하기위한 서비스
     * 수강 신청 안했으면 0 return;
     * */
    public int getMyLectureRequestCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getMyLectureRequestCount(lectureRequest);
    }

    /**
     * 온라인 신청 남은 인원 return
     * */
    public int getLectureRequestOnlinePersonCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestOnlinePersonCount(lectureRequest);
    }

    /**
     * 오프라인 신청 남은 인원 return
     * */
    public int getLectureRequestOfflinePersonCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestOfflinePersonCount(lectureRequest);
    }

    /**
     * 대기 신청 남은 인원 return
     * */
    public int getLectureRequestWaitPersonCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestWaitPersonCount(lectureRequest);
    }

    /**
     * 강좌 재신청 서비스
     * */
    public void reapplyRequest(LectureRequest lectureRequest) {
        lectureRequestDao.reapplyLectureRequest(lectureRequest);
    }

    /**
     * 강좌 id, add_id 로 수강신청 하나 가져오기
     * */
    public LectureRequest lectureRequestOneByLectureIdAndAddId(String lecture_id, String add_id) {
        return lectureRequestDao.getLectureRequestOneLectureIdAndAddId(lecture_id, add_id);
    }

    /**
     * 강좌에 추첨대기인 신청자 리스트 리턴
     * */
    public List<LectureRequest> getRaffleLectureRequestList(String lecture_id) {
        return lectureRequestDao.getLectureRequestRaffleListByLectureId(lecture_id);
    }

    /**
     * 추첨내역 저장
     * */
    @Transactional
    @WorkingLogger(comment="신청자 추첨정보 업데이트", type="P")
    public boolean saveRaffleLectureRequest(LectureRequest lectureRequest) {
        List<LectureRequest> raffleList = lectureRequestDao.getLectureRequestRaffleListByLectureId(lectureRequest.getLecture_id());
        int remainCount = getLectureRequestOnlinePersonCount(lectureRequest);

        Collections.shuffle(raffleList);
        if(raffleList == null || raffleList.size() == 0) return false;
        if(remainCount <= 0) return false;

        for (LectureRequest request : raffleList) {
            request.setRequest_status("예약완료");
            lectureRequestDao.updateRequestStatus(request);
            remainCount -= 1;
            if(remainCount <= 0) break;
        }

        return true;
    }

    @Transactional(readOnly = true)
    @WorkingLogger(comment = "신청자 정보 조회", type="P")
    public List<LectureRequest> getLectureRequestListForApplicant(String homepage_id, String lecture_id, String applicant_type) {
        if (applicant_type.equals("오프라인")) {
            return lectureRequestDao.getLectureRequestListByLectureIdAndStatus(homepage_id, lecture_id, "예약완료", "오프라인");
        } else if(applicant_type.equals("온라인")) {
            return lectureRequestDao.getLectureRequestListByLectureIdAndStatus(homepage_id, lecture_id, "예약완료", "온라인");
        } else {
            return lectureRequestDao.getLectureRequestListByLectureIdAndStatus(homepage_id, lecture_id, "대기", "온라인");
        }
    }

    @Transactional(readOnly = true)
    @WorkingLogger(comment = "예약 상태 변경", type="P")
    public void changeStatus(LectureRequest lectureRequest) {
        lectureRequestDao.changeLectureRequestStatus(lectureRequest);
    }
}
