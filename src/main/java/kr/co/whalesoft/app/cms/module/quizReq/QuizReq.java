package kr.co.whalesoft.app.cms.module.quizReq;

import java.util.Calendar;

import kr.co.whalesoft.framework.utils.PagingUtils;
import org.springframework.web.multipart.MultipartFile;

public class QuizReq extends PagingUtils {
	private int search_quiz_year = Calendar.getInstance().get(Calendar.YEAR);  //퀴즈연도;
	private int search_quiz_month = Calendar.getInstance().get(Calendar.MONTH) + 1;  //퀴즈월
	private String search_quiz_type;
	
	private int quiz_idx;  //퀴즈IDX
	private int quiz_req_idx;  //퀴즈신청IDX
	private String quiz_answer;  //퀴즈신청답변
	private String name;  //신청자명
	private String school; //학교
	private int hak;  //학년
	private int ban;  //반
	private String gender;  // 성별
	private String age;  // 연령대
	private String phone;  //전화번호
	private String zip_code;
	private String address;  //주소
	private String winner_yn;  //정답자여부
	private String add_ip;  //신청IP
	private String add_id;  //등록ID
	private String add_date;  //등록일
	private String terms_yn;	//약관동의여부
	private String chosen_yn;	//당첨자여부
	private String applicant_id; // 참여자ID

	private MultipartFile quizReq_file;
	private String origin_file_name; // 원본파일명
	private String server_file_name; // 서버파일명
	private String file_extension; // 파일확장자

	private long file_size; // 파일크기

	private String birth_day; //생년월일

	public QuizReq() { }
	
	public QuizReq(String homepage_id, int quiz_idx) {
		setHomepage_id(homepage_id);
		this.quiz_idx = quiz_idx;
	}

	public int getQuiz_idx() {
		return quiz_idx;
	}
	public void setQuiz_idx(int quiz_idx) {
		this.quiz_idx = quiz_idx;
	}
	public int getQuiz_req_idx() {
		return quiz_req_idx;
	}
	public void setQuiz_req_idx(int quiz_req_idx) {
		this.quiz_req_idx = quiz_req_idx;
	}
	public String getQuiz_answer() {
		return quiz_answer;
	}
	public void setQuiz_answer(String quiz_answer) {
		this.quiz_answer = quiz_answer;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBan() {
		return ban;
	}
	public void setBan(int ban) {
		this.ban = ban;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}

	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getWinner_yn() {
		return winner_yn;
	}
	public void setWinner_yn(String winner_yn) {
		this.winner_yn = winner_yn;
	}
	public String getAdd_ip() {
		return add_ip;
	}
	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getSearch_quiz_year() {
		return search_quiz_year;
	}
	public void setSearch_quiz_year(int search_quiz_year) {
		this.search_quiz_year = search_quiz_year;
	}
	public int getSearch_quiz_month() {
		return search_quiz_month;
	}
	public void setSearch_quiz_month(int search_quiz_month) {
		this.search_quiz_month = search_quiz_month;
	} 
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	public String getSearch_quiz_type() {
		return search_quiz_type;
	}
	public void setSearch_quiz_type(String search_quiz_type) {
		this.search_quiz_type = search_quiz_type;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public int getHak() {
		return hak;
	}

	public void setHak(int hak) {
		this.hak = hak;
	}

	
	public String getTerms_yn() {
		return terms_yn;
	}

	
	public void setTerms_yn(String terms_yn) {
		this.terms_yn = terms_yn;
	}

	public String getChosen_yn() {
		return chosen_yn;
	}

	public void setChosen_yn(String chosen_yn) {
		this.chosen_yn = chosen_yn;
	}

	@Override
	public String toString() {
		return String.format(
				"QuizReq [quiz_idx=%s, quiz_req_idx=%s, quiz_answer=%s, name=%s, school=%s, hak=%s, ban=%s, phone=%s, zip_code=%s, address=%s, winner_yn=%s, add_ip=%s, add_id=%s, add_date=%s, terms_yn=%s, chosen_yn=%s]",
				quiz_idx, quiz_req_idx, quiz_answer, name, school, hak, ban, phone, zip_code, address, winner_yn,
				add_ip, add_id, add_date, terms_yn, chosen_yn);
	}

	public String getApplicant_id() {
		return applicant_id;
	}

	public void setApplicant_id(String applicant_id) {
		this.applicant_id = applicant_id;
	}

	public MultipartFile getQuizReq_file() {
		return quizReq_file;
	}

	public void setQuizReq_file(MultipartFile quizReq_file) {
		this.quizReq_file = quizReq_file;
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

	public String getBirth_day() {
		return birth_day;
	}

	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}
}
