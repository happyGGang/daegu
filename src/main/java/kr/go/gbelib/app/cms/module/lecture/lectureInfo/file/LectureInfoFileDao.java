package kr.go.gbelib.app.cms.module.lecture.lectureInfo.file;

import kr.go.gbelib.app.cms.module.lecture.lectureInfo.LectureInfo;

public interface LectureInfoFileDao {

    void addLectureInfoFile(LectureInfoFile lectureInfoFile);

    LectureInfoFile getLectureInfoFile(LectureInfo lectureInfo);

    LectureInfoFile getLectureInfoFileByServerName(String file_server_name);

    void deleteFile(LectureInfoFile lectureInfoFile);
}
