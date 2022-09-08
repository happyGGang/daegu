package kr.co.whalesoft.app.cms.homepage;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.googlecode.ehcache.annotations.Cacheable;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuDao;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class HomepageService extends BaseService {

	@Autowired
	private HomepageDao dao;

	@Autowired
	private MenuService menuService;

	@Autowired
	private MenuDao menuDao;

	@Resource
	private SqlSessionFactory sqlSessionFactoryBean;

	public List<Homepage> getHomepage() {
		return dao.getHomepage();
	}

	public List<Homepage> getNormalHomepage() {
		return dao.getNormalHomepage();
	}

	public List<Homepage> getHomepageList(Homepage homepage) {
		return dao.getHomepageList(homepage);
	}

	public int getHomepageListCount() {
		return dao.getHomepageListCount();
	}

	/**
	 * 홈페이지 1개 리턴. 조회조건 : homepage_id
	 * @param homepage (homepage_id)
	 * @return Homepage (Singular)
	 */
	public Homepage getHomepageOne(Homepage homepage) {
		Homepage homepage2 = dao.getHomepageOne(homepage);

		if(homepage2 != null) {
			if(homepage2.getTemp_start_date() != null && homepage2.getTemp_start_date().length() >= 11) {
				homepage2.setTemp_start_date_1(homepage2.getTemp_start_date().substring(0, 4) + "-" + homepage2.getTemp_start_date().substring(4, 6) + "-" + homepage2.getTemp_start_date().substring(6, 8));
				homepage2.setTemp_start_date_2(homepage2.getTemp_start_date().substring(8, 10));
				homepage2.setTemp_start_date_3(homepage2.getTemp_start_date().substring(10, 12));
			}

			if(homepage2.getTemp_end_date() != null && homepage2.getTemp_end_date().length() >= 11) {
				homepage2.setTemp_end_date_1(homepage2.getTemp_end_date().substring(0, 4) + "-" + homepage2.getTemp_end_date().substring(4, 6) + "-" + homepage2.getTemp_end_date().substring(6, 8));
				homepage2.setTemp_end_date_2(homepage2.getTemp_end_date().substring(8, 10));
				homepage2.setTemp_end_date_3(homepage2.getTemp_end_date().substring(10, 12));
			}
			
			// 서브 홈페이지 homepage_id, context path
			if(StringUtils.isEmpty(homepage2.getContext_path()) && homepage2.getHomepage_group().charAt(0) == 'h') {
				Homepage parentHome = new Homepage();
				parentHome.setHomepage_id(homepage2.getHomepage_group());
				parentHome = dao.getHomepageOne(parentHome);

				if(!"h74".equals(homepage.getHomepage_id()) && !"h75".equals(homepage.getHomepage_id()) && !"h76".equals(homepage.getHomepage_id())) {
					homepage2.setHomepage_id(parentHome.getHomepage_id());
					homepage2.setContext_path(parentHome.getContext_path());
				} else {
					homepage2.setContext_path(parentHome.getContext_path());
				}
			}
		}

		return homepage2;
	}

	@Cacheable(cacheName="homepageOneInPath")
	public Homepage getHomepageOneInPath(String context_path) {
		return dao.getHomepageOneInPath(context_path);
	}

	public Homepage getHomepageOneByCode(Homepage homepage) {
		return dao.getHomepageOneByCode(homepage);
	}

	@Transactional
	public int addHomepage(Homepage homepage) {
		/** 홈페이지 ID 설정(자동) **/
		homepage.setHomepage_id(dao.getHomepageID());
		int result = dao.addHomepage(homepage);
		return result;
	}

	public int modifyHomepage(Homepage homepage) {
		return dao.modifyHomepage(homepage);
	}

	public int deleteHomepage(Homepage homepage) {
		int result = dao.deleteHomepage(homepage);

		if ( result > 0 ) {
			menuDao.deleteMenusByHomepageId(homepage);
		}

		return result;
	}

	public int modifyHomepageTemp(Homepage homepage) {
		if(homepage.getTemp_use_yn().equals("Y")) {
			if(homepage.getTemp_start_date_1() != null && homepage.getTemp_start_date_2() != null && homepage.getTemp_start_date_3() != null) {
				homepage.setTemp_start_date(homepage.getTemp_start_date_1().replaceAll("-", "") + homepage.getTemp_start_date_2() + homepage.getTemp_start_date_3());
			}

			if(homepage.getTemp_end_date_1() != null && homepage.getTemp_end_date_2() != null && homepage.getTemp_end_date_3() != null) {
				homepage.setTemp_end_date(homepage.getTemp_end_date_1().replaceAll("-", "") + homepage.getTemp_end_date_2() + homepage.getTemp_end_date_3());
			}
		}

		return dao.modifyHomepageTemp(homepage);
	}

	public int getMenuIdxByLinkUrl(String homepageId, String linkUrl) {
		return menuService.getMenuIdxByLinkUrl(new Menu(homepageId, linkUrl));
	}

	/**
	 * 모듈번호로 메뉴IDX 가져오기
	 * @param homepageId
	 * @param i
	 * @return
	 */
	public int getMenuIdxByProgramIdx(String homepageId, int i) {
		return menuService.getMenuIdxByProgramIdx(new Menu(homepageId, i));
	}

	public List<Homepage> getMySiteList(Member member) {
		if (member.isAdmin()) {
			return dao.getHomepage();
		} else {
			return dao.getMySiteList(member);
		}
	}

	/**
	 * @author whalesoft
	 * @param homepage
	 * @date 2020.07.22
	 *
	 * @return 서브 홈페이지 수
	 *
	 */
	public int getSubHomepageListCount(Homepage homepage) {
		return dao.getSubHomepageListCount(homepage);
	}

	/**
	 * @author whalesoft
	 * @date 2020.07.22
	 *
	 * @param homepage
	 * @return
	 *
	 */
	public List<Homepage> getSubHomepageList(Homepage homepage) {
		return dao.getSubHomepageList(homepage);
	}

	/**
	 * @author whalesoft
	 * @date 2020.07.22
	 *
	 * @param homepage
	 * @return
	 *
	 */
	public int getSubNextPrintSeq(Homepage homepage) {
		return dao.getSubNextPrintSeq(homepage);
	}

}