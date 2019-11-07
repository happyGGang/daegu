package kr.co.whalesoft.app.cms.projectManage;

import org.springframework.web.multipart.MultipartFile;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class ProjectManage extends PagingUtils {

	private int req_idx;  //접수IDX
	private String type;  //종류
	private String title;  //제목
	private String contents;  //내용
	private String file_name;  // 파일명
	private String status;  //상태
	private String person;  //담당자
	private String add_date;  //등록일
	private String end_date;  //완료일
	
	private MultipartFile file;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public int getReq_idx() {
		return req_idx;
	}
	public void setReq_idx(int req_idx) {
		this.req_idx = req_idx;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
}