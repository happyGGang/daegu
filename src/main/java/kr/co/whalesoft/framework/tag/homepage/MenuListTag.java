package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.lang.StringUtils;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.framework.tag.HtmlTag;

/**
 * menuList 를 UL , DIV 형태의 테르로 변환하벼 보내주는 테그
 * 
 * @author whalesoft
 *
 */
public class MenuListTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private List<Menu> menuList;
	
	private int activeMenu = 0;				//선택 메뉴 번호

	private int startDeps = 1; 				// 불러들일 메뉴의 시작 깊이 기본 1Deps부터
	
	private String tagType = "ul";			// html로 표현할 테그 정의, ul, table, div
	
	private String tagClass = "";			// 전체를 감싸는 테그의 class 정의
	
	
	private String subTagClass[] = {"","","",""};		// 요소를 정의하는 테그의 감싸는 테그의 class 정의
	
	private String tagStyle = "";			// 전체를 감싸는 테그의 style 정의
	
	private String subTagStyle[] = {"","","",""};		// 요소를 정의하는 테그의 감싸는 테그의 style 정의
	
	private String tagId = "";				// 전체를 감싸는 테그의 id 정의
	
	private String subTagId[] = {"","","",""};			// 요소를 정의하는 테그의 감싸는 테그의 id 정의
	
	public List<Menu> getMenuList() {
		if(menuList != null) {
			List<Menu> arrayList = new ArrayList<Menu>();
			arrayList.addAll(this.menuList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setMenuList(List<Menu> menuList) {
		if(menuList != null) {
			this.menuList = new ArrayList<Menu>();
			this.menuList.addAll(menuList);
		}
	}
	
	

	public int getActiveMenu() {
		return activeMenu;
	}

	public void setActiveMenu(int activeMenu) {
		this.activeMenu = activeMenu;
	}

	public int getStartDeps() {
		return startDeps;
	}

	public void setStartDeps(int startDeps) {
		this.startDeps = startDeps;
	}
	
	public String getTagType() {
		return tagType;
	}

	public void setTagType(String tagType) {
		this.tagType = tagType;
	}
	
	

	public String getTagClass() {
		return tagClass;
	}

	public void setTagClass(String tagClass) {
		this.tagClass = tagClass;
	}

	public String getTagStyle() {
		return tagStyle;
	}

	public void setTagStyle(String tagStyle) {
		this.tagStyle = tagStyle;
	}

	public String getTagId() {
		return tagId;
	}

	public void setTagId(String tagId) {
		this.tagId = tagId;
	}
	
	

	public String[] getSubTagClass() {
		return subTagClass;
	}

	public void setSubTagClass(String[] subTagClass) {
		this.subTagClass = subTagClass;
	}

	public String[] getSubTagStyle() {
		return subTagStyle;
	}

	public void setSubTagStyle(String[] subTagStyle) {
		this.subTagStyle = subTagStyle;
	}

	public String[] getSubTagId() {
		return subTagId;
	}

	public void setSubTagId(String[] subTagId) {
		this.subTagId = subTagId;
	}

	@Override
	public int doEndTag() throws JspException {
		
		//String tagType = "ul";
		String subTagType = "li";
		
		if(tagType.equals("ul")){
			subTagType = "li";
		}
		
		
		
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		List<HtmlTag> ulTag = new ArrayList<HtmlTag>();
		List<HtmlTag> liTag_lvl = new ArrayList<HtmlTag>();
		
		for(int i = 0 ; i < startDeps-1 ; i++){
			ulTag.add(i,null);
			liTag_lvl.add(i,null);
		}
		
		
		ulTag.add(startDeps-1,new HtmlTag(tagType));
		liTag_lvl.add(startDeps-1,new HtmlTag(subTagType));
		
		int preMenuLevel = startDeps;
		
		if(menuList != null) {
			for(Menu menu : menuList) {
				String link_url = "";
				
				if ( menu.getMenu_type().equals("HTML") ) {
					link_url = "/" + homepage.getContext_path() + "/html.do?menu_idx=" + menu.getMenu_idx();
				}
				else if ( menu.getMenu_type().equals("PROGRAM") ) {
					link_url = String.format("/%s%s?menu_idx=%s", homepage.getContext_path(), menu.getMenu_url(), menu.getMenu_idx());
					if ( !StringUtils.isEmpty(menu.getMenu_url_param()) ) {
						link_url = String.format("/%s%s?menu_idx=%s&%s", homepage.getContext_path(), menu.getMenu_url(), menu.getMenu_idx(), menu.getMenu_url_param());	
					}
				}
				else if ( menu.getMenu_type().equals("BOARD") ) {
					link_url = String.format("/%s/board/index.do?menu_idx=%s&manage_idx=%s", homepage.getContext_path(), menu.getMenu_idx(), menu.getManage_idx());
				}
				else if ( menu.getMenu_type().equals("LINK") ) {
					if (!StringUtils.isEmpty(menu.getLink_url()) && menu.getLink_url().contains("menu_idx")) {
						link_url = menu.getLink_url();
					} else {
						link_url = String.format("/%s%s?menu_idx=%s", homepage.getContext_path(), menu.getLink_url(), menu.getMenu_idx());
					}
				}
				else if ( menu.getMenu_type().equals("LINK_OUTER") ) {
					link_url = menu.getLink_url();
				}
				else {
					link_url = "/" + homepage.getContext_path() + "/html.do?menu_idx=" + menu.getMenu_idx();
				}
				
				String targetStr = "";
				
				if(menu.getMenu_level() >= startDeps){
					if ( menu.getMenu_type().equals("LINK_OUTER") ) {
						targetStr = "target=\"_blank\"";
					}
					
					// 그룹테그 생성
					if(preMenuLevel < menu.getMenu_level()){
						HtmlTag ul =  new HtmlTag("ul");
						
						if(tagClass.indexOf("{0}") != -1)
							ul.setAttribute("class", tagClass.replaceAll("\\{0\\}", Integer.toString(menu.getMenu_level())));
						else
							ul.setAttribute("class", tagClass);
						
						if(tagId.indexOf("{0}") != -1)
							ul.setAttribute("id", tagId.replaceAll("\\{0\\}", Integer.toString(menu.getMenu_level())));
						else
							ul.setAttribute("id", tagId);
						
						if(tagStyle.indexOf("{0}") != -1)
							ul.setAttribute("style", tagStyle.replaceAll("\\{0\\}", Integer.toString(menu.getMenu_level())));
						else
							ul.setAttribute("style", tagStyle);
						
						liTag_lvl.get(menu.getMenu_level()-1).addSubTag(ul);
						ulTag.add(menu.getMenu_level()-1,ul);
					}
					
					//속성테그 생성
					HtmlTag li = new HtmlTag("li");
					if(subTagClass[menu.getMenu_level()-1].indexOf("{0}") != -1)
						li.setAttribute("class", subTagClass[menu.getMenu_level()-1].replaceAll("\\{0\\}", Integer.toString(menu.getMenu_level())));
					else
						li.setAttribute("class", subTagClass[menu.getMenu_level()-1]);
					
					if(subTagId[menu.getMenu_level()-1].indexOf("{0}") != -1)
						li.setAttribute("id", subTagId[menu.getMenu_level()-1].replaceAll("\\{0\\}", Integer.toString(menu.getMenu_level())));
					else
						li.setAttribute("id", subTagId[menu.getMenu_level()-1]);
					
					if(subTagStyle[menu.getMenu_level()-1].indexOf("{0}") != -1)
						li.setAttribute("style", subTagStyle[menu.getMenu_level()-1].replaceAll("\\{0\\}", Integer.toString(menu.getMenu_level())));
					else
						li.setAttribute("style", subTagStyle[menu.getMenu_level()-1]);
					
					//선택된 메뉴의 경우
					if( menu.getMenu_idx() == activeMenu ){
						li.setAttribute("class", "active " + li.getAttribute("class"));
					}
					
					li.setContent("<a href=\"" + link_url + "\" "+targetStr+"><span>" + menu.getMenu_name() + "</span></a>");
					liTag_lvl.add(menu.getMenu_level(),li);
					ulTag.get(menu.getMenu_level()-1).addSubTag(li);;
					
				}
				
				preMenuLevel = menu.getMenu_level();
			}
		}
			
		try {
			pageContext.getOut().println(ulTag.get(startDeps-1).toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	
	
	
	
}