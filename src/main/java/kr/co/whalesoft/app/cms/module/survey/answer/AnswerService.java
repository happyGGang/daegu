package kr.co.whalesoft.app.cms.module.survey.answer;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import freemarker.template.utility.StringUtil;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class AnswerService extends BaseService {

	@Autowired
	private AnswerDao dao;
	
	private Map<String, String[]> authArr = new HashMap<String, String[]>();
	
	private final String student[] = {"01", "02", "03", "04", "05"};
	private final String teacher[] = {"06"};
	private final String special[] = {"07"};
	private final String general[] = {"08"};
	private final String parent[] = {"09"};
	private final String regular[] = {"10"};
	private final String organ[] = {"11"};
	private final String etc[] = {"12"};
	
	public AnswerService() {
		authArr.put("STUDENT", student);
		authArr.put("TEACHER", teacher);
		authArr.put("SPECIAL", special);
		authArr.put("GENERAL", general);
		authArr.put("PARENT", parent);
		authArr.put("REGULAR", regular);
		authArr.put("ORGAN", organ);
		authArr.put("ETC", etc);
	}
	
	@Transactional
	public int addAnswerSurvey(Quest quest) {
		int result = 0;
		result = dao.addSurveyAnswerUser(quest);
		
		for (Answer answer : quest.getAnswer_list()) {
			if(answer.getQuest_type() != null) {
				if (answer.getQuest_type().equals("DESCRIPTION")) {
					int answerIdx = dao.getNextAnswerIdx(quest);
					answer.setAnswer_idx(answerIdx);
					quest.setAnswer(answer);
					result += dao.addSurveyAnswerDetail(quest);
				} else {
					if (answer.getQuest_idx_list() != null && answer.getQuest_idx_list().size() > 0) {
						for (String answerStr : answer.getQuest_idx_list()) {
							if (StringUtils.isNotEmpty(answerStr)) {
								int answerIdx = dao.getNextAnswerIdx(quest);
								answer.setAnswer_idx(answerIdx);
								
								
								if (answerStr.indexOf("-") > 0) {
									answer.setChoice_answer(Integer.parseInt(answerStr.substring(answerStr.indexOf("-")+1)));
								} else {
									answer.setChoice_answer(Integer.parseInt(answerStr));
								}
								quest.setAnswer(answer);
								result += dao.addSurveyAnswerDetail(quest);
								if (answer.getQuest_type().equals("MATRIX")) {
									answer.setMatrix_idx(Integer.parseInt(answerStr.substring(0, answerStr.lastIndexOf("-"))));
									dao.addSurveyAnswerMatrix(quest);
								}
							}
						}
					}
				}
			}
		}
		return result; 
	}

	public boolean authCheck(String SurveyAuthToken, Member member) {
		StringTokenizer authToken = null;
		
		if(SurveyAuthToken != null) {
			authToken = new StringTokenizer(SurveyAuthToken, ",");
				
			while(authToken.hasMoreTokens()) {
				String auth = authToken.nextToken().trim();
				
				if(auth.equals("ALL")) {
					return true;
				} else {
					return true;
//					if(authArr.get(auth) != null) {
//						for(String authStr : authArr.get(auth)) {
//							if(authStr.equals(member.getUserCD())) {
//								return true;
//							}
//						}
//					}
				}
			}
		}
		
		return false;
	}
	
	public List<Answer> getSurveyAnswerUser(Quest quest) {
		return dao.getSurveyAnswerUser(quest);
	}

	public boolean isDupleAnswer(Quest quest, Member member) {
		quest.setAdd_id(member.getMember_id());
		return dao.getSurveyAnswerUserOne(quest) > 0 ? true : false;
	}

	public boolean isSurveyPeriod(Quest quest) {
		return dao.getSurveyPeriod(quest) > 0 ? true : false;
	}

	public boolean isSurveyOpen(Quest quest) {
		return dao.getSurveyOpen(quest) > 0 ? true : false;
	}
	
	public Object excelUpload(Quest quest, MultipartFile excel, List<Quest> questForm) throws Exception {
		Workbook workbook = Workbook.getWorkbook(excel.getInputStream());
		Sheet sheet = workbook.getSheet(0);
		
		int colLength = 0;
		for(int i = 0; i < sheet.getRow(0).length; i++) {
			if(StringUtils.isNotEmpty(sheet.getCell(i, 0).getContents())) {
				colLength++;
			}
		}
		if(colLength != questForm.size() + 2) {
			return "엑셀 양식이 올바르지 않습니다. 다시 확인 해주세요.";
		}
		
		String cellStr = sheet.getCell(0, 1).getContents().substring(0, 1);
		if(StringUtils.equals(cellStr, "*")) {
			return "예시글을 삭제 후 2번 행 부터 작성 해주세요.";
		}

		int rowCount = sheet.getRows();
		List<Quest> questList = new ArrayList<Quest>();

		for(int i = 1; i < rowCount; i++) {
			Object surveyXls = getSurveyExcelUpload(sheet, i, quest, questForm);
			if(surveyXls instanceof Quest) {
				if(surveyXls != null) {
					questList.add((Quest)surveyXls);
				}
			} else if(surveyXls instanceof String) {
				return surveyXls;
			}
			
		}
		
		workbook.close();
		
		return questList;
	}
	
	private Object getSurveyExcelUpload(Sheet sheet, int row ,Quest quest, List<Quest> questForm) {
//		if(sheet.getRow(row).length < 1) {
		int numRow = questForm.size() + 2;
		int result = 0;
		for(int i = 0; i < numRow; i++) {
			if(StringUtils.isEmpty(sheet.getCell(i, row).getContents().trim())) {
				result++;
			} else {
				break;
			}
		}
		
		if(result == numRow) {
			return null;
		}
//		}
		
		Quest one = new Quest();
		one.setAnswer_list(new ArrayList<Answer>());
		
		Cell user_name = sheet.getCell(1, row);
		one.setAdd_user_name(user_name.getContents());
		one.setHomepage_id(quest.getHomepage_id());
		one.setSurvey_idx(quest.getSurvey_idx());
		one.setMenu_idx(quest.getMenu_idx());
		
		// 문항수 만큼 동작
		for(int i = 0; i < questForm.size(); i++) {
			Answer  answer = new Answer();
			answer.setQuest_idx_list(new ArrayList<String>());
			
			Quest target = questForm.get(i);
			
			String type = target.getQuest_type();
			int questIdx = target.getQuest_idx();
			answer.setQuest_type(type);
			answer.setQuest_idx(questIdx);
			
			String free = target.getQuest_detail_free_yn();
			String strValue = sheet.getCell(2+i, row).getContents();
			
			if(type.equals("ONE")) {
				if(StringUtils.isEmpty(strValue.trim())) {
					return row + "번행 " + (i+1) + "번 문항에 답하지 않으셨습니다.";
				}
				
				try {
					Integer.parseInt(strValue.trim());
					int mtx = Integer.parseInt(strValue.trim());
					if(mtx > target.getQuest_count() || mtx < 1) {
						return row + "번행 " + (i+1) + "번 문항에 해당 보기가 없습니다.\n 현재 값 : " + strValue.trim();
					}
					answer.getQuest_idx_list().add(strValue.trim());
				} catch (NumberFormatException numberException) {
					if(free.equals("Y")) {
						try {
							int valueLength = strValue.getBytes("UTF-8").length;
							if(valueLength > 4000) {
								return String.format(row + "번행 " + (i+1) + "번 문항의 입력하신 길이가 큽니다.\n현재 : %s byte, 제한 : %s byte", valueLength, 4000);
							}
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
						answer.getQuest_idx_list().add("99");
						answer.setShort_answer(strValue.trim());
					} else {
						return row + "번행 " + (i+1) + "번 문항은 자유응답형이 없습니다. 다시 확인해주세요.";
					}
				}
			} else if(type.equals("MULTI")) {
				if(StringUtils.isEmpty(strValue.trim())) {
					return row + "번행 " + (i+1) + "번 문항에 답하지 않으셨습니다.";
				}
				
				String[] strValues = strValue.split(",");
				for(String v : strValues) {
					try {
						int mtx = Integer.parseInt(v.trim());
						if(mtx > target.getQuest_count() || mtx < 1) {
							return row + "번행 " + (i+1) + "번 문항에 해당 보기가 없습니다.\n 현재 값 : " + v;
						}
						
						int dupl = 0;
						for(int j = 0; j < strValues.length; j++) {
							dupl = v.trim().equals(strValues[j].trim()) ? ++dupl : dupl;
							if(dupl > 1) {
								return row + "번행 " + (i+1) + "번 문항에 중복된 값이 있습니다.";
							}
						}
							
						answer.getQuest_idx_list().add(v.trim());
					} catch (NumberFormatException numberException) {
						if(free.equals("Y")) {
							if(strValues[strValues.length-1].equals(v)) {
								try {
									int valueLength = v.getBytes("UTF-8").length; 
									if(valueLength > 4000) {
										return String.format(row + "번행 " + (i+1) + "번 문항의 입력하신 길이가 큽니다.\n현재 : %s byte, 제한 : %s byte", valueLength, 4000);
									}
								} catch (UnsupportedEncodingException e) {
									e.printStackTrace();
								}
								answer.getQuest_idx_list().add("99");
								answer.setShort_answer(v.trim());
							} else {
								return row + "번행 " + (i+1) + "번 문항의 보기에 문자가 있습니다.";
							}
						}
					}
				}
			} else if(type.equals("MATRIX")) {
				int num = 1;
				String[] strValues = strValue.split(",");
				if(strValues.length != target.getMatrix_count()) {
					return row + "번행 " + (i+1) + "번 문항의 답변 개수가 다릅니다.";
				}
				
				for(String v : strValues) {
					if(StringUtils.isEmpty(v.trim())) {
						return row + "번행 " + (i+1) + "번 문항의 " + num + "번 질문에 답하지 않으셨습니다.";
					}
					
					try {
						int mtx = Integer.parseInt(v.trim());
						if(mtx > target.getQuest_count() || mtx < 1) {
							return row + "번행 " + (i+1) + "번 문항의 " + num + "번 답변에 해당 보기가 없습니다.";
						}
					} catch (NumberFormatException numberException) {
						return row + "번행 " + (i+1) + "번 문항은 문자를 입력할 수 없습니다.";
					}
					
					answer.getQuest_idx_list().add(num + "-" + v.trim());
					num++;
				}
			} else if(type.equals("DESCRIPTION")) {
				String required = questForm.get(i).getRequired_yn();
				if(required.equals("Y") && StringUtils.isEmpty(strValue)) {
					return row + "번행 " + (i+1) + "번 문항에 답하지 않으셨습니다.";
				}
				try {
					int valueLength = strValue.getBytes("UTF-8").length;
					if(valueLength > 4000) {
						return String.format(row + "번행 " + (i+1) + "번 문항의 입력하신 길이가 큽니다.\n현재 : %s byte, 제한 : %s byte", valueLength, 4000);
					}
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				answer.setRequired_yn(required);
				answer.setShort_answer(strValue.trim());
			}
			one.getAnswer_list().add(answer);
		}
		 
		return one;
	}

	public List<Answer> getShuffledAnswers(Quest quest) {
		return dao.getShuffledAnswers(quest);
	}
	
	public List<Answer> getRandomShuffledAnswers(Quest quest) {
		return dao.getRandomShuffledAnswers(quest);
	}
	
	public List<Answer> getSurveyAnswerUser2(int survey_idx) {
		return dao.getSurveyAnswerUser2(survey_idx);
	}
	
}
