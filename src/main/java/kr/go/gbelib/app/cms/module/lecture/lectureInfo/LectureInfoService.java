package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfo;
import kr.go.gbelib.app.cms.module.lecture.courseInfo.CourseInfoDao;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.file.LectureInfoFile;
import kr.go.gbelib.app.cms.module.lecture.lectureInfo.file.LectureInfoFileDao;
import kr.go.gbelib.app.cms.module.lecture.lectureRequest.LectureRequestDao;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.util.List;

@Service
public class LectureInfoService extends BaseService {

    @Autowired
    private LectureInfoDao lectureInfoDao;

    @Autowired
    private CourseInfoDao courseInfoDao;

    @Autowired
    private LectureInfoFileDao lectureInfoFileDao;

    @Autowired
    LectureRequestDao lectureRequestDao;

    @Autowired
    @Qualifier("lectureInfoStorage")
    private FileStorage lectureInfoStorage;

    /**
     * 강좌 정보 등록
     * */
    @Transactional
    @WorkingLogger(comment="강좌 정보 등록", type="P")
    public void addLectureInfo(LectureInfo lectureInfo, String sessionMemberId, String remoteAddr, MultipartHttpServletRequest mpRequest) {
        lectureInfo.setAdd_id(sessionMemberId);
        lectureInfo.setAdd_ip(remoteAddr);
        lectureInfoDao.addLectureInfo(lectureInfo);
        multipartFile(lectureInfo, mpRequest);
    }

    /**
     * 강좌 정보 수정
     * */
    @Transactional
    @WorkingLogger(comment="강좌 정보 수정", type="P")
    public void updateLectureInfo(LectureInfo lectureInfo, MultipartHttpServletRequest mpRequest) {
        MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");
        if(mFile != null) {
            deleteFile(lectureInfo);
            multipartFile(lectureInfo, mpRequest);
        }
        lectureInfoDao.updateLectureInfo(lectureInfo);
    }

    /**
     * 과정 목록 가져오기
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="강좌페이지에서 과정 목록 조회", type="P")
    public List<CourseInfo> courseInfoIdList(String homepage_id) {
        return courseInfoDao.getCourseInfoListNoPaging(homepage_id);
    }

    /**
     * 강좌 목록 가져오기
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="강좌 목록 조회", type="P")
    public List<LectureInfo> lectureInfoList(LectureInfo lectureInfo) {
        return lectureInfoDao.getLectureInfoList(lectureInfo);
    }

    /**
     * 강좌 수 가져오기(과정별)
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="강좌 수 가져오기", type="P")
    public int lectureInfoCount(LectureInfo lectureInfo) {
        return lectureInfoDao.getLectureInfoCount(lectureInfo);
    }

    /**
     * 강좌 수 가져오기(과정별)
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="강좌 수 가져오기", type="P")
    public int lectureInfoCount(String homepage_id, String course_id) {
        return lectureInfoDao.getLectureInfoCountByHomepageIdAndCourseId(homepage_id, course_id);
    }

    /**
     * 강좌 정보 하나 가져오기
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="강좌 정보 하나 가져오기", type="P")
    public LectureInfo lectureInfoOne(String lecture_id, String connect_type) {
        return lectureInfoDao.getLectureInfoOne(lecture_id, connect_type);
    }

    /**
     * 검색을 위한 준비
     * */
    public void setSearchingData(LectureInfo lectureInfo) {
        // 과정을 선택하지 않았다면
        if(lectureInfo.getSearching_course_id() == null || lectureInfo.getSearching_course_id().equals("")){
            CourseInfo courseInfo = courseInfoDao.getLatestCourseInfo(lectureInfo.getHomepage_id());
            if(courseInfo != null) {
                lectureInfo.setSearching_course_id(courseInfo.getCourse_id());
            }

        }
        lectureInfo.setSearch_type("lecture_title");
    }

    /**
     * 첨부파일 추가
     * */
    @WorkingLogger(comment="강좌 첨부파일 추가", type="P")
    public void multipartFile(LectureInfo lectureInfo, MultipartHttpServletRequest mpRequest) {
        MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");

        if( mFile != null ) {
            String serverFileName 	= Long.toString((System.currentTimeMillis()));
            String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
            String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
            String filePath 		= "/" + lectureInfo.getHomepage_id();

            File f = lectureInfoStorage.addFile(mFile, serverFileName+"."+fileExtension, filePath);

            LectureInfoFile lectureInfoFile =
                    new LectureInfoFile(lectureInfo.getLecture_id(), fileName+"."+fileExtension, serverFileName+"."+fileExtension);
            lectureInfoFile.setHomepage_id(lectureInfo.getHomepage_id());

            lectureInfoFileDao.addLectureInfoFile(lectureInfoFile);
        }
    }

    /**
     * 강좌 첨부파일 파일 가져오기
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="강좌 첨부파일 하나 조회", type="P")
    public LectureInfoFile lectureInfoFile(LectureInfo lectureInfo) {
        LectureInfoFile fileEntity = lectureInfoFileDao.getLectureInfoFile(lectureInfo);
        String homepage_id = lectureInfo.getHomepage_id();

        if(fileEntity != null) {
            String rootPath = lectureInfoStorage.getRootPath();
            fileEntity.setPath(rootPath + "/" + homepage_id + "/" + fileEntity.getFile_server_name());
        }

        return fileEntity;
    }

    /**
     * 파일이 저장된 루트
     * */
    public String getRootPath() {
        return lectureInfoStorage.getRootPath();
    }


    /**
     * 서버 이름으로 파일 가져오기
     * */
    @Transactional(readOnly = true)
    @WorkingLogger(comment="강좌 첨부파일 하나 조회", type="P")
    public LectureInfoFile lectureInfoFile(String server_file_name) {
        return lectureInfoFileDao.getLectureInfoFileByServerName(server_file_name);
    }

    /**
     * 강좌 삭제
     * */
    @Transactional
    @WorkingLogger(comment="강좌 삭제", type="P")
    public void deleteLectureInfo(LectureInfo lectureInfo) {
        deleteFile(lectureInfo);
        lectureInfoDao.deleteLectureInfo(lectureInfo);
    }

    /**
     *
     * */
    @Transactional
    @WorkingLogger(comment="강좌 첨부파일 삭제", type="P")
    public void deleteFile(LectureInfo lectureInfo) {
        LectureInfoFile lectureInfoFile = lectureInfoFileDao.getLectureInfoFile(lectureInfo);
        if(lectureInfoFile != null) {
            String fileName = lectureInfoFile.getFile_server_name();
            String filePath = lectureInfoFile.getHomepage_id();
            lectureInfoStorage.deleteFile(fileName, filePath);
            lectureInfoFileDao.deleteFile(lectureInfoFile);
        }
    }

    /**
     * 강좌에 연결된 인원이 있는지
     * */
    @WorkingLogger(comment="강좌에 등록된 유저 수 조회", type="P")
    public boolean isRequestInLecture(LectureInfo lectureInfo) {
        if(lectureRequestDao.getRequestCountByLectureId(lectureInfo.getLecture_id()) > 0)
            return true;
        return false;
    }

    /**
     * 유저의 수강신청 강좌 목록 가져오기
     * */
    @WorkingLogger(comment="유저의 수강신청 강좌 목록 조회", type="P")
    public List<LectureInfo> getMyLectureInfoList(LectureInfo lectureInfo) {
        return lectureInfoDao.getLectureInfoListByRequestAddId(lectureInfo);
    }

    /**
     * 유저의 수강신청 강좌 목록 수
     * */
    @WorkingLogger(comment="유저의 수강신청 목록 수 조회", type="P")
    public int getMyLectureInfoCount(LectureInfo lectureInfo) {
        return lectureInfoDao.getLectureInfoCountByRequestAddId(lectureInfo);
    }

    /**
     * 진행중인 과정의 강좌 리스트
     * */
    @WorkingLogger(comment="진행중인 과정 강좌 리스트 조회", type="P")
    @Transactional
    public List<LectureInfo> getOngoingCourseLectureInfoList(LectureInfo lectureInfo) {
        return lectureInfoDao.getOngoingCourseLectureInfoList(lectureInfo);
    }

    /**
     * 진행중인 과정의 강좌 수
     * */
    @WorkingLogger(comment="진행중인 과정 강좌 수 조회", type="P")
    @Transactional
    public int getOngoingCourseLectureInfoCount(LectureInfo lectureInfo) {
        return lectureInfoDao.getOngoingCourseLectureInfoCount(lectureInfo);
    }
}