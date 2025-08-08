package kr.go.gbelib.app.cms.module.division;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Division extends PagingUtils {

    private int idx; //IDX
    private int parent_idx; //상위 분류 IDX
	private String name; //분류명
	private int depth; //계층 깊이 (1:대, 2:중, 3:소)
	private String code; //분류 코드
	private String order_no; //정렬 순서
	private String use_yn = "Y"; //사용 여부
	private String add_date; //등록일시
	private String mod_date; //수정일시

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getParent_idx() {
        return parent_idx;
    }

    public void setParent_idx(int parent_idx) {
        this.parent_idx = parent_idx;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getOrder_no() {
        return order_no;
    }

    public void setOrder_no(String order_no) {
        this.order_no = order_no;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }

    public String getAdd_date() {
        return add_date;
    }

    public void setAdd_date(String add_date) {
        this.add_date = add_date;
    }

    public String getMod_date() {
        return mod_date;
    }

    public void setMod_date(String mod_date) {
        this.mod_date = mod_date;
    }
}
