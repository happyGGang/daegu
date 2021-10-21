package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import java.util.List;

public interface LectureInfoDao {
    List<LectureInfo> getLectureInfoList(LectureInfo lectureInfo);

    int getLectureInfoCount(LectureInfo lectureInfo);

    void addLectureInfo(LectureInfo lectureInfo);

    LectureInfo getLectureInfoOne(String lecture_id);

    void updateLectureInfo(LectureInfo lectureInfo);

    void deleteLectureInfo(LectureInfo lectureInfo);

    int getLectureInfoCountByHomepageIdAndCourseId(String homepage_id, String course_id);

    List<LectureInfo> getLectureInfoListByHomepageIdAndCourseId(String homepage_id, String course_id);

    List<LectureInfo> getLectureInfoListByRequestAddId(LectureInfo lectureInfo);

    int getLectureInfoCountByRequestAddId(LectureInfo lectureInfo);

    List<LectureInfo> getOngoingCourseLectureInfoList(LectureInfo lectureInfo);

    int getOngoingCourseLectureInfoCount(LectureInfo lectureInfo);

}
