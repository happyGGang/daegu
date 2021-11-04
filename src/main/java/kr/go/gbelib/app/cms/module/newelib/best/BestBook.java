package kr.go.gbelib.app.cms.module.newelib.best;

import kr.go.gbelib.app.cms.module.newelib.book.Book;

public class BestBook extends Book {
	
	private int lend_cnt;
	private int reserve_cnt;
	private int comment_cnt;
	private int recommend_cnt;
	private int audio_view_cnt;
	private int elearn_view_cnt;
	private float rank_index;
	private String auto_update_yn;
	private String types;
	private int date_range;
	private float lend_weight;
	private float reserve_weight;
	private float comment_weight;
	private float recommend_weight;
	private float audiobook_weight;
	private float elearning_weight;
	public BestBook() {
		this.setType(null);
	}
	public int getLend_cnt() {
		return lend_cnt;
	}
	public void setLend_cnt(int lend_cnt) {
		this.lend_cnt = lend_cnt;
	}
	public int getReserve_cnt() {
		return reserve_cnt;
	}
	public void setReserve_cnt(int reserve_cnt) {
		this.reserve_cnt = reserve_cnt;
	}
	public int getComment_cnt() {
		return comment_cnt;
	}
	public void setComment_cnt(int comment_cnt) {
		this.comment_cnt = comment_cnt;
	}
	public int getRecommend_cnt() {
		return recommend_cnt;
	}
	public void setRecommend_cnt(int recommend_cnt) {
		this.recommend_cnt = recommend_cnt;
	}
	public int getAudio_view_cnt() {
		return audio_view_cnt;
	}
	public void setAudio_view_cnt(int audio_view_cnt) {
		this.audio_view_cnt = audio_view_cnt;
	}
	public int getElearn_view_cnt() {
		return elearn_view_cnt;
	}
	public void setElearn_view_cnt(int elearn_view_cnt) {
		this.elearn_view_cnt = elearn_view_cnt;
	}
	public float getRank_index() {
		return rank_index;
	}
	public void setRank_index(float rank_index) {
		this.rank_index = rank_index;
	}
	public String getAuto_update_yn() {
		return auto_update_yn;
	}
	public void setAuto_update_yn(String auto_update_yn) {
		this.auto_update_yn = auto_update_yn;
	}
	public int getDate_range() {
		return date_range;
	}
	public void setDate_range(int date_range) {
		this.date_range = date_range;
	}
	public float getLend_weight() {
		return lend_weight;
	}
	public void setLend_weight(float lend_weight) {
		this.lend_weight = lend_weight;
	}
	public float getReserve_weight() {
		return reserve_weight;
	}
	public void setReserve_weight(float reserve_weight) {
		this.reserve_weight = reserve_weight;
	}
	public float getComment_weight() {
		return comment_weight;
	}
	public void setComment_weight(float comment_weight) {
		this.comment_weight = comment_weight;
	}
	public float getRecommend_weight() {
		return recommend_weight;
	}
	public void setRecommend_weight(float recommend_weight) {
		this.recommend_weight = recommend_weight;
	}
	public float getAudiobook_weight() {
		return audiobook_weight;
	}
	public void setAudiobook_weight(float audiobook_weight) {
		this.audiobook_weight = audiobook_weight;
	}
	public float getElearning_weight() {
		return elearning_weight;
	}
	public void setElearning_weight(float elearning_weight) {
		this.elearning_weight = elearning_weight;
	}
	public String getTypes() {
		return types;
	}
	public void setTypes(String types) {
		this.types = types;
	}
	
}
