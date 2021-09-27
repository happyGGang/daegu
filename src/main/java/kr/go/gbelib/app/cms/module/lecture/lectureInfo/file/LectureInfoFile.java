package kr.go.gbelib.app.cms.module.lecture.lectureInfo.file;

import kr.co.whalesoft.framework.utils.BeanUtils;

import java.util.Date;

public class LectureInfoFile extends BeanUtils {

    private String lecture_id;
    private String file_original_name;
    private String file_server_name;
    private Date add_date;
    private String path;

    public LectureInfoFile() {}

    public LectureInfoFile(String lecture_id, String file_original_name, String file_server_name) {
        this.lecture_id = lecture_id;
        this.file_original_name = file_original_name;
        this.file_server_name = file_server_name;
    }

    public String getLecture_id() {
        return lecture_id;
    }

    public void setLecture_id(String lecture_id) {
        this.lecture_id = lecture_id;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getFile_original_name() {
        return file_original_name;
    }

    public void setFile_original_name(String file_original_name) {
        this.file_original_name = file_original_name;
    }

    public String getFile_server_name() {
        return file_server_name;
    }

    public void setFile_server_name(String file_server_name) {
        this.file_server_name = file_server_name;
    }

    public Date getAdd_date() {
        return add_date;
    }

    public void setAdd_date(Date add_date) {
        this.add_date = add_date;
    }
}
