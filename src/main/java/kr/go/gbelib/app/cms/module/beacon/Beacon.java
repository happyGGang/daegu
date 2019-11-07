package kr.go.gbelib.app.cms.module.beacon;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Beacon extends PagingUtils {
	
	private int tid;                  // 비콘 키
	private String lib_code;          // 도서관 코드
	private String uuid = "EBEFD083-70A2-47C8-9837-E7B5634DF524";              // 비콘 기기값(고정)
	private int major = 1;                // 비콘 MAJOR
	private int minor;                // 비콘 MINOR
	private String distance = "CLProximityNear";          // 비콘 거리 
	private String type;              // 타입 (INSERT 시 CLProximityNear 으로 입력) "타입 : (텍스트-단순 텍스트 표출,공지-URL에는 이미지 URL입력 CONTENT에는 내용 입력,바로가기 - URL에는 이동 URL입력 CONTENT에는 내용 입력)"
	private String content;           // 내용        
	private String url;               // 링크 URL   
	private String udate;             // 수정일자     
	private String atch_file_id;      // 파일첨부 키   
	private String mod_id;            // 수정자 아이디  
	private String mod_nm;            // 수정자 이름   
	private String mod_ip;            // 수정자 IP  
	
	private String place_info;  //비콘의 실별
	
	private MultipartFile file;
	                                   
	private String lib_name;          // 도서관명  
	
	public Beacon() {}

	public String getLib_code() {
		return lib_code;
	}

	public void setLib_code(String lib_code) {
		this.lib_code = lib_code;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public int getMajor() {
		return major;
	}

	public void setMajor(int major) {
		this.major = major;
	}

	public int getMinor() {
		return minor;
	}

	public void setMinor(int minor) {
		this.minor = minor;
	}

	public String getDistance() {
		return distance;
	}

	public void setDistance(String distance) {
		this.distance = distance;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUdate() {
		return udate;
	}

	public void setUdate(String udate) {
		this.udate = udate;
	}

	public String getAtch_file_id() {
		return atch_file_id;
	}

	public void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public String getMod_nm() {
		return mod_nm;
	}

	public void setMod_nm(String mod_nm) {
		this.mod_nm = mod_nm;
	}

	public String getMod_ip() {
		return mod_ip;
	}

	public void setMod_ip(String mod_ip) {
		this.mod_ip = mod_ip;
	}

	public String getLib_name() {
		return lib_name;
	}

	public void setLib_name(String lib_name) {
		this.lib_name = lib_name;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getPlace_info() {
		return place_info;
	}

	public void setPlace_info(String place_info) {
		this.place_info = place_info;
	}
}
