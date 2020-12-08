package kr.co.whalesoft.app.cms.dataMigration;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StrUtil;

@Controller
@RequestMapping(value = {"/cms/dm"})
public class DataMigrationController extends BaseController {

	private final String basePath = "/cms/dataMigration/";

	@Autowired
	private CodeService codeService;

	@Autowired
	private DataMigrationService service;

	/**
	 * 달성군립도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/dalseonggun.*"})
	public String dalseonggun(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "dalseonggun";
	}

	/**
	 * 달성군립도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savedalseonggun.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savedalseonggun(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib2_dalseonggun");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "rebooks")) {
					dataMap = service.getListNNRecommendBookDalseonggun(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovieDalseonggun(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNNDalseonggun(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getParent_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}

					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
						one.setRequest_state("4");
					}
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
						one.setUser_name("관리자");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "/Users/yongju/documents/dglib2/dalseonggun/dslib2014/data/board/";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}


					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

//					String i5 = one.getImsi_v_5();
//					String i6 = one.getImsi_v_6();
//					String i8 = one.getImsi_v_8();
					String reContent = "";
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
//						one.setImsi_v_5(null);
//						one.setImsi_v_6(null);
//						one.setImsi_v_7(null);
//						one.setImsi_v_8(null);
						reContent = one.getImsi_v_20() + "";
						one.setImsi_v_20(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}


					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "/Users/yongju/documents/dglib2/dalseonggun/dslib2014/data/board/"+tableConfig.get("A_TABLENAME")+"/";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}



					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						int replyBoardIdx = service.getNextBoardIdx();
						DataMigration two = new DataMigration();
						two.setBoard_idx(replyBoardIdx);
						two.setGroup_seq(boardIdx);
						two.setManage_idx(manage_idx);
						two.setGroup_step(1);
						two.setParent_seq(boardIdx);
						two.setContent(reContent);
						two.setUser_name("관리자");
						two.setUser_id("admin");
						two.setTitle("답변 : " + one.getTitle());
						two.setAdd_date(one.getAdd_date());
						two.setSecret_yn(one.getSecret_yn());


						try {
							two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
						service.insertBoard(two);
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}




	/**
	 * 달서구도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/dalseogu.*"})
	public String dalseogu(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "dalseogu";
	}

	/**
	 * 달서구도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savedalseogu.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savedalseogu(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib2_dalseogu");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
//				List<String> fileList = service.getFileListNN(dm);
//				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "recommend_book")) {
					dataMap = service.getListNNRecommendBookDalseogu(manager_seq+"");
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovieDalseogu(manager_seq+"");

				} else {
					dataMap = service.getListNNDalseogu(manager_seq+"");

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					if (manager_seq == 69808861) {
						manage_idx = 736;
						if (one.getCategory1().equals("120") || one.getCategory1().equals("119")) {
							manage_idx = 736;
						} else if (one.getCategory1().equals("115") || one.getCategory1().equals("116")) {
							manage_idx = 734;
						} else if (one.getCategory1().equals("117") || one.getCategory1().equals("118")) {
							manage_idx = 735;
						}
					}

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);
					switch (manager_seq) {
						case 98953450 : one.setCategory1("004");
						case 54413277 : one.setCategory1("005");
						case 46532516 : one.setCategory1("006");
						case 60105960 : one.setCategory1("001");
						case 25985290 : one.setCategory1("003");
						case 75218135 : one.setCategory1("002");
					}

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getParent_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
						one.setRequest_state("4");
					}
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
						one.setUser_name("관리자");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "/Users/yongju/documents/dglib2/dalseogu/ROOT/data/board/";

//					one.setFileColumns(fileColumns);
//					one.setTableName(tableConfig.get("A_TABLENAME"));
//					Map<String, String> fileDataNN = service.getFileDataNN(one);

					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file1());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file2());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file3());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file4());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file5());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file6());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file7());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file8());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file9());
					setDalseoguFiles(tableConfig, map1, orgFileMap, filePath, one.getBbs_file10());

					//					if (!fileDataNN.isEmpty()) {
//						for (int k = 1; k <= fileList.size(); k++) {
//							String columnName = "b_file"+k;
//							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
//								map1 = new HashMap<String, Object>();
//								String fileName = fileDataNN.get(columnName);
//								map1.put("ORG_FILE_NAME", fileName);
//								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
//								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
//								map1.put("FILE_SIZE", f.length());
//								String filename = "";
//								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
//								String rndchars = RandomStringUtils.randomAlphanumeric(7);
//								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
//								map1.put("SERVER_FILE_NAME", filename);
//								orgFileMap.add(map1);
//							}
//						}
//
//					}


					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

//					String i5 = one.getImsi_v_5();
//					String i6 = one.getImsi_v_6();
//					String i8 = one.getImsi_v_8();
					String reContent = "";
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
//						one.setImsi_v_5(null);
//						one.setImsi_v_6(null);
//						one.setImsi_v_7(null);
//						one.setImsi_v_8(null);
						reContent = one.getImsi_v_20() + "";
						one.setImsi_v_20(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}



					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "/Users/yongju/documents/dglib2/dalseogu/ROOT/data/board/"+tableConfig.get("A_TABLENAME")+"/";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						int replyBoardIdx = service.getNextBoardIdx();
						DataMigration two = new DataMigration();
						two.setBoard_idx(replyBoardIdx);
						two.setGroup_seq(boardIdx);
						two.setManage_idx(manage_idx);
						two.setGroup_step(1);
						two.setParent_seq(boardIdx);
						two.setContent(reContent);
						two.setUser_name("관리자");
						two.setUser_id("admin");
						two.setTitle("답변 : " + one.getTitle());
						two.setAdd_date(one.getAdd_date());
						two.setRequest_state("4");
						two.setSecret_yn(one.getSecret_yn());

						try {
							two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
						service.insertBoard(two);
					}



				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	private void setDalseoguFiles(Map<String, String> tableConfig, Map<String, Object> map1, List<Map<String, Object>> orgFileMap, String filePath, String bbs_file1) {
		if (StringUtils.isNotEmpty(bbs_file1)) {
			map1 = new HashMap<>();
			String fileName = bbs_file1;
			map1.put("ORG_FILE_NAME", fileName);
			map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
			File f = new File(filePath + tableConfig.get("A_TABLENAME") + "/" + fileName);
			map1.put("FILE_SIZE", f.length());
			String filename = "";
			String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
			String rndchars = RandomStringUtils.randomAlphanumeric(7);
			filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
			map1.put("SERVER_FILE_NAME", filename);
			orgFileMap.add(map1);
		}
	}


	/**
	 * 고산 도서관    - cs
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/gosan.*"})
	public String gosan(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "gosan";
	}

	/**
	 * 고산 도서관    - cs
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savegosan.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savegosan(DataMigration dm, HttpServletRequest request) {
		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();


				List<DataMigration> dataMap = new ArrayList<>();
				if (manager_seq == 44) {//book
					dataMap = service.getListGosanBook(manager_seq);
				} else if (manager_seq == 18) {//movie
					dataMap = service.getListGosanMovie(manager_seq);
				} else {
					dataMap = service.getListGosan(manager_seq);
				}

				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);


					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}




					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;
					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					String filePath = "/Users/yongju/documents/dglib2/suseong/gosan/data/bbsData/";

					suseongFileCheck(orgFileMapTmp, one.getHid_file());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file0());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file1());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file2());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file3());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file4());

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://library.suseong.kr/gosan/", "/data/gosan/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (manage_idx == 118) {
						one.setRequest_state("4");
					}

					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목 없음"));

					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							try {
								service.fileMoveSuseong(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					if (manager_seq == 2) {
						int replyBoardIdx = service.getNextBoardIdx();
						List<DataMigration> twoArr = service.getListGosanComment(one);
						DataMigration two = new DataMigration();
						if (CollectionUtils.isNotEmpty(twoArr)) {

							two.setBoard_idx(replyBoardIdx);
							two.setGroup_seq(boardIdx);
							two.setManage_idx(manage_idx);
							two.setGroup_step(1);
							two.setParent_seq(boardIdx);
							StringBuilder twoContent = new StringBuilder();
							for (DataMigration dataMigration : twoArr) {
								twoContent.append(dataMigration.getContent());
							}
							two.setContent(twoContent.toString());
							two.setUser_name(StringUtils.defaultIfEmpty(twoArr.get(0).getUser_name(), "담당자"));
							two.setUser_id("admin");
							two.setTitle("답변 : " + one.getTitle());
							two.setAdd_date(twoArr.get(0).getAdd_date());
							two.setSecret_yn(one.getSecret_yn());
							try {
								two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
							} catch (Exception e) {
								// TODO: handle exception
							}
							service.insertBoard(two);
						}

					}


				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}



	/**
	 * 용학 도서관    - cs
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/yonghak.*"})
	public String yonghak(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "yonghak";
	}

	/**
	 * 용학 도서관    - cs
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/saveyonghak.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveyonghak(DataMigration dm, HttpServletRequest request) {
		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();


				List<DataMigration> dataMap = new ArrayList<>();
				if (manager_seq == 44) {//book
					dataMap = service.getListYonghakBook(manager_seq);
				} else if (manager_seq == 18) {//movie
					dataMap = service.getListYonghakMovie(manager_seq);
				} else {
					dataMap = service.getListYonghak(manager_seq);
				}

				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);


					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}




					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;
					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					String filePath = "/Users/yongju/documents/dglib2/suseong/yonghak/data/bbsData/";

					suseongFileCheck(orgFileMapTmp, one.getHid_file());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file0());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file1());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file2());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file3());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file4());

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://library.suseong.kr/yonghak/", "/data/yonghak/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (manage_idx == 118) {
						one.setRequest_state("4");
					}

					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목 없음"));

					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							try {
								service.fileMoveSuseong(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					if (manager_seq == 2) {
						int replyBoardIdx = service.getNextBoardIdx();
						List<DataMigration> twoArr = service.getListYonghakComment(one);
						DataMigration two = new DataMigration();
						if (CollectionUtils.isNotEmpty(twoArr)) {

							two.setBoard_idx(replyBoardIdx);
							two.setGroup_seq(boardIdx);
							two.setManage_idx(manage_idx);
							two.setGroup_step(1);
							two.setParent_seq(boardIdx);
							StringBuilder twoContent = new StringBuilder();
							for (DataMigration dataMigration : twoArr) {
								twoContent.append(dataMigration.getContent());
							}
							two.setContent(twoContent.toString());
							two.setUser_name(StringUtils.defaultIfEmpty(twoArr.get(0).getUser_name(), "담당자"));
							two.setUser_id("admin");
							two.setTitle("답변 : " + one.getTitle());
							two.setAdd_date(twoArr.get(0).getAdd_date());
							two.setSecret_yn(one.getSecret_yn());
							try {
								two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
							} catch (Exception e) {
								// TODO: handle exception
							}
							service.insertBoard(two);
						}

					}


				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	/**
	 * 범어 도서관    - cs
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/beomeo.*"})
	public String beomeo(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "beomeo";
	}

	/**
	 * 범어 도서관    - cs
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savebeomeo.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savebeomeo(DataMigration dm, HttpServletRequest request) {
		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();


				List<DataMigration> dataMap = new ArrayList<>();
				if (manager_seq == 48) {//book
					dataMap = service.getListBeomeoBook(manager_seq);
				} else if (manager_seq == 18) {//movie
					dataMap = service.getListBeomeoMovie(manager_seq);
				} else {
					dataMap = service.getListBeomeo(manager_seq);
				}

				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);


					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}




					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;
					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					String filePath = "/Users/yongju/documents/dglib2/suseong/beomeo/data/bbsData/";

					suseongFileCheck(orgFileMapTmp, one.getHid_file());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file0());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file1());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file2());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file3());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file4());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file5());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file6());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file7());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file8());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file9());
					suseongFileCheck(orgFileMapTmp, one.getBbs_file10());

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://library.suseong.kr/beomeo/", "/data/beomeo/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (manage_idx == 118) {
						one.setRequest_state("4");
					}

					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목 없음"));

					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							try {
								service.fileMoveSuseong(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					if (manager_seq == 2) {
						int replyBoardIdx = service.getNextBoardIdx();
						List<DataMigration> twoArr = service.getListBeomeoComment(one);
						DataMigration two = new DataMigration();
						if (CollectionUtils.isNotEmpty(twoArr)) {

							two.setBoard_idx(replyBoardIdx);
							two.setGroup_seq(boardIdx);
							two.setManage_idx(manage_idx);
							two.setGroup_step(1);
							two.setParent_seq(boardIdx);
							StringBuilder twoContent = new StringBuilder();
							for (DataMigration dataMigration : twoArr) {
								twoContent.append(dataMigration.getContent());
							}
							two.setContent(twoContent.toString());
							two.setUser_name(StringUtils.defaultIfEmpty(twoArr.get(0).getUser_name(), "담당자"));
							two.setUser_id("admin");
							two.setTitle("답변 : " + one.getTitle());
							two.setAdd_date(twoArr.get(0).getAdd_date());

							try {
								two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
							} catch (Exception e) {
								// TODO: handle exception
							}
							service.insertBoard(two);
						}

					}


				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	private void suseongFileCheck(List<Map<String, Object>> orgFileMapTmp, String fileData) {
		Map<String, Object> map1;
		if (StringUtils.isNotEmpty(fileData) && !StringUtils.equalsIgnoreCase(fileData, "null")) {
			String[] fileDataSplit = fileData.split("\\|:\\|");
			for (String s : fileDataSplit) {
				String server = s.split("/")[0];
				String org = s.split("/")[1];
				map1 = new HashMap<String, Object>();
				map1.put("ORG_FILE_NAME", org);
				map1.put("SERVER_FILE_NAME", server);
				orgFileMapTmp.add(map1);
				map1 = null;
			}
		}
	}


	/**
	 * 북구도서관 태전   - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/taejeon.*"})
	public String taejeon(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "taejeon";
	}

	/**
	 * 북구도서관 태전  - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savetaejeon.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savetaejeon(DataMigration dm, HttpServletRequest request) {
		dm.setDbUser("MC");
		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				List<DataMigration> dataMap = null;
				if (manager_seq == -1) {//book
					List<Code> code = codeService.getCode("h47", "B0004");
					StringBuffer sb = new StringBuffer();
					for (Code c : code) {
						sb.append(String.format(" when bk_category = '%s' then '%s'", c.getCode_name(), c.getCode_id()));
					}
					dm.setCategory5(sb.toString());
					dm.setDbUser("16");
					dataMap = service.orgListDKBookBukgu(dm);
				} else if (manager_seq == -2) {//movie
					dataMap = service.orgListDKMovieBukgu(dm);

				} else {//board
					Map<String, Object> p = new HashMap<String, Object>();
					p.put("manager_seq", manager_seq);
					p.put("dbUser", dm.getDbUser());
					dataMap = service.getListDKBukgu(p);

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);


					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}


					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;
					String fileFolder = "board/";
					if (manager_seq == -1) {
						fileFolder = "book/";
					} else if (manager_seq == -2) {
						fileFolder = "movie/";
					}
					String filePath = "/Users/yongju/documents/dglib2/bukgu/wdFiles/upload/"+fileFolder;

					if (manager_seq > 0) {
						filePath = "/Users/yongju/documents/dglib2/bukgu/wdFiles/";
					}

					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					if (manager_seq < 0) {
						if (StringUtils.isNotEmpty(one.getOrg_file_name()) && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "0") && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
							map1 = new HashMap<String, Object>();
							map1.put("ORG_FILE_NAME", one.getOrg_file_name());
							map1.put("SERVER_FILE_NAME", one.getServer_file_name());
							orgFileMapTmp.add(map1);
							map1 = null;
						}
					} else {
						orgFileMapTmp = service.getFileDataDKBukgu(one.getBoard_seq());
					}
					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.dsl.daegu.kr/wdCheditor/attach/", "/data/userfiles/h4/"));
					one.setContent(one.getContent().replaceAll("/wdCheditor/attach/", "/data/userfiles/h4/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					if (manager_seq < 0 && StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
						one.setPreview_img(one.getServer_file_name());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (manage_idx == 118) {
						one.setRequest_state("4");
					}

					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목 없음"));

					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "F:\\프로젝트\\대구시교육청도서관\\db\\dalsung\\www0725\\homepage\\wd"+fileFolder+"\\upload\\";
							try {
								service.fileMoveDK(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}




				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	/**
	 * 북구도서관 대현  - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/daehyun.*"})
	public String daehyun(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "daehyun";
	}

	/**
	 * 북구도서관 대현 - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savedaehyun.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savedaehyun(DataMigration dm, HttpServletRequest request) {
		dm.setDbUser("MB");
		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				List<DataMigration> dataMap = null;
				if (manager_seq == -1) {//book
					List<Code> code = codeService.getCode("h47", "B0004");
					StringBuffer sb = new StringBuffer();
					for (Code c : code) {
						sb.append(String.format(" when bk_category = '%s' then '%s'", c.getCode_name(), c.getCode_id()));
					}
					dm.setCategory5(sb.toString());
					dm.setDbUser("15");
					dataMap = service.orgListDKBookBukgu(dm);
				} else if (manager_seq == -2) {//movie
					dataMap = service.orgListDKMovieBukgu(dm);

				} else {//board
					Map<String, Object> p = new HashMap<String, Object>();
					p.put("manager_seq", manager_seq);
					p.put("dbUser", dm.getDbUser());
					dataMap = service.getListDKBukgu(p);

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					if (manager_seq == -1) {
						if (one.getCategory1().equals("0003") || one.getCategory1().equals("0004")) {
							manage_idx = 706;
						} else {
							manage_idx = 707;
						}

					}
					one.setManage_idx(manage_idx);


					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}


					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;
					String fileFolder = "board/";
					if (manager_seq == -1) {
						fileFolder = "book/";
					} else if (manager_seq == -2) {
						fileFolder = "movie/";
					}
					String filePath = "/Users/yongju/documents/dglib2/bukgu/wdFiles/upload/"+fileFolder;

					if (manager_seq > 0) {
						filePath = "/Users/yongju/documents/dglib2/bukgu/wdFiles/";
					}

					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					if (manager_seq < 0) {
						if (StringUtils.isNotEmpty(one.getOrg_file_name()) && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "0") && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
							map1 = new HashMap<String, Object>();
							map1.put("ORG_FILE_NAME", one.getOrg_file_name());
							map1.put("SERVER_FILE_NAME", one.getServer_file_name());
							orgFileMapTmp.add(map1);
							map1 = null;
						}
					} else {
						orgFileMapTmp = service.getFileDataDKBukgu(one.getBoard_seq());
					}
					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.dsl.daegu.kr/wdCheditor/attach/", "/data/userfiles/h4/"));
					one.setContent(one.getContent().replaceAll("/wdCheditor/attach/", "/data/userfiles/h4/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					if (manager_seq < 0 && StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
						one.setPreview_img(one.getServer_file_name());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (manage_idx == 118) {
						one.setRequest_state("4");
					}

					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목 없음"));

					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "F:\\프로젝트\\대구시교육청도서관\\db\\dalsung\\www0725\\homepage\\wd"+fileFolder+"\\upload\\";
							try {
								service.fileMoveDK(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}




				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	/**
	 * 북구도서관 구수산  - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/gususan.*"})
	public String gususan(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "gususan";
	}

	/**
	 * 북구도서관 구수산 - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savegususan.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savegususan(DataMigration dm, HttpServletRequest request) {
		dm.setDbUser("MA");
		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				List<DataMigration> dataMap = null;
				if (manager_seq == -1) {//book
					List<Code> code = codeService.getCode("h46", "B0004");
					StringBuffer sb = new StringBuffer();
					for (Code c : code) {
						sb.append(String.format(" when bk_category = '%s' then '%s'", c.getCode_name(), c.getCode_id()));
					}
					dm.setCategory5(sb.toString());
					dm.setDbUser("11");
					dataMap = service.orgListDKBookBukgu(dm);
				} else if (manager_seq == -2) {//movie
					dataMap = service.orgListDKMovieBukgu(dm);

				} else {//board
					Map<String, Object> p = new HashMap<String, Object>();
					p.put("manager_seq", manager_seq);
					p.put("dbUser", dm.getDbUser());
					dataMap = service.getListDKBukgu(p);

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					if (manager_seq == -1) {
						if (one.getCategory1().equals("0003") || one.getCategory1().equals("0004")) {
							manage_idx = 696;
						} else {
							manage_idx = 697;
						}

					}
					one.setManage_idx(manage_idx);


					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}


					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;
					String fileFolder = "board/";
					if (manager_seq == -1) {
						fileFolder = "book/";
					} else if (manager_seq == -2) {
						fileFolder = "movie/";
					}
					String filePath = "/Users/yongju/documents/dglib2/bukgu/wdFiles/upload/"+fileFolder;

					if (manager_seq > 0) {
						filePath = "/Users/yongju/documents/dglib2/bukgu/wdFiles/";
					}

					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					if (manager_seq < 0) {
						if (StringUtils.isNotEmpty(one.getOrg_file_name()) && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "0") && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
							map1 = new HashMap<String, Object>();
							map1.put("ORG_FILE_NAME", one.getOrg_file_name());
							map1.put("SERVER_FILE_NAME", one.getServer_file_name());
							orgFileMapTmp.add(map1);
							map1 = null;
						}
					} else {
						orgFileMapTmp = service.getFileDataDKBukgu(one.getBoard_seq());
					}
					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.dsl.daegu.kr/wdCheditor/attach/", "/data/userfiles/h4/"));
					one.setContent(one.getContent().replaceAll("/wdCheditor/attach/", "/data/userfiles/h4/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					if (manager_seq < 0 && StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
						one.setPreview_img(one.getServer_file_name());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (manage_idx == 118) {
						one.setRequest_state("4");
					}

					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목 없음"));

					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "F:\\프로젝트\\대구시교육청도서관\\db\\dalsung\\www0725\\homepage\\wd"+fileFolder+"\\upload\\";
							try {
								service.fileMoveDK(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}




				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}


	/**
	 * 남구도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/namgu.*"})
	public String namgu(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "namgu";
	}

	/**
	 * 남구도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savenamgu.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savenamgu(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib2_namgu");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "recommend_book")) {
					dataMap = service.getListNNRecommendBookNamgu(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovieNamgu(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNN(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getParent_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
						one.setRequest_state("4");
					}
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
						one.setUser_name("관리자");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "/Users/yongju/documents/dglib2/namgu/ROOT/data/board";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}


					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					String i5 = one.getImsi_v_5();
					String i6 = one.getImsi_v_6();
					String i8 = one.getImsi_v_8();
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setImsi_v_5(null);
						one.setImsi_v_6(null);
						one.setImsi_v_7(null);
						one.setImsi_v_8(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}


					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "/Users/yongju/documents/dglib2/namgu/ROOT/data/board/"+tableConfig.get("A_TABLENAME")+"/";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						int replyBoardIdx = service.getNextBoardIdx();
						DataMigration two = new DataMigration();
						two.setBoard_idx(replyBoardIdx);
						two.setGroup_seq(boardIdx);
						two.setManage_idx(manage_idx);
						two.setGroup_step(1);
						two.setParent_seq(boardIdx);
						two.setContent(i8);
						two.setUser_name(StringUtils.defaultIfEmpty(i5, "관리자"));
						two.setUser_id("admin");
						two.setTitle("답변 : " + one.getTitle());
						two.setAdd_date(StringUtils.defaultIfEmpty(StringUtils.replace(i6, "-00-00", one.getAdd_date()), one.getAdd_date()));
						two.setRequest_state("4");

						try {
							two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
						service.insertBoard(two);
					}



				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}


	/**
	 * 서구도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/seogu.*"})
	public String seogu(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "seogu";
	}

	/**
	 * 서구도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/saveseogu.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveseogu(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib2_seogu");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "recommend_book")) {
					dataMap = service.getListNNRecommendBookSeogu(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovieSeogu(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNN(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getParent_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}

					if (manager_seq == 97945357) {//notice
						if (StringUtils.equals(one.getCategory1(), "97")) {
							one.setCategory1("h77");
						} else if (StringUtils.equals(one.getCategory1(), "98")) {
							one.setCategory1("h61");
						} else if (StringUtils.equals(one.getCategory1(), "100")) {
							one.setCategory1("h62");
						} else if (StringUtils.equals(one.getCategory1(), "99")) {
							one.setCategory1("h63");
						} else if (StringUtils.equals(one.getCategory1(), "101")) {
							one.setCategory1("h64");
						} else if (StringUtils.equals(one.getCategory1(), "126")) {
							one.setCategory1("h65");
						}
					}

					if (manager_seq == 88531425) {//lost
						if (StringUtils.equals(one.getCategory1(), "109")) {
							one.setCategory1("0001");
						} else if (StringUtils.equals(one.getCategory1(), "110")) {
							one.setCategory1("0002");
						} else if (StringUtils.equals(one.getCategory1(), "111")) {
							one.setCategory1("0004");
						} else if (StringUtils.equals(one.getCategory1(), "112")) {
							one.setCategory1("0003");
						} else if (StringUtils.equals(one.getCategory1(), "113")) {
							one.setCategory1("0005");
						}
					}

					if (manager_seq == 65896833 || manager_seq == 24353980) {
						one.setCategory1("0001");
					}
					if (manager_seq == 18955127 || manager_seq == 83125664) {
						one.setCategory1("0002");
					}
					if (manager_seq == 63572892 || manager_seq == 66636428) {
						one.setCategory1("0004");
					}
					if (manager_seq == 85802822 || manager_seq == 34737171) {
						one.setCategory1("0003");
					}
					if (manager_seq == 97924812 || manager_seq == 69184541) {
						one.setCategory1("0005");
					}

					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "recommend_book")) {
						String c1 = one.getCategory1();
						switch (c1) {
							case "104": case "106": case "115": case "119": case "123": case "103": case "105": case "114": case "118": case "122":
								manage_idx = 623; one.setManage_idx(623);break;
							case "107": case "116": case "120": case "124" :
								manage_idx = 624; one.setManage_idx(624);break;
							case "108": case "117": case "121": case "125": case "127": case "102":
								manage_idx = 625; one.setManage_idx(625);break;
							default : manage_idx = 625; break;
						}
						switch (manager_seq) {
							case 95533164 : one.setCategory1("0001");break;
							case 18644879 : one.setCategory1("0002");break;
							case 57333631 : one.setCategory1("0004");break;
							case 82793497 : one.setCategory1("0003");break;
							case 15618915 : one.setCategory1("0005");break;
						}


					}

					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
						one.setRequest_state("4");
					}
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
						one.setUser_name("관리자");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "/Users/yongju/Documents/dglib2/seogu/data/board";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}


					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					String i5 = one.getImsi_v_5();
					String i6 = one.getImsi_v_6();
					String i8 = one.getImsi_v_8();
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setImsi_v_5(null);
						one.setImsi_v_6(null);
						one.setImsi_v_7(null);
						one.setImsi_v_8(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}


					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "/Users/yongju/Documents/dglib2/seogu/data/board/"+tableConfig.get("A_TABLENAME")+"/";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}




				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}



	/**
	 * 동구도서관 - ilus
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/donggu.*"})
	public String donggu(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "donggu";
	}

	/**
	 * 동구도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savedonggu.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savedonggu(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

//				//테이블명 가져오기
//				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
//				dm.setDbUser("dglib_sslib");
//				dm.setTableName(tableConfig.get("A_TABLENAME"));
//				List<String> fileList = service.getFileListNN(dm);
//				String fileColumns = StringUtils.join(fileList, ", ");
//
//				List<DataMigration> dataMap = null;
//				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "newbook")) {
//					dataMap = service.getListNNNewBook(tableConfig.get("A_TABLENAME"));
//				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
//					dataMap = service.getListNNMovie(tableConfig.get("A_TABLENAME"));
//
//				} else {
//					dataMap = service.getListNN(tableConfig.get("A_TABLENAME"));
//
//				}

				List<DataMigration> dataMap = null;

				if (manager_seq == 0) {//movie
					dataMap = service.getListDongguMovie();
				} else {
					dataMap = service.getListDonggu(manager_seq);
				}



				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getParent_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


					if (manager_seq == 7) {
						manage_idx = 616;
						if (StringUtils.equals(one.getCategory1(), "175")) {
							manage_idx = 617;
						} else if (StringUtils.equals(one.getCategory1(), "176")) {
							manage_idx = 618;
						} else if (StringUtils.equals(one.getCategory1(), "177")) {
							manage_idx = 619;
						}
						one.setCategory1(null);
					} else if (manager_seq == 1) {
//						INSERT INTO DGLIB.TN_SVP_BBS_SJ (SBJECT_CODE, BBS_TY_ID, BBS_ID, SBJECT_NAME) VALUES (137, null, 1, '신천');
//						INSERT INTO DGLIB.TN_SVP_BBS_SJ (SBJECT_CODE, BBS_TY_ID, BBS_ID, SBJECT_NAME) VALUES (81, null, 1, '안심');
//						INSERT INTO DGLIB.TN_SVP_BBS_SJ (SBJECT_CODE, BBS_TY_ID, BBS_ID, SBJECT_NAME) VALUES (82, null, 1, '작은');
						if (StringUtils.equals(one.getCategory1(), "81")) {
							one.setCategory5("h73");
						} else if (StringUtils.equals(one.getCategory1(), "137")) {
							one.setCategory5("h59");
						} else if (StringUtils.equals(one.getCategory1(), "82")) {
							one.setCategory5("h60");
						}
					}

					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					one.setManager_seq(manager_seq);
					if (manager_seq != 0) {
						List<String> dongguContents = service.getDongguContents(one);
						StringBuffer sb = new StringBuffer();
						for (String s : dongguContents) {
							sb.append(s);
						}
						one.setContent(sb.toString());
					}


					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "/Users/yongju/Documents/dglib2/donggu";

					if (manager_seq != 0) {
						List<Map<String, Object>> fileDataDonggu = service.getFileDataDonggu(one);

						if (!fileDataDonggu.isEmpty()) {
							for (int k = 0; k < fileDataDonggu.size(); k++) {
								map1 = new HashMap<String, Object>();
								map1 = fileDataDonggu.get(k);
								String fileName = String.valueOf(map1.get("ORG_FILE_NAME"));
								String serverfileName = String.valueOf(map1.get("SERVER_FILE_NAME"));
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(serverfileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								map1.put("ORG_FILE", serverfileName);
								orgFileMap.add(map1);
							}
						}
					} else {
						map1 = new HashMap<String, Object>();
						String fileName = one.getOrg_file_name();
						if (StringUtils.isNotEmpty(fileName)) {
							String serverfileName = one.getServer_file_name();

							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(serverfileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("ORG_FILE", serverfileName);
							orgFileMap.add(map1);
						}

					}


					if (StringUtils.isNotEmpty(one.getContent())) {
						one.setContent(one.getContent().replaceAll("http://www.donggu-lib.kr", "/data/userfiles/h45/"));
					}


					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq != 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}

								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					result += service.insertBoard(one);

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
//							String path = "/Users/yongju/Documents/dglib2/donggu/upload/moviesch/image/";
							try {
								service.fileMoveDonggu(map2, manage_idx);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}
	/**
	 * 수성도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/sslib.*"})
	public String sslib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "sslib";
	}

	/**
	 * 수성도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savesslib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savenn(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib_sslib");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "newbook")) {
					dataMap = service.getListNNNewBook(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovie(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNN(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getParent_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}

					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
						one.setRequest_state("4");
					}
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
						one.setUser_name("관리자");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\suseong\\data\\board\\";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.tglnet.or.kr/userfiles/", "/data/userfiles/h10/"));
					one.setContent(one.getContent().replaceAll("/userfiles/", "/data/userfiles/h9/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					String i5 = one.getImsi_v_5();
					String i6 = one.getImsi_v_6();
					String i8 = one.getImsi_v_8();
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setImsi_v_5(null);
						one.setImsi_v_6(null);
						one.setImsi_v_7(null);
						one.setImsi_v_8(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}

					one.setContent(one.getContent().replaceAll("/data/userfiles/", "/data/userfiles/h9/"));

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "F:\\프로젝트\\대구시교육청도서관\\db\\suseong\\data\\board\\"+tableConfig.get("A_TABLENAME")+"\\";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}



					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						int replyBoardIdx = service.getNextBoardIdx();
						DataMigration two = new DataMigration();
						two.setBoard_idx(replyBoardIdx);
						two.setGroup_seq(boardIdx);
						two.setManage_idx(manage_idx);
						two.setGroup_step(1);
						two.setParent_seq(boardIdx);
						two.setContent(i8);
						two.setUser_name(StringUtils.defaultIfEmpty(i5, "수성도서관"));
						two.setUser_id("admin");
						two.setTitle("답변 : " + one.getTitle());
						two.setAdd_date(StringUtils.defaultIfEmpty(StringUtils.replace(i6, "-00-00", one.getAdd_date()), one.getAdd_date()));


						try {
							two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
						service.insertBoard(two);
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}


	/**
	 * 달성도서관 - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/dslib.*"})
	public String dslib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "dslib";
	}

	/**
	 * 달성도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savedslib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveds(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				List<DataMigration> dataMap = null;
				if (manager_seq == -1) {
					List<Code> code = codeService.getCode("h4", "B0004");
					StringBuffer sb = new StringBuffer();
					for (Code c : code) {
						sb.append(String.format(" when bk_category = '%s' then '%s'", c.getCode_name(), c.getCode_id()));
					}
					dm.setCategory5(sb.toString());
					dataMap = service.orgListDK2(dm);
				} else if (manager_seq == -2) {
					dataMap = service.orgListDK3("");

				} else {
					dataMap = service.getListDK(manager_seq);

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);


					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}


					try {
						one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
					} catch (Exception e) {
						// TODO: handle exception
					}

					Map<String, Object> map1 = null;
					String fileFolder = "Board";
					if (manager_seq == -1) {
						fileFolder = "Book";
					} else if (manager_seq == -2) {
						fileFolder = "Movie";
					}
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\dalsung\\www0725\\homepage\\wd"+fileFolder+"\\upload\\";

					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					if (manager_seq < 0) {
						if (!StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "0") && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
							map1 = new HashMap<String, Object>();
							map1.put("ORG_FILE_NAME", one.getOrg_file_name());
							map1.put("SERVER_FILE_NAME", one.getServer_file_name());
							orgFileMapTmp.add(map1);
							map1 = null;
						}
					} else {
						orgFileMapTmp = service.getFileDataDK(one.getBoard_seq());
					}
					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.dsl.daegu.kr/wdCheditor/attach/", "/data/userfiles/h4/"));
					one.setContent(one.getContent().replaceAll("/wdCheditor/attach/", "/data/userfiles/h4/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					if (manager_seq < 0 && StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
						one.setPreview_img(one.getServer_file_name());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (manage_idx == 118) {
						one.setRequest_state("4");
					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = "F:\\프로젝트\\대구시교육청도서관\\db\\dalsung\\www0725\\homepage\\wd"+fileFolder+"\\upload\\";
							try {
								service.fileMoveDK(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());


				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}


	/**
	 * 228기념학생도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/lib228.*"})
	public String lib228(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "lib228";
	}

	/**
	 * 228기념학생도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/save228lib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save228lib(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호


				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib_228lib");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "book")) {
					dataMap = service.getListNNNewBook228(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovie228(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNN228(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getBoard_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
						one.setRequest_state("4");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					if (manage_idx != 216) {
						try {
							one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\228\\228source\\228source-2\\ROOT\\data\\board";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}

					one.setContent(one.getContent().replaceAll("/data/userfiles/", "/data/userfiles/h1/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					String i5 = one.getImsi_v_5();
					String i6 = one.getImsi_v_6();
					String i8 = one.getImsi_v_8();
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setImsi_v_5(null);
						one.setImsi_v_6(null);
						one.setImsi_v_7(null);
						one.setImsi_v_8(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = filePath+"\\"+tableConfig.get("A_TABLENAME")+"\\";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}



					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						int replyBoardIdx = service.getNextBoardIdx();
						DataMigration two = new DataMigration();
						two.setBoard_idx(replyBoardIdx);
						two.setGroup_seq(boardIdx);
						two.setManage_idx(manage_idx);
						two.setGroup_step(1);
						two.setParent_seq(boardIdx);
						two.setContent(i8);
						two.setUser_name(StringUtils.defaultIfEmpty(i5, "수성도서관"));
						two.setUser_id("admin");
						two.setTitle("답변 : " + one.getTitle());
						two.setAdd_date(StringUtils.defaultIfEmpty(StringUtils.replace(i6, "-00-00", one.getAdd_date()), one.getAdd_date()));


						try {
							two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
						service.insertBoard(two);
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	/**
	 * 228기념학생도서관 - 학교도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/support228.*"})
	public String support228(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "support228";
	}

	/**
	 * 228기념학생도서관 - 학교도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/save228support.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save228support(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호


				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib_228support");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
//				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "book")) {
//					dataMap = service.getListNNNewBook228(tableConfig.get("A_TABLENAME"));
//				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
//					dataMap = service.getListNNMovie228(tableConfig.get("A_TABLENAME"));
//
//				} else {
					dataMap = service.getListNN(tableConfig.get("A_TABLENAME"));

//				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getBoard_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


//					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
//						one.setUser_id("unknown");
//					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					if (manage_idx != 228) {
						try {
							one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\228\\228support\\data\\board";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}
					one.setContent(one.getContent().replaceAll("/data/userfiles/", "/data/userfiles/h1/"));
					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
//								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
//								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					String i5 = one.getImsi_v_5();
					String i6 = one.getImsi_v_6();
					String i8 = one.getImsi_v_8();
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setImsi_v_5(null);
						one.setImsi_v_6(null);
						one.setImsi_v_7(null);
						one.setImsi_v_8(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = filePath+"\\"+tableConfig.get("A_TABLENAME")+"\\";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}



					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						int replyBoardIdx = service.getNextBoardIdx();
						DataMigration two = new DataMigration();
						two.setBoard_idx(replyBoardIdx);
						two.setGroup_seq(boardIdx);
						two.setManage_idx(manage_idx);
						two.setGroup_step(1);
						two.setParent_seq(boardIdx);
						two.setContent(i8);
						two.setUser_name(StringUtils.defaultIfEmpty(i5, "수성도서관"));
						two.setUser_id("admin");
						two.setTitle("답변 : " + one.getTitle());
						two.setAdd_date(StringUtils.defaultIfEmpty(StringUtils.replace(i6, "-00-00", one.getAdd_date()), one.getAdd_date()));


						try {
							two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
						service.insertBoard(two);
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	/**
	 * 두류도서관 - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/drlib.*"})
	public String drlib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "drlib";
	}

	/**
	 * 두류도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savedrlib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savedr(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				List<DataMigration> dataMap = null;
				if (manager_seq == -1) {
					List<Code> code = codeService.getCode("h6", "B0003");
					StringBuffer sb = new StringBuffer();
					for (Code c : code) {
						sb.append(String.format(" when bk_category = '%s' then '%s'", c.getCode_name(), c.getCode_id()));
					}
					dm.setCategory5(sb.toString());
					dataMap = service.orgListDK2(dm);
				} else if (manager_seq == -2) {
					dataMap = service.orgListDK3("");

				} else {
					dataMap = service.getListDK(manager_seq);

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setManage_idx(manage_idx);

					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}

					if (manage_idx != 130) {
						try {
							System.out.println("@@@@@@@@@@@@@@@@ aaa : ");
							String a = StrUtil.delHtmlTagPatterns(one.getContent());
							System.out.println("@@@@@@@@@@@@@@@@ bbb : ");
							String b = StrUtil.previewContent(a,1000);
							System.out.println("@@@@@@@@@@@@@@@@ ccc : ");
							one.setContent_summary(b);
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;
					String fileFolder = "Board";
					if (manager_seq == -1) {
						fileFolder = "Book";
					} else if (manager_seq == -2) {
						fileFolder = "Movie";
					}
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\duryu\\homepage\\duryu_main\\wd"+fileFolder+"\\upload\\";

					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					if (manager_seq < 0) {
						if (!StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "0") && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
							map1 = new HashMap<String, Object>();
							map1.put("ORG_FILE_NAME", one.getOrg_file_name());
							map1.put("SERVER_FILE_NAME", one.getServer_file_name());
							orgFileMapTmp.add(map1);
							map1 = null;
						}
					} else {
						orgFileMapTmp = service.getFileDataDK(one.getBoard_seq());
					}
					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.duryu-lib.daegu.kr/duryu_main/wdCheditor/attach/", "/data/userfiles/h6/"));
					one.setContent(one.getContent().replaceAll("/duryu_main/wdCheditor/attach/", "/data/userfiles/h6/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					if (manager_seq < 0 && StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
						one.setPreview_img(one.getServer_file_name());
					}

					one.setBoard_file_count(orgFileMap.size());
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목없음"));
					one.setUser_name(StringUtils.defaultIfEmpty(one.getUser_name(), "관리자"));
					if (manage_idx == 133) {
						one.setRequest_state("4");
					}

					try {
						one.setUser_name(URLDecoder.decode(one.getUser_name(), "UTF-8"));
					} catch (UnsupportedEncodingException e1) {
					} catch (NullPointerException e2) {
					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							try {
								service.fileMoveDK(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());


				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}


	/**
	 * 북부도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/bblib.*"})
	public String bblib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "bblib";
	}

	/**
	 * 북부도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savebblib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savebblib(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호


				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib_bukbu");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "book")) {
					dataMap = service.getListNNNewBookBukbu(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovieBukbu(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNNBukbu(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getBoard_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					if (manage_idx != 216) {
						try {
							one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\bukbu\\www\\bblib2017\\data\\board";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}

					one.setContent(one.getContent().replaceAll("/userfiles/", "/data/userfiles/h7/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					String i5 = one.getImsi_v_5();
					String i6 = one.getImsi_v_6();
					String i8 = one.getImsi_v_8();
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setImsi_v_5(null);
						one.setImsi_v_6(null);
						one.setImsi_v_7(null);
						one.setImsi_v_8(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}

					if (manage_idx == 148 || manage_idx == 149 || manage_idx == 4) {
						one.setRequest_state("4");
					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = filePath+"\\"+tableConfig.get("A_TABLENAME")+"\\";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}



					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						int replyBoardIdx = service.getNextBoardIdx();
						DataMigration two = new DataMigration();
						two.setBoard_idx(replyBoardIdx);
						two.setGroup_seq(boardIdx);
						two.setManage_idx(manage_idx);
						two.setGroup_step(1);
						two.setParent_seq(boardIdx);
						two.setContent(i8);
						two.setUser_name(StringUtils.defaultIfEmpty(i5, "수성도서관"));
						two.setUser_id("admin");
						two.setTitle("답변 : " + one.getTitle());
						two.setAdd_date(StringUtils.defaultIfEmpty(StringUtils.replace(i6, "-00-00", one.getAdd_date()), one.getAdd_date()));


						try {
							two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
						service.insertBoard(two);
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}



	/**
	 * 서부도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/sblib.*"})
	public String sblib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "sblib";
	}

	/**
	 * 서부도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savesblib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savesblib(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호


				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib_seobu");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "book")) {
					dataMap = service.getListNNNewBookSeobu(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovieSeobu(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNNBukbu(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getBoard_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					if (manage_idx != 216) {
						try {
							one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\seobu\\sblib201011\\data\\board";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.tglnet.or.kr/userfiles/", "/data/userfiles/h10/"));
					one.setContent(one.getContent().replaceAll("http://www.seobu-lib.daegu.kr/userfiles/", "/data/userfiles/h8/"));
					one.setContent(one.getContent().replaceAll("/userfiles/", "/data/userfiles/h8/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					String i5 = one.getImsi_v_5();
					String i6 = one.getImsi_v_6();
					String i8 = one.getImsi_v_8();
					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setImsi_v_5(null);
						one.setImsi_v_6(null);
						one.setImsi_v_7(null);
						one.setImsi_v_8(null);
					}

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목없음"));
					if (manage_idx == 165) {
						one.setRequest_state("4");
					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = filePath+"\\"+tableConfig.get("A_TABLENAME")+"\\";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}



					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						int replyBoardIdx = service.getNextBoardIdx();
						DataMigration two = new DataMigration();
						two.setBoard_idx(replyBoardIdx);
						two.setGroup_seq(boardIdx);
						two.setManage_idx(manage_idx);
						two.setGroup_step(1);
						two.setParent_seq(boardIdx);
						two.setContent(i8);
						two.setUser_name(StringUtils.defaultIfEmpty(i5, "수성도서관"));
						two.setUser_id("admin");
						two.setTitle("답변 : " + one.getTitle());
						two.setAdd_date(StringUtils.defaultIfEmpty(StringUtils.replace(i6, "-00-00", one.getAdd_date()), one.getAdd_date()));


						try {
							two.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(two.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
						service.insertBoard(two);
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	/**
	 * 남부도서관 - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/nblib.*"})
	public String nblib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "nblib";
	}

	/**
	 * 남부도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savenblib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savenb(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				List<DataMigration> dataMap = null;
				if (manager_seq == -1) {
					if (manage_idx == 102) {
						dm.setImsi_n_1(2);//권장도서
					} else {
						dm.setImsi_n_1(5);//어르신
					}
					dataMap = service.orgListDK2(dm);
				} else if (manager_seq == -2) {
					dataMap = service.orgListDK3("");

				} else {
					dataMap = service.getListDK(manager_seq);

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setManage_idx(manage_idx);

					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}

					if (manage_idx != 130) {
						try {
							System.out.println("@@@@@@@@@@@@@@@@ aaa : ");
							String a = StrUtil.delHtmlTagPatterns(one.getContent());
							System.out.println("@@@@@@@@@@@@@@@@ bbb : ");
							String b = StrUtil.previewContent(a,1000);
							System.out.println("@@@@@@@@@@@@@@@@ ccc : ");
							one.setContent_summary(b);
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;
					String fileFolder = "Board";
					if (manager_seq == -1) {
						fileFolder = "Book";
					} else if (manager_seq == -2) {
						fileFolder = "Movie";
					}
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\nambu\\source\\www0718\\nambulib\\wd"+fileFolder+"\\upload\\";

					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					if (manager_seq < 0) {
						if (!StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "0") && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
							map1 = new HashMap<String, Object>();
							map1.put("ORG_FILE_NAME", one.getOrg_file_name());
							map1.put("SERVER_FILE_NAME", one.getServer_file_name());
							orgFileMapTmp.add(map1);
							map1 = null;
						}
					} else {
						orgFileMapTmp = service.getFileDataDK(one.getBoard_seq());
					}
					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}
					one.setContent(one.getContent().replaceAll("http://www.nbl.or.kr/wdCheditor/attach/", "/data/userfiles/h3/"));
					one.setContent(one.getContent().replaceAll("/wdCheditor/attach/", "/data/userfiles/h3/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					if (manager_seq < 0 && StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
						one.setPreview_img(one.getServer_file_name());
					}

					one.setBoard_file_count(orgFileMap.size());
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목없음"));

					if (manage_idx == 101 || manage_idx == 111) {
						one.setRequest_state("4");
					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							try {
								service.fileMoveDK(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());


				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	/**
	 * 동부도서관 - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/dblib.*"})
	public String dblib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "dblib";
	}

	/**
	 * 동부도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savedblib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savedb(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				List<DataMigration> dataMap = null;
				if (manager_seq == -1) {
					dataMap = service.orgListDK2(dm);
				} else if (manager_seq == -2) {
					dataMap = service.orgListDK3("");

				} else {
					dataMap = service.getListDK(manager_seq);

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setManage_idx(manage_idx);

					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}

					if (manage_idx != 130) {
						try {
							System.out.println("@@@@@@@@@@@@@@@@ aaa : ");
							String a = StrUtil.delHtmlTagPatterns(one.getContent());
							System.out.println("@@@@@@@@@@@@@@@@ bbb : ");
							String b = StrUtil.previewContent(a,1000);
							System.out.println("@@@@@@@@@@@@@@@@ ccc : ");
							one.setContent_summary(b);
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;
					String fileFolder = "Board";
					if (manager_seq == -1) {
						fileFolder = "Book";
					} else if (manager_seq == -2) {
						fileFolder = "Movie";
						if (one.getImsi_v_6().equals("시청각실")) {
							one.setCategory1("0001");
						} else if (one.getImsi_v_6().equals("북스타트룸")) {
							one.setCategory1("0002");
						}
					}
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\dongbu\\www0722\\new\\wd"+fileFolder+"\\upload\\";

					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					if (manager_seq < 0) {
						if (!StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "0") && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
							map1 = new HashMap<String, Object>();
							map1.put("ORG_FILE_NAME", one.getOrg_file_name());
							map1.put("SERVER_FILE_NAME", one.getServer_file_name());
							orgFileMapTmp.add(map1);
							map1 = null;
						}
					} else {
						orgFileMapTmp = service.getFileDataDK(one.getBoard_seq());
					}
					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.dongbu-lib.daegu.kr/newwdCheditor/attach/", "/data/userfiles/h5/"));
					one.setContent(one.getContent().replaceAll("./wdCheditor/attach/", "/data/userfiles/h5/"));
					one.setContent(one.getContent().replaceAll("/wdCheditor/attach/", "/data/userfiles/h5/"));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					if (manager_seq < 0 && StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
						one.setPreview_img(one.getServer_file_name());
					}

					one.setBoard_file_count(orgFileMap.size());
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목없음"));

					if (manage_idx == 124 || manage_idx == 125) {
						one.setRequest_state("4");
					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							try {
								service.fileMoveDK(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());


				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}


	/**
	 * 중앙도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/jalib.*"})
	public String jalib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "jalib";
	}

	/**
	 * 중앙도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savejalib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savejalib(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호


				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib_jungang");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "book")) {
					dataMap = service.getListNNNewBookJungang(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovieJungang(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNNJungang(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getParent_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					if (manage_idx != 216) {
						try {
							one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\jungang\\board";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.tglnet.or.kr/userfiles/", "/data/userfiles/h10/"));
					one.setContent(one.getContent().replaceAll("/userfiles/", "/data/userfiles/h10/"));


					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목없음"));
					if (manage_idx == 185 || manage_idx == 185) {
						one.setRequest_state("4");
					}
					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = filePath+"\\"+tableConfig.get("A_TABLENAME")+"\\";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}

	/**
	 * 중앙도서관 - NN
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/hublib.*"})
	public String hublib(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "hublib";
	}

	/**
	 * 중앙도서관
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/savehublib.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savehublib(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호


				//테이블명 가져오기
				Map<String, String> tableConfig = service.getTableNameNN(manager_seq);

				//파일목록 가져오기
				dm.setDbUser("dglib_hublib");
				dm.setTableName(tableConfig.get("A_TABLENAME"));
				List<String> fileList = service.getFileListNN(dm);
				String fileColumns = StringUtils.join(fileList, ", ");

				List<DataMigration> dataMap = null;
				if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "book")) {
					dataMap = service.getListNNNewBookJungang(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
					dataMap = service.getListNNMovieJungang(tableConfig.get("A_TABLENAME"));
				} else if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "nninc_lib")) {
					dataMap = service.getListNNHubLib(tableConfig.get("A_TABLENAME"));

				} else {
					dataMap = service.getListNNHub(tableConfig.get("A_TABLENAME"));

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);

					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setGroup_seq(boardIdx);
					one.setManage_idx(manage_idx);

					idxMap.put(one.getBoard_seq(), boardIdx);
					if (one.getParent_seq() != 0) {
						if (one.getBoard_seq() != one.getParent_seq()) {
							if (idxMap.get(one.getParent_seq()) != null) {
								one.setGroup_seq(idxMap.get(one.getParent_seq()));
								one.setParent_seq(idxMap.get(one.getParent_seq()));
								one.setGroup_step(1);
							}
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					} else {
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					}


					if (StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "qna")) {
						one.setUser_id("unknown");
					}
					one.setUser_id(StringUtils.defaultIfEmpty(one.getUser_id(), "unknown"));

					if (manage_idx != 216) {
						try {
							one.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(one.getContent()),1000));
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;

					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\jungang\\board";

					one.setFileColumns(fileColumns);
					one.setTableName(tableConfig.get("A_TABLENAME"));
					Map<String, String> fileDataNN = service.getFileDataNN(one);

					if (!fileDataNN.isEmpty()) {
						for (int k = 1; k <= fileList.size(); k++) {
							String columnName = "b_file"+k;
							if (fileDataNN.containsKey(columnName) && StringUtils.isNotBlank(fileDataNN.get(columnName))) {
								map1 = new HashMap<String, Object>();
								String fileName = fileDataNN.get(columnName);
								map1.put("ORG_FILE_NAME", fileName);
								map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
								File f = new File(filePath + tableConfig.get("A_TABLENAME") + "\\" + fileName);
								map1.put("FILE_SIZE", f.length());
								String filename = "";
								String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
								String rndchars = RandomStringUtils.randomAlphanumeric(7);
								filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
								map1.put("SERVER_FILE_NAME", filename);
								orgFileMap.add(map1);
							}
						}

					}

					one.setContent(one.getContent().replaceAll("http://www.tglnet.or.kr/userfiles/", "/data/userfiles/h10/"));
					one.setContent(one.getContent().replaceAll("/userfiles/", "/data/userfiles/h10/"));


					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (!StringUtils.containsIgnoreCase(tableConfig.get("A_LEVEL"), "movie")) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					one.setBoard_file_count(orgFileMap.size());

					if (StringUtils.equals(one.getAdd_date(), "-00-00")) {

					}
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목없음"));
					if (manage_idx == 185 || manage_idx == 185) {
						one.setRequest_state("4");
					}
					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							String path = filePath+"\\"+tableConfig.get("A_TABLENAME")+"\\";
							try {
								service.fileMoveNN(map2, manage_idx, path);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());

				}

			}


		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}



	/**
	 * 228민주 - DK
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param model
	 * @param dm
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/minju.*"})
	public String minju(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "minju";
	}

	/**
	 * 228민주
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param dm
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/saveminju.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveminju(DataMigration dm, HttpServletRequest request) {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));//MYSQL게시판번호
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));//CMS게시판번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				List<DataMigration> dataMap = null;
				if (manager_seq == -1) {
					List<Code> code = codeService.getCode("h2", "B0003");
					StringBuffer sb = new StringBuffer();
					for (Code c : code) {
						sb.append(String.format(" when bk_category = '%s' then '%s'", c.getCode_name(), c.getCode_id()));
					}
					dm.setCategory5(sb.toString());
					dataMap = service.orgListDK2(dm);
				} else if (manager_seq == -2) {
					dataMap = service.orgListDK3("");

				} else {
					dataMap = service.getListDK(manager_seq);

				}
				int result = 0;
				for (int j = 0; j < dataMap.size(); j++) {
					DataMigration one = dataMap.get(j);


					int boardIdx = service.getNextBoardIdx();
					one.setBoard_idx(boardIdx);
					one.setManage_idx(manage_idx);

					if (one.getGroup_step() == 0) {
						idxMap.put(one.getGroup_seq(), boardIdx);
						one.setGroup_seq(boardIdx);
						one.setParent_seq(0);
					} else {
						if (idxMap.get(one.getGroup_seq()) != null) {
							one.setParent_seq(idxMap.get(one.getGroup_seq()));
							one.setGroup_seq(idxMap.get(one.getGroup_seq()));
						} else {
							one.setGroup_seq(boardIdx);
							one.setParent_seq(0);
						}
					}

					if (manage_idx != 130) {
						try {
							System.out.println("@@@@@@@@@@@@@@@@ aaa : ");
							String a = StrUtil.delHtmlTagPatterns(one.getContent());
							System.out.println("@@@@@@@@@@@@@@@@ bbb : ");
							String b = StrUtil.previewContent(a,1000);
							System.out.println("@@@@@@@@@@@@@@@@ ccc : ");
							one.setContent_summary(b);
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

					Map<String, Object> map1 = null;
					String fileFolder = "Board";
					if (manager_seq == -1) {
						fileFolder = "Book";
					} else if (manager_seq == -2) {
						fileFolder = "Movie";
					}
					String filePath = "F:\\프로젝트\\대구시교육청도서관\\db\\228minju\\html\\wd"+fileFolder+"\\upload\\";

					List<Map<String, Object>> orgFileMapTmp = new ArrayList<Map<String, Object>>();
					if (manager_seq < 0) {
						if (!StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "0") && !StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
							map1 = new HashMap<String, Object>();
							map1.put("ORG_FILE_NAME", one.getOrg_file_name());
							map1.put("SERVER_FILE_NAME", one.getServer_file_name());
							orgFileMapTmp.add(map1);
							map1 = null;
						}
					} else {
						orgFileMapTmp = service.getFileDataDK(one.getBoard_seq());
					}
					List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

					if (!orgFileMapTmp.isEmpty()) {
						for (int k = 0; k < orgFileMapTmp.size(); k++) {
							Map<String, Object> tmpFile = orgFileMapTmp.get(k);
							map1 = new HashMap<String, Object>();
							String fileName = String.valueOf(tmpFile.get("ORG_FILE_NAME"));
							String sFileName = String.valueOf(tmpFile.get("SERVER_FILE_NAME"));
							map1.put("S_FILE_NAME", sFileName);
							map1.put("ORG_FILE_NAME", fileName);
							map1.put("FILE_EXT", fileName.substring(fileName.lastIndexOf(".")+1));
							File f = new File(filePath + sFileName);
							map1.put("FILE_SIZE", f.length());
							String filename = "";
							String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
							String rndchars = RandomStringUtils.randomAlphanumeric(7);
							filename = datetime + "_" + rndchars + "." + map1.get("FILE_EXT");
							map1.put("SERVER_FILE_NAME", filename);
							orgFileMap.add(map1);
						}

					}
					one.setContent(one.getContent().replaceAll("http://www.228lib.or.k/data/userfiles/", "/data/userfiles/h2/"));
					one.setContent(one.getContent().replaceAll("http://www.228lib.or.kr/new/wdCheditor/attach/", "/data/userfiles/h2/"));
					one.setContent(one.getContent().replaceAll("./wdCheditor/attach/", "/data/userfiles/h2/"));
					one.setContent(one.getContent().replaceAll("/wdCheditor/attach/", "/data/userfiles/h2/"));
					one.setContent(one.getContent().replaceAll("\\\\\"", ""));

					if (orgFileMap != null && orgFileMap.size() > 0) {
						String content = "";
						for (Map<String, Object> map2 : orgFileMap) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
								if (manager_seq > 0) {
									content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("SERVER_FILE_NAME"))+"\" ></p>";
								}
								if (StringUtils.isEmpty(one.getPreview_img())) {
									one.setPreview_img(String.valueOf(map2.get("SERVER_FILE_NAME")));
								}
							}
						}
						one.setContent(content + one.getContent());
					}

					if (manager_seq < 0 && StringUtils.equalsIgnoreCase(one.getOrg_file_name(), "api")) {
						one.setPreview_img(one.getServer_file_name());
					}

					one.setBoard_file_count(orgFileMap.size());
					one.setTitle(StringUtils.defaultIfEmpty(one.getTitle(), "제목없음"));

					if (manage_idx == 99) {
						one.setRequest_state("4");
					}

					result += service.insertBoard(one);

					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "."+fileExt.toLowerCase());
							}
							map2.put("add_id", one.getUser_id());
							try {
								service.fileMoveDK(map2, manage_idx, filePath);
								service.insertBoardFile(map2);
							} catch (Exception e) {
								// TODO: handle exception
							}
						}
					}

					System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
					System.out.println("@@@@@@@@@@@@@@@@ progress : " + (j+1) + " / " + dataMap.size());
					System.out.println("@@@@@@@@@@@@@@@@ result : " + result + " / " + dataMap.size());


				}

			}

		}


		JsonResponse res = new JsonResponse(request);
		res.setValid(true);

		return res;
	}







}