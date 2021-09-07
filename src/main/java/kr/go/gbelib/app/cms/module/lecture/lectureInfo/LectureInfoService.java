package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
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
    private LectureInfoDao dao;

    @Autowired
    @Qualifier("lectureInfoStorage")
    private FileStorage fileStorage;


    public int getLectureInfoCount(LectureInfo lectureInfo) {
        return dao.getLectureInfoCount(lectureInfo);
    }

    public List<LectureInfo> getLectureInfoList(LectureInfo lectureInfo) {
        return dao.getLectureInfoList(lectureInfo);
    }

    public LectureInfo getLectureInfoOne(LectureInfo lectureInfo) {
        LectureInfo returnLectureInfo = dao.getLectureInfoOne(lectureInfo);

        if(returnLectureInfo.getEdu_start_time() != null && !returnLectureInfo.getEdu_start_time().equals("")) {
            String edu_start_time_array[] = returnLectureInfo.getEdu_start_time().split(":");

            returnLectureInfo.setEdu_start_time_1(edu_start_time_array[0]);
            returnLectureInfo.setEdu_start_time_2(edu_start_time_array[1]);
        }

        if(returnLectureInfo.getEdu_end_time() != null && !returnLectureInfo.getEdu_end_time().equals("")) {
            String edu_end_time_array[] = returnLectureInfo.getEdu_end_time().split(":");

            returnLectureInfo.setEdu_end_time_1(edu_end_time_array[0]);
            returnLectureInfo.setEdu_end_time_2(edu_end_time_array[1]);
        }

        if(returnLectureInfo.getDay_week() != null && !returnLectureInfo.getDay_week().equals("")) {
            returnLectureInfo.setDay_week_array(returnLectureInfo.getDay_week().split(","));
        }

        if(returnLectureInfo.getEdu_category() != null && !returnLectureInfo.getEdu_category().equals("")) {
            returnLectureInfo.setEdu_category_array(returnLectureInfo.getEdu_category().split(","));
        }

        if(returnLectureInfo.getEdu_target() != null && !returnLectureInfo.getEdu_target().equals("")) {
            returnLectureInfo.setEdu_target_array(returnLectureInfo.getEdu_target().split(","));
        }

        return returnLectureInfo;
    }

    @Transactional
    public int insertLectureInfo(LectureInfo lectureInfo, MultipartHttpServletRequest mpRequest) {

        lectureInfo.setEdu_start_time(lectureInfo.getEdu_start_time_1() + ":" + lectureInfo.getEdu_start_time_2());
        lectureInfo.setEdu_end_time(lectureInfo.getEdu_end_time_1() + ":" + lectureInfo.getEdu_end_time_2());

        if(dao.insertLectureInfo(lectureInfo) > 0) {
            MultipartFile mFile = null;

            for(int i=1; i<=lectureInfo.getFile_count(); i++) {
                mFile = mpRequest.getFileMap().get("file_array_" + i);

                if(mFile != null) {
                    String fileName = mFile.getOriginalFilename();
                    String filePath = "/";

                    String serverFileName = fileStorage.getServerFileName(fileName);

                    File f = fileStorage.addFile(mFile, serverFileName, filePath);
                    lectureInfo.setFile_original_name(fileName);
                    lectureInfo.setFile_server_name(f.getName());

                    dao.insertLectureInfoFile(lectureInfo);
                }
            }
        }

        return 1;
    }

    @Transactional
    public int updateLectureInfo(LectureInfo lectureInfo, MultipartHttpServletRequest mpRequest) {

        lectureInfo.setEdu_start_time(lectureInfo.getEdu_start_time_1() + ":" + lectureInfo.getEdu_start_time_2());
        lectureInfo.setEdu_end_time(lectureInfo.getEdu_end_time_1() + ":" + lectureInfo.getEdu_end_time_2());

        if(dao.updateLectureInfo(lectureInfo) > 0) {
            if(lectureInfo.getDelete_file_list() != null && lectureInfo.getDelete_file_list().size() > 0) {
                dao.deleteLectureInfoFile(lectureInfo);
            }

            MultipartFile mFile = null;

            for(int i=1; i<=lectureInfo.getFile_count(); i++) {
                mFile = mpRequest.getFileMap().get("file_array_" + i);

                if(mFile != null) {
                    String fileName = mFile.getOriginalFilename();
                    String filePath = "/";

                    String serverFileName = fileStorage.getServerFileName(fileName);

                    File f = fileStorage.addFile(mFile, serverFileName, filePath);
                    lectureInfo.setFile_original_name(fileName);
                    lectureInfo.setFile_server_name(f.getName());

                    dao.insertLectureInfoFile(lectureInfo);
                }
            }
        }

        return 1;
    }

    @Transactional
    public int deleteLectureInfo(LectureInfo lectureInfo) {
        if(dao.deleteLectureInfo(lectureInfo) > 0) {
            dao.deleteLectureInfoFileAll(lectureInfo);
            dao.deleteLectureRequest(lectureInfo);
        }

        return 1;
    }

    public List<LectureInfo> getLectureInfoFileList(LectureInfo lectureInfo) {
        return dao.getLectureInfoFileList(lectureInfo);
    }

    public LectureInfo getLectureInfoFileOne(LectureInfo lectureInfo) {
        return dao.getLectureInfoFileOne(lectureInfo);
    }

}
