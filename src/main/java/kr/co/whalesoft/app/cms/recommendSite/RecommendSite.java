/**
 *
 */
package kr.co.whalesoft.app.cms.recommendSite;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author whaleesoft YONGJU 2019. 11. 28.
 *
 */
public class RecommendSite extends PagingUtils {

	private int recommend_site_idx; // 사이트IDX
	private String recommend_site_name; // 사이트명
	private String recommend_site_desc; // 사이트설명
	private String link_target; // 링크대상
	private int print_seq; // 출력순서
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시

	public RecommendSite() {
	}

	public RecommendSite(String homepage_id) {
		super.setHomepage_id(homepage_id);
	}

	public int getRecommend_site_idx() {
		return recommend_site_idx;
	}

	public void setRecommend_site_idx(int recommend_site_idx) {
		this.recommend_site_idx = recommend_site_idx;
	}

	public String getRecommend_site_name() {
		return recommend_site_name;
	}

	public void setRecommend_site_name(String recommend_site_name) {
		this.recommend_site_name = recommend_site_name;
	}

	public String getRecommend_site_desc() {
		return recommend_site_desc;
	}

	public void setRecommend_site_desc(String recommend_site_desc) {
		this.recommend_site_desc = recommend_site_desc;
	}

	public String getLink_target() {
		return link_target;
	}

	public void setLink_target(String link_target) {
		this.link_target = link_target;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
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

}
