package kr.go.gbelib.app.module.myItem;

import java.util.ArrayList;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MyItem extends PagingUtils {

	public static final int ITEM_TYPE_BOOK 	= 1;
	public static final int ITEM_TYPE_BOARD	= 2;
	
	private String member_key;
	private int storage_idx;
	private int item_idx;
	private String item_name;
	private String author;
	private String publer;
	private String loca;
	private String ctrl_no;
	private String call_no;
	private String img_url;
	private String item_url;
	private String add_date;
	private int item_type = ITEM_TYPE_BOOK;
	
	private List<String> strList;//검색결과 보관함 등록 용
	
	public MyItem() { }
	
	public MyItem(String homepage_id, String member_key) {
		setHomepage_id(homepage_id);
		this.setMember_key(member_key);
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}

	public int getStorage_idx() {
		return storage_idx;
	}

	public void setStorage_idx(int storage_idx) {
		this.storage_idx = storage_idx;
	}

	public int getItem_idx() {
		return item_idx;
	}

	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}

	public String getItem_url() {
		return item_url;
	}

	public void setItem_url(String item_url) {
		this.item_url = item_url;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getAdd_date() {
		return add_date;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPubler() {
		return publer;
	}

	public void setPubler(String publer) {
		this.publer = publer;
	}

	public String getLoca() {
		return loca;
	}

	public void setLoca(String loca) {
		this.loca = loca;
	}

	public String getCtrl_no() {
		return ctrl_no;
	}

	public void setCtrl_no(String ctrl_no) {
		this.ctrl_no = ctrl_no;
	}
	
	public String getCall_no() {
		return call_no;
	}
	
	public void setCall_no(String call_no) {
		this.call_no = call_no;
	}

	public String getImg_url() {
		return img_url;
	}

	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}

	public int getItem_type() {
		return item_type;
	}

	public void setItem_type(int item_type) {
		this.item_type = item_type;
	}
	
	public List<String> getStrList() {
		if(strList != null) {
			List<String> arrayList = new ArrayList<String>();
			arrayList.addAll(this.strList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setStrList(List<String> strList) {
		if(strList != null) {
			this.strList = new ArrayList<String>();
			this.strList.addAll(strList);
		}
	}

}