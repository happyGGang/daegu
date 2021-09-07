package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import java.util.List;

public interface LectureInfoDao {

    public int getLectureInfoCount(LectureInfo lectureInfo);

    public List<LectureInfo> getLectureInfoList(LectureInfo lectureInfo);

    public LectureInfo getLectureInfoOne(LectureInfo lectureInfo);

    public int insertLectureInfo(LectureInfo lectureInfo);

    public int updateLectureInfo(LectureInfo lectureInfo);

    public int deleteLectureInfo(LectureInfo lectureInfo);

    public List<LectureInfo> getLectureInfoFileList(LectureInfo lectureInfo);

    public List<LectureInfo> getLectureInfoImageFileList(LectureInfo lectureInfo);

    public LectureInfo getLectureInfoFileOne(LectureInfo lectureInfo);

    public int insertLectureInfoFile(LectureInfo lectureInfo);

    public int deleteLectureInfoFile(LectureInfo lectureInfo);

    public int deleteLectureInfoFileAll(LectureInfo lectureInfo);

    public int deleteLectureRequest(LectureInfo lectureInfo);

}
