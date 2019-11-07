package kr.co.whalesoft.app.cms.dataMigration;

import java.util.List;
import java.util.Map;

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

}
