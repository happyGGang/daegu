package kr.go.gbelib.app.cms.module.lecture.courseInfo;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.co.whalesoft.framework.utils.PagingUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.List;

@Service
public class CourseInfoService extends BaseService {

    @Autowired
    private CourseInfoDao courseInfoDao;

    /**
     * 강좌 좌정 리스트 조회
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="강좌 과정 리스트 조회", type="P")
    public List<CourseInfo> courseInfoList(CourseInfo courseInfo) {
        return courseInfoDao.getCourseInfoList(courseInfo);
    }

    /**
     * 강좌 과정 개수 조회
     * */
    @WorkingLogger(comment="강좌 과정 개수 조회", type="P")
    @Transactional(readOnly = true)
    public int courseInfoCount(CourseInfo courseInfo) {
        return courseInfoDao.getCourseInfoCount(courseInfo);
    }

    /**
     * 강좌 과정 페이징
     * */
    public void setPaging(Model model, int totalDataCount, PagingUtils pagingUtils) {
        pagingUtils.setTotalDataCount(totalDataCount);
        model.addAttribute("paging", pagingUtils);
    }

    /**
     * 강좌 과정 추가
     * */
    @WorkingLogger(comment="강좌 과정 추가", type="P")
    @Transactional
    public void addCourseInfo(CourseInfo courseInfo, String add_id, String add_ip) {

        courseInfo.setAdd_id(add_id);
        courseInfo.setAdd_ip(add_ip);

        courseInfoDao.addCourseInfo(courseInfo);
    }

    /**
     * 강좌 과정 하나 가져오기
     * */
    @WorkingLogger(comment="강좌 과정 조회", type="P")
    @Transactional(readOnly = true)
    public CourseInfo setCourseInfo(String course_id) {
        return courseInfoDao.getCourseInfo(course_id);
    }

    /**
     * 강좌 과정 수정
     * */
    @WorkingLogger(comment="강좌 과정 수정", type="P")
    @Transactional
    public void updateCourse(CourseInfo courseInfo) {
        courseInfoDao.updateCourseInfo(courseInfo);
    }

    /**
     * 강좌 과정 삭제
     * */
    @WorkingLogger(comment="강좌 과정 삭제", type="P")
    @Transactional
    public void deleteCourseInfo(CourseInfo courseInfo) {
        courseInfoDao.deleteCourseInfo(courseInfo);
    }


    /**
     * 과정 기간 중복되는 과정 수
     * */
    @WorkingLogger(comment="과정 기간 중복되는 과정 수 조회", type="P")
    @Transactional(readOnly = true)
    public int getOverlapCourseInfoCount(CourseInfo courseInfo) {
        return courseInfoDao.getOverlapCourseInfoCount(courseInfo);
    }

    /**
     * 현재 노출기간에 포함된 사용중인 과정 리턴
     * */
    @WorkingLogger(comment="현재 노출 기간에 포함된 사용중인 과정 조회", type="P")
    @Transactional(readOnly = true)
    public CourseInfo getOngoingCourseInfoOne(String homepage_id) {
        return courseInfoDao.getOngoingCourseInfoOne(homepage_id);
    }

    /**
     * course_id로 과정 하나 조회
     * */
    @WorkingLogger(comment="과정 하나 조회", type="P")
    @Transactional(readOnly = true)
    public CourseInfo getCourseInfoByCourseId(String course_id) {
        return courseInfoDao.getCourseInfo(course_id);
    }


    /**
     * 강좌 과정 등록 사용 불가 날짜 리턴
     * */
    /*public List<String> getDisabledDays(CourseInfo courseInfo) throws ParseException {
        List<CourseInfo> courseInfoList = courseInfoDao.getReservedCourseDates(courseInfo);
        List<String> disableDates = new ArrayList<String>();
        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();

        for (CourseInfo entity : courseInfoList ) {
            Date view_start_date = transFormat.parse(entity.getView_start_date());
            cal.setTime(view_start_date);

            int day_count = entity.getDay_count();
            cal.add(Calendar.DATE, -1);

            for(int i = 0; i < day_count; i++) {
                cal.add(Calendar.DATE, 1);
                disableDates.add(transFormat.format(cal.getTime()));
            }
        }

        return disableDates;
    }*/
}
