package kr.go.gbelib.app.cms.module.archive;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Archive extends PagingUtils {

	private int book_idx;
	private String large_code; //대분류코드 (1차카테고리)
	private String mid_code; //중분류코드 (2차카테고리)
	private String small_code; //소분류코드 (3차카테고리)
	private String original_large_code; //대분류코드 (1차 카테고리) 수정용
	private String original_mid_code; //중분류코드(2차 카테고리) 수정용
	private String original_small_code; //소분류코드(3차 카테고리) 수정용
	private String large_code_name; //대분류명 (1차 카테고리명)
	private String mid_code_name; //중분류명 (2차 카테고리명)
	private String small_code_name; //소분류명 (3차 카테고리명)
	private String manage_num; //관리번호
	private String related_number; //관련번호
	private String title; //제목
	private String product_year; //생산연도
	private String product_year_start; //시대별 검색용
	private String product_year_end; //시대별 검색용
	private String product_date; //생산일자
	private String producer_name; //생산자명
	private String original_owner; //원본소장처
	private String region; //지역
	private String person; //인물
	private String description; //설명
	private String type; //유형
	private String data_type; //형태
	private String provide_method; //제급방법
	private String public_yn; //공개여부
	private String view_count; //조회수
	private String file_name; //파일명
	private String file_path; //파일경로
	private String image_file_name; //이미지(썸네일) 파일명
	private String image_file_path; //이미지(썸네일) 파일경로
	private String view_file_path; //뷰어 파일 경로
	private String addle_data_yn; //애뜰자료유무
	
	private String archive_link; //링크
	private String era; //시대
	private String copyright; //저작권표시
	private String information_ment; //이용안내멘트
	
	private String add_id; //추가 ID
	private Date add_date; //추가 날짜
	private String modify_id; //수정 ID
	private Date modify_date; //수정 날
	private String delete_yn; //삭제 여부
	private String delete_id; //삭제 ID
	private Date delete_date; //삭제 날짜
	
	private MultipartFile archive_file;
	private MultipartFile image_archive_file;
	
	private String view_mode; //뷰 모드 (썸네일형, 리스트형)
	private String menu_url_param; //메뉴idx를 가져오기 위한 값
	
	private boolean research; //아카이브 재검색용 True or False
	private String research_text; //아카이브 재검색용 텍스트
	private List<String> research_text_list; //아카이브 재검색용 텍스트 리스트
	
	public Archive() {}
	
	public Archive(String large_code, String mid_code, String small_code, int book_idx) {
		this.large_code = large_code;
		this.mid_code = mid_code;
		this.small_code = small_code;
		this.book_idx = book_idx;
	}
	public int getBook_idx() {
		return book_idx;
	}
	public void setBook_idx(int book_idx) {
		this.book_idx = book_idx;
	}
	public String getLarge_code() {
		return large_code;
	}
	public void setLarge_code(String large_code) {
		this.large_code = large_code;
	}
	public String getMid_code() {
		return mid_code;
	}
	public void setMid_code(String mid_code) {
		this.mid_code = mid_code;
	}
	public String getSmall_code() {
		return small_code;
	}
	public void setSmall_code(String small_code) {
		this.small_code = small_code;
	}
	public String getOriginal_large_code() {
		return original_large_code;
	}
	public void setOriginal_large_code(String original_large_code) {
		this.original_large_code = original_large_code;
	}
	public String getOriginal_mid_code() {
		return original_mid_code;
	}
	public void setOriginal_mid_code(String original_mid_code) {
		this.original_mid_code = original_mid_code;
	}
	public String getOriginal_small_code() {
		return original_small_code;
	}
	public void setOriginal_small_code(String original_small_code) {
		this.original_small_code = original_small_code;
	}
	public String getLarge_code_name() {
		return large_code_name;
	}
	public void setLarge_code_name(String large_code_name) {
		this.large_code_name = large_code_name;
	}
	public String getMid_code_name() {
		return mid_code_name;
	}
	public void setMid_code_name(String mid_code_name) {
		this.mid_code_name = mid_code_name;
	}
	public String getSmall_code_name() {
		return small_code_name;
	}
	public void setSmall_code_name(String small_code_name) {
		this.small_code_name = small_code_name;
	}
	public String getManage_num() {
		return manage_num;
	}
	public void setManage_num(String manage_num) {
		this.manage_num = manage_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getProduct_year() {
		return product_year;
	}
	public void setProduct_year(String product_year) {
		this.product_year = product_year;
	}
	public String getProduct_year_start() {
		return product_year_start;
	}
	public void setProduct_year_start(String product_year_start) {
		this.product_year_start = product_year_start;
	}
	public String getProduct_year_end() {
		return product_year_end;
	}
	public void setProduct_year_end(String product_year_end) {
		this.product_year_end = product_year_end;
	}
	public String getProduct_date() {
		return product_date;
	}
	public void setProduct_date(String product_date) {
		this.product_date = product_date;
	}
	public String getProducer_name() {
		return producer_name;
	}
	public void setProducer_name(String producer_name) {
		this.producer_name = producer_name;
	}
	public String getOriginal_owner() {
		return original_owner;
	}
	public void setOriginal_owner(String original_owner) {
		this.original_owner = original_owner;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getData_type() {
		return data_type;
	}
	public void setData_type(String data_type) {
		this.data_type = data_type;
	}
	public String getProvide_method() {
		return provide_method;
	}
	public void setProvide_method(String provide_method) {
		this.provide_method = provide_method;
	}
	public String getPublic_yn() {
		return public_yn;
	}
	public void setPublic_yn(String public_yn) {
		this.public_yn = public_yn;
	}
	public String getView_count() {
		return view_count;
	}
	public void setView_count(String view_count) {
		this.view_count = view_count;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getImage_file_name() {
		return image_file_name;
	}
	public void setImage_file_name(String image_file_name) {
		this.image_file_name = image_file_name;
	}
	public String getImage_file_path() {
		return image_file_path;
	}
	public void setImage_file_path(String image_file_path) {
		this.image_file_path = image_file_path;
	}
	public String getView_file_path() {
		return view_file_path;
	}
	public void setView_file_path(String view_file_path) {
		this.view_file_path = view_file_path;
	}
	public String getAddle_data_yn() {
		return addle_data_yn;
	}
	public void setAddle_data_yn(String addle_data_yn) {
		this.addle_data_yn = addle_data_yn;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	public String getDelete_id() {
		return delete_id;
	}
	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}
	public Date getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
	}
	public MultipartFile getArchive_file() {
		return archive_file;
	}
	public void setArchive_file(MultipartFile archive_file) {
		this.archive_file = archive_file;
	}
	public MultipartFile getImage_archive_file() {
		return image_archive_file;
	}
	public void setImage_archive_file(MultipartFile image_archive_file) {
		this.image_archive_file = image_archive_file;
	}
	public String getView_mode() {
		return view_mode;
	}
	public void setView_mode(String view_mode) {
		this.view_mode = view_mode;
	}
	public String getMenu_url_param() {
		return menu_url_param;
	}
	public void setMenu_url_param(String menu_url_param) {
		this.menu_url_param = menu_url_param;
	}
	public boolean isResearch() {
		return research;
	}
	public void setResearch(boolean research) {
		this.research = research;
	}
	public String getResearch_text() {
		return research_text;
	}
	public void setResearch_text(String research_text) {
		this.research_text = research_text;
	}
	public List<String> getResearch_text_list() {
		return research_text_list;
	}
	public void setResearch_text_list(List<String> research_text_list) {
		this.research_text_list = research_text_list;
	}
	public String getRelated_number() {
		return related_number;
	}
	public void setRelated_number(String related_number) {
		this.related_number = related_number;
	}

	public String getArchive_link() {
		return archive_link;
	}

	public void setArchive_link(String archive_link) {
		this.archive_link = archive_link;
	}

	public String getEra() {
		return era;
	}

	public void setEra(String era) {
		this.era = era;
	}

	public String getCopyright() {
		return copyright;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright;
	}

	public String getInformation_ment() {
		return information_ment;
	}

	public void setInformation_ment(String information_ment) {
		this.information_ment = information_ment;
	}
	
}
