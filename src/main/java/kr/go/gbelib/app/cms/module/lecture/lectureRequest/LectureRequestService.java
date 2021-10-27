package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.lecture.SendMessageService;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfo;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfoDao;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfoService;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfo;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfoDao;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Autowired
    private CourseInfoService courseInfoService;

    @Autowired
    private LectureInfoService lectureInfoService;

    @Autowired
    private SendMessageService sendMessageService;

    /**
     * 과정 목록 가져오기
     */
    @Transactional(readOnly = true)
    @WorkingLogger(comment = "수강신청 페이지에서 과정 목록 조회", type = "P")
    public List<CourseInfo> courseInfoIdList(String homepage_id) {
        return courseInfoDao.getCourseInfoListNoPaging(homepage_id);
    }

    /**
     * 검색을 위한 준비
     */
    @WorkingLogger(comment = "수강신청 페이지에서 선택한 강좌과정이 없으면 조회", type = "P")
    public void setSearchingData(LectureRequest lectureRequest) {
        // 예약상태를 선택하지 않았다면
        if (lectureRequest.getSearch_request_status() == null || lectureRequest.getSearch_request_status().equals("")) {
            lectureRequest.setSearch_request_status("예약완료");
        }

        // 과정을 선택하지 않았다면
        if (lectureRequest.getSearch_course_id() == null || lectureRequest.getSearch_course_id().equals("")) {
            CourseInfo courseInfoOngoing = courseInfoService.getOngoingCourseInfoOne(lectureRequest.getHomepage_id());
            if (courseInfoOngoing != null) {
                lectureRequest.setSearch_course_id(courseInfoOngoing.getCourse_id());
                return;
            }

            CourseInfo courseInfo = courseInfoDao.getLatestCourseInfo(lectureRequest.getHomepage_id());
            if (courseInfo != null) {
                lectureRequest.setSearch_course_id(courseInfo.getCourse_id());
            }
        }
    }

    /**
     * 수강신청 개수 가져오기
     */
    @WorkingLogger(comment = "수강신청 페이지에서 과정 목록 조회", type = "P")
    @Transactional(readOnly = true)
    public int getLectureRequestCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestCount(lectureRequest);
    }

    /**
     * 수강신청 목록 조회
     */
    @WorkingLogger(comment = "수강신청 목록 조회", type = "P")
    public List<LectureRequest> lectureRequestList(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestList(lectureRequest);
    }

    /**
     * 과정에대한 강좌 목록 조회
     * parameter LectureRequest
     */
    @WorkingLogger(comment = "수강신청 페이지에서 강좌 목록 조회", type = "P")
    public List<LectureInfo> lectureInfoList(LectureRequest lectureRequest) {
        if (lectureRequest.getSearch_course_id() != null && !lectureRequest.getSearch_course_id().equals("")) {
            return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(lectureRequest.getHomepage_id(), lectureRequest.getSearch_course_id());
        }
        return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(lectureRequest.getHomepage_id(), lectureRequest.getCourse_id());
    }

    /**
     * 과정에대한 강좌 목록 조회
     * parameter String, String
     */
    @WorkingLogger(comment = "수강신청 페이지에서 강좌 목록 조회", type = "P")
    public List<LectureInfo> lectureInfoList(String homepage_id, String course_id) {
        return lectureInfoDao.getLectureInfoListByHomepageIdAndCourseId(homepage_id, course_id);
    }

    /**
     * 수강 신청 하나 조회
     */
    @WorkingLogger(comment = "수강신청 페이지에서 수강신청 하나 조회", type = "P")
    public LectureRequest lectureRequestOne(String request_id) {
        return lectureRequestDao.getLectureRequestOne(request_id);
    }

    /**
     * 최신 course_id set
     */
    @WorkingLogger(comment = "수강신청 페이지에서 과정 조회", type = "P")
    public void setDefaultCourse(LectureRequest lectureRequest) {
        CourseInfo courseInfo = courseInfoDao.getLatestCourseInfo(lectureRequest.getHomepage_id());
        if (courseInfo != null) {
            lectureRequest.setCourse_id(courseInfo.getCourse_id());
        }
    }

    /**
     * 수강신청 추가
     */
    @WorkingLogger(comment = "수강신청", type = "P")
    @Transactional
    public boolean addLectureRequest(LectureRequest lectureRequest) {
        if (lectureRequestDao.addLectureRequest(lectureRequest) != 1) { // insert 가 잘 진행되면 1을 반환
            return false;
        }

        LectureInfo lectureOne = lectureInfoService.lectureInfoOne(lectureRequest.getLecture_id()); // 강좌 가져오기

        // 문자 전송
        // 수강생에게 전송
        sendMessageService.printMessage(lectureRequest.getRequest_name(), lectureRequest.getPhone_number(), lectureOne.getLecture_title(), lectureOne.getSupporter_name(), lectureOne.getSupporter_tel(), lectureRequest.getRequest_status(), "수강신청이 완료되었습니다.");

        return true;
    }

    /**
     * 수강신청 수정
     */
    @WorkingLogger(comment = "수강신청 수정", type = "P")
    @Transactional
    public void updateLectureRequest(LectureRequest lectureRequest) {
        lectureRequestDao.updateLectureRequest(lectureRequest);
    }

    /**
     * 수강신청 취소
     */
    @WorkingLogger(comment = "수강신청 취소", type = "P")
    @Transactional
    public LectureRequest cancelLectureRequest(LectureRequest lectureRequest, String member_id, String session_ip) {
        LectureRequest cancelLectureRequest = lectureRequestDao.getLectureRequestOne(lectureRequest.getRequest_id());
        String status = cancelLectureRequest.getRequest_status();
        int waitUpdateCnt = 0;

        // 예약 취소
        lectureRequest.setCancel_id(member_id);
        lectureRequest.setCancel_ip(session_ip);
        lectureRequest.setCancel_yn("Y");
        lectureRequest.setRequest_status("예약취소");
        int cancelUpdateCount = lectureRequestDao.cancelLectureRequest(lectureRequest);

        if (cancelUpdateCount != 1) return null;  // 업데이트 오류시 null return;

        LectureRequest requestOne = lectureRequestDao.getLectureRequestOne(lectureRequest.getRequest_id());
        LectureInfo lectureOne = lectureInfoService.lectureInfoOne(requestOne.getLecture_id());

        // 예약 취소시 수강생에게 알림
        sendMessageService.printMessage(requestOne.getRequest_name(), requestOne.getPhone_number(), lectureOne.getLecture_title(), lectureOne.getSupporter_name(), lectureOne.getSupporter_tel(), requestOne.getRequest_status(), "강좌가 취소되었습니다.");

        // 예약완료인 사람이 취소되었을 경우, 모집이 마감되지 않았을 경우에만 자동 승인
        if (status.equals("예약완료") && !lectureOne.getLecture_status1().equals("모집마감")) {

            // 우선예약자의 request_id 가져오기
            LectureRequest priorityWaitRequest = lectureRequestDao.getPriorityWaitRequest(requestOne);
            waitUpdateCnt = lectureRequestDao.changePriorityWait(priorityWaitRequest);

            // 예약완료 자동알림 여부가 Y이고 대기자를 완료자로 변경을 성공하면 문자전송
            if (waitUpdateCnt == 1 && lectureOne.getAuto_sms().equals("Y")) {
                sendMessageService.printMessage(priorityWaitRequest.getRequest_name(), priorityWaitRequest.getPhone_number(), lectureOne.getLecture_title(), lectureOne.getSupporter_name(), lectureOne.getSupporter_tel(), "예약완료", "대기하시던 강좌의 예약이 완료되었습니다.");
            }
        }

        LectureRequest canceledRequest = lectureRequestDao.getLectureRequestOne(cancelLectureRequest.getRequest_id());
        canceledRequest.setWaitUpdateCnt(waitUpdateCnt);

        // 취소에 성공하면 취소한 신청정보 리턴
        return canceledRequest;
    }

    /**
     * 이미 수강 신청했는지 확인하기위한 서비스
     * 수강 신청 안했으면 0 return;
     */
    public int getMyLectureRequestCountOfLectureInfo(LectureRequest lectureRequest) {
        return lectureRequestDao.getMyLectureRequestCountOfLectureInfo(lectureRequest);
    }

    /**
     * 온라인 신청 남은 인원 return
     */
    public int getLectureRequestOnlinePersonCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestOnlinePersonCount(lectureRequest);
    }

    /**
     * 오프라인 신청 남은 인원 return
     */
    public int getLectureRequestOfflinePersonCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestOfflinePersonCount(lectureRequest);
    }

    /**
     * 대기 신청 남은 인원 return
     */
    public int getLectureRequestWaitPersonCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getLectureRequestWaitPersonCount(lectureRequest);
    }

    /**
     * 강좌 재신청 서비스
     */
    public void reapplyRequest(LectureRequest lectureRequest) {
        lectureRequestDao.reapplyLectureRequest(lectureRequest);
    }

    /**
     * 강좌 id, add_id 로 수강신청 하나 가져오기
     */
    public LectureRequest lectureRequestOneByLectureIdAndAddId(String lecture_id, String add_id) {
        return lectureRequestDao.getLectureRequestOneLectureIdAndAddId(lecture_id, add_id);
    }

    /**
     * 강좌에 추첨대기인 신청자 리스트 리턴
     */
    public List<LectureRequest> getRaffleLectureRequestList(String lecture_id) {
        return lectureRequestDao.getLectureRequestRaffleListByLectureId(lecture_id);
    }

    /**
     * 추첨내역 저장
     */
    @Transactional
    @WorkingLogger(comment = "신청자 추첨정보 업데이트", type = "P")
    public boolean saveRaffleLectureRequest(LectureRequest lectureRequest) {
        List<LectureRequest> raffleList = lectureRequestDao.getLectureRequestListByLectureIdAndStatus(lectureRequest.getHomepage_id(), lectureRequest.getLecture_id(), "대기", "온라인");
        int remainCount = getLectureRequestOnlinePersonCount(lectureRequest);

        // 대기자가 없거나, 온라인 남은 온라인 모집인원이 없을 경우 false 리턴
        if (raffleList == null || raffleList.size() <= 0) return false;
        if (remainCount <= 0) return false;

        // 대기자 리스트 섞기
        Collections.shuffle(raffleList);

        for (LectureRequest request : raffleList) {
            request.setRequest_status("예약완료");
            lectureRequestDao.updateRequestStatus(request);
            remainCount--;
            if (remainCount <= 0) break;
        }

        return true;
    }

    /**
     * request_type 으로 신청자 정보를 조회할 수 있는 서비스
     */
    @Transactional(readOnly = true)
    @WorkingLogger(comment = "신청자 정보 조회", type = "P")
    public List<LectureRequest> getLectureRequestListForApplicant(String homepage_id, String lecture_id, String applicant_type) {
        if (applicant_type.equals("오프라인")) {
            return lectureRequestDao.getLectureRequestListByLectureIdAndStatus(homepage_id, lecture_id, "예약완료", "오프라인");
        } else if (applicant_type.equals("온라인")) {
            return lectureRequestDao.getLectureRequestListByLectureIdAndStatus(homepage_id, lecture_id, "예약완료", "온라인");
        } else {
            return lectureRequestDao.getLectureRequestListByLectureIdAndStatus(homepage_id, lecture_id, "대기", "온라인");
        }
    }

    /**
     * 예약상태 변경 서비스
     */
    @Transactional(readOnly = true)
    @WorkingLogger(comment = "예약 상태 변경", type = "P")
    public int changeStatus(LectureRequest lectureRequest) {
        int updateCnt = lectureRequestDao.changeLectureRequestStatus(lectureRequest);

        if (updateCnt == 1) {
            LectureRequest requestOne = lectureRequestDao.getLectureRequestOne(lectureRequest.getRequest_id());
            LectureInfo lectureOne = lectureInfoService.lectureInfoOne(requestOne.getLecture_id());

            sendMessageService.printMessage(requestOne.getRequest_name(), requestOne.getPhone_number(), lectureOne.getLecture_title(), lectureOne.getSupporter_name(), lectureOne.getSupporter_tel(), requestOne.getRequest_status(), "예약상태가 변경되었습니다.");
        }

        return updateCnt;
    }

    /**
     * 신청할 수 있는 남은 강좌 수 확인
     */
    @Transactional(readOnly = true)
    @WorkingLogger(comment = "신청할 수 있는 강좌수 조회", type = "P")
    public int getMyLeftLectureRequestCount(LectureRequest lectureRequest) {
        return lectureRequestDao.getMyLeftLectureRequestCount(lectureRequest);
    }

    /**
     * id로 신청자 목록 조회
     */
    @WorkingLogger(comment = "신청자 목록 조회", type = "P")
    @Transactional
    public List<LectureRequest> getLectureRequestListByRequestIdList(List<String> requestIdList) {
        return lectureRequestDao.getLectureRequestListByRequestIdList(requestIdList);
    }

    /**
     * 예약불참으로 변경
     * */
    @WorkingLogger(comment = "예약상태 예약불참으로 변경")
    @Transactional
    public int changeNoAttendance(LectureRequest lectureRequest, String member_id, String session_ip) {
        lectureRequest.setCancel_id(member_id);
        lectureRequest.setCancel_ip(session_ip);
        lectureRequest.setCancel_yn("Y");
        lectureRequest.setRequest_status("예약불참");

        int updateCnt = lectureRequestDao.cancelLectureRequest(lectureRequest);

        if (updateCnt == 1) {
            LectureRequest requestOne = lectureRequestDao.getLectureRequestOne(lectureRequest.getRequest_id());
            LectureInfo lectureOne = lectureInfoService.lectureInfoOne(requestOne.getLecture_id());

            sendMessageService.printMessage(requestOne.getRequest_name(), requestOne.getPhone_number(), lectureOne.getLecture_title(), lectureOne.getSupporter_name(), lectureOne.getSupporter_tel(), requestOne.getRequest_status(), "예약상태가 예약불참으로 변경되었습니다.");
        }

        return updateCnt;
    }
}
