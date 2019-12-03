package kr.co.whalesoft.app.cms.dataMigration;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.file.Download;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StrUtil;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.book.BookService;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.teacher.Teacher;

@Controller
@RequestMapping(value = {"/cms/dm"})
public class DataMigrationController extends BaseController {

	private final String basePath = "/cms/dataMigration/";

	@Autowired
	private BoardManageService boardManageService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private DataMigrationService service;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private BookService bookService;

	@Autowired
	private ElibCategoryService elibCategoryService;

	@RequestMapping(value = {"/index.*"})
	public String migration(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "migration";
	}

	@RequestMapping(value = {"/dk.*"})
	public String dk(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "dk";
	}

	@RequestMapping(value = {"/info.*"})
	public String info(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "info";
	}

	@RequestMapping(value = {"/yd.*"})
	public String yd(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "yd";
	}

	@RequestMapping(value = {"/sj.*"})
	public String sj(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "sj";
	}

	@RequestMapping(value = {"/gm.*"})
	public String gm(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "gm";
	}

	@RequestMapping(value = {"/od.*"})
	public String od(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "od";
	}

	@RequestMapping(value = {"/jc.*"})
	public String jc(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "jc";
	}

	@RequestMapping(value = {"/sju.*"})
	public String sju(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "sju";
	}

	@RequestMapping(value = {"/gbccs.*"})
	public String gbccs(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "gbccs";
	}

	@RequestMapping(value = {"/makethumb.*"})
	public String makethumb(Model model, DataMigration dm, HttpServletRequest request, HttpServletResponse response) {
		return basePath + "makethumb";
	}

	/**
	 * 센터 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(DataMigration dm, HttpServletRequest request) throws SQLException, IOException {

//		Map<String, Object> paramMap = request.getParameterMap();
//		Map<String, Object> map = new HashMap<String, Object>();
//		Iterator it = paramMap.keySet().iterator();
//		String key = null;
//		String[] value = null;
//		while(it.hasNext())
//		{
//		    key = (String) it.next();
//		    value = (String[]) paramMap.get(key);
//		    for(int i=0; i<value.length; i++)
//		    {
//		        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
//		    }
//		    String arraystos = Arrays.toString(value);
//		    arraystos = arraystos.substring(1, arraystos.length()-1);
//		    map.put(key, arraystos);
//		}


		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {
				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));
				List<DataMigration> dataMap = service.orgList(Integer.parseInt(manager_seq_arr.get(i)));

				for (DataMigration orgMap : dataMap) {

					List<Map<String, Object>> orgFileMap = service.getFileData(orgMap.getBoard_seq());
					int boardIdx = service.getNextBoardIdx();
					orgMap.setBoard_idx(boardIdx);
					orgMap.setManage_idx(manage_idx);

					if (orgMap.getNotice_start_date() != null) {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						orgMap.setNotice_start_date_str(sdf.format(orgMap.getNotice_start_date()));
					}

					if (orgMap.getNotice_end_date() != null) {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						orgMap.setNotice_end_date_str(sdf.format(orgMap.getNotice_end_date()));
					}

					if (StringUtils.isEmpty(orgMap.getUser_id())) {
						orgMap.setUser_id("admin");
					}

					service.insertBoard(orgMap);
					for (Map<String, Object> map2 : orgFileMap) {
						map2.put("board_idx", boardIdx);
						service.insertBoardFile(map2);
						service.fileMove(map2, manager_seq, manage_idx);
					}


					List<Map<String, Object>> orgCommentMap = service.getCommentData(orgMap.getBoard_seq());

					for (Map<String, Object> map2 : orgCommentMap) {
						map2.put("board_idx", boardIdx);
						service.insertBoardComment(map2);
					}
				}

			}
		}




		JsonResponse res = new JsonResponse(request);
		res.setValid(true);


//		service.migration(dataMap, manager_seq, manage_idx);
//		service.migration2(dataMap, manager_seq, manage_idx);
//		service.migration3(list, manager_seq, manage_idx);
		return res;
	}

	/**
	 * 학생문화회관 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = { "/save2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save2(DataMigration dm, HttpServletRequest request) throws SQLException, IOException {

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();
		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {
				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));
				List<DataMigration> dataMap = service.orgGbccsList(Integer.parseInt(manager_seq_arr.get(i)));

				for (DataMigration orgMap : dataMap) {

					List<Map<String, Object>> orgFileMap = service.getGbccsFileData(orgMap);
					List<Map<String, Object>> orgCommentMap = service.getGbccsCommentData(orgMap);

					int boardIdx = service.getNextBoardIdx();
					idxMap.put(orgMap.getBoard_seq(), boardIdx);
					orgMap.setBoard_idx(boardIdx);
					orgMap.setManage_idx(manage_idx);

					if (orgMap.getGroup_step() != 0) {
						if (orgMap.getBoard_seq() != orgMap.getParent_seq()) {
							if (idxMap.get(orgMap.getBoard_seq()) != null) {
								orgMap.setParent_seq(idxMap.get(orgMap.getGroup_seq()));
								orgMap.setGroup_seq(idxMap.get(orgMap.getGroup_seq()));
							}
						} else {
							orgMap.setGroup_seq(boardIdx);
							orgMap.setParent_seq(0);
						}
					} else {
						orgMap.setGroup_seq(boardIdx);
						orgMap.setParent_seq(0);
					}

					if (orgMap.getNotice_start_date() != null) {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						orgMap.setNotice_start_date_str(sdf.format(orgMap.getNotice_start_date()));
					}

					if (orgMap.getNotice_end_date() != null) {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						orgMap.setNotice_end_date_str(sdf.format(orgMap.getNotice_end_date()));
					}

					if (StringUtils.isEmpty(orgMap.getUser_id())) {
						orgMap.setUser_id("admin");
					}

					String previewName = "";

					for (Map<String, Object> map2 : orgFileMap) {
						map2.put("board_idx", boardIdx);

						String realFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
						String fileext = realFileName.substring(realFileName.lastIndexOf(".")+1);
						String fileName = "";
						fileName = Long.toString((System.currentTimeMillis()));
						if (previewName.equals("")) {
							String ext = "jpg|bmp|gif|png|jpeg";
							if (ext.indexOf(fileext.toLowerCase()) > -1) {
								previewName = fileName;
							}
						}
						map2.put("FILE_EXT", fileext);
						map2.put("FILE_NAME", fileName);

						long fileSize = 0;
						String sourceFileName = String.valueOf(map2.get("RENAME_FILE_NAME"));
						File sourceFile = new File("D:\\develop_tool\\uploadFiles\\commBoard\\" + String.valueOf(map2.get("PATH")) + "\\" + sourceFileName);
						fileSize = sourceFile.length();
						map2.put("FILE_SIZE", fileSize);

						service.insertBoardFile(map2);
						service.fileMoveGbccs(map2, manager_seq, manage_idx);
					}


					for (Map<String, Object> map2 : orgCommentMap) {
						map2.put("board_idx", boardIdx);
						service.insertBoardComment(map2);
					}

					orgMap.setPreview_img(previewName);
					int filecount = 0;
					try {
						filecount = orgFileMap.size();
					} catch (Exception e) {
						// TODO: handle exception
					}
					orgMap.setFile_count(filecount);
					if (StringUtils.isNotEmpty(orgMap.getContent()) && orgMap.getContent().length() < 4000) {
//						orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));
					}
					orgMap.setPreview_content("");
					if (StringUtils.isNotEmpty(orgMap.getSecret_yn()) ) {
						orgMap.setSecret_yn(orgMap.getSecret_yn().trim());
					}
					service.insertBoard(orgMap);
				}

			}
		}




		JsonResponse res = new JsonResponse(request);
		res.setValid(true);


//		service.migration(dataMap, manager_seq, manage_idx);
//		service.migration2(dataMap, manager_seq, manage_idx);
//		service.migration3(list, manager_seq, manage_idx);
		return res;
	}

	/**
	 * dk 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "/savedk.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save2(HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);

//		int dataType = Integer.parseInt((String) map.get("dataType"));
//		int manager_seq = Integer.parseInt((String) map.get("manager_seq"));
		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		String categoryName = (String)map.get("manager_seq");
		List<DataMigration> list = null;
//		list = service.orgListDK(manager_seq);
		list = service.orgListDK2(categoryName);
//		switch (dataType) {
//		case 1:
//			list = service.orgListDK(manager_seq);
//			break;
//		case 2:
//			list = service.orgListDKtheme(manager_seq);
//			break;
//		default:
//			list = service.orgListDKbook(manager_seq);
//			break;
//		}


		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
//			List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = null;

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
			map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
			map1.put("FILE_EXT", "tmp");
			map1.put("FILE_SIZE", 0);
			orgFileMap = new ArrayList<Map<String, Object>>();
			if (!orgMap.getReal_file_name().startsWith("http")) {
				orgFileMap.add(map1);
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);
			if (orgMap.getCategory1().equals("1")) {
				orgMap.setCategory1("001");
			} else if (orgMap.getCategory1().equals("2")) {
				orgMap.setCategory1("002");
			} else if (orgMap.getCategory1().equals("5")) {
				orgMap.setCategory1("003");
			}

			orgMap.setGroup_seq(boardIdx);
			orgMap.setParent_seq(0);
//			if (manager_seq == 2) {
//				orgMap.setGroup_seq(idxMap.get(orgMap.getBoard_seq()));
//				orgMap.setParent_seq(0);
//			} else {
//				if (orgMap.getBoard_seq() != orgMap.getParent_seq()) {
//					if (idxMap.get(orgMap.getBoard_seq()) != null) {
//						orgMap.setGroup_seq(idxMap.get(orgMap.getParent_seq()));
//						orgMap.setParent_seq(idxMap.get(orgMap.getParent_seq()));
//					}
//				} else {
//					orgMap.setGroup_seq(boardIdx);
//					orgMap.setParent_seq(0);
//				}
//			}
			orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));
//			if (orgFileMap != null && orgFileMap.size() > 0) {
//				String content = "";
//				for (Map<String, Object> map2 : orgFileMap) {
//					if (String.valueOf(map2.get("REAL_FILE_NAME")).indexOf(".") > -1) {
//						content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("REAL_FILE_NAME"))+"\" ></p>";
//					}
//				}
//				orgMap.setContent(content + orgMap.getContent());
//			}

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {
				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}
//			if (!orgMap.getReal_file_name().startsWith("http")) {
//				orgMap.setPreview_img(orgMap.getReal_file_name());
//			}


			orgMap.setFile_count(orgFileMap.size());
			service.insertBoarddk(orgMap);
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					service.insertBoardFiledk(map2);
					service.fileMoveDK(map2, manage_idx);
				}
			}










//			List<Map<String, Object>> orgCommentMap = service.getCommentDK(orgMap.getBoard_seq());
//			orgCommentMap = null;
//			System.out.println("@@@@@@@@@@@ commentSize : " + orgCommentMap.size());
//			if (orgCommentMap != null && orgCommentMap.size() > 0) {
//				for (Map<String, Object> map2 : orgCommentMap) {
//					if (StringUtils.isNotEmpty(String.valueOf(map2.get("add_date")))) {
//						String add_date = orgMap.getAdd_date() + "000";
//						long addDate = Long.parseLong(add_date);
//						map2.put("crt_dt", format.parse(format.format(addDate)));
//					}
//					if (StringUtils.isNotEmpty(String.valueOf(map2.get("modify_date")))) {
//						String modify_date = orgMap.getModify_date() + "000";
//						long modifyDate = Long.parseLong(modify_date);
//						map2.put("upt_dt", format.parse(format.format(modifyDate)));
//					}
//					map2.put("board_idx", boardIdx);
//					service.addBoardCommentdk(map2);
//				}
//			}

		}

		return res;
	}



	/**
	 * info 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "/saveinfo.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveInfo(HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);

//		int dataType = Integer.parseInt((String) map.get("dataType"));
		int manager_seq = Integer.parseInt((String) map.get("manager_seq"));
		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
//		String categoryName = (String)map.get("manager_seq");
		List<DataMigration> list = null;
		list = service.orgListINFO(manager_seq);


//		list = service.orgListDK2(categoryName);

		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());
		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
//			List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

			Map<String, Object> map1 = null;

			boolean hasFile1 = false;
			boolean hasFile2 = false;
			boolean hasFile3 = false;
			boolean hasFile4 = false;
			boolean hasFile5 = false;

			if (!StringUtils.isEmpty(orgMap.getImsi_v_1())) {
				hasFile1 = true;
				map1 = new HashMap<String, Object>();
				map1.put("REAL_FILE_NAME", orgMap.getImsi_v_1());
				map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_2());
				map1.put("FILE_EXT", orgMap.getImsi_v_1().substring(orgMap.getImsi_v_1().lastIndexOf(".")+1));
				map1.put("FILE_SIZE", 0);
				String fileName = Long.toString((System.currentTimeMillis()))+"1" + orgMap.getImsi_v_1().substring(orgMap.getImsi_v_1().lastIndexOf("."));
				map1.put("FILE_NAME", fileName);
				orgFileMap.add(map1);
			}

			if (hasFile1) {
				if (!StringUtils.isEmpty(orgMap.getImsi_v_3())) {
					hasFile2 = true;
					map1 = new HashMap<String, Object>();
					map1.put("REAL_FILE_NAME", orgMap.getImsi_v_3());
					map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_4());
					map1.put("FILE_EXT", orgMap.getImsi_v_3().substring(orgMap.getImsi_v_3().lastIndexOf(".")+1));
					map1.put("FILE_SIZE", 0);
					String fileName = Long.toString((System.currentTimeMillis()))+"2" + orgMap.getImsi_v_3().substring(orgMap.getImsi_v_3().lastIndexOf("."));
					map1.put("FILE_NAME", fileName);
					orgFileMap.add(map1);
				}
				if (hasFile2) {
					if (!StringUtils.isEmpty(orgMap.getImsi_v_5())) {
						hasFile3 = true;
						map1 = new HashMap<String, Object>();
						map1.put("REAL_FILE_NAME", orgMap.getImsi_v_5());
						map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_6());
						map1.put("FILE_EXT", orgMap.getImsi_v_5().substring(orgMap.getImsi_v_5().lastIndexOf(".")+1));
						map1.put("FILE_SIZE", 0);
						String fileName = Long.toString((System.currentTimeMillis()))+"3" + orgMap.getImsi_v_5().substring(orgMap.getImsi_v_5().lastIndexOf("."));
						map1.put("FILE_NAME", fileName);
						orgFileMap.add(map1);
					}
					if (hasFile3) {
						if (!StringUtils.isEmpty(orgMap.getImsi_v_7())) {
							hasFile4 = true;
							map1 = new HashMap<String, Object>();
							map1.put("REAL_FILE_NAME", orgMap.getImsi_v_7());
							map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_8());
							map1.put("FILE_EXT", orgMap.getImsi_v_7().substring(orgMap.getImsi_v_7().lastIndexOf(".")+1));
							map1.put("FILE_SIZE", 0);
							String fileName = Long.toString((System.currentTimeMillis()))+"4" + orgMap.getImsi_v_7().substring(orgMap.getImsi_v_7().lastIndexOf("."));
							map1.put("FILE_NAME", fileName);
							orgFileMap.add(map1);
						}
						if (hasFile4) {
							if (!StringUtils.isEmpty(orgMap.getImsi_v_9())) {
								hasFile5 = true;
								map1 = new HashMap<String, Object>();
								map1.put("REAL_FILE_NAME", orgMap.getImsi_v_9());
								map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_10());
								map1.put("FILE_EXT", orgMap.getImsi_v_9().substring(orgMap.getImsi_v_9().lastIndexOf(".")+1));
								map1.put("FILE_SIZE", 0);
								String fileName = Long.toString((System.currentTimeMillis()))+"5" + orgMap.getImsi_v_9().substring(orgMap.getImsi_v_9().lastIndexOf("."));
								map1.put("FILE_NAME", fileName);
								orgFileMap.add(map1);
							}
						}
					}
				}
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

//			orgMap.setGroup_seq(boardIdx);
//			orgMap.setParent_seq(0);
//			if (manager_seq == 2) {
//				orgMap.setGroup_seq(idxMap.get(orgMap.getBoard_seq()));
//				orgMap.setParent_seq(0);
//			} else {
				if (orgMap.getBoard_seq() != orgMap.getGroup_seq()) {
					if (idxMap.get(orgMap.getBoard_seq()) != null) {
						orgMap.setParent_seq(idxMap.get(orgMap.getGroup_seq()));
						orgMap.setGroup_seq(idxMap.get(orgMap.getGroup_seq()));
					}
				} else {
					orgMap.setGroup_seq(boardIdx);
					orgMap.setParent_seq(0);
				}
//			}
			if  (StringUtils.isEmpty(orgMap.getContent())) {
				orgMap.setContent("");
			}
			if (StringUtils.isNotEmpty(orgMap.getContent())) {
				orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));
			}



			if (orgFileMap != null && orgFileMap.size() > 0) {
				String content = "";
				for (Map<String, Object> map2 : orgFileMap) {
					String ext = "jpg|bmp|gif|png|jpeg";
					if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
						if (content.equals("")) {
							content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("FILE_NAME"))+"\" ></p>";
							orgMap.setPreview_img(String.valueOf(map2.get("FILE_NAME")));
						}
					}
				}
				orgMap.setContent(content + orgMap.getContent());
			}

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {
				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}
//			if (!orgMap.getReal_file_name().startsWith("http")) {
//			orgMap.setPreview_img(orgMap.getReal_file_name());
//			orgMap.setPreview_img(String.valueOf(map2.get("FILE_NAME")));
//			}


			orgMap.setFile_count(orgFileMap.size());
			service.insertBoarddk(orgMap);
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					service.insertBoardFiledk(map2);
					service.fileMoveDK(map2, manage_idx);
				}
			}

		}

		return res;
	}


	/**
	 * 영덕도서관 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "/saveyd.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveyd(HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);

		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		String table_name = (String)map.get("manager_seq");
		List<DataMigration> list = null;
		DataMigration tmp = new DataMigration();
		tmp.setTableName(table_name);
//		list = service.orgListyd2(tmp);
		list = service.orgListyd(tmp);

		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());
		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = service.getFileDataYD(orgMap.getBoard_seq());

			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

			if (orgMap.getBoard_seq() != orgMap.getParent_seq()) {
				if (idxMap.get(orgMap.getBoard_seq()) != null) {
					int parentseq = idxMap.get(orgMap.getParent_seq());
					orgMap.setParent_seq(parentseq);
					orgMap.setGroup_seq(parentseq);
				}
			} else {
				orgMap.setGroup_seq(boardIdx);
				orgMap.setParent_seq(0);
			}
			if  (StringUtils.isEmpty(orgMap.getContent())) {
				orgMap.setContent("");
			}
			if (StringUtils.isNotEmpty(orgMap.getContent())) {
				orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));
			}

			if (StringUtils.isNotEmpty(orgMap.getImsi_v_20())) {
				orgMap.setImsi_v_20(StrUtil.previewContent(orgMap.getImsi_v_20(), 2000));
			}

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {
				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}

			orgMap.setFile_count(orgFileMap.size());
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String realFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
					String fileext = realFileName.substring(realFileName.lastIndexOf(".")+1);
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileext.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					map2.put("FILE_EXT", fileext);
					map2.put("FILE_NAME", fileName);


					long fileSize = 0;
					try {
						fileSize = (Long) map2.get("FILE_SIZE");
					} catch (Exception e) {
					}

					if ( fileSize == 0 ) {
						String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
						File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
						fileSize = sourceFile.length();
						map2.put("FILE_SIZE", fileSize);
					}

					service.insertBoardFiledk(map2);
					service.fileMoveDK(map2, manage_idx);
				}
			}
			orgMap.setPreview_img(previewName);

			service.insertBoardyd(orgMap);


		}

		return res;
	}


	/**
	 * dk 상주 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "savesj.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savesj(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				continue;
			} else {
				System.out.println("@@@@@@@@@@@@@@@ manager_seq size : " + manager_seq_arr.get(i));
				System.out.println("@@@@@@@@@@@@@@@ manage_idx size : " + manage_idx_arr.get(i));

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));

				List<DataMigration> list = null;
				list = service.orgListDK(manager_seq);

				System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

				//  원래번호 ,  신규번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				for (int j = 0; j < list.size(); j++) {

					DataMigration orgMap = list.get(j);
					System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
					List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
//					List<Map<String, Object>> orgFileMap = null;

//					Map<String, Object> map1 = new HashMap<String, Object>();
//					map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
//					map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
//					map1.put("FILE_EXT", "tmp");
//					map1.put("FILE_SIZE", 0);
//					orgFileMap = new ArrayList<Map<String, Object>>();
//					if (!orgMap.getReal_file_name().startsWith("http")) {
//						orgFileMap.add(map1);
//					}

//					System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
					int boardIdx = service.getNextBoardIdx();
					idxMap.put(orgMap.getBoard_seq(), boardIdx);
					orgMap.setBoard_idx(boardIdx);
					orgMap.setManage_idx(manage_idx);
//					if (orgMap.getCategory1().equals("1")) {
//						orgMap.setCategory1("001");
//					} else if (orgMap.getCategory1().equals("2")) {
//						orgMap.setCategory1("002");
//					} else if (orgMap.getCategory1().equals("5")) {
//						orgMap.setCategory1("003");
//					}

//					orgMap.setGroup_seq(boardIdx);
//					orgMap.setParent_seq(0);
////					if (manager_seq == 2) {
////						orgMap.setGroup_seq(idxMap.get(orgMap.getBoard_seq()));
////						orgMap.setParent_seq(0);
////					} else {
					if (orgMap.getParent_seq() != 0) {
						if (orgMap.getBoard_seq() != orgMap.getParent_seq()) {
							if (idxMap.get(orgMap.getBoard_seq()) != null) {
								orgMap.setGroup_seq(idxMap.get(orgMap.getParent_seq()));
								orgMap.setParent_seq(idxMap.get(orgMap.getParent_seq()));
							}
						} else {
							orgMap.setGroup_seq(boardIdx);
							orgMap.setParent_seq(0);
						}
					} else {
						orgMap.setGroup_seq(boardIdx);
						orgMap.setParent_seq(0);
					}
//					orgMap.setGroup_seq(boardIdx);
//					orgMap.setParent_seq(0);
//					}

					orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
						String add_date = orgMap.getAdd_date() + "000";
						long addDate = Long.parseLong(add_date);
						orgMap.setCrt_dt(format.parse(format.format(addDate)));
					}
					if (StringUtils.isNotEmpty(orgMap.getModify_date())) {
						String modify_date = orgMap.getModify_date() + "000";
						long modifyDate = Long.parseLong(modify_date);
						orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
					}
//					if (!orgMap.getReal_file_name().startsWith("http")) {
//						orgMap.setPreview_img(orgMap.getReal_file_name());
//					}


					orgMap.setFile_count(orgFileMap.size());
					String previewName = "";
					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "." + fileExt.toLowerCase());
							}
							String fileName = "";
							fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
							if (previewName.equals("")) {
								String ext = "jpg|bmp|gif|png|jpeg";
								if (ext.indexOf(fileExt.toLowerCase()) > -1) {
									previewName = fileName;
								}
							}
							map2.put("FILE_NAME", fileName);




							long fileSize = 0;
							try {
								fileSize = (Long) map2.get("FILE_SIZE");
							} catch (Exception e) {
							}

							if ( fileSize == 0 ) {
								String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
								File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
								fileSize = sourceFile.length();
								map2.put("FILE_SIZE", fileSize);
							}

							service.insertBoardFiledk(map2);
							service.fileMoveDK(map2, manage_idx);
						}
					}
					orgMap.setPreview_img(previewName);
					if (StringUtils.isEmpty(orgMap.getUser_id())) {
						orgMap.setUser_id("admin");
					}
					service.insertBoarddk(orgMap);

					List<Map<String, Object>> orgCommentMap = service.getCommentDK(orgMap.getBoard_seq());
//					orgCommentMap = null;
					System.out.println("@@@@@@@@@@@ commentSize : " + orgCommentMap.size());
					if (orgCommentMap != null && orgCommentMap.size() > 0) {
						for (Map<String, Object> map2 : orgCommentMap) {
							if (StringUtils.isNotEmpty(String.valueOf(map2.get("add_date")))) {
								String add_date = orgMap.getAdd_date() + "000";
								long addDate = Long.parseLong(add_date);
								map2.put("crt_dt", format.parse(format.format(addDate)));
							}
							if (StringUtils.isNotEmpty(String.valueOf(map2.get("modify_date")))) {
								String modify_date = orgMap.getModify_date() + "000";
								long modifyDate = Long.parseLong(modify_date);
								map2.put("upt_dt", format.parse(format.format(modifyDate)));
							}
							map2.put("board_idx", boardIdx);
							service.addBoardCommentdk(map2);
						}
					}

				}

			}
		}

		res.setValid(true);
		return res;
	}


	/**
	 * dk 상주 이관 - 도서
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "savesj2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savesj2(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);


		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				break;
			}
		}

//		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		int manage_idx = Integer.parseInt(manage_idx_arr.get(0));
		List<DataMigration> list = null;
		list = service.orgListDK2("");
		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
//			List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = null;

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
			map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
			String fileext = "";
			String extpattern = "jpg|bmp|gif|png|jpeg";
			if (extpattern.indexOf(orgMap.getReal_file_name().toLowerCase()) < 0) {
				fileext = "jpg";
			} else {
				fileext = orgMap.getReal_file_name().substring(orgMap.getReal_file_name().indexOf(".")+1);
			}
			map1.put("FILE_EXT", fileext);

			orgFileMap = new ArrayList<Map<String, Object>>();
			if (StringUtils.isNotEmpty(orgMap.getReal_file_name())) {
				if (!orgMap.getReal_file_name().startsWith("http")) {
					orgFileMap.add(map1);
				}
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

			orgMap.setGroup_seq(boardIdx);
			orgMap.setParent_seq(0);
			orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {

				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}
//			if (!orgMap.getReal_file_name().startsWith("http")) {
//				orgMap.setPreview_img(orgMap.getReal_file_name());
//			}


			orgMap.setFile_count(orgFileMap.size());
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileExt.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					long fileSize = 0;
					try {
						fileSize = (Long) map2.get("FILE_SIZE");
					} catch (Exception e) {
					}

					if ( fileSize == 0 ) {
						String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
						File sourceFile = new File("D:\\develop_tool\\book\\" + sourceFileName);
						fileSize = sourceFile.length();
						map2.put("FILE_SIZE", fileSize);
					}
					map2.put("FILE_NAME", fileName);
					service.insertBoardFiledk(map2);
					service.fileMovebookDK(map2, manage_idx);
				}
			}
			orgMap.setPreview_img(previewName);
			if (StringUtils.isEmpty(orgMap.getUser_id())) {
				orgMap.setUser_id("admin");
			}
			if (StringUtils.isEmpty(orgMap.getTitle())) {
				orgMap.setTitle("제목없음");
			}
			service.insertBoarddk(orgMap);

			List<Map<String, Object>> orgCommentMap = service.getCommentDK(orgMap.getBoard_seq());
//			List<Map<String, Object>> orgCommentMap = service.getReadCommentDK(orgMap.getBoard_seq());
//			orgCommentMap = null;
			System.out.println("@@@@@@@@@@@ commentSize : " + orgCommentMap.size());
			if (orgCommentMap != null && orgCommentMap.size() > 0) {
				for (Map<String, Object> map2 : orgCommentMap) {
					if (StringUtils.isNotEmpty(String.valueOf(map2.get("add_date")))) {
						String add_date = orgMap.getAdd_date() + "000";
						long addDate = Long.parseLong(add_date);
						map2.put("crt_dt", format.parse(format.format(addDate)));
					}
					if (StringUtils.isNotEmpty(String.valueOf(map2.get("modify_date")))) {
						long modifyDate = 0;
						String modify_date = orgMap.getModify_date() + "000";
						try {
							modifyDate = Long.parseLong(modify_date);
						} catch (Exception e) {
							modifyDate = Long.parseLong("0000");
						}
						map2.put("upt_dt", format.parse(format.format(modifyDate)));
					}
					map2.put("board_idx", boardIdx);
					service.addBoardCommentdk(map2);
				}
			}

		}

		return res;
	}


	/**
	 * dk 상주 이관 - 영화
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "savesj3.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savesj3(HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);

//		int dataType = Integer.parseInt((String) map.get("dataType"));
//		int manager_seq = Integer.parseInt((String) map.get("manager_seq"));
		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		String categoryName = (String)map.get("manager_seq");
		List<DataMigration> list = null;
//		list = service.orgListDK(manager_seq);
		list = service.orgListDK3(categoryName);
//		switch (dataType) {
//		case 1:
//			list = service.orgListDK(manager_seq);
//			break;
//		case 2:
//			list = service.orgListDKtheme(manager_seq);
//			break;
//		default:
//			list = service.orgListDKbook(manager_seq);
//			break;
//		}
		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
//			List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = null;

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
			map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
			String fileext = "";
			String extpattern = "jpg|bmp|gif|png|jpeg";
			if (extpattern.indexOf(orgMap.getReal_file_name().toLowerCase()) < 0) {
				fileext = "jpg";
			} else {
				fileext = orgMap.getReal_file_name().substring(orgMap.getReal_file_name().indexOf(".")+1);
			}
			map1.put("FILE_EXT", fileext);
			map1.put("FILE_SIZE", 0);
			orgFileMap = new ArrayList<Map<String, Object>>();
			if (StringUtils.isNotEmpty(orgMap.getReal_file_name()) && (!orgMap.getReal_file_name().equals("0"))) {
				if (!orgMap.getReal_file_name().startsWith("http")) {
					orgFileMap.add(map1);
				}
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

			orgMap.setGroup_seq(boardIdx);
			orgMap.setParent_seq(0);
			orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {

				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}
//			if (!orgMap.getReal_file_name().startsWith("http")) {
//				orgMap.setPreview_img(orgMap.getReal_file_name());
//			}


			int fileCount = orgFileMap == null ? 0 : orgFileMap.size();
			orgMap.setFile_count(fileCount);
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileExt.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					map2.put("FILE_NAME", fileName);
					service.insertBoardFiledk(map2);
					service.fileMovebookDK(map2, manage_idx);
				}
			}
			orgMap.setPreview_img(previewName);
			if (StringUtils.isEmpty(orgMap.getUser_id())) {
				orgMap.setUser_id("admin");
			}
			if (StringUtils.isEmpty(orgMap.getTitle())) {
				orgMap.setTitle("제목없음");
			}
			service.insertBoarddk(orgMap);

			//영화 코멘트 없음
//			List<Map<String, Object>> orgCommentMap = service.getCommentDK(orgMap.getBoard_seq());
//			orgCommentMap = null;
//			System.out.println("@@@@@@@@@@@ commentSize : " + orgCommentMap.size());
//			if (orgCommentMap != null && orgCommentMap.size() > 0) {
//				for (Map<String, Object> map2 : orgCommentMap) {
//					if (StringUtils.isNotEmpty(String.valueOf(map2.get("add_date")))) {
//						String add_date = orgMap.getAdd_date() + "000";
//						long addDate = Long.parseLong(add_date);
//						map2.put("crt_dt", format.parse(format.format(addDate)));
//					}
//					if (StringUtils.isNotEmpty(String.valueOf(map2.get("modify_date")))) {
//						long modifyDate = 0;
//						String modify_date = orgMap.getModify_date() + "000";
//						try {
//							modifyDate = Long.parseLong(modify_date);
//						} catch (Exception e) {
//							modifyDate = Long.parseLong("0000");
//						}
//						map2.put("upt_dt", format.parse(format.format(modifyDate)));
//					}
//					map2.put("board_idx", boardIdx);
//					service.addBoardCommentdk(map2);
//				}
//			}

		}

		return res;
	}

	/**
	 * 섬네일 생성
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "savemakethumb.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savemakethumb(HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);

		int manager_seq = Integer.parseInt((String) map.get("manager_seq"));
		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		List<DataMigration> list = null;
		list = service.boardList(manager_seq);
		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);




			System.out.println("@@@@@@@@@@@@@@ board_idx : " + orgMap.getBoard_idx());
			List<BoardFile> orgFileMap = service.getFileList(orgMap.getBoard_seq());

			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (BoardFile map2 : orgFileMap) {
					service.makeThumb(manager_seq, map2);
				}
			}


		}

		return res;
	}



	/**
	 * dk 구미 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "savegm.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savegm(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				break;
			} else {
				System.out.println("@@@@@@@@@@@@@@@ manager_seq size : " + manager_seq_arr.get(i));
				System.out.println("@@@@@@@@@@@@@@@ manage_idx size : " + manage_idx_arr.get(i));

				int manager_seq = Integer.parseInt(manager_seq_arr.get(i));
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));

				List<DataMigration> list = null;
				list = service.orgListGM(manager_seq);

				System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

				//  원래번호 ,  신규번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				for (int j = 0; j < list.size(); j++) {

					DataMigration orgMap = list.get(j);
					System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
					List<Map<String, Object>> orgFileMap = service.getFileDataGM(orgMap.getBoard_seq());

					int boardIdx = service.getNextBoardIdx();
					idxMap.put(orgMap.getBoard_seq(), boardIdx);
					orgMap.setBoard_idx(boardIdx);
					orgMap.setManage_idx(manage_idx);

					if (manager_seq == 3) {
						if (orgMap.getParent_seq() != 0) {
							if (orgMap.getBoard_seq() != orgMap.getParent_seq()) {
								if (idxMap.get(orgMap.getBoard_seq()) != null) {
									orgMap.setGroup_seq(idxMap.get(orgMap.getParent_seq()));
									orgMap.setParent_seq(idxMap.get(orgMap.getParent_seq()));
								}
							} else {
								orgMap.setGroup_seq(boardIdx);
								orgMap.setParent_seq(0);
							}
						} else {
							orgMap.setGroup_seq(boardIdx);
							orgMap.setParent_seq(0);
						}
					} else {
						orgMap.setGroup_seq(boardIdx);
						orgMap.setParent_seq(0);
					}

					orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
						String add_date = orgMap.getAdd_date() + "000";
						long addDate = Long.parseLong(add_date);
						orgMap.setCrt_dt(format.parse(format.format(addDate)));
					}
					if (StringUtils.isNotEmpty(orgMap.getModify_date())) {
						String modify_date = orgMap.getModify_date() + "000";
						long modifyDate = Long.parseLong(modify_date);
						orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
					}
					if (StringUtils.isNotEmpty(orgMap.getNotice_start_date_str()) && !orgMap.getNotice_start_date_str().equals("0")) {
						String modify_date = orgMap.getNotice_start_date_str() + "000";
						long modifyDate = Long.parseLong(modify_date);
						orgMap.setNotice_start_date(format.parse(format.format(modifyDate)));
					}
					if (StringUtils.isNotEmpty(orgMap.getNotice_end_date_str()) && !orgMap.getNotice_end_date_str().equals("0")) {
						String modify_date = orgMap.getNotice_end_date_str() + "000";
						long modifyDate = Long.parseLong(modify_date);
						orgMap.setNotice_end_date(format.parse(format.format(modifyDate)));
					}
//					if (!orgMap.getReal_file_name().startsWith("http")) {
//						orgMap.setPreview_img(orgMap.getReal_file_name());
//					}


					orgMap.setFile_count(orgFileMap.size());
					String previewName = "";
					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "." + fileExt.toLowerCase());
							}
							String fileName = "";
							fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
							if (previewName.equals("")) {
								String ext = "jpg|bmp|gif|png|jpeg";
								if (ext.indexOf(fileExt.toLowerCase()) > -1) {
									previewName = fileName;
								}
							}
							map2.put("FILE_NAME", fileName);




							long fileSize = 0;
							try {
								fileSize = (Long) map2.get("FILE_SIZE");
							} catch (Exception e) {
							}

							if ( fileSize == 0 ) {
								String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
								File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
								fileSize = sourceFile.length();
								map2.put("FILE_SIZE", fileSize);
							}

							service.insertBoardFiledk(map2);
							service.fileMoveGM(map2, manage_idx);
						}
					}
					orgMap.setPreview_img(previewName);
					if (StringUtils.isEmpty(orgMap.getUser_id())) {
						orgMap.setUser_id("admin");
					}
					service.insertBoarddk(orgMap);

				}

			}
		}

		res.setValid(true);
		return res;
	}




	/**
	 * dk 구미 이관 - 영화
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "savegm3.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savegm3(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);



		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				break;
			}
		}

//		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		int manage_idx = Integer.parseInt(manage_idx_arr.get(0));
		String categoryName = (String)map.get("manager_seq");
		List<DataMigration> list = null;
		list = service.orgListGM3(categoryName);
		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
//			List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = null;

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
			map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
			String fileext = "";
			String extpattern = "jpg|bmp|gif|png|jpeg";
			if (extpattern.indexOf(orgMap.getReal_file_name().toLowerCase()) < 0) {
				fileext = "jpg";
			} else {
				fileext = orgMap.getReal_file_name().substring(orgMap.getReal_file_name().indexOf(".")+1);
			}
			map1.put("FILE_EXT", fileext);
			map1.put("FILE_SIZE", 0);
			orgFileMap = new ArrayList<Map<String, Object>>();
			if (StringUtils.isNotEmpty(orgMap.getReal_file_name()) && (!orgMap.getReal_file_name().equals("0"))) {
				if (!orgMap.getReal_file_name().startsWith("http")) {
					orgFileMap.add(map1);
				}
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

			orgMap.setGroup_seq(boardIdx);
			orgMap.setParent_seq(0);
			orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {

				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}
//			if (!orgMap.getReal_file_name().startsWith("http")) {
//				orgMap.setPreview_img(orgMap.getReal_file_name());
//			}


			int fileCount = orgFileMap == null ? 0 : orgFileMap.size();
			orgMap.setFile_count(fileCount);
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileExt.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					map2.put("FILE_NAME", fileName);
					service.insertBoardFiledk(map2);
					service.fileMovebookDK(map2, manage_idx);
				}
			}
			if (previewName.equals("")) {
				orgMap.setPreview_img(orgMap.getReal_file_name());
			} else {
				orgMap.setPreview_img(previewName);
			}
			if (StringUtils.isEmpty(orgMap.getUser_id())) {
				orgMap.setUser_id("admin");
			}
			if (StringUtils.isEmpty(orgMap.getTitle())) {
				orgMap.setTitle("제목없음");
			}
			service.insertBoarddk(orgMap);

		}

		return res;
	}



	/**
	 * dk 구미 이관 - 도서
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "savegm2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savegm2(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);


		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				break;
			}
		}

//		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		int manage_idx = Integer.parseInt(manage_idx_arr.get(0));
		List<DataMigration> list = null;
		list = service.orgListGM2("");
		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
//			List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = null;

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
			map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
			String fileext = "";
			String extpattern = "jpg|bmp|gif|png|jpeg";
			if (extpattern.indexOf(orgMap.getReal_file_name().toLowerCase()) < 0) {
				fileext = "jpg";
			} else {
				fileext = orgMap.getReal_file_name().substring(orgMap.getReal_file_name().indexOf(".")+1);
			}
			map1.put("FILE_EXT", fileext);

			orgFileMap = new ArrayList<Map<String, Object>>();
			if (StringUtils.isNotEmpty(orgMap.getReal_file_name())) {
				if (!orgMap.getReal_file_name().startsWith("http")) {
					orgFileMap.add(map1);
				}
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

			orgMap.setGroup_seq(boardIdx);
			orgMap.setParent_seq(0);
			orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {

				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}
//			if (!orgMap.getReal_file_name().startsWith("http")) {
//				orgMap.setPreview_img(orgMap.getReal_file_name());
//			}


			orgMap.setFile_count(orgFileMap.size());
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileExt.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					long fileSize = 0;
					try {
						fileSize = (Long) map2.get("FILE_SIZE");
					} catch (Exception e) {
					}

					if ( fileSize == 0 ) {
						String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
						File sourceFile = new File("D:\\develop_tool\\book\\" + sourceFileName);
						fileSize = sourceFile.length();
						map2.put("FILE_SIZE", fileSize);
					}
					map2.put("FILE_NAME", fileName);
					service.insertBoardFiledk(map2);
					service.fileMovebookDK(map2, manage_idx);
				}
			}
			if (orgMap.getReal_file_name().startsWith("http")) {
				orgMap.setPreview_img(orgMap.getReal_file_name());
			} else {
				orgMap.setPreview_img(previewName);
			}
			if (StringUtils.isEmpty(orgMap.getUser_id())) {
				orgMap.setUser_id("admin");
			}
			if (StringUtils.isEmpty(orgMap.getTitle())) {
				orgMap.setTitle("제목없음");
			}
			if (StringUtils.isEmpty(orgMap.getUser_name())) {
				orgMap.setUser_name("관리자");
			}
			service.insertBoarddk(orgMap);

//			List<Map<String, Object>> orgCommentMap = service.getCommentDK(orgMap.getBoard_seq());
//			List<Map<String, Object>> orgCommentMap = service.getReadCommentDK(orgMap.getBoard_seq());
//			orgCommentMap = null;
//			System.out.println("@@@@@@@@@@@ commentSize : " + orgCommentMap.size());
//			if (orgCommentMap != null && orgCommentMap.size() > 0) {
//				for (Map<String, Object> map2 : orgCommentMap) {
//					if (StringUtils.isNotEmpty(String.valueOf(map2.get("add_date")))) {
//						String add_date = orgMap.getAdd_date() + "000";
//						long addDate = Long.parseLong(add_date);
//						map2.put("crt_dt", format.parse(format.format(addDate)));
//					}
//					if (StringUtils.isNotEmpty(String.valueOf(map2.get("modify_date")))) {
//						long modifyDate = 0;
//						String modify_date = orgMap.getModify_date() + "000";
//						try {
//							modifyDate = Long.parseLong(modify_date);
//						} catch (Exception e) {
//							modifyDate = Long.parseLong("0000");
//						}
//						map2.put("upt_dt", format.parse(format.format(modifyDate)));
//					}
//					map2.put("board_idx", boardIdx);
//					service.addBoardCommentdk(map2);
//				}
//			}

		}

		return res;
	}




	/**
	 * dk 외동 이관 - 도서
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "saveod2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveod2(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);


		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				break;
			}
		}

//		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		int manage_idx = Integer.parseInt(manage_idx_arr.get(0));
		List<DataMigration> list = null;
		list = service.orgListOD2("");
		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
//			List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = null;

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
			map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
			String fileext = "";
			String extpattern = "jpg|bmp|gif|png|jpeg";
			if (extpattern.indexOf(orgMap.getReal_file_name().toLowerCase()) < 0) {
				fileext = "jpg";
			} else {
				fileext = orgMap.getReal_file_name().substring(orgMap.getReal_file_name().indexOf(".")+1);
			}
			map1.put("FILE_EXT", fileext);

			orgFileMap = new ArrayList<Map<String, Object>>();
			if (StringUtils.isNotEmpty(orgMap.getReal_file_name())) {
				if (!orgMap.getReal_file_name().startsWith("http")) {
					orgFileMap.add(map1);
				}
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

			orgMap.setGroup_seq(boardIdx);
			orgMap.setParent_seq(0);
			orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {

				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}
//			if (!orgMap.getReal_file_name().startsWith("http")) {
//				orgMap.setPreview_img(orgMap.getReal_file_name());
//			}


			orgMap.setFile_count(orgFileMap.size());
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileExt.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					long fileSize = 0;
					try {
						fileSize = (Long) map2.get("FILE_SIZE");
					} catch (Exception e) {
					}

					if ( fileSize == 0 ) {
						String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
						File sourceFile = new File("D:\\develop_tool\\book\\" + sourceFileName);
						fileSize = sourceFile.length();
						map2.put("FILE_SIZE", fileSize);
					}
					map2.put("FILE_NAME", fileName);
					service.insertBoardFiledk(map2);
					service.fileMovebookDK(map2, manage_idx);
				}
			}
			orgMap.setPreview_img(previewName);
			if (StringUtils.isEmpty(orgMap.getUser_id())) {
				orgMap.setUser_id("admin");
			}
			if (StringUtils.isEmpty(orgMap.getTitle())) {
				orgMap.setTitle("제목없음");
			}
			service.insertBoarddk(orgMap);

//			List<Map<String, Object>> orgCommentMap = service.getCommentDK(orgMap.getBoard_seq());
//			List<Map<String, Object>> orgCommentMap = service.getReadCommentDK(orgMap.getBoard_seq());
//			orgCommentMap = null;
//			System.out.println("@@@@@@@@@@@ commentSize : " + orgCommentMap.size());
//			if (orgCommentMap != null && orgCommentMap.size() > 0) {
//				for (Map<String, Object> map2 : orgCommentMap) {
//					if (StringUtils.isNotEmpty(String.valueOf(map2.get("add_date")))) {
//						String add_date = orgMap.getAdd_date() + "000";
//						long addDate = Long.parseLong(add_date);
//						map2.put("crt_dt", format.parse(format.format(addDate)));
//					}
//					if (StringUtils.isNotEmpty(String.valueOf(map2.get("modify_date")))) {
//						long modifyDate = 0;
//						String modify_date = orgMap.getModify_date() + "000";
//						try {
//							modifyDate = Long.parseLong(modify_date);
//						} catch (Exception e) {
//							modifyDate = Long.parseLong("0000");
//						}
//						map2.put("upt_dt", format.parse(format.format(modifyDate)));
//					}
//					map2.put("board_idx", boardIdx);
//					service.addBoardCommentdk(map2);
//				}
//			}

		}

		return res;
	}



	/**
	 * info 점촌 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@RequestMapping(value = { "savejc.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savejc(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		JsonResponse res = new JsonResponse(request);

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				break;
			} else {
				System.out.println("@@@@@@@@@@@@@@@ manager_seq size : " + manager_seq_arr.get(i));
				System.out.println("@@@@@@@@@@@@@@@ manage_idx size : " + manage_idx_arr.get(i));

				String tabale_name = String.valueOf(manager_seq_arr.get(i));
				int manage_idx = Integer.parseInt(manage_idx_arr.get(i));
				DataMigration tableName = new DataMigration(tabale_name);
				List<DataMigration> list = null;
				list = service.orgListJC(tableName);

				System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

				//  원래번호 ,  신규번호
				Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

				for (int j = 0; j < list.size(); j++) {

					DataMigration orgMap = list.get(j);
					System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
					List<Map<String, Object>> orgFileMap = service.getFileDataJC(orgMap);
//					List<Map<String, Object>> orgFileMap = null;

//					Map<String, Object> map1 = new HashMap<String, Object>();
//					map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
//					map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
//					map1.put("FILE_EXT", "tmp");
//					map1.put("FILE_SIZE", 0);
//					orgFileMap = new ArrayList<Map<String, Object>>();
//					if (!orgMap.getReal_file_name().startsWith("http")) {
//						orgFileMap.add(map1);
//					}

//					System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
					int boardIdx = service.getNextBoardIdx();
					idxMap.put(orgMap.getBoard_seq(), boardIdx);
					orgMap.setBoard_idx(boardIdx);
					orgMap.setManage_idx(manage_idx);
//					if (orgMap.getCategory1().equals("1")) {
//						orgMap.setCategory1("001");
//					} else if (orgMap.getCategory1().equals("2")) {
//						orgMap.setCategory1("002");
//					} else if (orgMap.getCategory1().equals("5")) {
//						orgMap.setCategory1("003");
//					}

//					orgMap.setGroup_seq(boardIdx);
//					orgMap.setParent_seq(0);
////					if (manager_seq == 2) {
////						orgMap.setGroup_seq(idxMap.get(orgMap.getBoard_seq()));
////						orgMap.setParent_seq(0);
////					} else {
					if (orgMap.getParent_seq() != 0) {
						if (orgMap.getBoard_seq() != orgMap.getParent_seq()) {
							if (idxMap.get(orgMap.getBoard_seq()) != null) {
								orgMap.setGroup_seq(idxMap.get(orgMap.getParent_seq()));
								orgMap.setParent_seq(idxMap.get(orgMap.getParent_seq()));
							}
						} else {
							orgMap.setGroup_seq(boardIdx);
							orgMap.setParent_seq(0);
						}
					} else {
						orgMap.setGroup_seq(boardIdx);
						orgMap.setParent_seq(0);
					}
//					orgMap.setGroup_seq(boardIdx);
//					orgMap.setParent_seq(0);
//					}

					if (StringUtils.isNotEmpty(orgMap.getContent())) {
						orgMap.setContent(orgMap.getContent().replaceAll("&lt;", "<"));
						orgMap.setContent(orgMap.getContent().replaceAll("&gt;", ">"));
						orgMap.setContent(orgMap.getContent().replaceAll("&quot;", "'"));
					}

					if (orgMap.getBoard_seq() != 17 &&
							orgMap.getBoard_seq() != 26) {
						orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));
					}

					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//					if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
//						String add_date = orgMap.getAdd_date() + "000";
//						long addDate = Long.parseLong(add_date);
//						orgMap.setCrt_dt(format.parse(format.format(addDate)));
//					} else {
//						orgMap.setCrt_dt(new Date());
//					}
//					if (StringUtils.isNotEmpty(orgMap.getModify_date())) {
//						String modify_date = orgMap.getModify_date() + "000";
//						long modifyDate = Long.parseLong(modify_date);
//						orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
//					} else {
//						orgMap.setUpt_dt(new Date());
//					}
						orgMap.setUpt_dt(orgMap.getCrt_dt());


					orgMap.setFile_count(orgFileMap.size());
					String previewName = "";
					if (orgFileMap != null && orgFileMap.size() > 0) {
						for (Map<String, Object> map2 : orgFileMap) {
							map2.put("board_idx", boardIdx);
							String fileExt = String.valueOf(map2.get("FILE_EXT"));
							if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
								map2.put("FILE_EXT", "." + fileExt.toLowerCase());
							}
							String fileName = "";
							fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
							if (previewName.equals("")) {
								String ext = "jpg|bmp|gif|png|jpeg";
								if (ext.indexOf(fileExt.toLowerCase()) > -1) {
									previewName = fileName;
								}
							}
							map2.put("FILE_NAME", fileName);




							long fileSize = 0;
							try {
								fileSize = (Long) map2.get("FILE_SIZE");
							} catch (Exception e) {
							}

							if ( fileSize == 0 ) {
								String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
								File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
								fileSize = sourceFile.length();
								map2.put("FILE_SIZE", fileSize);
							}

							service.insertBoardFiledk(map2);
							service.fileMoveDK(map2, manage_idx);
						}
					}
					orgMap.setPreview_img(previewName);
					if (StringUtils.isEmpty(orgMap.getUser_id())) {
						orgMap.setUser_id("admin");
					}
					service.insertBoarddk(orgMap);

				}

			}
		}

		res.setValid(true);
		return res;
	}


	/**
	 * dk 외동 이관 - 도서
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@RequestMapping(value = { "savejc2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savejc2(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		JsonResponse res = new JsonResponse(request);

		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				break;
			}
		}

//		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
		int manage_idx = Integer.parseInt(manage_idx_arr.get(0));
		List<DataMigration> list = null;
//		list = service.orgListJCBook();
		list = service.orgListJCMovie();
		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = null;

			if (StringUtils.isNotEmpty(orgMap.getReal_file_name())) {
				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
				map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
				String fileext = "";
				String extpattern = "jpg|bmp|gif|png|jpeg";
				if (extpattern.indexOf(orgMap.getReal_file_name().toLowerCase()) < 0) {
					fileext = "jpg";
				} else {
					fileext = orgMap.getReal_file_name().substring(orgMap.getReal_file_name().indexOf(".")+1);
				}
				map1.put("FILE_EXT", fileext);

				orgFileMap = new ArrayList<Map<String, Object>>();
				if (StringUtils.isNotEmpty(orgMap.getReal_file_name())) {
					if (!orgMap.getReal_file_name().startsWith("http")) {
						orgFileMap.add(map1);
					}
				}
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

			orgMap.setGroup_seq(boardIdx);
			orgMap.setParent_seq(0);
			orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			} else {
				orgMap.setCrt_dt(new Date());
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {
				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			} else {
				orgMap.setUpt_dt(new Date());
			}

			int fileCOunt = (orgFileMap == null || orgFileMap.size()==0) ? 0 : orgFileMap.size();
			orgMap.setFile_count(fileCOunt);
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileExt.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					long fileSize = 0;
					try {
						fileSize = (Long) map2.get("FILE_SIZE");
					} catch (Exception e) {
					}

					if ( fileSize == 0 ) {
						String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
						File sourceFile = new File("D:\\develop_tool\\book\\" + sourceFileName);
						fileSize = sourceFile.length();
						map2.put("FILE_SIZE", fileSize);
					}
					map2.put("FILE_NAME", fileName);
					service.insertBoardFiledk(map2);
					service.fileMovebookDK(map2, manage_idx);
				}
			}
			orgMap.setPreview_img(previewName);
			if (StringUtils.isEmpty(orgMap.getUser_id())) {
				orgMap.setUser_id("admin");
			}
			if (StringUtils.isEmpty(orgMap.getTitle())) {
				orgMap.setTitle("제목없음");
			}
			service.insertBoarddk(orgMap);

		}

		return res;
	}



	/**
	 * 풍기분관 이관
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "/savepg.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savepg(HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);

//		int dataType = Integer.parseInt((String) map.get("dataType"));
		int manager_seq = Integer.parseInt((String) map.get("manager_seq"));
		int manage_idx = Integer.parseInt((String) map.get("manage_idx"));
//		String manager_seq = (String)map.get("manager_seq");
		List<DataMigration> list = null;
		list = service.orgListPG(manager_seq);


//		list = service.orgListDK2(categoryName);

		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());
		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
//			List<Map<String, Object>> orgFileMap = service.getFileDataDK(orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = new ArrayList<Map<String, Object>>();

			Map<String, Object> map1 = null;

			boolean hasFile1 = false;
			boolean hasFile2 = false;
			boolean hasFile3 = false;
			boolean hasFile4 = false;
			boolean hasFile5 = false;

			if (!StringUtils.isEmpty(orgMap.getImsi_v_1())) {
				hasFile1 = true;
				map1 = new HashMap<String, Object>();
				map1.put("REAL_FILE_NAME", orgMap.getImsi_v_1());
				map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_2());
				map1.put("FILE_EXT", orgMap.getImsi_v_1().substring(orgMap.getImsi_v_1().lastIndexOf(".")+1));
				map1.put("FILE_SIZE", 0);
				long fileSize = 0;
				String sourceFileName = String.valueOf(map1.get("REAL_FILE_NAME"));
				File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
				fileSize = sourceFile.length();
				map1.put("FILE_SIZE", fileSize);
				String fileName = Long.toString((System.currentTimeMillis()))+"1" + orgMap.getImsi_v_1().substring(orgMap.getImsi_v_1().lastIndexOf("."));
				map1.put("FILE_NAME", fileName);
				orgFileMap.add(map1);
			}

			if (hasFile1) {
				if (!StringUtils.isEmpty(orgMap.getImsi_v_3())) {
					hasFile2 = true;
					map1 = new HashMap<String, Object>();
					map1.put("REAL_FILE_NAME", orgMap.getImsi_v_3());
					map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_4());
					map1.put("FILE_EXT", orgMap.getImsi_v_3().substring(orgMap.getImsi_v_3().lastIndexOf(".")+1));
					String sourceFileName = String.valueOf(map1.get("REAL_FILE_NAME"));
					File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
					long fileSize = 0;
					fileSize = sourceFile.length();
					map1.put("FILE_SIZE", fileSize);
					String fileName = Long.toString((System.currentTimeMillis()))+"2" + orgMap.getImsi_v_3().substring(orgMap.getImsi_v_3().lastIndexOf("."));
					map1.put("FILE_NAME", fileName);
					orgFileMap.add(map1);
				}
				if (hasFile2) {
					if (!StringUtils.isEmpty(orgMap.getImsi_v_5())) {
						hasFile3 = true;
						map1 = new HashMap<String, Object>();
						map1.put("REAL_FILE_NAME", orgMap.getImsi_v_5());
						map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_6());
						map1.put("FILE_EXT", orgMap.getImsi_v_5().substring(orgMap.getImsi_v_5().lastIndexOf(".")+1));
						String sourceFileName = String.valueOf(map1.get("REAL_FILE_NAME"));
						long fileSize = 0;
						File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
						fileSize = sourceFile.length();
						map1.put("FILE_SIZE", fileSize);
						String fileName = Long.toString((System.currentTimeMillis()))+"3" + orgMap.getImsi_v_5().substring(orgMap.getImsi_v_5().lastIndexOf("."));
						map1.put("FILE_NAME", fileName);
						orgFileMap.add(map1);
					}
					if (hasFile3) {
						if (!StringUtils.isEmpty(orgMap.getImsi_v_7())) {
							hasFile4 = true;
							map1 = new HashMap<String, Object>();
							map1.put("REAL_FILE_NAME", orgMap.getImsi_v_7());
							map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_8());
							map1.put("FILE_EXT", orgMap.getImsi_v_7().substring(orgMap.getImsi_v_7().lastIndexOf(".")+1));
							String sourceFileName = String.valueOf(map1.get("REAL_FILE_NAME"));
							long fileSize = 0;
							File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
							fileSize = sourceFile.length();
							map1.put("FILE_SIZE", fileSize);
							String fileName = Long.toString((System.currentTimeMillis()))+"4" + orgMap.getImsi_v_7().substring(orgMap.getImsi_v_7().lastIndexOf("."));
							map1.put("FILE_NAME", fileName);
							orgFileMap.add(map1);
						}
						if (hasFile4) {
							if (!StringUtils.isEmpty(orgMap.getImsi_v_9())) {
								hasFile5 = true;
								map1 = new HashMap<String, Object>();
								map1.put("REAL_FILE_NAME", orgMap.getImsi_v_9());
								map1.put("RENAME_FILE_NAME", orgMap.getImsi_v_10());
								map1.put("FILE_EXT", orgMap.getImsi_v_9().substring(orgMap.getImsi_v_9().lastIndexOf(".")+1));
								String sourceFileName = String.valueOf(map1.get("REAL_FILE_NAME"));
								long fileSize = 0;
								File sourceFile = new File("D:\\develop_tool\\board\\" + sourceFileName);
								fileSize = sourceFile.length();
								map1.put("FILE_SIZE", fileSize);
								String fileName = Long.toString((System.currentTimeMillis()))+"5" + orgMap.getImsi_v_9().substring(orgMap.getImsi_v_9().lastIndexOf("."));
								map1.put("FILE_NAME", fileName);
								orgFileMap.add(map1);
							}
						}
					}
				}
			}

//			System.out.println("@@@@@@@@@@@ fileListSize : " + orgFileMap.size());
			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

//			orgMap.setGroup_seq(boardIdx);
//			orgMap.setParent_seq(0);
//			if (manager_seq == 2) {
//				orgMap.setGroup_seq(idxMap.get(orgMap.getBoard_seq()));
//				orgMap.setParent_seq(0);
//			} else {
				if (orgMap.getBoard_seq() != orgMap.getGroup_seq()) {
					if (idxMap.get(orgMap.getBoard_seq()) != null) {
						orgMap.setParent_seq(idxMap.get(orgMap.getGroup_seq()));
						orgMap.setGroup_seq(idxMap.get(orgMap.getGroup_seq()));
					}
				} else {
					orgMap.setGroup_seq(boardIdx);
					orgMap.setParent_seq(0);
				}
//			}
			if  (StringUtils.isEmpty(orgMap.getContent())) {
				orgMap.setContent("");
			}
			if (StringUtils.isNotEmpty(orgMap.getContent())) {
				orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));
			}



//			if (orgFileMap != null && orgFileMap.size() > 0) {
//				String content = "";
//				for (Map<String, Object> map2 : orgFileMap) {
//					String ext = "jpg|bmp|gif|png|jpeg";
//					if (ext.indexOf(String.valueOf(map2.get("FILE_EXT")).toLowerCase()) > -1) {
//						if (content.equals("")) {
////							content += "<p><img src=\"/data/board/"+manage_idx+"/"+boardIdx+"/"+String.valueOf(map2.get("FILE_NAME"))+"\" ></p>";
//							orgMap.setPreview_img(String.valueOf(map2.get("FILE_NAME")));
//						}
//					}
//				}
//				orgMap.setContent(content + orgMap.getContent());
//			}

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {
				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}
//			if (!orgMap.getReal_file_name().startsWith("http")) {
//			orgMap.setPreview_img(orgMap.getReal_file_name());
//			orgMap.setPreview_img(String.valueOf(map2.get("FILE_NAME")));
//			}


			orgMap.setFile_count(orgFileMap.size());
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileExt.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					map2.put("FILE_NAME", fileName);
					service.insertBoardFiledk(map2);
					service.fileMovePG(map2, manage_idx);
				}
			}
			orgMap.setPreview_img(previewName);
			if (StringUtils.isEmpty(orgMap.getUser_id())) {
				orgMap.setUser_id("admin");
			}
			service.insertBoarddk(orgMap);

		}
		res.setValid(true);
		return res;
	}


	/**
	 * dk 외동 이관 - 도서
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ParseException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = { "savepg2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse savepg2(DataMigration dm, HttpServletRequest request) throws SQLException, IOException, ParseException {

		Map<String, Object> paramMap = request.getParameterMap();
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator it = paramMap.keySet().iterator();
		String key = null;
		String[] value = null;
		while(it.hasNext())
		{
			key = (String) it.next();
			value = (String[]) paramMap.get(key);
			for(int i=0; i<value.length; i++)
			{
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + key + " : " + value[i]);
			}
			String arraystos = Arrays.toString(value);
			arraystos = arraystos.substring(1, arraystos.length()-1);
			map.put(key, arraystos);
		}

		JsonResponse res = new JsonResponse(request);


		List<String> manager_seq_arr = dm.getManager_seq_arr();
		List<String> manage_idx_arr = dm.getManage_idx_arr();

		for (int i = 0; i < manager_seq_arr.size(); i++) {
			if (StringUtils.isEmpty(manager_seq_arr.get(i))) {
				break;
			}
		}

		int manage_idx = Integer.parseInt(manage_idx_arr.get(0));
		List<DataMigration> list = null;
		list = service.orgListPG2("");
		System.out.println("@@@@@@@@@@@@@@@ list size : " + list.size());

		//  원래번호 ,  신규번호
		Map<Integer, Integer> idxMap = new HashMap<Integer, Integer>();

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);
			System.out.println("@@@@@@@@@@@@@@ board_seq : " + orgMap.getBoard_seq());
			List<Map<String, Object>> orgFileMap = null;

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("REAL_FILE_NAME", orgMap.getReal_file_name());
			map1.put("RENAME_FILE_NAME", orgMap.getRename_file_name());
			String fileext = "";
			String extpattern = "jpg|bmp|gif|png|jpeg";
			if (extpattern.indexOf(orgMap.getReal_file_name().toLowerCase()) < 0) {
				fileext = "jpg";
			} else {
				fileext = orgMap.getReal_file_name().substring(orgMap.getReal_file_name().indexOf(".")+1);
			}
			map1.put("FILE_EXT", fileext);

			orgFileMap = new ArrayList<Map<String, Object>>();
			if (StringUtils.isNotEmpty(orgMap.getReal_file_name())) {
				if (!orgMap.getReal_file_name().startsWith("http")) {
					orgFileMap.add(map1);
				}
			}

			int boardIdx = service.getNextBoardIdx();
			idxMap.put(orgMap.getBoard_seq(), boardIdx);
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);

			orgMap.setGroup_seq(boardIdx);
			orgMap.setParent_seq(0);
			orgMap.setPreview_content(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(orgMap.getContent()),1000));

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (StringUtils.isNotEmpty(orgMap.getAdd_date())) {
				String add_date = orgMap.getAdd_date() + "000";
				long addDate = Long.parseLong(add_date);
				orgMap.setCrt_dt(format.parse(format.format(addDate)));
			}
			if (StringUtils.isNotEmpty(orgMap.getModify_date())) {

				String modify_date = orgMap.getModify_date() + "000";
				long modifyDate = Long.parseLong(modify_date);
				orgMap.setUpt_dt(format.parse(format.format(modifyDate)));
			}


			orgMap.setFile_count(orgFileMap.size());
			String previewName = "";
			if (orgFileMap != null && orgFileMap.size() > 0) {
				for (Map<String, Object> map2 : orgFileMap) {
					map2.put("board_idx", boardIdx);
					String fileExt = String.valueOf(map2.get("FILE_EXT"));
					if (StringUtils.isNotEmpty(fileExt) && !fileExt.startsWith(".")) {
						map2.put("FILE_EXT", "." + fileExt.toLowerCase());
					}
					String fileName = "";
					fileName = Long.toString((System.currentTimeMillis()))+String.valueOf(map2.get("FILE_EXT"));
					if (previewName.equals("")) {
						String ext = "jpg|bmp|gif|png|jpeg";
						if (ext.indexOf(fileExt.toLowerCase()) > -1) {
							previewName = fileName;
						}
					}
					long fileSize = 0;
					try {
						fileSize = (Long) map2.get("FILE_SIZE");
					} catch (Exception e) {
					}

					if ( fileSize == 0 ) {
						String sourceFileName = String.valueOf(map2.get("REAL_FILE_NAME"));
						File sourceFile = new File("D:\\develop_tool\\book\\" + sourceFileName);
						fileSize = sourceFile.length();
						map2.put("FILE_SIZE", fileSize);
					}
					map2.put("FILE_NAME", fileName);
					service.insertBoardFiledk(map2);
					service.fileMovebookDK(map2, manage_idx);
				}
			}
			orgMap.setPreview_img(previewName);
			if (StringUtils.isEmpty(orgMap.getUser_id())) {
				orgMap.setUser_id("admin");
			}
			if (StringUtils.isEmpty(orgMap.getTitle())) {
				orgMap.setTitle("제목없음");
			}
			service.insertBoarddk(orgMap);


		}

		return res;
	}

	private String getStringCellValue(Cell cell) {
		return cell == null ? "" : cell.getStringCellValue();
	}

	@RequestMapping(value = {"/elib/kyobo_old.*"})
	public String kyobo_old(Model model, HttpServletRequest request) {
		System.out.println("@@@@@@@@@@@@@ kyobo starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();

		parentIdMap.put("가정/생활/요리", 13);
		parentIdMap.put("건강/의학", 12);
		parentIdMap.put("경영/경제", 1);
		parentIdMap.put("경제경영", 1);
		parentIdMap.put("교재/수험서", 17);
		parentIdMap.put("국어/외국어", 7);
		parentIdMap.put("사회/정치/법", 8);
		parentIdMap.put("소설", 3);
		parentIdMap.put("시/에세이", 5);
		parentIdMap.put("아동", 20);
		parentIdMap.put("여행/취미", 14);
		parentIdMap.put("역사/풍속/신화", 9);
		parentIdMap.put("예술/대중문화", 15);
		parentIdMap.put("유아", 19);
		parentIdMap.put("인문", 6);
		parentIdMap.put("자기계발", 2);
		parentIdMap.put("자연과학/공학", 10);
		parentIdMap.put("장르소설", 4);
		parentIdMap.put("종교/역학", 16);
		parentIdMap.put("청소년교양", 18);
		parentIdMap.put("컴퓨터/인터넷", 11);
		parentIdMap.put("코믹스", 21);
		parentIdMap.put("공부방", 178);
		parentIdMap.put("한글동화", 181);

		cateIdMap.put("OA(사무자동화)", 80);
		cateIdMap.put("OS/네트워크", 98);
		cateIdMap.put("가톨릭", 134);
		cateIdMap.put("각국경제", 30);
		cateIdMap.put("갤러리북/포토북/도록", 131);
		cateIdMap.put("건강일반", 104);
		cateIdMap.put("결혼과부부생활", 110);
		cateIdMap.put("경영관리/CEO", 23);
		cateIdMap.put("경영일반/경영이론", 22);
		cateIdMap.put("경영전략/e비즈니스", 24);
		cateIdMap.put("경제일반/경제이론", 29);
		cateIdMap.put("공무원수험서", 140);
		cateIdMap.put("공부방법", 142);
		cateIdMap.put("교양과학", 90);
		cateIdMap.put("교양철학", 56);
		cateIdMap.put("교육이론/교육방법", 61);
		cateIdMap.put("교육일반", 60);
		cateIdMap.put("국내여행", 117);
		cateIdMap.put("국방/군사/통일", 79);
		cateIdMap.put("국어학", 53);
		cateIdMap.put("그래픽/멀티미디어", 103);
		cateIdMap.put("그림책", 151);
		cateIdMap.put("글쓰기", 54);
		cateIdMap.put("기독교", 133);
		cateIdMap.put("기업실무관리", 25);
		cateIdMap.put("기타나라소설", 44);
		cateIdMap.put("기타만화", 160);
		cateIdMap.put("기타수험서", 141);
		cateIdMap.put("기타외국어", 72);
		cateIdMap.put("다이어트", 107);
		cateIdMap.put("대중연예/음악", 130);
		cateIdMap.put("대학입시논술", 136);
		cateIdMap.put("대학입시면접", 137);
		cateIdMap.put("데이터베이스구축/관리", 99);
		cateIdMap.put("독서법/독서지도", 55);
		cateIdMap.put("독일소설", 43);
		cateIdMap.put("동양사", 84);
		cateIdMap.put("동양철학", 57);
		cateIdMap.put("디자인/도안", 125);
		cateIdMap.put("러시아소설", 41);
		cateIdMap.put("로맨스", 45);
		cateIdMap.put("마케팅/세일즈", 26);
		cateIdMap.put("무역/교통/관광", 31);
		cateIdMap.put("무협", 46);
		cateIdMap.put("문학이론", 161);
		cateIdMap.put("문화사", 51);
		cateIdMap.put("물리학", 91);
		cateIdMap.put("미술", 124);
		cateIdMap.put("법률/소송", 80);
		cateIdMap.put("불교", 132);
		cateIdMap.put("비즈니스능력계발", 34);
		cateIdMap.put("사전/연감", 139);
		cateIdMap.put("사진/영상", 127);
		cateIdMap.put("사회과학일반", 74);
		cateIdMap.put("사회문제/사회복지", 75);
		cateIdMap.put("상식/취미/실용", 155);
		cateIdMap.put("생물학", 92);
		cateIdMap.put("생활과학", 95);
		cateIdMap.put("서양사", 83);
		cateIdMap.put("서양철학", 58);
		cateIdMap.put("성공/처세", 32);
		cateIdMap.put("세계사", 82);
		cateIdMap.put("수험영어", 68);
		cateIdMap.put("스포츠", 121);
		cateIdMap.put("시", 48);
		cateIdMap.put("신화/신화학", 88);
		cateIdMap.put("심리이론", 64);
		cateIdMap.put("심리일반", 63);
		cateIdMap.put("심리치료/정신분석", 65);
		cateIdMap.put("아동교양만화", 157);
		cateIdMap.put("아동학습만화", 158);
		cateIdMap.put("어린이문학", 156);
		cateIdMap.put("어린이영어", 174);
		cateIdMap.put("언론/신문/방송", 76);
		cateIdMap.put("에세이", 49);
		cateIdMap.put("역사일반", 81);
		cateIdMap.put("연극/희곡", 128);
		cateIdMap.put("영미소설", 38);
		cateIdMap.put("영어교재/문고", 67);
		cateIdMap.put("영화/드라마", 129);
		cateIdMap.put("예술론/미학", 123);
		cateIdMap.put("예술입문서", 122);
		cateIdMap.put("와인/칵테일/음료", 116);
		cateIdMap.put("요리", 115);
		cateIdMap.put("웹사이트/홈페이지만들기", 102);
		cateIdMap.put("유/초등부교육", 62);
		cateIdMap.put("유아교양", 152);
		cateIdMap.put("유아놀이", 150);
		cateIdMap.put("유통/창업", 27);
		cateIdMap.put("육아", 112);
		cateIdMap.put("음악", 126);
		cateIdMap.put("의학", 109);
		cateIdMap.put("인간관계", 35);
		cateIdMap.put("인문학일반", 59);
		cateIdMap.put("일반영어", 66);
		cateIdMap.put("일본소설", 39);
		cateIdMap.put("일본어", 70);
		cateIdMap.put("자기능력계발", 33);
		cateIdMap.put("자연요법/대체의학", 108);
		cateIdMap.put("재테크/금융", 28);
		cateIdMap.put("정치/외교", 77);
		cateIdMap.put("좋은부모", 113);
		cateIdMap.put("중국소설", 40);
		cateIdMap.put("중국어", 71);
		cateIdMap.put("지구과학", 93);
		cateIdMap.put("지리학", 89);
		cateIdMap.put("진로", 143);
		cateIdMap.put("질병치료/예방", 105);
		cateIdMap.put("청소년 교양과학", 146);
		cateIdMap.put("청소년 문학", 144);
		cateIdMap.put("청소년 역사", 149);
		cateIdMap.put("청소년 예술", 145);
		cateIdMap.put("청소년 인문교양", 147);
		cateIdMap.put("청소년 자기계발", 148);
		cateIdMap.put("초등공통1~6학년", 159);
		cateIdMap.put("초등학교", 135);
		cateIdMap.put("취미", 120);
		cateIdMap.put("취업전략", 138);
		cateIdMap.put("컴퓨터공학", 97);
		cateIdMap.put("컴퓨터입문/활용", 96);
		cateIdMap.put("태교/출산준비", 111);
		cateIdMap.put("테마시/에세이", 50);
		cateIdMap.put("테마여행", 119);
		cateIdMap.put("판타지", 47);
		cateIdMap.put("풍속/민속", 86);
		cateIdMap.put("프랑스소설", 42);
		cateIdMap.put("프로그래밍 및 언어", 100);
		cateIdMap.put("학습참고서", 154);
		cateIdMap.put("한국사", 85);
		cateIdMap.put("한국소설", 37);
		cateIdMap.put("한문학/한자", 52);
		cateIdMap.put("한방치료", 106);
		cateIdMap.put("한자", 73);
		cateIdMap.put("해외여행", 118);
		cateIdMap.put("행정/정책", 78);
		cateIdMap.put("호기심/창의력/습관", 153);
		cateIdMap.put("홈인테리어", 114);
		cateIdMap.put("화술/협상", 36);
		cateIdMap.put("환경/도시/조경", 94);
		cateIdMap.put("영어공부", 179);
		cateIdMap.put("영어동화공부", 180);
		cateIdMap.put("한국전래동화", 182);

		try {

			FileInputStream file = new FileInputStream(new File("D:\\업무\\경북도서관\\메타\\교보.xlsx"));
			//Get the workbook instance for XLS file
			XSSFWorkbook workbook = new XSSFWorkbook(file);
			//Get first sheet from the workbook
			XSSFSheet sheet = workbook.getSheetAt(0);
			int rowStart = 1;
		    int rowEnd = sheet.getLastRowNum();
		    for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
		        Row row = sheet.getRow(rowNum);
		        if (row == null) {
		        	System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

		           // This whole row is empty
		           // Handle it as needed
		           continue;
		        }

				Book book = new Book();

				book.setBook_code(row.getCell(1, Row.RETURN_BLANK_AS_NULL).getStringCellValue());

				String categories = row.getCell(3, Row.RETURN_BLANK_AS_NULL).getStringCellValue();
				String[] categories1 = categories.split(">");

				for(int i=0; i<categories1.length; ++i) categories1[i] = categories1[i].trim();

				book.setParent_id(parentIdMap.get(categories1[0]));
				book.setCate_id(cateIdMap.get(categories1[1]));

				book.setBook_name(getStringCellValue(row.getCell(4, Row.RETURN_BLANK_AS_NULL)));
				book.setAuthor_name(getStringCellValue(row.getCell(5, Row.RETURN_BLANK_AS_NULL)));
				book.setBook_pubname(getStringCellValue(row.getCell(6, Row.RETURN_BLANK_AS_NULL)));
				book.setIsbn13(getStringCellValue(row.getCell(8, Row.RETURN_BLANK_AS_NULL)));
				book.setBook_pubdt(getStringCellValue(row.getCell(9, Row.RETURN_BLANK_AS_NULL)));
				book.setBook_regdt(getStringCellValue(row.getCell(10, Row.RETURN_BLANK_AS_NULL)));
				book.setFormat(getStringCellValue(row.getCell(11, Row.RETURN_BLANK_AS_NULL)).toUpperCase());
				book.setDevice("3");
				book.setUse_yn("Y");
				book.setType("EBK");
				book.setBook_image(getStringCellValue(row.getCell(14, Row.RETURN_BLANK_AS_NULL)));
				book.setLibrary_code("9999999");
				book.setCom_code("KYOB");

				book.setBook_info(getStringCellValue(row.getCell(17, Row.RETURN_BLANK_AS_NULL)));
				book.setAuthor_info(getStringCellValue(row.getCell(18, Row.RETURN_BLANK_AS_NULL)));
				book.setBook_table(getStringCellValue(row.getCell(19, Row.RETURN_BLANK_AS_NULL)));

				if(bookService.addBook(book) == 0) {
					System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook failed at " + rowNum + "");
					throw new Exception();
				}
			}

			file.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}

		System.out.println("@@@@@@@@@@@@@ kyobo ends");

		return "none";
	}

	private String getLibraryCode(String filename) {
		if("성주도서관_62.xlsx".equals(filename)) {
		    // 성주
			return "00147009";
		} else if("고령도서관_154.xlsx".equals(filename)) {
		    // 고령
			return "00147002";
		} else if("안동도서관_126.xlsx".equals(filename)) {
		    // 안동
			return "00147010";
		} else if("영덕도서관_1351.xlsx".equals(filename)) {
		    // 영덕
			return "00147031";
		} else if("영양도서관_199.xlsx".equals(filename)) {
		    // 영양
			return "00147012";
		} else if("영일도서관_1992.xlsx".equals(filename)) {
		    // 영일
			return "00147013";
		} else if("영주도서관_137.xlsx".equals(filename)) {
		    // 영주
			return "00147032";
		} else if("영천금호도서관_1097.xlsx".equals(filename)) {
		    // 영천금호
			return "00147014";
		} else if("울릉도서관_217.xlsx".equals(filename)) {
		    // 울릉
			return "00147017";
		} else if("울진도서관_639.xlsx".equals(filename)) {
		    // 울진
			return "00147018";
		} else {
		    // 통합
			return "9999999";
		}
	}

	@RequestMapping(value = {"/elib/fxli.*"})
	public void fxli(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("@@@@@@@@@@@@@ fxli starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();

		parentIdMap.put("가정/생활", 222);
		parentIdMap.put("경제/비즈니스", 223);
		parentIdMap.put("문학", 224);
		parentIdMap.put("문화/예술", 225);
		parentIdMap.put("사회", 226);
		parentIdMap.put("어린이", 227);
		parentIdMap.put("에세이/산문", 228);
		parentIdMap.put("역사", 229);
		parentIdMap.put("연령별분류", 230);
		parentIdMap.put("외국어", 231);
		parentIdMap.put("인문", 232);
		parentIdMap.put("자연/과학", 233);
		parentIdMap.put("장르문학", 234);
		parentIdMap.put("종교/역학", 235);
		parentIdMap.put("취미/여행", 236);
		parentIdMap.put("컴퓨터/인터넷", 237);

		cateIdMap.put("1~2학년", 278);
		cateIdMap.put("3~4학년", 279);
		cateIdMap.put("5~6학년", 417);
		cateIdMap.put("SF/밀리터리", 290);
		cateIdMap.put("건강", 238);
		cateIdMap.put("건축", 418);
		cateIdMap.put("경제/경영", 245);
		cateIdMap.put("고전", 250);
		cateIdMap.put("고전명작", 265);
		cateIdMap.put("공포", 291);
		cateIdMap.put("과학과컴퓨터", 266);
		cateIdMap.put("과학산책", 288);
		cateIdMap.put("교육/환경", 260);
		cateIdMap.put("기독교", 295);
		cateIdMap.put("기타", 255);
		cateIdMap.put("기타", 298);
		cateIdMap.put("기타 외국어", 281);
		cateIdMap.put("다이어트/패션/미용", 239);
		cateIdMap.put("동요/동시", 419);
		cateIdMap.put("로맨스", 292);
		cateIdMap.put("마케팅/세일즈", 246);
		cateIdMap.put("멀티동화", 267);
		cateIdMap.put("미술", 256);
		cateIdMap.put("무협", 416);
		cateIdMap.put("법률/행정/복지", 261);
		cateIdMap.put("불교", 296);
		cateIdMap.put("사진", 257);
		cateIdMap.put("사회학이해", 262);
		cateIdMap.put("산문집", 272);
		cateIdMap.put("생활/실용영어", 282);
		cateIdMap.put("성/사랑", 240);
		cateIdMap.put("성공철학/자기계발", 247);
		cateIdMap.put("세계사", 273);
		cateIdMap.put("시", 251);
		cateIdMap.put("심리/정신분석", 285);
		cateIdMap.put("언론/미디어", 263);
		cateIdMap.put("여행/관광", 299);
		cateIdMap.put("역사이론/고고학", 274);
		cateIdMap.put("연극/영화", 258);
		cateIdMap.put("외국동화", 268);
		cateIdMap.put("외국소설", 252);
		cateIdMap.put("요리", 241);
		cateIdMap.put("음악", 259);
		cateIdMap.put("이론과평론", 253);
		cateIdMap.put("인문학산책", 286);
		cateIdMap.put("인물이야기", 275);
		cateIdMap.put("인터넷/홈페이지", 300);
		cateIdMap.put("일본어", 283);
		cateIdMap.put("임신/출산", 242);
		cateIdMap.put("자녀교육", 243);
		cateIdMap.put("재테크/투자", 248);
		cateIdMap.put("전학년", 280);
		cateIdMap.put("정치/외교", 264);
		cateIdMap.put("주택/인테리어", 244);
		cateIdMap.put("창업/취업", 249);
		cateIdMap.put("천주교", 297);
		cateIdMap.put("추리", 293);
		cateIdMap.put("컴퓨터입문/활용", 301);
		cateIdMap.put("판타지", 294);
		cateIdMap.put("풍속/문화이야기", 276);
		cateIdMap.put("프로그래밍", 420);
		cateIdMap.put("학습만화와교양", 270);
		cateIdMap.put("한국/동양철학", 287);
		cateIdMap.put("한국동화", 271);
		cateIdMap.put("한국사", 277);
		cateIdMap.put("한국소설", 254);
		cateIdMap.put("한자/중국어", 284);
		cateIdMap.put("화학/생명", 289);

		// 오디오북
		parentIdMap.put("강연/북러닝", 302);
		parentIdMap.put("에세이", 303);
		parentIdMap.put("오디오드라마", 304);
		parentIdMap.put("요약본/교양도서", 305);
		parentIdMap.put("요약본/명작도서", 306);
		parentIdMap.put("인문", 307);
		parentIdMap.put("자기계발", 308);
		parentIdMap.put("한국문학", 309);

		String[] filenames = {"북큐브2차3차.xlsx"};

		for(String filename: filenames) {
			try {
				String path = "D:\\업무\\경북도서관\\메타\\" + filename;

				FileInputStream file = new FileInputStream(new File(path));
				//Get the workbook instance for XLS file
				XSSFWorkbook workbook = new XSSFWorkbook(file);
				//Get first sheet from the workbook
				XSSFSheet sheet = workbook.getSheetAt(0);
				int rowStart = 2;
				int rowEnd = sheet.getLastRowNum();
				for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

						// This whole row is empty
						// Handle it as needed
						continue;
					}

					Book book = new Book();

					book.setBook_code(row.getCell(1, Row.RETURN_BLANK_AS_NULL).getStringCellValue());

					String parent = getStringCellValue(row.getCell(2, Row.RETURN_BLANK_AS_NULL));
					String child = getStringCellValue(row.getCell(3, Row.RETURN_BLANK_AS_NULL));

					System.out.println("@@@@@@@@@@@@@ parent: " + parent + ", child: " + child);

					ElibCategory cate = new ElibCategory();
					cate.setCate_name(StringUtils.defaultString(parent).trim());
					cate.setType("EBK");
					cate.setDepth(1);

					ElibCategory parentCategory = elibCategoryService.getParentByName(cate);

					if(parentCategory == null) {
						System.out.println("@@@@@@@@@@@@ new parent category: " + cate.getCate_name() + " " + elibCategoryService.addCategory(cate));
						book.setParent_id(cate.getCate_id());
						cate.setParent_id(cate.getCate_id());
					} else {
						book.setParent_id(parentCategory.getCate_id());
						cate.setParent_id(parentCategory.getCate_id());
					}

					cate.setCate_name(StringUtils.defaultString(child).trim());
					cate.setDepth(2);
					ElibCategory childCategory = elibCategoryService.getChildByName(cate);

					if(childCategory == null) {
						System.out.println("@@@@@@@@@@@@ new child category: " + cate.getCate_name() + " " + elibCategoryService.addCategory(cate));
						book.setCate_id(cate.getCate_id());
					} else {
						book.setCate_id(childCategory.getCate_id());
					}

					book.setBook_name(getStringCellValue(row.getCell(4, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_name(getStringCellValue(row.getCell(5, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubname(getStringCellValue(row.getCell(6, Row.RETURN_BLANK_AS_NULL)));
					book.setIsbn13(getStringCellValue(row.getCell(7, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubdt(getStringCellValue(row.getCell(8, Row.RETURN_BLANK_AS_NULL)));
//					book.setBook_regdt("2017-12-06");
					book.setFormat(getStringCellValue(row.getCell(11, Row.RETURN_BLANK_AS_NULL)).toUpperCase());
					book.setDevice("3");
					book.setUse_yn("Y");
					if("오디오북".equals(parent)) {
						book.setType("ADO");
					} else {
						book.setType("EBK");
					}
					book.setBook_image(getStringCellValue(row.getCell(12, Row.RETURN_BLANK_AS_NULL)));
//					book.setLibrary_code(getLibraryCode(filename));
					book.setLibrary_code("9999999");
					book.setCom_code("FXLI");

					book.setBook_info(getStringCellValue(row.getCell(14, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_info(getStringCellValue(row.getCell(15, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_table(getStringCellValue(row.getCell(16, Row.RETURN_BLANK_AS_NULL)));
					book.setMax_lend((int) row.getCell(17, Row.RETURN_BLANK_AS_NULL).getNumericCellValue());

					if(bookService.addBook(book) == 0) {
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook failed at " + rowNum + "");
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook filename: " + filename + ", book_code: " + book.getBook_code());
						throw new Exception();
					}
				}

				file.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("@@@@@@@@@@@@@ fxli ends");

		response.getOutputStream().println("done");
	}

	@RequestMapping(value = {"/elib/hans.*"})
	public void hans(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("@@@@@@@@@@@@@ hans starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();

		parentIdMap.put("가정", 408);
		parentIdMap.put("강연", 409);
		parentIdMap.put("건강/실용", 410);
		parentIdMap.put("경영/경제", 411);
		parentIdMap.put("소설", 209);
		parentIdMap.put("시/에세이", 412);
		parentIdMap.put("아동/청소년", 413);
		parentIdMap.put("인문/사회/역사", 414);
		parentIdMap.put("자기계발", 415);

		String[] filenames = {"한솔.xlsx"};

		for(String filename: filenames) {
			try {
				String path = "D:\\업무\\경북도서관\\메타\\" + filename;

				FileInputStream file = new FileInputStream(new File(path));
				//Get the workbook instance for XLS file
				XSSFWorkbook workbook = new XSSFWorkbook(file);
				//Get first sheet from the workbook
				XSSFSheet sheet = workbook.getSheetAt(0);
				int rowStart = 2;
				int rowEnd = sheet.getLastRowNum();
				for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

						// This whole row is empty
						// Handle it as needed
						continue;
					}

					Book book = new Book();

					book.setBook_code(String.valueOf((int)row.getCell(3, Row.RETURN_BLANK_AS_NULL).getNumericCellValue()));

					String parent = getStringCellValue(row.getCell(5, Row.RETURN_BLANK_AS_NULL));

					book.setParent_id(parentIdMap.get(parent));
					book.setBook_name(getStringCellValue(row.getCell(6, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_name(getStringCellValue(row.getCell(7, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubname(getStringCellValue(row.getCell(8, Row.RETURN_BLANK_AS_NULL)));
					book.setIsbn13("");
					book.setBook_pubdt("");
					book.setBook_regdt("2017-12-04");
					book.setFormat("");
					book.setDevice("3");
					book.setUse_yn("Y");
					book.setType("ADO");
					book.setBook_image(getStringCellValue(row.getCell(17, Row.RETURN_BLANK_AS_NULL)));
					book.setLibrary_code("9999999");
					book.setCom_code("HANS");

					book.setBook_info(getStringCellValue(row.getCell(15, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_info("");
					book.setBook_table(getStringCellValue(row.getCell(14, Row.RETURN_BLANK_AS_NULL)));
					book.setMax_lend(0);
					book.setLink_url(getStringCellValue(row.getCell(21, Row.RETURN_BLANK_AS_NULL)) + "1c197626e65d811c1976");

					if(bookService.addBook(book) == 0) {
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook failed at " + rowNum + "");
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook filename: " + filename + ", book_code: " + book.getBook_code());
						throw new Exception();
					}
				}

				file.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("@@@@@@@@@@@@@ hans ends");

		response.getOutputStream().println("done");
	}

	@RequestMapping(value = {"/elib/yes.*"})
	public void yes(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("@@@@@@@@@@@@@ yes starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();

		parentIdMap.put("가정과생활", 421);
		parentIdMap.put("국어와외국어", 422);
		parentIdMap.put("만화", 423);
		parentIdMap.put("문학", 424);
		parentIdMap.put("비즈니스와경제", 425);
		parentIdMap.put("어린이/청소년", 426);
		parentIdMap.put("예술/대중문화", 427);
		parentIdMap.put("인문/사회", 428);
		parentIdMap.put("자기관리", 429);
		parentIdMap.put("장르문학", 621);
		parentIdMap.put("수험서/자격증", 630);
		parentIdMap.put("자연과과학", 641);
		parentIdMap.put("컴퓨터와인터넷", 645);

		cateIdMap.put("가정과생활", 430);
		cateIdMap.put("취미/여행", 431);
		cateIdMap.put("영어", 432);
		cateIdMap.put("교양만화/비평", 433);
		cateIdMap.put("소설", 434);
		cateIdMap.put("시/평론", 435);
		cateIdMap.put("에세이/산문", 436);
		cateIdMap.put("CEO/비즈니스맨", 437);
		cateIdMap.put("경영", 438);
		cateIdMap.put("경제", 439);
		cateIdMap.put("마케팅/세일즈", 440);
		cateIdMap.put("투자/재테크", 441);
		cateIdMap.put("어린이", 442);
		cateIdMap.put("유아", 443);
		cateIdMap.put("청소년", 444);
		cateIdMap.put("미술", 448);
		cateIdMap.put("예술기행", 449);
		cateIdMap.put("인문/사회", 450);
		cateIdMap.put("성공학/경력관리", 451);
		cateIdMap.put("여성을 위한 자기계발", 452);
		cateIdMap.put("인간관계", 453);
		cateIdMap.put("처세술/삶의자세", 454);
		cateIdMap.put("화술/협상/회의진행", 455);
		cateIdMap.put("사진", 618);
		cateIdMap.put("역사/종교", 619);
		cateIdMap.put("창조적사고", 620);
		cateIdMap.put("판타지/유머/추리", 622);
		cateIdMap.put("취업/직업의세계", 623);
		cateIdMap.put("고전/희곡", 628);
		cateIdMap.put("공무원", 631);
		cateIdMap.put("과학일반", 642);
		cateIdMap.put("국어", 624);
		cateIdMap.put("대중문화", 636);
		cateIdMap.put("어린이", 633);
		cateIdMap.put("예술일반/예술사", 638);
		cateIdMap.put("오피스활용도서", 646);
		cateIdMap.put("유아", 634);
		cateIdMap.put("유학/이민", 640);
		cateIdMap.put("음악", 639);
		cateIdMap.put("인체", 643);
		cateIdMap.put("일본어", 625);
		cateIdMap.put("중국어", 626);
		cateIdMap.put("청소년", 635);
		cateIdMap.put("취업/상식/적성검사", 632);
		cateIdMap.put("토목/건축공학", 644);
		cateIdMap.put("한문/한자", 627);
		cateIdMap.put("연극/공연", 637);
		cateIdMap.put("인터넷비즈니스", 629);
		cateIdMap.put("건축", 647);
		cateIdMap.put("IT 전문서", 648);
		cateIdMap.put("경제/금융/회계/물류", 649);
		cateIdMap.put("고등고시/전문직", 650);
		cateIdMap.put("디자인/공예", 651);
		cateIdMap.put("로맨스", 652);
		cateIdMap.put("무협", 653);
		cateIdMap.put("생명과학", 655);
		cateIdMap.put("웹/컴퓨터 입문&활용", 656);
		cateIdMap.put("지구과학", 654);
		cateIdMap.put("코믹/풍자/웹툰", 657);
		cateIdMap.put("판타지/SF", 658);


		String[] filenames = {"예스2차3차.xlsx"};

		for(String filename: filenames) {
			try {
				String path = "D:\\업무\\경북도서관\\메타\\" + filename;

				FileInputStream file = new FileInputStream(new File(path));
				//Get the workbook instance for XLS file
				XSSFWorkbook workbook = new XSSFWorkbook(file);
				//Get first sheet from the workbook
				XSSFSheet sheet = workbook.getSheetAt(0);
				int rowStart = 2;
				int rowEnd = sheet.getLastRowNum();
				for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

						// This whole row is empty
						// Handle it as needed
						continue;
					}

					Book book = new Book();

					book.setBook_code(row.getCell(1, Row.RETURN_BLANK_AS_NULL).getStringCellValue());

					String parent = getStringCellValue(row.getCell(2, Row.RETURN_BLANK_AS_NULL));
					String child = getStringCellValue(row.getCell(3, Row.RETURN_BLANK_AS_NULL));

					System.out.println("@@@@@@@@@@@@@ parent: " + parent + ", child: " + child);

					book.setParent_id(parentIdMap.get(parent));
					book.setCate_id(cateIdMap.get(child));
					book.setBook_name(getStringCellValue(row.getCell(4, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_name(getStringCellValue(row.getCell(5, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubname(getStringCellValue(row.getCell(6, Row.RETURN_BLANK_AS_NULL)));
					book.setIsbn13(getStringCellValue(row.getCell(9, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubdt(getStringCellValue(row.getCell(10, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_regdt("2017-12-19");
					book.setFormat(getStringCellValue(row.getCell(14, Row.RETURN_BLANK_AS_NULL)).toUpperCase());
					book.setDevice("3");
					book.setUse_yn("Y");
					book.setType("EBK");
					book.setBook_image(getStringCellValue(row.getCell(15, Row.RETURN_BLANK_AS_NULL)));
//					book.setLibrary_code("9999999"); // 통합
					book.setLibrary_code("00147008"); // 상주
//					book.setLibrary_code("00147020"); // 점촌
					book.setCom_code("YESB");

					book.setBook_info(getStringCellValue(row.getCell(17, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_info(getStringCellValue(row.getCell(18, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_table(getStringCellValue(row.getCell(19, Row.RETURN_BLANK_AS_NULL)));
					book.setMax_lend((int) row.getCell(21, Row.RETURN_BLANK_AS_NULL).getNumericCellValue());

					if(bookService.addBook(book) == 0) {
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook failed at " + rowNum + "");
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook filename: " + filename + ", book_code: " + book.getBook_code());
						throw new Exception();
					}
				}

				file.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("@@@@@@@@@@@@@ yes ends");

		response.getOutputStream().println("done");
	}

	@RequestMapping(value = {"/elib/yp.*"})
	public void yp(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("@@@@@@@@@@@@@ yp starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();

		parentIdMap.put("건강/의학/가정", 310);
		parentIdMap.put("경제경영", 311);
		parentIdMap.put("과학", 312);
		parentIdMap.put("교육", 313);
		parentIdMap.put("기술공학", 314);
		parentIdMap.put("소설", 315);
		parentIdMap.put("시/에세이", 316);
		parentIdMap.put("역사", 317);
		parentIdMap.put("예술/대중문화", 318);
		parentIdMap.put("외국어", 319);
		parentIdMap.put("유아/어린이", 320);
		parentIdMap.put("인문", 321);
		parentIdMap.put("자기계발", 322);
		parentIdMap.put("정치법률", 323);
		parentIdMap.put("종교/역학", 324);
		parentIdMap.put("취미/실용", 325);
		parentIdMap.put("컴퓨터/IT", 326);
		parentIdMap.put("학습", 327);

		cateIdMap.put("건강에세이/건강기타", 328);
		cateIdMap.put("건강일반", 329);
		cateIdMap.put("결혼/가정", 330);
		cateIdMap.put("육아", 331);
		cateIdMap.put("의학일반", 332);
		cateIdMap.put("의학전문", 333);
		cateIdMap.put("자녀교육", 334);
		cateIdMap.put("한의학", 335);
		cateIdMap.put("경영학", 336);
		cateIdMap.put("경제학", 337);
		cateIdMap.put("마케팅", 338);
		cateIdMap.put("과학일반", 339);
		cateIdMap.put("물리학", 340);
		cateIdMap.put("생물학", 341);
		cateIdMap.put("지구과학", 342);
		cateIdMap.put("화학", 343);
		cateIdMap.put("교육학일반", 347);
		cateIdMap.put("전문/대학교육", 348);
		cateIdMap.put("학습지도/교육방법", 349);
		cateIdMap.put("건축", 350);
		cateIdMap.put("환경공학", 351);
		cateIdMap.put("영미소설", 352);
		cateIdMap.put("유럽소설", 353);
		cateIdMap.put("한국소설", 354);
		cateIdMap.put("외국에세이", 355);
		cateIdMap.put("한국시", 356);
		cateIdMap.put("한국에세이", 357);
		cateIdMap.put("기타역사", 358);
		cateIdMap.put("동양사", 359);
		cateIdMap.put("서양사", 360);
		cateIdMap.put("세계사", 361);
		cateIdMap.put("한국사", 362);
		cateIdMap.put("미술", 363);
		cateIdMap.put("사진", 364);
		cateIdMap.put("영화/비디오", 365);
		cateIdMap.put("영어회화/청취", 366);
		cateIdMap.put("일어", 367);
		cateIdMap.put("중국어회화", 368);
		cateIdMap.put("아동과학", 369);
		cateIdMap.put("아동문학", 370);
		cateIdMap.put("아동어학", 371);
		cateIdMap.put("아동학습", 372);
		cateIdMap.put("유아그림책", 373);
		cateIdMap.put("지능개발", 374);
		cateIdMap.put("교양사상", 375);
		cateIdMap.put("문학이론", 376);
		cateIdMap.put("사회학", 377);
		cateIdMap.put("심리학", 378);
		cateIdMap.put("언론학", 379);
		cateIdMap.put("인문학", 380);
		cateIdMap.put("철학", 381);
		cateIdMap.put("성공학", 382);
		cateIdMap.put("인간관계", 383);
		cateIdMap.put("자기능력계발", 384);
		cateIdMap.put("화술/협상", 385);
		cateIdMap.put("법학", 389);
		cateIdMap.put("정치/외교", 390);
		cateIdMap.put("행정/정책", 391);
		cateIdMap.put("카톨릭", 392);
		cateIdMap.put("국내여행", 393);
		cateIdMap.put("해외여행", 394);
		cateIdMap.put("IT일반", 395);
		cateIdMap.put("고등학교 학습", 396);
		cateIdMap.put("청소년 교양", 397);
		cateIdMap.put("초등학교 학습", 398);

		String[] filenames = {"영풍.xlsx"};

		for(String filename: filenames) {
			try {
				String path = "D:\\업무\\경북도서관\\메타\\" + filename;

				FileInputStream file = new FileInputStream(new File(path));
				//Get the workbook instance for XLS file
				XSSFWorkbook workbook = new XSSFWorkbook(file);
				//Get first sheet from the workbook
				XSSFSheet sheet = workbook.getSheetAt(0);
				int rowStart = 2;
				int rowEnd = sheet.getLastRowNum();
				for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

						// This whole row is empty
						// Handle it as needed
						continue;
					}

					Book book = new Book();

					book.setBook_code(row.getCell(1, Row.RETURN_BLANK_AS_NULL).getStringCellValue());

					String parent = getStringCellValue(row.getCell(2, Row.RETURN_BLANK_AS_NULL));
					String child = getStringCellValue(row.getCell(3, Row.RETURN_BLANK_AS_NULL));

					System.out.println("@@@@@@@@@@@@@ parent: " + parent + ", child: " + child);

					book.setParent_id(parentIdMap.get(parent));
					book.setCate_id(cateIdMap.get(child));
					book.setBook_name(getStringCellValue(row.getCell(4, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_name(getStringCellValue(row.getCell(5, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubname(getStringCellValue(row.getCell(6, Row.RETURN_BLANK_AS_NULL)));
					book.setIsbn13(getStringCellValue(row.getCell(9, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubdt(getStringCellValue(row.getCell(10, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_regdt("2017-12-06");
					book.setFormat(getStringCellValue(row.getCell(14, Row.RETURN_BLANK_AS_NULL)).toUpperCase());
					book.setDevice("3");
					book.setUse_yn("Y");
					book.setType("EBK");
					book.setBook_image(getStringCellValue(row.getCell(15, Row.RETURN_BLANK_AS_NULL)));
					book.setLibrary_code("9999999");
					book.setCom_code("Y2BK");

					book.setBook_info(getStringCellValue(row.getCell(17, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_info(getStringCellValue(row.getCell(18, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_table(getStringCellValue(row.getCell(19, Row.RETURN_BLANK_AS_NULL)));
					book.setMax_lend(5);

					if(bookService.addBook(book) == 0) {
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook failed at " + rowNum + "");
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook filename: " + filename + ", book_code: " + book.getBook_code());
						throw new Exception();
					}
				}

				file.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("@@@@@@@@@@@@@ yp ends");

		response.getOutputStream().println("done");
	}

	@RequestMapping(value = {"/elib/cont.*"})
	public void cont(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("@@@@@@@@@@@@@ cont starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();

		parentIdMap.put("CEO/리더십", 456);
		parentIdMap.put("경제/자산관리", 457);
		parentIdMap.put("글로벌경제/트랜드", 458);
		parentIdMap.put("동화", 459);
		parentIdMap.put("소설", 460);
		parentIdMap.put("시/에세이", 461);
		parentIdMap.put("어린이", 462);
		parentIdMap.put("영어", 463);
		parentIdMap.put("영어동화", 464);
		parentIdMap.put("인문/교육", 465);
		parentIdMap.put("일본어", 466);
		parentIdMap.put("자기계발", 467);
		parentIdMap.put("중국어", 468);
		parentIdMap.put("커뮤니케이션/심리", 469);

		String[] filenames = {"컨텐츠포털.xlsx"};

		for(String filename: filenames) {
			try {
				String path = "D:\\업무\\경북도서관\\메타\\" + filename;

				FileInputStream file = new FileInputStream(new File(path));
				//Get the workbook instance for XLS file
				XSSFWorkbook workbook = new XSSFWorkbook(file);
				//Get first sheet from the workbook
				XSSFSheet sheet = workbook.getSheetAt(0);
				int rowStart = 2;
				int rowEnd = sheet.getLastRowNum();
				for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

						// This whole row is empty
						// Handle it as needed
						continue;
					}

					Book book = new Book();

					book.setBook_code(row.getCell(1, Row.RETURN_BLANK_AS_NULL).getStringCellValue());

					String parent = getStringCellValue(row.getCell(2, Row.RETURN_BLANK_AS_NULL));

					System.out.println("@@@@@@@@@@@@@ parent: " + parent);

					book.setParent_id(parentIdMap.get(parent));
					book.setBook_name(getStringCellValue(row.getCell(4, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_name(getStringCellValue(row.getCell(7, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubname(getStringCellValue(row.getCell(8, Row.RETURN_BLANK_AS_NULL)));
					book.setIsbn13("");
					book.setBook_pubdt("");
					book.setBook_regdt("2017-12-06");
					book.setFormat("");
					book.setDevice("3");
					book.setUse_yn("Y");
					book.setType("ADO");
					book.setBook_image(getStringCellValue(row.getCell(10, Row.RETURN_BLANK_AS_NULL)));
					book.setLibrary_code("9999999");
					book.setCom_code("CONT");
					book.setLink_url(getStringCellValue(row.getCell(9, Row.RETURN_BLANK_AS_NULL)));
					book.setMobile_url(getStringCellValue(row.getCell(23, Row.RETURN_BLANK_AS_NULL)));

					book.setBook_info(getStringCellValue(row.getCell(16, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_info(getStringCellValue(row.getCell(17, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_table(getStringCellValue(row.getCell(18, Row.RETURN_BLANK_AS_NULL)));
					book.setMax_lend(0);

					if(bookService.addBook(book) == 0) {
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook failed at " + rowNum + "");
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook filename: " + filename + ", book_code: " + book.getBook_code());
						throw new Exception();
					}
				}

				file.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("@@@@@@@@@@@@@ cont ends");

		response.getOutputStream().println("done");
	}

	@RequestMapping(value = {"/elib/glob.*"})
	public void glob(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("@@@@@@@@@@@@@ glob starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();

		parentIdMap.put("영어", 470);
		parentIdMap.put("일본어", 471);
		parentIdMap.put("제3외국어", 472);
		parentIdMap.put("중국어", 473);
		parentIdMap.put("한국사", 474);

		cateIdMap.put("TOEIC 스피킹", 475);
		cateIdMap.put("TOEIC 종합", 476);
		cateIdMap.put("듣기/말하기", 477);
		cateIdMap.put("문법/어휘/독해/작문", 478);
		cateIdMap.put("비즈니스영어", 479);
		cateIdMap.put("영어회화", 480);
		cateIdMap.put("문법/어휘/독해/작문", 481);
		cateIdMap.put("비즈니스일본어", 482);
		cateIdMap.put("일본어회화", 483);
		cateIdMap.put("자격증/시험과정", 484);
		cateIdMap.put("독일어", 485);
		cateIdMap.put("프랑스어", 486);
		cateIdMap.put("문법/어휘/독해/작문", 487);
		cateIdMap.put("비즈니스중국어", 488);
		cateIdMap.put("중국어회화", 489);
		cateIdMap.put("한국사능력검정 고급과정 (1~2급)", 490);
		cateIdMap.put("한국사능력시험 중급(3~4급)", 491);

		String[] filenames = {"글로벌.xlsx"};

		for(String filename: filenames) {
			try {
				String path = "D:\\업무\\경북도서관\\메타\\" + filename;

				FileInputStream file = new FileInputStream(new File(path));
				//Get the workbook instance for XLS file
				XSSFWorkbook workbook = new XSSFWorkbook(file);
				//Get first sheet from the workbook
				XSSFSheet sheet = workbook.getSheetAt(0);
				int rowStart = 2;
				int rowEnd = sheet.getLastRowNum();
				for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

						// This whole row is empty
						// Handle it as needed
						continue;
					}

					Book book = new Book();

					book.setBook_code(row.getCell(1, Row.RETURN_BLANK_AS_NULL).getStringCellValue());

					String parent = getStringCellValue(row.getCell(2, Row.RETURN_BLANK_AS_NULL));
					String child = getStringCellValue(row.getCell(3, Row.RETURN_BLANK_AS_NULL));

					System.out.println("@@@@@@@@@@@@@ parent: " + parent + ", child: " + child);

					ElibCategory cate = new ElibCategory();
					cate.setCate_name("[글로벌21] " + StringUtils.defaultString(parent).trim());
					cate.setType("WEB");
					cate.setDepth(1);

					ElibCategory parentCategory = elibCategoryService.getParentByName(cate);

					if(parentCategory == null) {
						System.out.println("@@@@@@@@@@@@ new parent category: " + cate.getCate_name() + " " + elibCategoryService.addCategory(cate));
						book.setParent_id(cate.getCate_id());
						cate.setParent_id(cate.getCate_id());
					} else {
						book.setParent_id(parentCategory.getCate_id());
						cate.setParent_id(parentCategory.getCate_id());
					}

					cate.setCate_name(StringUtils.defaultString(child).trim());
					cate.setDepth(2);
					ElibCategory childCategory = elibCategoryService.getChildByName(cate);

					if(childCategory == null) {
						System.out.println("@@@@@@@@@@@@ new child category: " + cate.getCate_name() + " " + elibCategoryService.addCategory(cate));
						book.setCate_id(cate.getCate_id());
					} else {
						book.setCate_id(childCategory.getCate_id());
					}

//					book.setParent_id(parentIdMap.get(parent));
//					book.setCate_id(cateIdMap.get(child));
					book.setBook_name(getStringCellValue(row.getCell(4, Row.RETURN_BLANK_AS_NULL)));
					book.setLesson_no((int) row.getCell(5, Row.RETURN_BLANK_AS_NULL).getNumericCellValue());
					book.setLesson_name(getStringCellValue(row.getCell(6, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_name(getStringCellValue(row.getCell(7, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubname(getStringCellValue(row.getCell(8, Row.RETURN_BLANK_AS_NULL)));
					book.setIsbn13("");
					book.setBook_pubdt("");
					book.setBook_regdt("2017-12-06");
					book.setFormat("");
					book.setDevice("3");
					book.setUse_yn("Y");
					book.setType("WEB");
					book.setBook_image(getStringCellValue(row.getCell(11, Row.RETURN_BLANK_AS_NULL)));
					book.setLibrary_code("9999999");
					book.setCom_code("GLOB");
					book.setLesson_url(getStringCellValue(row.getCell(9, Row.RETURN_BLANK_AS_NULL)));
					book.setMobile_url(getStringCellValue(row.getCell(10, Row.RETURN_BLANK_AS_NULL)));

					book.setBook_info(getStringCellValue(row.getCell(17, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_info(getStringCellValue(row.getCell(18, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_table(getStringCellValue(row.getCell(19, Row.RETURN_BLANK_AS_NULL)));
					book.setMax_lend(0);

					if(bookService.addElearning(book) == 0) {
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addElearning failed at " + rowNum + "");
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addElearning filename: " + filename + ", book_code: " + book.getBook_code());
						throw new Exception();
					}
				}

				file.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("@@@@@@@@@@@@@ glob ends");

		response.getOutputStream().println("done");
	}

	@RequestMapping(value = {"/elib/eduw.*"})
	public void eduw(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("@@@@@@@@@@@@@ eduw starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();

		parentIdMap.put("MS OFFICE", 492);
		parentIdMap.put("리더십/경력관리", 558);
		parentIdMap.put("면접/합격비법 특강", 561);
		parentIdMap.put("부사관", 564);
		parentIdMap.put("사무자동화산업기사", 566);
		parentIdMap.put("사무자동화산업기사 실기", 568);
		parentIdMap.put("기출문제 해설", 542);
		parentIdMap.put("워드프로세서", 570);
		parentIdMap.put("입문특강", 572);
		parentIdMap.put("기초외국어", 538);
		parentIdMap.put("정보처리기사", 584);
		parentIdMap.put("정보처리산업기사", 587);
		parentIdMap.put("취미", 590);
		parentIdMap.put("취업/경력강좌", 593);
		parentIdMap.put("취업/진로관리", 595);
		parentIdMap.put("컴퓨터활용능력(1급)", 601);
		parentIdMap.put("컴퓨터활용능력(2급)", 603);
		parentIdMap.put("테마특강", 605);
		parentIdMap.put("핵심요약", 611);
		parentIdMap.put("기본이론", 496);

		cateIdMap.put("컴퓨터활용능력(1급)", 602);
		cateIdMap.put("생명과학Ⅰ", 576);
		cateIdMap.put("사회", 575);
		cateIdMap.put("물리Ⅰ", 574);
		cateIdMap.put("국어", 573);
		cateIdMap.put("행정법총론", 609);
		cateIdMap.put("행정학개론", 610);
		cateIdMap.put("워드프로세서", 571);
		cateIdMap.put("국어", 612);
		cateIdMap.put("사무자동화산업기사 실기", 569);
		cateIdMap.put("사회", 613);
		cateIdMap.put("사무자동화산업기사", 567);
		cateIdMap.put("취업강좌", 565);
		cateIdMap.put("영어", 614);
		cateIdMap.put("취업강좌", 563);
		cateIdMap.put("면접가이드", 562);
		cateIdMap.put("한국사", 615);
		cateIdMap.put("리더십강좌", 560);
		cateIdMap.put("경력강좌", 559);
		cateIdMap.put("행정법총론", 616);
		cateIdMap.put("수학", 577);
		cateIdMap.put("영어", 578);
		cateIdMap.put("한국사", 600);
		cateIdMap.put("취업강좌", 599);
		cateIdMap.put("진로관리강좌", 598);
		cateIdMap.put("일반상식 테마특강", 597);
		cateIdMap.put("NCS", 596);
		cateIdMap.put("컴퓨터활용능력(2급)", 604);
		cateIdMap.put("취업강좌", 594);
		cateIdMap.put("프리웨어 사진편집", 592);
		cateIdMap.put("디지털카메라 사진촬영", 591);
		cateIdMap.put("국어", 606);
		cateIdMap.put("정보처리산업기사 필기", 589);
		cateIdMap.put("정보처리(산업)기사 실기", 588);
		cateIdMap.put("영어", 607);
		cateIdMap.put("정보처리기사 필기", 586);
		cateIdMap.put("정보처리(산업)기사 실기", 585);
		cateIdMap.put("한국사", 608);
		cateIdMap.put("화학Ⅰ", 583);
		cateIdMap.put("행정학개론", 582);
		cateIdMap.put("행정법총론", 581);
		cateIdMap.put("한국사", 580);
		cateIdMap.put("지구과학Ⅰ", 579);
		cateIdMap.put("화학Ⅰ", 557);
		cateIdMap.put("형사소송법", 556);
		cateIdMap.put("형법", 555);
		cateIdMap.put("영어", 521);
		cateIdMap.put("수학", 520);
		cateIdMap.put("수사", 519);
		cateIdMap.put("소방학", 518);
		cateIdMap.put("소방관계법규", 517);
		cateIdMap.put("세법", 516);
		cateIdMap.put("세무직회계학", 515);
		cateIdMap.put("세무직세법", 514);
		cateIdMap.put("생명과학Ⅰ", 513);
		cateIdMap.put("생명과학", 512);
		cateIdMap.put("사회복지학 개론", 511);
		cateIdMap.put("사회", 510);
		cateIdMap.put("보건행정", 509);
		cateIdMap.put("물리Ⅰ", 508);
		cateIdMap.put("물리", 507);
		cateIdMap.put("국제법", 506);
		cateIdMap.put("국어", 505);
		cateIdMap.put("교정학개론", 504);
		cateIdMap.put("교정학", 503);
		cateIdMap.put("교육학 개론", 502);
		cateIdMap.put("교육학", 501);
		cateIdMap.put("관세법개론", 500);
		cateIdMap.put("공중보건", 499);
		cateIdMap.put("경찰학 개론", 498);
		cateIdMap.put("경제학", 497);
		cateIdMap.put("MS 파워포인트 2007", 495);
		cateIdMap.put("MS 워드 2007", 494);
		cateIdMap.put("MS 엑셀 2007", 493);
		cateIdMap.put("지구과학", 522);
		cateIdMap.put("지구과학Ⅰ", 523);
		cateIdMap.put("한국사", 524);
		cateIdMap.put("헌법", 554);
		cateIdMap.put("행정학개론", 553);
		cateIdMap.put("행정학", 552);
		cateIdMap.put("행정법총론", 551);
		cateIdMap.put("한국사", 550);
		cateIdMap.put("영어", 549);
		cateIdMap.put("수학", 548);
		cateIdMap.put("수사", 547);
		cateIdMap.put("사회", 546);
		cateIdMap.put("국어", 545);
		cateIdMap.put("경찰학 개론", 544);
		cateIdMap.put("경제학", 543);
		cateIdMap.put("중국어강좌", 541);
		cateIdMap.put("일본강좌", 540);
		cateIdMap.put("영어강좌", 539);
		cateIdMap.put("회계학", 537);
		cateIdMap.put("회계원리", 536);
		cateIdMap.put("화학Ⅰ", 535);
		cateIdMap.put("화학", 534);
		cateIdMap.put("형사소송법 개론", 533);
		cateIdMap.put("형사소송법", 532);
		cateIdMap.put("형법", 531);
		cateIdMap.put("헌법", 530);
		cateIdMap.put("행정학개론", 529);
		cateIdMap.put("행정학", 528);
		cateIdMap.put("행정법총론", 527);
		cateIdMap.put("행정법각론", 526);
		cateIdMap.put("행정법", 525);
		cateIdMap.put("행정학개론", 617);

		String[] filenames = {"에듀윌.xlsx"};

		for(String filename: filenames) {
			try {
				String path = "D:\\업무\\경북도서관\\메타\\" + filename;

				FileInputStream file = new FileInputStream(new File(path));
				//Get the workbook instance for XLS file
				XSSFWorkbook workbook = new XSSFWorkbook(file);
				//Get first sheet from the workbook
				XSSFSheet sheet = workbook.getSheetAt(0);
				int rowStart = 2;
				int rowEnd = sheet.getLastRowNum();
				for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

						// This whole row is empty
						// Handle it as needed
						continue;
					}

					Book book = new Book();


					String parent = getStringCellValue(row.getCell(1, Row.RETURN_BLANK_AS_NULL));
					String child = getStringCellValue(row.getCell(0, Row.RETURN_BLANK_AS_NULL));


					System.out.println("@@@@@@@@@@@@@ parent: " + parent + ", child: " + child);

					book.setParent_id(parentIdMap.get(parent));
					book.setCate_id(cateIdMap.get(child));
					String book_name = getStringCellValue(row.getCell(2, Row.RETURN_BLANK_AS_NULL));
					book.setBook_name(book_name);
					book.setLesson_no((int) row.getCell(3, Row.RETURN_BLANK_AS_NULL).getNumericCellValue());
					book.setPlay_time(getStringCellValue(row.getCell(4, Row.RETURN_BLANK_AS_NULL)));
					book.setLesson_name(getStringCellValue(row.getCell(5, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_name("에듀윌");
					book.setBook_pubname(getStringCellValue(row.getCell(2, Row.RETURN_BLANK_AS_NULL)));
					book.setIsbn13("");
					book.setBook_pubdt("");
					book.setBook_regdt("2017-12-06");
					book.setFormat("");
					book.setDevice("1");
					book.setUse_yn("Y");
					book.setType("WEB");
					book.setBook_image("");
					book.setLibrary_code("9999999");
					book.setCom_code("EDUW");

					book.setBook_code(DigestUtils.md5Hex(child + "|" + book_name));

					String url = "http://www.eduwill.net/Common/Player_Aqua/player_CP_C.asp?";
					url += "DATASRC=" + row.getCell(6, Row.RETURN_BLANK_AS_NULL).getStringCellValue();
					url += "&reqAction=open";
					url += "&SiteID=GBELIB";
					url += "&ProductCode=" + row.getCell(7, Row.RETURN_BLANK_AS_NULL).getStringCellValue();

					book.setLesson_url(url);
					book.setMobile_url(url);

					book.setBook_info("");
					book.setAuthor_info("");
					book.setBook_table("");
					book.setMax_lend(0);

					if(bookService.addElearning(book) == 0) {
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addElearning failed at " + rowNum + "");
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addElearning filename: " + filename + ", book_code: " + book.getBook_code());
						throw new Exception();
					}
				}

				file.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("@@@@@@@@@@@@@ eduw ends");

		response.getOutputStream().println("done");
	}

	@RequestMapping(value = {"/elib/kyob.*"})
	public void kyob(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("@@@@@@@@@@@@@ kyob starts");

		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();

		parentIdMap.put("가정/생활/요리", 13);
		parentIdMap.put("건강/의학", 12);
		parentIdMap.put("경영/경제", 1);
		parentIdMap.put("경제경영", 1);
		parentIdMap.put("교재/수험서", 17);
		parentIdMap.put("국어/외국어", 7);
		parentIdMap.put("사회/정치/법", 8);
		parentIdMap.put("소설", 3);
		parentIdMap.put("시/에세이", 5);
		parentIdMap.put("아동", 20);
		parentIdMap.put("여행/취미", 14);
		parentIdMap.put("역사/풍속/신화", 9);
		parentIdMap.put("예술/대중문화", 15);
		parentIdMap.put("유아", 19);
		parentIdMap.put("인문", 6);
		parentIdMap.put("자기계발", 2);
		parentIdMap.put("자연과학/공학", 10);
		parentIdMap.put("장르소설", 4);
		parentIdMap.put("종교/역학", 16);
		parentIdMap.put("청소년교양", 18);
		parentIdMap.put("컴퓨터/인터넷", 11);
		parentIdMap.put("코믹스", 21);
		parentIdMap.put("공부방", 178);
		parentIdMap.put("한글동화", 181);

		cateIdMap.put("OA(사무자동화)", 80);
		cateIdMap.put("OS/네트워크", 98);
		cateIdMap.put("가톨릭", 134);
		cateIdMap.put("각국경제", 30);
		cateIdMap.put("갤러리북/포토북/도록", 131);
		cateIdMap.put("건강일반", 104);
		cateIdMap.put("결혼과부부생활", 110);
		cateIdMap.put("경영관리/CEO", 23);
		cateIdMap.put("경영일반/경영이론", 22);
		cateIdMap.put("경영전략/e비즈니스", 24);
		cateIdMap.put("경제일반/경제이론", 29);
		cateIdMap.put("공무원수험서", 140);
		cateIdMap.put("공부방법", 142);
		cateIdMap.put("교양과학", 90);
		cateIdMap.put("교양철학", 56);
		cateIdMap.put("교육이론/교육방법", 61);
		cateIdMap.put("교육일반", 60);
		cateIdMap.put("국내여행", 117);
		cateIdMap.put("국방/군사/통일", 79);
		cateIdMap.put("국어학", 53);
		cateIdMap.put("그래픽/멀티미디어", 103);
		cateIdMap.put("그림책", 151);
		cateIdMap.put("글쓰기", 54);
		cateIdMap.put("기독교", 133);
		cateIdMap.put("기업실무관리", 25);
		cateIdMap.put("기타나라소설", 44);
		cateIdMap.put("기타만화", 160);
		cateIdMap.put("기타수험서", 141);
		cateIdMap.put("기타외국어", 72);
		cateIdMap.put("다이어트", 107);
		cateIdMap.put("대중연예/음악", 130);
		cateIdMap.put("대학입시논술", 136);
		cateIdMap.put("대학입시면접", 137);
		cateIdMap.put("데이터베이스구축/관리", 99);
		cateIdMap.put("독서법/독서지도", 55);
		cateIdMap.put("독일소설", 43);
		cateIdMap.put("동양사", 84);
		cateIdMap.put("동양철학", 57);
		cateIdMap.put("디자인/도안", 125);
		cateIdMap.put("러시아소설", 41);
		cateIdMap.put("로맨스", 45);
		cateIdMap.put("마케팅/세일즈", 26);
		cateIdMap.put("무역/교통/관광", 31);
		cateIdMap.put("무협", 46);
		cateIdMap.put("문학이론", 161);
		cateIdMap.put("문화사", 51);
		cateIdMap.put("물리학", 91);
		cateIdMap.put("미술", 124);
		cateIdMap.put("법률/소송", 80);
		cateIdMap.put("불교", 132);
		cateIdMap.put("비즈니스능력계발", 34);
		cateIdMap.put("사전/연감", 139);
		cateIdMap.put("사진/영상", 127);
		cateIdMap.put("사회과학일반", 74);
		cateIdMap.put("사회문제/사회복지", 75);
		cateIdMap.put("상식/취미/실용", 155);
		cateIdMap.put("생물학", 92);
		cateIdMap.put("생활과학", 95);
		cateIdMap.put("서양사", 83);
		cateIdMap.put("서양철학", 58);
		cateIdMap.put("성공/처세", 32);
		cateIdMap.put("세계사", 82);
		cateIdMap.put("수험영어", 68);
		cateIdMap.put("스포츠", 121);
		cateIdMap.put("시", 48);
		cateIdMap.put("신화/신화학", 88);
		cateIdMap.put("심리이론", 64);
		cateIdMap.put("심리일반", 63);
		cateIdMap.put("심리치료/정신분석", 65);
		cateIdMap.put("아동교양만화", 157);
		cateIdMap.put("아동학습만화", 158);
		cateIdMap.put("어린이문학", 156);
		cateIdMap.put("어린이영어", 174);
		cateIdMap.put("언론/신문/방송", 76);
		cateIdMap.put("에세이", 49);
		cateIdMap.put("역사일반", 81);
		cateIdMap.put("연극/희곡", 128);
		cateIdMap.put("영미소설", 38);
		cateIdMap.put("영어교재/문고", 67);
		cateIdMap.put("영화/드라마", 129);
		cateIdMap.put("예술론/미학", 123);
		cateIdMap.put("예술입문서", 122);
		cateIdMap.put("와인/칵테일/음료", 116);
		cateIdMap.put("요리", 115);
		cateIdMap.put("웹사이트/홈페이지만들기", 102);
		cateIdMap.put("유/초등부교육", 62);
		cateIdMap.put("유아교양", 152);
		cateIdMap.put("유아놀이", 150);
		cateIdMap.put("유통/창업", 27);
		cateIdMap.put("육아", 112);
		cateIdMap.put("음악", 126);
		cateIdMap.put("의학", 109);
		cateIdMap.put("인간관계", 35);
		cateIdMap.put("인문학일반", 59);
		cateIdMap.put("일반영어", 66);
		cateIdMap.put("일본소설", 39);
		cateIdMap.put("일본어", 70);
		cateIdMap.put("자기능력계발", 33);
		cateIdMap.put("자연요법/대체의학", 108);
		cateIdMap.put("재테크/금융", 28);
		cateIdMap.put("정치/외교", 77);
		cateIdMap.put("좋은부모", 113);
		cateIdMap.put("중국소설", 40);
		cateIdMap.put("중국어", 71);
		cateIdMap.put("지구과학", 93);
		cateIdMap.put("지리학", 89);
		cateIdMap.put("진로", 143);
		cateIdMap.put("질병치료/예방", 105);
		cateIdMap.put("청소년 교양과학", 146);
		cateIdMap.put("청소년 문학", 144);
		cateIdMap.put("청소년 역사", 149);
		cateIdMap.put("청소년 예술", 145);
		cateIdMap.put("청소년 인문교양", 147);
		cateIdMap.put("청소년 자기계발", 148);
		cateIdMap.put("초등공통1~6학년", 159);
		cateIdMap.put("초등학교", 135);
		cateIdMap.put("취미", 120);
		cateIdMap.put("취업전략", 138);
		cateIdMap.put("컴퓨터공학", 97);
		cateIdMap.put("컴퓨터입문/활용", 96);
		cateIdMap.put("태교/출산준비", 111);
		cateIdMap.put("테마시/에세이", 50);
		cateIdMap.put("테마여행", 119);
		cateIdMap.put("판타지", 47);
		cateIdMap.put("풍속/민속", 86);
		cateIdMap.put("프랑스소설", 42);
		cateIdMap.put("프로그래밍 및 언어", 100);
		cateIdMap.put("학습참고서", 154);
		cateIdMap.put("한국사", 85);
		cateIdMap.put("한국소설", 37);
		cateIdMap.put("한문학/한자", 52);
		cateIdMap.put("한방치료", 106);
		cateIdMap.put("한자", 73);
		cateIdMap.put("해외여행", 118);
		cateIdMap.put("행정/정책", 78);
		cateIdMap.put("호기심/창의력/습관", 153);
		cateIdMap.put("홈인테리어", 114);
		cateIdMap.put("화술/협상", 36);
		cateIdMap.put("환경/도시/조경", 94);
		cateIdMap.put("영어공부", 179);
		cateIdMap.put("영어동화공부", 180);
		cateIdMap.put("한국전래동화", 182);

		String[] filenames = {"교보2차3차.xlsx"};

		for(String filename: filenames) {
			try {
				String path = "D:\\업무\\경북도서관\\메타\\" + filename;

				FileInputStream file = new FileInputStream(new File(path));
				//Get the workbook instance for XLS file
				XSSFWorkbook workbook = new XSSFWorkbook(file);
				//Get first sheet from the workbook
				XSSFSheet sheet = workbook.getSheetAt(0);
				int rowStart = 2;
				int rowEnd = sheet.getLastRowNum();
				for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						System.out.println("@@@@@@@@@@@@@@@ ignored rowNum: " + rowNum);

						// This whole row is empty
						// Handle it as needed
						continue;
					}

					Book book = new Book();

					book.setBook_code(row.getCell(1, Row.RETURN_BLANK_AS_NULL).getStringCellValue());

					String parent = getStringCellValue(row.getCell(2, Row.RETURN_BLANK_AS_NULL));
					String child = getStringCellValue(row.getCell(3, Row.RETURN_BLANK_AS_NULL));

					System.out.println("@@@@@@@@@@@@@ parent: " + parent + ", child: " + child);

					ElibCategory cate = new ElibCategory();
					cate.setCate_name(StringUtils.defaultString(parent).trim());
					cate.setType("EBK");
					cate.setDepth(1);

					ElibCategory parentCategory = elibCategoryService.getParentByName(cate);

					if(parentCategory == null) {
						System.out.println("@@@@@@@@@@@@ new parent category: " + cate.getCate_name() + " " + elibCategoryService.addCategory(cate));
						book.setParent_id(cate.getCate_id());
						cate.setParent_id(cate.getCate_id());
					} else {
						book.setParent_id(parentCategory.getCate_id());
						cate.setParent_id(parentCategory.getCate_id());
					}

					cate.setCate_name(StringUtils.defaultString(child).trim());
					cate.setDepth(2);
					ElibCategory childCategory = elibCategoryService.getChildByName(cate);

					if(childCategory == null) {
						System.out.println("@@@@@@@@@@@@ new child category: " + cate.getCate_name() + " " + elibCategoryService.addCategory(cate));
						book.setCate_id(cate.getCate_id());
					} else {
						book.setCate_id(childCategory.getCate_id());
					}

//					book.setParent_id(parentIdMap.get(parent));
//					book.setCate_id(cateIdMap.get(child));

					book.setBook_name(getStringCellValue(row.getCell(4, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_name(getStringCellValue(row.getCell(5, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubname(getStringCellValue(row.getCell(6, Row.RETURN_BLANK_AS_NULL)));
					book.setIsbn13(getStringCellValue(row.getCell(8, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_pubdt(getStringCellValue(row.getCell(9, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_regdt("2017-12-19");
					book.setFormat(getStringCellValue(row.getCell(13, Row.RETURN_BLANK_AS_NULL)).toUpperCase());
					book.setDevice("3");
					book.setUse_yn("Y");
					book.setType("EBK");
					book.setBook_image(getStringCellValue(row.getCell(14, Row.RETURN_BLANK_AS_NULL)));
					book.setLibrary_code("9999999");
					book.setCom_code("KYOB");

					book.setBook_info(getStringCellValue(row.getCell(17, Row.RETURN_BLANK_AS_NULL)));
					book.setAuthor_info(getStringCellValue(row.getCell(18, Row.RETURN_BLANK_AS_NULL)));
					book.setBook_table(getStringCellValue(row.getCell(19, Row.RETURN_BLANK_AS_NULL)));
					book.setMax_lend((int) row.getCell(21, Row.RETURN_BLANK_AS_NULL).getNumericCellValue());

					if(bookService.addBook(book) == 0) {
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook failed at " + rowNum + "");
						System.out.println("@@@@@@@@@@@@@@@@@@@ do1 addBook filename: " + filename + ", book_code: " + book.getBook_code());
						throw new Exception();
					}
				}

				file.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("@@@@@@@@@@@@@ kyob ends");

		response.getOutputStream().println("done");
	}

	@RequestMapping(value = {"/certDownload.*"}, method = RequestMethod.GET)
	public void certDownload(Model model, Teacher teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Download down = new Download(request, response, "cert.xls");

		service.table(down.getOutputStream(), request);


		down.close();
	}
}