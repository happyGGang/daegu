package kr.co.whalesoft.app.cms.module.survey;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.app.cms.module.survey.quest.QuestService;
import kr.co.whalesoft.framework.base.BaseService;
import net.sf.jxls.transformer.XLSTransformer;

@Service
public class SurveyService extends BaseService {

	@Autowired
	private SurveyDao dao;
	
	@Autowired
	private QuestService questService;
	
	public int getSurveyCount(Survey survey) {
		return dao.getSurveyCount(survey);
	}
	
	public int getAnswerUserCount(Survey survey) {
		return dao.getAnswerUserCount(survey);
	}
	
	public List<Survey> getSurvey(Survey survey) {
		return dao.getSurvey(survey);
	}
	
	public int getUserSurveyCount(Survey survey) {
		return dao.getUserSurveyCount(survey);
	}
	
	public List<Survey> getUserSurvey(Survey survey) {
		return dao.getUserSurvey(survey);
	}
	
	public List<Survey> getSurveyAll(String homepage_id) {
		return dao.getSurveyAll(homepage_id);
	}
	
	public Survey getSurveyOne(Survey survey) {
		return dao.getSurveyOne(survey);
	}
	
	public Survey getSurveyOneByUser(Survey survey) {
		return dao.getSurveyOneByUser(survey);
	}
	
	public int modifySurvey(Survey survey) {
		return dao.modifySurvey(survey);
	}
	
	public int modifySurveyDate(Survey survey) {
		return dao.modifySurveyDate(survey);
	}
	
	public int addSurvey(Survey survey) {
		return dao.addSurvey(survey);
	}
	
	public int deleteSurvey(Survey survey) {
		return dao.deleteSurvey(survey);
	}
	
	public int deleteSurveyQuest(Survey survey) {
		return dao.deleteSurveyQuest(survey);
	}
	
	public int deleteSurveyQuestDetail(Survey survey) {
		return dao.deleteSurveyQuestDetail(survey);
	}
	
	public int deleteSurveyQuestMatrix(Survey survey) {
		return dao.deleteSurveyQuestMatrix(survey);
	}
	
	public int deleteSurveyAnswerDetail(Survey survey) {
		return dao.deleteSurveyAnswerDetail(survey);
	}
	
	public int deleteSurveyAnswerUser(Survey survey) {
		return dao.deleteSurveyAnswerUser(survey);
	}		
	
	public int deleteSurveyAnswerMatrix(Survey survey) {
		return dao.deleteSurveyAnswerMatrix(survey);
	}
	public int copySurvey(Survey survey) {
		return dao.copySurvey(survey);
	}
	
	public int copySurveyQuest(Survey survey) {
		return dao.copySurveyQuest(survey);
	}
	
	public int copySurveyQuestDetail(Survey survey) {
		return dao.copySurveyQuestDetail(survey);
	}
	
	public int copySurveyQuestMatrix(Survey survey) {
		return dao.copySurveyQuestMatrix(survey);
	}

	public int modifySurveyOpenYN(Survey survey) {
		
		if(survey.getSurvey_open_yn().equals("Y")) {
			survey.setSurvey_open_yn("N");
		} else {
			survey.setSurvey_open_yn("Y");
		}
		
		
		return dao.modifySurveyOpenYN(survey);
	}
	
	public int modifySurveyPrivateYn(Survey survey) {
		if(survey.getSurvey_private_yn().equals("Y")) {
			survey.setSurvey_private_yn("N");
		} else {
			survey.setSurvey_private_yn("Y");
		}
		
		
		return dao.modifySurveyPrivateYn(survey);
	}
	
	public boolean isLimitedUser(Survey survey, Member member) {
		Survey survey1 = dao.getSurveyOne(survey);

		if(survey1 == null) return false;

		if(!"Y".equals(survey1.getLimit_user_yn())) {
			return false;
		}

		String limited_user_id = survey1.getLimit_user_id();

		if(limited_user_id == null) return false;

		String[] limited_user_ids = limited_user_id.split(",");
		String userId = member.getMember_id();
		
		for(String id: limited_user_ids) {
			if(id.equals(userId)) {
				return true;
			}
		}

		return false;
	}

	public void writeExcelData(Quest quest, OutputStream outputStream, HttpServletRequest request) throws Exception {
		String sampleFilePath = request.getSession().getServletContext().getRealPath("/") + "/resources/cms/survey/offline.xls";
		Workbook workbook = null;
		
		Survey survey = new Survey();
		if (quest.getSurvey_idx() != 0) {
			survey.setSurvey_idx(quest.getSurvey_idx());
			survey.setHomepage_id(quest.getHomepage_id());
			survey = getSurveyOne(survey);
		}
		List<Quest> questList = questService.getQuest(quest);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("questList", questList);
		dataMap.put("quest", quest);
		dataMap.put("survey", survey);
		
		workbook = new XLSTransformer().transformXLS(new BufferedInputStream(new FileInputStream(new File(sampleFilePath))), dataMap);
		
		workbook.write(outputStream);
	}
	
	public int add_select_cnt(Survey survey) {
		return dao.add_select_cnt(survey);
	}
	
}