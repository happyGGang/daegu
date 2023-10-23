package kr.go.gbelib.app.cms.module.api;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "internationalDataRoom_teach_list")
public class InternationalTeachXmlResult {

	private String teach_title = "";
	private int limit_count;
	private int backup_count;
	private String teach_date = "";
	private String teach_dayweek = "";
	private String join_date = "";
	private String category = "";
	private String contents = "";
	private String teach_stage = "";
	private String teacher = "";
	private String teach_etc = "";
	private String teach_target = "";
	private String file_name = "";
	private String image_url = "";
	
	private String message = "";
	
	InternationalTeachXmlResult() { }

	InternationalTeachXmlResult(String teach_title, int limit_count, int backup_count, String teach_date, String teach_dayweek,
								String join_date, String category, String contents, String teach_stage, String teacher,
								String teach_etc, String teach_target, String file_name, String image_url, String message) {
		this.teach_title = teach_title;
		this.limit_count = limit_count;
		this.backup_count = backup_count;
		this.teach_date = teach_date;
		this.teach_dayweek = teach_dayweek;
		this.join_date = join_date;
		this.category = category;
		this.contents = contents;
		this.teach_stage = teach_stage;
		this.teacher = teacher;
		this.teach_etc = teach_etc;
		this.teach_target = teach_target;
		this.file_name = file_name;
		this.image_url = image_url;
		this.message = message;
	}
	
	public String getMessage() {
		return message;
	}

	@XmlElement
	public void setMessage(String message) {
		this.message = message;
	}

	public String getTeach_title() {
		return teach_title;
	}

	@XmlElement
	public void setTeach_title(String teach_title) {
		this.teach_title = teach_title;
	}

	public int getLimit_count() {
		return limit_count;
	}

	@XmlElement
	public void setLimit_count(int limit_count) {
		this.limit_count = limit_count;
	}

	public int getBackup_count() {
		return backup_count;
	}

	@XmlElement
	public void setBackup_count(int backup_count) {
		this.backup_count = backup_count;
	}

	public String getTeach_date() {
		return teach_date;
	}

	@XmlElement
	public void setTeach_date(String teach_date) {
		this.teach_date = teach_date;
	}

	public String getTeach_dayweek() {
		return teach_dayweek;
	}

	@XmlElement
	public void setTeach_dayweek(String teach_dayweek) {
		this.teach_dayweek = teach_dayweek;
	}

	public String getJoin_date() {
		return join_date;
	}

	@XmlElement
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getCategory() {
		return category;
	}

	@XmlElement
	public void setCategory(String category) {
		this.category = category;
	}

	public String getContents() {
		return contents;
	}

	@XmlElement
	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getTeach_stage() {
		return teach_stage;
	}

	@XmlElement
	public void setTeach_stage(String teach_stage) {
		this.teach_stage = teach_stage;
	}

	public String getTeacher() {
		return teacher;
	}

	@XmlElement
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public String getTeach_etc() {
		return teach_etc;
	}

	@XmlElement
	public void setTeach_etc(String teach_etc) {
		this.teach_etc = teach_etc;
	}

	public String getTeach_target() {
		return teach_target;
	}

	@XmlElement
	public void setTeach_target(String teach_target) {
		this.teach_target = teach_target;
	}

	public String getFile_name() {
		return file_name;
	}
	
	@XmlElement
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getImage_url() {
		return image_url;
	}

	@XmlElement
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	
}
