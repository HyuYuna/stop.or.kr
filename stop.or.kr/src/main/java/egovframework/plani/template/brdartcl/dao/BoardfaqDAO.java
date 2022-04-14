package egovframework.plani.template.brdartcl.dao;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardfaqVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 개별 게시판에 대한 CRUD를 처리한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.dao] [BoardfaqDAO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:59:00
 * @version : 1.0
 */
@Mapper
public interface BoardfaqDAO {

  /**
   * 게시판을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertBoardfaq(BoardfaqVO vo) throws Exception;

  /**
   * 댓글 등록을 위해 그룹 순서 을/를 수정한다.
   * 
   * @param boardfaqreplyVO : 수정할 정보
   * @exception Exception
   */
  public void updateBoardfaqreply(BoardfaqVO vo) throws Exception;


  /**
   * 게시판을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateBoardfaq(BoardfaqVO vo) throws Exception;

  /**
   * 게시판을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoardfaq(BoardfaqVO vo) throws Exception;

  /**
   * 게시판항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public BoardfaqVO selectBoardfaq(BoardfaqVO vo) throws Exception;

  /**
   * 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectBoardfaqList(BoardfaqVO vo) throws Exception;

  /**
   * 게시판목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardfaqListTotCnt(BoardfaqVO vo) throws Exception;

  /**
   * 게시판 조회수등 을/를 수정한다.
   * 
   * @param boardhitsVO : 수정할 정보
   * @exception Exception
   */
  public void updateBoardxcount(BoardfaqVO vo) throws Exception;


  /**
   * 선택된 글과 답글 목록 을/를 조회한다.
   * 
   * @param boardfaqVO : 조회할 정보
   * @exception Exception
   */
  public List selectBoardfaqgroupList(BoardfaqVO vo) throws Exception;

}

