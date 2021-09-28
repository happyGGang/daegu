package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import java.util.List;

public interface LectureRequestDao {
    int getLectureRequestCount(LectureRequest lectureRequest);

    List<LectureRequest> getLectureRequestList(LectureRequest lectureRequest);

    LectureRequest getLectureRequestOne(String request_id);

    void addLectureRequest(LectureRequest lectureRequest);

    void updateLectureRequest(LectureRequest lectureRequest);

    void cancelLectureRequest(LectureRequest lectureRequest);
}
