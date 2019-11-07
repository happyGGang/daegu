package kr.co.whalesoft.app.cms.module.support;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Support extends PagingUtils {
	
	private String homepage_id;        //홈페이지ID   
	private int seq;                   //일련번호
	private String req_type;           //신청구분
	private String req_id;             //신청기관ID
	private String req_name;           //신청기관명
	private String req_organ_div;      //신청기관구분
	private String req_organ_code;     //신청기관코드
	private String req_tel;            //신청기관연락처
	private String requer_name;        //신청자이름
	private String requer_tel;         //신청자휴대폰
	private String requer_tel1;         //신청자휴대폰
	private String requer_tel2;         //신청자휴대폰
	private String requer_tel3;         //신청자휴대폰
	private String req_email;          //신청자이메일
	private String req_title;          //신청제목
	private String req_content;        //신청내용
	private String req_ip;             //신청IP
	private String hope_req_dt;          //신청희망일자
	private String student_id;         //학생ID
	private String pc_spec;            //PC사양
	private String crt_dt;               //신청일자
	private String support_div;        //지원구분
	private String supporter;          //지원자
	private String support_clerk;      //지원담당
	private String supporter_tel;      //지원자연락처
	private String subcontractor;      //협력업체
	private String support_content;    //지원내용
	private String support_content2;   //시스템관리운영교육
	private String special_feature;    //특기사항
	private String supplies_support;   //소모품지원내역
	private String satisfaction;       //만족도
	private String comments;           //한줄의견
	private String process_state;      //처리상태
	private String support_state;      //지원처리상태
	private String comp_dt;              //완료일자
	private String internet_line;      //인터넷사업자
	private String orther;             //그외신청자
	private String student_name;       //학생이름
	private String student_tel;        //학생전화번호
	private String student_hp;         //학생휴대폰번호
	private String zip_code;           //우편번호
	private String student_addr1;      //학생주소1
	private String student_addr2;      //학생주소2
	private String service_name;       //서비스이름
	private String support_id;         //지원자아이디
	private String service_id;         //서비스아이디
	private String eduinfo_agree;      //교육정보동의
	private String mod_dt;               //수정일자
	private String exp_dt;               //협력일자
	private String delete_yn;          //삭제여부
	private int closed_day;
	private String member_key;
	
	private String sun;
	private String mon;
	private String tue;
	private String wed;
	private String thu;
	private String fri;
	private String sat;
	private String plan_year;
	private String plan_month;
	private String plan_date;
	
	private String pageType;
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getReq_type() {
		return req_type;
	}
	public void setReq_type(String req_type) {
		this.req_type = req_type;
	}
	public String getReq_id() {
		return req_id;
	}
	public void setReq_id(String req_id) {
		this.req_id = req_id;
	}
	public String getReq_name() {
		return req_name;
	}
	public void setReq_name(String req_name) {
		this.req_name = req_name;
	}
	public String getReq_organ_div() {
		return req_organ_div;
	}
	public void setReq_organ_div(String req_organ_div) {
		this.req_organ_div = req_organ_div;
	}
	public String getReq_organ_code() {
		return req_organ_code;
	}
	public void setReq_organ_code(String req_organ_code) {
		this.req_organ_code = req_organ_code;
	}
	public String getReq_tel() {
		return req_tel;
	}
	public void setReq_tel(String req_tel) {
		this.req_tel = req_tel;
	}
	public String getRequer_name() {
		return requer_name;
	}
	public void setRequer_name(String requer_name) {
		this.requer_name = requer_name;
	}
	public String getRequer_tel() {
		return requer_tel;
	}
	public void setRequer_tel(String requer_tel) {
		this.requer_tel = requer_tel;
	}
	public String getRequer_tel1() {
		return requer_tel1;
	}
	public void setRequer_tel1(String requer_tel1) {
		this.requer_tel1 = requer_tel1;
	}
	public String getRequer_tel2() {
		return requer_tel2;
	}
	public void setRequer_tel2(String requer_tel2) {
		this.requer_tel2 = requer_tel2;
	}
	public String getRequer_tel3() {
		return requer_tel3;
	}
	public void setRequer_tel3(String requer_tel3) {
		this.requer_tel3 = requer_tel3;
	}
	public String getReq_email() {
		return req_email;
	}
	public void setReq_email(String req_email) {
		this.req_email = req_email;
	}
	public String getReq_title() {
		return req_title;
	}
	public void setReq_title(String req_title) {
		this.req_title = req_title;
	}
	public String getReq_content() {
		return req_content;
	}
	public void setReq_content(String req_content) {
		this.req_content = req_content;
	}
	public String getReq_ip() {
		return req_ip;
	}
	public void setReq_ip(String req_ip) {
		this.req_ip = req_ip;
	}
	public String getHope_req_dt() {
		return hope_req_dt;
	}
	public void setHope_req_dt(String hope_req_dt) {
		this.hope_req_dt = hope_req_dt;
	}
	public String getStudent_id() {
		return student_id;
	}
	public void setStudent_id(String student_id) {
		this.student_id = student_id;
	}
	public String getPc_spec() {
		return pc_spec;
	}
	public void setPc_spec(String pc_spec) {
		this.pc_spec = pc_spec;
	}
	public String getCrt_dt() {
		return crt_dt;
	}
	public void setCrt_dt(String crt_dt) {
		this.crt_dt = crt_dt;
	}
	public String getSupport_div() {
		return support_div;
	}
	public void setSupport_div(String support_div) {
		this.support_div = support_div;
	}
	public String getSupporter() {
		return supporter;
	}
	public void setSupporter(String supporter) {
		this.supporter = supporter;
	}
	public String getSupport_clerk() {
		return support_clerk;
	}
	public void setSupport_clerk(String support_clerk) {
		this.support_clerk = support_clerk;
	}
	public String getSupporter_tel() {
		return supporter_tel;
	}
	public void setSupporter_tel(String supporter_tel) {
		this.supporter_tel = supporter_tel;
	}
	public String getSubcontractor() {
		return subcontractor;
	}
	public void setSubcontractor(String subcontractor) {
		this.subcontractor = subcontractor;
	}
	public String getSupport_content() {
		return support_content;
	}
	public void setSupport_content(String support_content) {
		this.support_content = support_content;
	}
	public String getSupport_content2() {
		return support_content2;
	}
	public void setSupport_content2(String support_content2) {
		this.support_content2 = support_content2;
	}
	public String getSpecial_feature() {
		return special_feature;
	}
	public void setSpecial_feature(String special_feature) {
		this.special_feature = special_feature;
	}
	public String getSupplies_support() {
		return supplies_support;
	}
	public void setSupplies_support(String supplies_support) {
		this.supplies_support = supplies_support;
	}
	public String getSatisfaction() {
		return satisfaction;
	}
	public void setSatisfaction(String satisfaction) {
		this.satisfaction = satisfaction;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getProcess_state() {
		return process_state;
	}
	public void setProcess_state(String process_state) {
		this.process_state = process_state;
	}
	public String getSupport_state() {
		return support_state;
	}
	public void setSupport_state(String support_state) {
		this.support_state = support_state;
	}
	public String getComp_dt() {
		return comp_dt;
	}
	public void setComp_dt(String comp_dt) {
		this.comp_dt = comp_dt;
	}
	public String getInternet_line() {
		return internet_line;
	}
	public void setInternet_line(String internet_line) {
		this.internet_line = internet_line;
	}
	public String getOrther() {
		return orther;
	}
	public void setOrther(String orther) {
		this.orther = orther;
	}
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	public String getStudent_tel() {
		return student_tel;
	}
	public void setStudent_tel(String student_tel) {
		this.student_tel = student_tel;
	}
	public String getStudent_hp() {
		return student_hp;
	}
	public void setStudent_hp(String student_hp) {
		this.student_hp = student_hp;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	public String getStudent_addr1() {
		return student_addr1;
	}
	public void setStudent_addr1(String student_addr1) {
		this.student_addr1 = student_addr1;
	}
	public String getStudent_addr2() {
		return student_addr2;
	}
	public void setStudent_addr2(String student_addr2) {
		this.student_addr2 = student_addr2;
	}
	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	public String getSupport_id() {
		return support_id;
	}
	public void setSupport_id(String support_id) {
		this.support_id = support_id;
	}
	public String getService_id() {
		return service_id;
	}
	public void setService_id(String service_id) {
		this.service_id = service_id;
	}
	public String getEduinfo_agree() {
		return eduinfo_agree;
	}
	public void setEduinfo_agree(String eduinfo_agree) {
		this.eduinfo_agree = eduinfo_agree;
	}
	public String getMod_dt() {
		return mod_dt;
	}
	public void setMod_dt(String mod_dt) {
		this.mod_dt = mod_dt;
	}
	public String getExp_dt() {
		return exp_dt;
	}
	public void setExp_dt(String exp_dt) {
		this.exp_dt = exp_dt;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	public String getSun() {
		return sun;
	}
	public void setSun(String sun) {
		this.sun = sun;
	}
	public String getMon() {
		return mon;
	}
	public void setMon(String mon) {
		this.mon = mon;
	}
	public String getTue() {
		return tue;
	}
	public void setTue(String tue) {
		this.tue = tue;
	}
	public String getWed() {
		return wed;
	}
	public void setWed(String wed) {
		this.wed = wed;
	}
	public String getThu() {
		return thu;
	}
	public void setThu(String thu) {
		this.thu = thu;
	}
	public String getFri() {
		return fri;
	}
	public void setFri(String fri) {
		this.fri = fri;
	}
	public String getSat() {
		return sat;
	}
	public void setSat(String sat) {
		this.sat = sat;
	}
	public String getPlan_year() {
		return plan_year;
	}
	public void setPlan_year(String plan_year) {
		this.plan_year = plan_year;
	}
	public String getPlan_month() {
		return plan_month;
	}
	public void setPlan_month(String plan_month) {
		this.plan_month = plan_month;
	}
	public String getPlan_date() {
		return plan_date;
	}
	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}
	public int getClosed_day() {
		return closed_day;
	}
	public void setClosed_day(int closed_day) {
		this.closed_day = closed_day;
	}
	public String getMember_key() {
		return member_key;
	}
	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}
	public String getPageType() {
		return pageType;
	}
	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	
}
