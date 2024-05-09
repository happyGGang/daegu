package kr.co.whalesoft.app.board.boardComment;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardDao;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.board.boardComment.boardCommentFile.BoardCommentFileService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.RequestUtils;

@Service
public class BoardCommentService extends BaseService {

	@Autowired
	private BoardCommentDao dao;

	@Autowired
	private LoginService loginService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private BoardDao boardDao;

	@Autowired
	private BoardService boardService;

	@Autowired
	private BoardCommentFileService boardCommentFileService;

	@Autowired
	private MemberService memberService;

	@Autowired
	@Qualifier("boardCommentStorage")
	private FileStorage boardCommentStorage;

	@Autowired
	@Qualifier("boardCommentTempStorage")
	private FileStorage boardCommentTempStorage;

	public List<BoardComment> getBoardComment(BoardComment boardComment) {
		List<BoardComment> lsit = dao.getBoardComment(boardComment);
		for ( BoardComment cmt : lsit ) {
			cmt.setFileList(boardCommentFileService.getBoardCommentFile(cmt));
		}
		return lsit;
	}

	public int getBoardCommentCount(BoardComment boardComment) {
		return dao.getBoardCommentCount(boardComment);
	}

	@Transactional
	public int addBoardComment(BoardComment boardComment, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);

		if (member.getLoginType().equals("CMS")) {
			boardComment.setUser_id(member.getMember_id());
		} else {
			if (StringUtils.isNotEmpty(member.getWeb_id())) {
				boardComment.setUser_id(member.getWeb_id());//일반이용자는 web_id로만 한다
			} else {
				boardComment.setUser_id(member.getMember_id());//web_id가 없는경우 대출자번호를 넣는다.
			}
			boardComment.setLas_user_id(member.getMember_id());//
			boardComment.setLas_user_seq(member.getSeq_no());
		}

		boardComment.setUser_name(member.getMember_name());
		boardComment.setUser_ip(RequestUtils.getClientIpAddr(request));

		boardComment.setBeforeFilePath(boardCommentTempStorage.getContextPath()+"/"+request.getSession().getId());
		boardComment.setAfterFilePath(boardCommentStorage.getContextPath());

		boardComment.setComment_idx(dao.getCommentIdx(boardComment));

		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		Board boardTmp = new Board();
		boardTmp.setManage_idx(boardComment.getManage_idx());
		boardTmp.setBoard_idx(boardComment.getBoard_idx());
		boardTmp.setDelete_yn("N");
		boardTmp.setHomepage_id(boardManage.getHomepage_id());
		boardTmp.setRequest_code(boardManage.getRequest_code());
		boardTmp.setCategory1Manage(boardManage.getCategory1());
		boardTmp.setCategory2Manage(boardManage.getCategory2());
		boardTmp.setCategory3Manage(boardManage.getCategory3());
		boardTmp.setCategory4Manage(boardManage.getCategory4());
		boardTmp.setCategory5Manage(boardManage.getCategory5());
		boardTmp = boardService.getBoardOne(boardTmp);


		if	(boardManage.getBoard_type().equals("LOSTCARD")) {
			Board board = new Board();
			board.setGroup_idx(boardComment.getBoard_idx());
			board.setManage_idx(boardComment.getManage_idx());
			board.setRequest_state(boardComment.getImsi_v_18());

			boardDao.modifyLostCardBoard(board);
		}
		/**
		 * 접수처리
		 */
		if (StringUtils.equals(boardComment.getImsi_v_20(), "Y")) {
			Homepage homepage = homepageService.getHomepageOne(new Homepage("c0"));
			homepage.setHomepage_name("프로젝트사이트");
			/*PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, boardComment.getImsi_v_19(), "["+boardTmp.getCategory1_name()+"] 유지보수 요청글이 등록되었습니다. 프로젝트 사이트 확인 바랍니다.", homepage.getHomepage_send_tell(), true);*/
			Board board = new Board();
			board.setRequest_state("1");
			board.setManage_idx(563);
			board.setGroup_idx(boardComment.getBoard_idx());
			boardDao.modifyQnaBoard(board);
		}

		/**
		 * 유지보수 처리 완료
		 * 글쓴사람에게 보낸다.
		 */
		if (StringUtils.equals(boardComment.getImsi_v_18(), "Y")) {
			Homepage homepage = homepageService.getHomepageOne(new Homepage("c0"));
			homepage.setHomepage_name("프로젝트사이트");
			Board board = new Board();
			board.setRequest_state("2");
			board.setManage_idx(563);
			board.setGroup_idx(boardComment.getBoard_idx());
			board.setBoard_idx(boardComment.getBoard_idx());

			Board boardOne = boardService.getBoardOne(board);
			Member boardMember = new Member();
			boardMember.setMember_id(boardOne.getAdd_id());
			boardMember = memberService.getMemberOne(boardMember);
			if (boardMember != null && StringUtils.isNotEmpty(boardMember.getCell_phone())) {
				/*PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, boardMember.getCell_phone(), "["+boardTmp.getCategory1_name()+"] 유지보수 처리가 완료되었습니다. 프로젝트 사이트 확인 바랍니다.", homepage.getHomepage_send_tell(), true);*/
			}

			boardDao.modifyQnaBoard(board);
		}

		boardComment.setGroup_comment_idx(boardComment.getGroup_comment_idx());

		if (dao.addBoardComment(boardComment) > 0) {

			if(boardComment.getBoardCommentFileArray()!=null && boardComment.getBoardCommentFileArray().length > 0) {
				boardCommentFileService.fileProcess(boardComment.getBoardCommentFileArray(), boardComment, "ADD", request);
				boardComment.setFile_count(boardComment.getBoardCommentFileArray().length);
//				dao.modifyBoardFileCount(boardComment);
			}

		}

		return 1;
	}

	public int modifyBoardComment(BoardComment boardComment, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);

		if (member.getLoginType().equals("CMS")) {
			boardComment.setUser_id(member.getMember_id());
		} else {
			if (StringUtils.isNotEmpty(member.getWeb_id())) {
				boardComment.setUser_id(member.getWeb_id());//일반이용자는 web_id로만 한다
			} else {
				boardComment.setUser_id(member.getMember_id());//web_id가 없는경우 대출자번호를 넣는다.
			}
			boardComment.setLas_user_id(member.getMember_id());//
			boardComment.setLas_user_seq(member.getSeq_no());
		}

		boardComment.setUser_name(member.getMember_name());
		return dao.modifyBoardComment(boardComment);
	}

	public int addBoardReplyComment(BoardComment boardComment, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);

		if (member.getLoginType().equals("CMS")) {
			boardComment.setUser_id(member.getMember_id());
		} else {
			if (StringUtils.isNotEmpty(member.getWeb_id())) {
				boardComment.setUser_id(member.getWeb_id());//일반이용자는 web_id로만 한다
			} else {
				boardComment.setUser_id(member.getMember_id());//web_id가 없는경우 대출자번호를 넣는다.
			}
			boardComment.setLas_user_id(member.getMember_id());//
			boardComment.setLas_user_seq(member.getSeq_no());
		}
		boardComment.setUser_name(member.getMember_name());
		boardComment.setUser_ip(RequestUtils.getClientIpAddr(request));

		return dao.addBoardReplyComment(boardComment);
	}

	public int deleteBoardComment(BoardComment boardComment) {
		return dao.deleteBoardComment(boardComment);
	}

	public String getBoardCommentId(BoardComment boardComment) {
		return dao.getBoardCommentId(boardComment);
	}

}