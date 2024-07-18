package kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion;

import kr.co.whalesoft.framework.utils.PagingUtils;
import org.springframework.web.multipart.MultipartFile;

public class CheckInOutSurveyQuestion extends PagingUtils {

	private String homepage_id;  //홈페이지ID
	private int checkinout_survey_idx;  //설문조사IDX
	private int checkinout_survey_question_idx;  //설문조사문항IDX
	private String checkinout_survey_question_title;  //설문조사문항제목
	private String checkinout_survey_question_type;  //설문조사문항타입
	private String checkinout_survey_question_item;  //설문조사문항보기

	private MultipartFile checkinout_survey_file;
	private String origin_file_name; // 원본파일명
	private String server_file_name; // 서버파일명
	private String file_extension; // 파일확장자
	private long file_size; // 파일크기

	public CheckInOutSurveyQuestion() {
	}

	public CheckInOutSurveyQuestion(String homepage_id, int checkinout_survey_idx) {
		setHomepage_id(homepage_id);
		this.checkinout_survey_idx = checkinout_survey_idx;
	}

	@Override
	public String getHomepage_id() {
		return homepage_id;
	}

	@Override
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getCheckinout_survey_idx() {
		return checkinout_survey_idx;
	}

	public void setCheckinout_survey_idx(int checkinout_survey_idx) {
		this.checkinout_survey_idx = checkinout_survey_idx;
	}

	public int getCheckinout_survey_question_idx() {
		return checkinout_survey_question_idx;
	}

	public void setCheckinout_survey_question_idx(int checkinout_survey_question_idx) {
		this.checkinout_survey_question_idx = checkinout_survey_question_idx;
	}

	public String getCheckinout_survey_question_title() {
		return checkinout_survey_question_title;
	}

	public void setCheckinout_survey_question_title(String checkinout_survey_question_title) {
		this.checkinout_survey_question_title = checkinout_survey_question_title;
	}

	public String getCheckinout_survey_question_type() {
		return checkinout_survey_question_type;
	}

	public void setCheckinout_survey_question_type(String checkinout_survey_question_type) {
		this.checkinout_survey_question_type = checkinout_survey_question_type;
	}

	public String getCheckinout_survey_question_item() {
		return checkinout_survey_question_item;
	}

	public void setCheckinout_survey_question_item(String checkinout_survey_question_item) {
		this.checkinout_survey_question_item = checkinout_survey_question_item;
	}

	public MultipartFile getCheckinout_survey_file() {
		return checkinout_survey_file;
	}

	public void setCheckinout_survey_file(MultipartFile checkinout_survey_file) {
		this.checkinout_survey_file = checkinout_survey_file;
	}

	public String getOrigin_file_name() {
		return origin_file_name;
	}

	public void setOrigin_file_name(String origin_file_name) {
		this.origin_file_name = origin_file_name;
	}

	public String getServer_file_name() {
		return server_file_name;
	}

	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}

	public String getFile_extension() {
		return file_extension;
	}

	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
}

