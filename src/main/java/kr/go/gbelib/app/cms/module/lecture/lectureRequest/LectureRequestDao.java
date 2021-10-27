package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import java.util.List;

public interface LectureRequestDao {
    int getLectureRequestCount(LectureRequest lectureRequest);

    List<LectureRequest> getLectureRequestList(LectureRequest lectureRequest);

    LectureRequest getLectureRequestOne(String request_id);

    int addLectureRequest(LectureRequest lectureRequest);

    void updateLectureRequest(LectureRequest lectureRequest);

    int cancelLectureRequest(LectureRequest lectureRequest);

    int getLectureRequestOnlinePersonCount(LectureRequest lectureRequest);

    int getLectureRequestOfflinePersonCount(LectureRequest lectureRequest);

    int getLectureRequestWaitPersonCount(LectureRequest lectureRequest);

    int getMyLectureRequestCountOfLectureInfo(LectureRequest lectureRequest);

    int getRequestCountByLectureId(String lecture_id);

    void reapplyLectureRequest(LectureRequest lectureRequest);

    LectureRequest getLectureRequestOneLectureIdAndAddId(String lecture_id, String add_id);

    List<LectureRequest> getLectureRequestRaffleListByLectureId(String lecture_id);

    void updateRequestStatus(LectureRequest request);

    List<LectureRequest> getLectureRequestListByLectureIdAndStatus(String homepage_id, String lecture_id, String request_status, String request_type);

    int changeLectureRequestStatus(LectureRequest lectureRequest);

    int getMyLeftLectureRequestCount(LectureRequest lectureRequest);

    int changePriorityWait(LectureRequest lectureRequest);

    LectureRequest getPriorityWaitRequest(LectureRequest lectureRequest);

    List<LectureRequest> getLectureRequestListByRequestIdList(List<String> requestIdList);
}
