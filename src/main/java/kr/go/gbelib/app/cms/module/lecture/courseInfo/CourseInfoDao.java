package kr.go.gbelib.app.cms.module.lecture.courseInfo;

import java.util.List;

public interface CourseInfoDao {
    List<CourseInfo> getCourseInfoList(CourseInfo courseInfo);

    int getCourseInfoCount(CourseInfo courseInfo);

    void addCourseInfo(CourseInfo courseInfo);

    CourseInfo getCourseInfo(String course_id);

    void updateCourseInfo(CourseInfo courseInfo);

    void deleteCourseInfo(CourseInfo courseInfo);

    List<CourseInfo> getCourseInfoListNoPaging(String homepage_id);

    CourseInfo getLatestCourseInfo(String homepage_id);

    List<CourseInfo> getReservedCourseDates(CourseInfo courseInfo);

    int getOverlapCourseInfoCount(CourseInfo courseInfo);

    CourseInfo getOngoingCourseInfoOne(String homepage_id);
}
