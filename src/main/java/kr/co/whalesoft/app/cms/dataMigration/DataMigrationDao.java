package kr.co.whalesoft.app.cms.dataMigration;

import java.util.List;
import java.util.Map;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.boardFile.BoardFile;

public interface DataMigrationDao {

	int getNextBoardIdx();

	List<Map<String, Object>> orgData(int manager_seq);

	int insertBoard(Map<String, Object> orgMap);

	List<Map<String, Object>> getFileData(int board_seq);

	int insertBoardFile(Map<String, Object> map2);

	List<DataMigration> orgList(int manager_seq);

	int insertBoard(DataMigration orgMap);

	List<DataMigration> getOrgListInfoset(int parseInt);

	List<Map<String, Object>> getFileDataDK(int bb_code);

	List<DataMigration> orgListDK(int manager_seq);

	int insertBoardFiledk(Map<String, Object> map2);

	int insertBoarddk(DataMigration orgMap);

	List<Map<String, Object>> getCommentDK(int bb_code);

	int addBoardCommentdk(Map<String, Object> map2);

	List<DataMigration> orgListDKtheme(int manager_seq);

	List<DataMigration> orgListDKbook(int manager_seq);

	List<DataMigration> orgListDK2(String categoryName);

	List<DataMigration> orgListINFO(int manager_seq);

	List<DataMigration> orgListyd(DataMigration dm);
	List<DataMigration> orgListyd2(DataMigration dm);
	List<DataMigration> orgListyd3(DataMigration dm);

	int insertBoardyd(DataMigration orgMap);

	List<Map<String, Object>> getFileDataYD(int board_seq);

	List<DataMigration> orgListDK3(String categoryName);

	List<BoardFile> getFileList(int board_seq);

	List<DataMigration> boardList(int manage_idx);

	List<Map<String, Object>> getCommentData(int board_seq);

	int insertBoardComment(Map<String, Object> map2);

	List<Map<String, Object>> getReadCommentDK(int board_seq);

	List<DataMigration> orgListGM(int manager_seq);

	List<Map<String, Object>> getFileDataGM(int bb_code);

	List<DataMigration> orgListGM3();

	List<DataMigration> orgListGM2();

	List<DataMigration> orgListOD2(String string);

	List<DataMigration> orgListJC(DataMigration dm);

	List<Map<String, Object>> getFileDataJC(DataMigration orgMap);

	List<DataMigration> orgListJCBook();

	List<DataMigration> orgListJCMovie();

	List<DataMigration> orgListPG(int manager_seq);

	List<DataMigration> orgListPG2();

	List<DataMigration> orgGbccsList(int parseInt);

	List<Map<String, Object>> getGbccsFileData(DataMigration dm);

	List<Map<String, Object>> getGbccsCommentData(DataMigration orgMap);

	/**
	 * @author whalesoft YONGJU 2019. 10. 26.
	 * @return
	 */
	List<Map<String, Object>> getTableMap();

	/**
	 * @author whalesoft YONGJU 2019. 10. 26.
	 * @param a
	 * @return
	 */
	List<Map<String, Object>> getColumns(Map<String, Object> a);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param manager_seq
	 * @return
	 */
	Map<String, String> getTableNameNN(int manager_seq);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNN(String tableName);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNN228(String tableName);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNNJungang(String tableName);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNNBukbu(String tableName);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNNNewBook(String tableName);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNNNewBook228(String tableName);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNNNewBookBukbu(String tableName);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNNNewBookSeobu(String tableName);

	/**
	 * @author whalesoft YONGJU 2019. 12. 10.
	 * @param tableName
	 * @return
	 */
	List<DataMigration> getListNNNewBookJungang(String tableName);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param one
	 * @return
	 */
	List<String> getFileListNN(DataMigration one);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param one
	 * @return
	 */
	Map<String, String> getFileDataNN(DataMigration one);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param string
	 * @return
	 */
	List<DataMigration> getListNNMovie(String string);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param string
	 * @return
	 */
	List<DataMigration> getListNNMovie228(String string);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param string
	 * @return
	 */
	List<DataMigration> getListNNMovieBukbu(String string);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param string
	 * @return
	 */
	List<DataMigration> getListNNMovieSeobu(String string);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param string
	 * @return
	 */
	List<DataMigration> getListNNMovieJungang(String string);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param manager_seq
	 * @return
	 */
	List<DataMigration> getListDK(int manager_seq);

	/**
	 * @author whalesoft YONGJU 2020. 1. 2.
	 * @param one
	 * @return
	 */
	List<DataMigration> getListDKDepth(DataMigration one);

	/**
	 * @author whalesoft YONGJU 2020. 1. 6.
	 * @param dm
	 * @return
	 */
	List<DataMigration> orgListDK2(DataMigration dm);

	/**
	 * @author whalesoft YONGJU 2020. 2. 22.
	 * @param string
	 * @return
	 */
	List<DataMigration> getListNNHub(String string);

	/**
	 * @author whalesoft YONGJU 2020. 2. 22.
	 * @param string
	 * @return
	 */
	List<DataMigration> getListNNHubLib(String string);

	List<DataMigration> getListDongguMovie();

	List<DataMigration> getListDonggu(int manager_seq);

	List<String> getDongguContents(DataMigration one);

	List<Map<String, Object>> getFileDataDonggu(DataMigration one);

	List<DataMigration> getListNNRecommendBookSeogu(String tableName);

	List<DataMigration> getListNNMovieSeogu(String a_tablename);

	List<DataMigration> getListNNRecommendBookNamgu(String tablename);

	List<DataMigration> getListNNMovieNamgu(String a_tablename);

	List<DataMigration> orgListDKBookBukgu(DataMigration dm);

	List<DataMigration> orgListDKMovieBukgu(DataMigration dm);

	List<DataMigration> getListDKBukgu(Map<String, Object> manager_seq);

	List<Map<String, Object>> getFileDataDKBukgu(int board_seq);

	List<DataMigration> getListBeomeo(int manager_seq);

	List<DataMigration> getListBeomeoBook(int manager_seq);

	List<DataMigration> getListBeomeoMovie(int manager_seq);

	List<DataMigration> getListBeomeoComment(DataMigration one);

	List<DataMigration> getListYonghak(int manager_seq);

	List<DataMigration> getListYonghakBook(int manager_seq);

	List<DataMigration> getListYonghakMovie(int manager_seq);

	List<DataMigration> getListYonghakComment(DataMigration one);

	List<DataMigration> getListGosan(int manager_seq);

	List<DataMigration> getListGosanBook(int manager_seq);

	List<DataMigration> getListGosanMovie(int manager_seq);

	List<DataMigration> getListGosanComment(DataMigration one);

	List<DataMigration> getListNNRecommendBookDalseogu(String tablename);

	List<DataMigration> getListNNMovieDalseogu(String tablename);

	List<DataMigration> getListNNDalseogu(String tablename);

	List<DataMigration> getListNNRecommendBookDalseonggun(String tablename);

	List<DataMigration> getListNNMovieDalseonggun(String tablename);

	List<DataMigration> getListNNDalseonggun(String tablename);
}
